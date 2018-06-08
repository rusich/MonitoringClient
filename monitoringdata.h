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

public:
    explicit MonitoringData(QQmlContext* ctx, QObject *parent = nullptr);
    bool getStatus();

public slots:
    void setStatus(bool newStatus);
    void parseMessage(QJsonObject* jsonReply);
    void gotError(QAbstractSocket::SocketError err);
    void connectClicked();
    void disconnectClicked();
    Q_INVOKABLE void getHost(QString hostname);
    void getHostsData();
    void getGroupsData();
    Q_INVOKABLE void getGraph(int graphid, int period, int width, int height);

signals:
    void statusChanged(QString newStatus);
    void error(QString err);
    void messageReceived(QJsonObject* jsonReply);
    void graphUpdated(const QVariant graph);
    void hostUpdated(const QString hostname);


private:
    MonitoringClient *client;
    QQmlContext* context;
    QJsonObject* hostConfigs;
    QQmlPropertyMap* hostConfigsMapping;
    QJsonObject* hosts;
    QQmlPropertyMap* hostsMapping;
    QJsonObject* groups;
    QQmlPropertyMap* groupsMapping;
    QTimer* dataGetTimer;
    void loadHosts();
};

#endif // BACKEND_H
