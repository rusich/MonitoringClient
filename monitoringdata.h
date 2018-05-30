#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QQmlContext>
#include <QQmlPropertyMap>
#include <QTimer>
#include "monitoringclient.h"

class MonitoringData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool currentStatus READ getStatus NOTIFY statusChanged)
    Q_PROPERTY(QJsonObject data MEMBER data)

public:
    explicit MonitoringData(QQmlContext* ctx, QObject *parent = nullptr);
    bool getStatus();

public slots:
    void setStatus(bool newStatus);
    void parseMessage(QJsonObject* jsonReply);
    void gotError(QAbstractSocket::SocketError err);
    void sendClicked(QString msg);
    void connectClicked();
    void disconnectClicked();
    void getHostsData();

signals:
    void statusChanged(QString newStatus);
    void networkError(QString err);
    void messageReceived(QJsonObject* jsonReply);


private:
    MonitoringClient *client;
    QJsonObject data;
    QQmlContext* context;
    QJsonObject* hostsConfigs;
    QQmlPropertyMap* hostsConfigsMapping;
    QJsonObject* hosts;
    QQmlPropertyMap* hostsMapping;
    QTimer* dataGetTimer;
    void loadHosts();
};

#endif // BACKEND_H
