#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QFileInfoList>
#include <unistd.h>
#include <QCryptographicHash>
#include "monitoringdata.h"
#include "../MonitoringServer/errors.h"

MonitoringData::MonitoringData(QQmlContext *ctx, QObject *parent) : QObject(parent)
{
    authorizedOnServer = false;
    settings = Settings::Instance();
    qDebug()<<settings->username;
    context = ctx;
    client = new MonitoringClient();
    connect(client, SIGNAL(netIn()), this, SIGNAL(netIn()));
    connect(client, SIGNAL(netOut()), this, SIGNAL(netOut()));
    //setStatus(client->get_status());

    connect(client, &MonitoringClient::messageReceived, this, &MonitoringData::parseMessage);
    connect(client, &MonitoringClient::statusChanged, this, &MonitoringData::setStatus);
    connect(client->serverSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(gotError(QAbstractSocket::SocketError)));

    hosts= new QJsonObject();
    hostsMapping = new QQmlPropertyMap(this);
    hostConfigs= new QJsonObject();
    hostConfigsMapping = new QQmlPropertyMap(this);
    groups = new QJsonObject();
    groupsMapping = new QQmlPropertyMap(this);

    context->setContextProperty("hosts", hostsMapping);
    context->setContextProperty("hostConfigs", hostConfigsMapping);
    context->setContextProperty("groups", groupsMapping);
    context->setContextProperty("backend",this);

    loadHosts();

    dataGetTimer = new QTimer(this);
    connect(dataGetTimer, SIGNAL(timeout()), this, SLOT(getGroupsData()));
    connect(dataGetTimer, SIGNAL(timeout()), this, SLOT(getHostsData()));
}

MonitoringData::~MonitoringData()
{
    //    settings->writeSettings();
}

bool MonitoringData::getStatus()
{
    return client->getStatus();
}

void MonitoringData::setStatus(bool newStatus)
{
    if (newStatus)
    {
        emit statusChanged("CONNECTED");
        authOnServer();
    }
    else
    {
        emit statusChanged("DISCONNECTED");
        dataGetTimer->stop();
        authorizedOnServer = false;
        authorizedUserName = "";
        emit authUNChanged(authorizedUserName);
    }
}

void MonitoringData::parseMessage(QJsonObject* jsonReply)
{
    QString replyType = jsonReply->value("replyType").toString();
    QString uuid = jsonReply->value("uuid").toString();
    QJsonObject replyData = jsonReply->value("data").toObject();

    if(replyType == "hostData")
    {
        hosts->insert(replyData["host"].toString(),replyData);

        hostsMapping->insert(replyData["host"].toString(),
                QVariant::fromValue(hosts->value(replyData["host"].toString())));
        emit hostUpdated(replyData["host"].toString());
    }
    else if(replyType == "groupsData")
    {
        for(int i=0; i < replyData.count();i++)
        {
            QString groupName = replyData.keys()[i];
            groups->insert(groupName,
                           replyData[replyData.keys()[i]]);
            groupsMapping->insert(groupName,
                                  QVariant::fromValue(groups->value(groupName)));
        }

    }
    else if (replyType == "graphData")
    {
        if(replyData["graphid"].toString().trimmed()!="")
        {
            //            QVariant* graph = new QVariant(replyData);
            emit graphUpdated(QVariant::fromValue(replyData));
        }
    }
    else if (replyType == "authSuccess")
    {
        authorizedOnServer = true;
        authorizedUserName = replyData["FullName"].toString();
        authUNChanged(authorizedUserName);
        getHostsData();
        getGroupsData();
        dataGetTimer->start(settings->updateInterval);
    }
    else if (replyType == "error")
    {
        emit error("Сервер сообщил об ошибке: " + replyData["errorMsg"].toString());
        if(replyData["errorId"].toInt() == ErrorType::NotAuthorized)
            client->closeConnection();
        if(replyData["errorId"].toInt() == ErrorType::IncorrectUserOrPassword)
            client->closeConnection();
        if(replyData["errorId"].toInt() == ErrorType::NoSuchHost) {
            hostConfigs->remove(replyData["host"].toString());
        }
        if(replyData["errorId"].toInt() == ErrorType::HostAccessDenied) {
            hostConfigs->remove(replyData["host"].toString());
        }
    }
    else
    {
        emit error("Сервер отправил неизвестный ответ: "+replyType);
    }

}

