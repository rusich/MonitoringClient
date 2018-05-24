#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include "monitoringclient.h"

class Backend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool currentStatus READ getStatus NOTIFY statusChanged)

public:
    explicit Backend(QObject *parent = nullptr);
    bool getStatus();

public slots:
    void setStatus(bool newStatus);
    void receivedSomething(QJsonObject* jsonReply);
    void gotError(QAbstractSocket::SocketError err);
    void sendClicked(QString msg);
    void connectClicked();
    void disconnectClicked();

signals:
    void statusChanged(QString newStatus);
    void someError(QString err);
    void messageReceived(QJsonObject* jsonReply);


private:
    MonitoringClient *client;
};

#endif // BACKEND_H
