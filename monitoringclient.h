#ifndef MONITORINGCLIENT_H
#define MONITORINGCLIENT_H

#include <QObject>
#include <QString>
#include <QTcpSocket>
#include <QDataStream>
#include <QTimer>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QUuid>
#include <QQmlContext>

class MonitoringClient : public QObject
{
    Q_OBJECT
public:
    explicit MonitoringClient(QObject *parent = nullptr);

    QTcpSocket* serverSocket;
    bool getStatus();
    quint64 sendMessage(QJsonObject *jsonRequest);

public slots:
    void connectToServer(const QString hostAddress, int portNumber);
    void closeConnection();
    void connected();
    void connectionTimeout();
    void readMessage();
    void gotDisconnection();

signals:
    void statusChanged(bool);
    void messageReceived(QJsonObject* jsonReply);
    void netIn();
    void netOut();

private:
    QString host;
    int port;
    bool status;
    quint16 nextMessageSize;
    QTimer* timeoutTimer;
};

#endif // MONITORINGCLIENT_H
