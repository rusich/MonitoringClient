#include <QCoreApplication>
#include <QDir>
#include <QFileInfo>
#include <QFileInfoList>
#include "monitoringdata.h"

MonitoringData::MonitoringData(QQmlContext *ctx, QObject *parent) : QObject(parent)
{
    context = ctx;
    client = new MonitoringClient("localhost", 9999);
    //setStatus(client->get_status());

    connect(client, &MonitoringClient::messageReceived, this, &MonitoringData::parseMessage);
    connect(client, &MonitoringClient::statusChanged, this, &MonitoringData::setStatus);
    connect(client->serverSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(gotError(QAbstractSocket::SocketError)));

    hosts= new QJsonObject();
    hostsMapping = new QQmlPropertyMap(this);
    hostsConfigs= new QJsonObject();
    hostsConfigsMapping = new QQmlPropertyMap(this);

    context->setContextProperty("hosts", hostsMapping);
    context->setContextProperty("backend",this);

    dataGetTimer = new QTimer(this);
    dataGetTimer->start(1000);
    connect(dataGetTimer, SIGNAL(timeout()), this, SLOT(getHostsData()));
    loadHosts();
}

bool MonitoringData::getStatus()
{
    return client->getStatus();
}

void MonitoringData::setStatus(bool newStatus)
{
    //qDebug() << "new status is:" << newStatus;
    if (newStatus)
    { emit statusChanged("CONNECTED"); }
    else
    { emit statusChanged("DISCONNECTED"); }
}

void MonitoringData::parseMessage(QJsonObject* jsonReply)
{
    QString replyType = jsonReply->value("replyType").toString();
    QString uuid = jsonReply->value("uuid").toString();
    QJsonObject data = jsonReply->value("data").toObject();

    if(replyType == "hostData")
    {
        hosts->insert(data["host"].toString(),data);

        hostsMapping->insert(data["host"].toString(),
                QVariant::fromValue(hosts->value(data["host"].toString())));
    }
    else
    {
        qDebug()<<"Unknown reply:"<<replyType;
    }

}

void MonitoringData::gotError(QAbstractSocket::SocketError err)
{
    //qDebug() << "got error";
    QString strError = "unknown";
    switch (err)
    {
    case 0:
        strError = "Connection was refused";
        break;
    case 1:
        strError = "Remote host closed the connection";
        break;
    case 2:
        strError = "Host address was not found";
        break;
    case 5:
        strError = "Connection timed out";
        break;
    default:
        strError = "Unknown error";
    }

    emit networkError(strError);
}

void MonitoringData::connectClicked()
{
    client->connectToServer();
}

void MonitoringData::sendClicked(QString msg)
{
    //tempTest
    QJsonObject test;
    test.insert("uuid",QUuid::createUuid().toString());
    test.insert("requestType","zabbixSingleRequest");
    QJsonObject zsr;
    zsr["method"] = "host.get";
    QJsonObject params = {{"output",QJsonArray({"hostid","host", "name"})},
                          {"selectInterfaces",QJsonArray({"interfaceid","ip"})}//,
                          //                          {"hostids",QJsonArray({"10197"})}
                         };
    zsr["params"] = params;
    test["request"] = zsr;
    client->sendMessage(&test);
}

void MonitoringData::disconnectClicked()
{
    client->closeConnection();
}

void MonitoringData::getHostsData()
{
    //Если нет подключения к серверу то запрос не отправляем
    if(!getStatus()) return;

//    this->dataGetTimer->stop();

    foreach (QString host, hostsConfigs->keys()) {
        QJsonObject* request = new QJsonObject();
        request->insert("requestType","getHost");
        request->insert("uuid",QUuid::createUuid().toString());
        request->insert("request", hostsConfigs->value(host));
        client->sendMessage(request);
    }
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
                qWarning()<<"ERROR:"<<fi.absoluteFilePath()<<"is not valid JSON file";
                continue;
            }

            hostsConfigs->insert(jsonObj["host"].toString(),jsonObj);

            hostsConfigsMapping->insert(jsonObj["host"].toString(),
                    QVariant::fromValue(hostsMapping->value(jsonObj["host"].toString())));
        }
    }
}


