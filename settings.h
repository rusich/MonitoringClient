#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QString>
#include <QCoreApplication>

const QString OrganizationName = "rusich";
const QString OrganizationDomain = "https://github.com/rusich";
const QString ApplicationName = "MonitoringClient";

class Settings: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString serverHostname MEMBER serverHostname)
    Q_PROPERTY(int serverPort MEMBER serverPort)
    Q_PROPERTY(QString username MEMBER username)
    Q_PROPERTY(QString password MEMBER password)
    Q_PROPERTY(int updateInterval MEMBER updateInterval)
    Q_PROPERTY(QString errorMsg MEMBER errorMsg NOTIFY errorMsgChanged)
private:
    Settings() { }
    Settings(const Settings&) = delete;
    Settings& operator=(const Settings&) = delete;
public:
    ~Settings() {writeSettings();}
    static Settings* Instance();
    QString serverHostname;
    int serverPort;
    QString username;
    QString password;
    int updateInterval;
    QString errorMsg;
    void readSettings();
    void writeSettings();
signals:
    void errorMsgChanged();
};

#endif // SETTINGS_H
