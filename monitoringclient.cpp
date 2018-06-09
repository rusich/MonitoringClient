#include "monitoringclient.h"

MonitoringClient::MonitoringClient(QObject *parent)
    : QObject(parent), nextMessageSize(0)
{
    status = false;
    serverSocket = new QTcpSocket();

    timeoutTimer = new QTimer();
    timeoutTimer->setSingleShot(true);

    connect(timeoutTimer, SIGNAL(timeout()), this, SLOT(connectionTimeout()));
    connect(serverSocket, SIGNAL(disconnected()), this, SLOT(closeConnection()));
}

void MonitoringClient::connectToServer(const QString hostAddress, int portNumber)
{
    timeoutTimer->start(5000);

    serverSocket->connectToHost(hostAddress, portNumber);
    connect(serverSocket,SIGNAL(connected()), this, SLOT(connected()));
    connect(serverSocket,SIGNAL(readyRead()), this, SLOT(readMessage()));
}

void MonitoringClient::connectionTimeout()
{
    if(serverSocket->state() == QAbstractSocket::ConnectingState)
    {
        serverSocket->abort();
        emit serverSocket->error(QAbstractSocket::SocketTimeoutError);
    }
}

void MonitoringClient::connected()
{
    status = true;
    emit statusChanged(status);
}

bool MonitoringClient::getStatus()
{
    return status;
}

quint64 MonitoringClient::sendMessage(QJsonObject *jsonRequest)
{
    QByteArray sendBuff;
    QDataStream out(&sendBuff, QIODevice::WriteOnly);
    QJsonDocument jsonDoc(*jsonRequest);
    QByteArray uncompressedMessage = jsonDoc.toJson(QJsonDocument::Compact);
    QByteArray compressedMessage = qCompress(uncompressedMessage,9);
    out << quint16(0) << compressedMessage;
    out.device()->seek(0);
    out << quint16(sendBuff.size() - sizeof(quint16));

    emit netOut();
    return serverSocket->write(sendBuff);
}

void MonitoringClient::readMessage()
{
    QDataStream in(serverSocket);
    while(true)
    {
        emit netIn();
        if(!nextMessageSize)
        {
            if((quint64)serverSocket->bytesAvailable()<sizeof(quint16)) {break;}
            in>>nextMessageSize;
        }


        if (serverSocket->bytesAvailable() < nextMessageSize) { break; }

        QByteArray compressedMessage;
        QByteArray uncompressedMessage;
        in>>compressedMessage;
        uncompressedMessage = qUncompress(compressedMessage);
        QJsonDocument jsonDoc= QJsonDocument::fromJson(uncompressedMessage);
        QJsonObject* jsonReply = new QJsonObject(jsonDoc.object());

        emit messageReceived(jsonReply);

        nextMessageSize = 0;
    }
}

void MonitoringClient::gotDisconnection()
{
    status = false;
    emit statusChanged(status);
}

void MonitoringClient::closeConnection()
{
    timeoutTimer->stop();

    qDebug() << serverSocket->state();
    disconnect(serverSocket, &QTcpSocket::connected, 0, 0);
    disconnect(serverSocket, &QTcpSocket::readyRead, 0, 0);

    bool shouldEmit = false;
    switch (serverSocket->state())
    {
        case 0:
            serverSocket->disconnectFromHost();
            shouldEmit = true;
            break;
        case 2:
            serverSocket->abort();
            shouldEmit = true;
            break;
        default:
            serverSocket->abort();
    }

    if (shouldEmit)
    {
        status = false;
        emit statusChanged(status);
    }
}
