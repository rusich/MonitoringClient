#include "backend.h"

Backend::Backend(QObject *parent) : QObject(parent)
{
    client = new MonitoringClient("localhost", 9999);

    //setStatus(client->get_status());

    connect(client, &MonitoringClient::messageReceived, this, &Backend::messageReceived);
    connect(client, &MonitoringClient::statusChanged, this, &Backend::setStatus);
    connect(client->serverSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(gotError(QAbstractSocket::SocketError)));
}

bool Backend::getStatus()
{
    return client->getStatus();
}

void Backend::setStatus(bool newStatus)
{
    //qDebug() << "new status is:" << newStatus;
    if (newStatus)
        { emit statusChanged("CONNECTED"); }
    else
        { emit statusChanged("DISCONNECTED"); }
}

void Backend::receivedSomething(QJsonObject* jsonReply)
{
    emit messageReceived(jsonReply);
}

void Backend::gotError(QAbstractSocket::SocketError err)
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

    emit someError(strError);
}

void Backend::connectClicked()
{
    client->connectToServer();
}

void Backend::sendClicked(QString msg)
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

void Backend::disconnectClicked()
{
    client->closeConnection();
}