void MonitoringData::gotError(QAbstractSocket::SocketError err)
{
    QString strError = "unknown";
    switch (err)
    {
    case 0:
        strError = "Невозможно подключиться к серверу";
        break;
    case 1:
        strError = "Сервер закрыл соединение";
        break;
    case 2:
        strError = "Неверно указан адрес сервера";
        break;
    case 5:
        strError = "Время ожидания соединения истекло";
        break;
    default:
        strError = "Неизвестная ошибка";
    }

    emit error(strError);
}

void MonitoringData::connectClicked()
{
    client->connectToServer(settings->serverHostname, settings->serverPort);
}

void MonitoringData::disconnectClicked()
{
    client->closeConnection();
}

void MonitoringData::getHost(QString hostname)
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;
    if(!authorizedOnServer) return;

    QJsonObject* request = new QJsonObject();
    request->insert("requestType","getHost");
    request->insert("uuid",QUuid::createUuid().toString());
    QJsonObject host;
    host["host"] = hostname;
    host["items"] = hostConfigs->value(hostname).toObject().value("items").toArray();
    request->insert("request", host);
    client->sendMessage(request);
}

void MonitoringData::getHostsData()
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;
    if(!authorizedOnServer) return;

    foreach (QString host, hostConfigs->keys()) {
        QJsonObject* request = new QJsonObject();
        request->insert("requestType","getHost");
        request->insert("uuid",QUuid::createUuid().toString());
        QJsonObject shortRequest;
        shortRequest["summary"] = "true";
        shortRequest["host"] = host;
        request->insert("request", shortRequest);
        client->sendMessage(request);
    }
}


void MonitoringData::getGroupsData()
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;
    if(!authorizedOnServer) return;
    QJsonObject* request = new QJsonObject();
    request->insert("requestType","getGroups");
    request->insert("uuid",QUuid::createUuid().toString());
    client->sendMessage(request);
}

void MonitoringData::getGraph(int graphid, int period, int width, int height)
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;
    if(!authorizedOnServer) return;
    QJsonObject* request = new QJsonObject();
    request->insert("requestType","getGraph");
    request->insert("uuid",QUuid::createUuid().toString());
    QJsonObject params;
    params["graphid"] = graphid;
    params["period"] = period;
    params["width"] = width;
    params["height"] = height;
    request->insert("request",params);
    client->sendMessage(request);
}

void MonitoringData::authOnServer()
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;
    QJsonObject* request = new QJsonObject();
    request->insert("requestType","auth");
    request->insert("uuid",QUuid::createUuid().toString());
    QJsonObject params;
    params["username"] = settings->username;
    params["password"] = QString(QCryptographicHash::hash(settings->password.toUtf8(),
                                                          QCryptographicHash::Md5).toHex());
    request->insert("request",params);
    client->sendMessage(request);
}

void MonitoringData::loadHosts()
{

    static int t=0;
    t++;
    QDir hostsDir(QCoreApplication::applicationDirPath()+
                  QDir::separator()+"hosts"+QDir::separator());
    QStringList nameFiletrs;
    nameFiletrs<<"*.json";
    hostsDir.setNameFilters(nameFiletrs);
    QFileInfoList hostsList = hostsDir.entryInfoList();
    foreach (QFileInfo fi, hostsList)  {
        QFile file(fi.absoluteFilePath());
        if (file.open(QFile::ReadOnly ))
        {
            QTextStream in(&file);
            QByteArray buf = in.readAll().toUtf8();
            QJsonDocument doc = QJsonDocument::fromJson(buf);
            QJsonObject jsonObj(doc.object());
            if(jsonObj.empty())
            {
                emit error("Файл настроек хоста "+fi.absoluteFilePath()+" является некорректным");
                continue;
            }

            hostConfigs->insert(jsonObj["host"].toString(),jsonObj);

            hostConfigsMapping->insert(jsonObj["host"].toString(),
                    QVariant::fromValue(hostConfigs->value(jsonObj["host"].toString())));
        }
    }
}


