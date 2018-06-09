#include "settings.h"
#include <QSettings>
#include <QDir>
#include <QDebug>
#include <QRegExp>

Settings *Settings::Instance()
{
    static Settings * _instance = 0;
    if(_instance == 0) {
        _instance = new Settings();
        _instance->readSettings();
    }
    return _instance ;
}


void Settings::readSettings()
{
    qDebug()<<"read settings";
    QCoreApplication::setOrganizationName(OrganizationName);
    QCoreApplication::setOrganizationDomain(OrganizationDomain);
    QCoreApplication::setApplicationName(ApplicationName);
    QSettings settings(QCoreApplication::applicationDirPath()+
                       QDir::separator()+"settings.ini", QSettings::IniFormat);

    settings.beginGroup("Server");
    serverHostname = settings.value("Hostname","localhost").toString();
    serverPort = settings.value("Port","9999").toInt();
    username = settings.value("Username","Admin").toString();
    password = settings.value("Password","password").toString();
    settings.endGroup();

    settings.beginGroup("Client");
    updateInterval = settings.value("UpdateInterval","60000").toInt();
    settings.endGroup();

    QRegExp ValidIP("^(([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$");
    QRegExp ValidHostName("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$");
    if(!ValidIP.exactMatch(serverHostname))
    {
        if(!ValidHostName.exactMatch(serverHostname))
            errorMsg = "Host: неверное имя хоста "+serverHostname +". Должен быть ip-адрес или корректное имя хоста.\n";
    }

}

void Settings::writeSettings()
{
    QCoreApplication::setOrganizationName(OrganizationName);
    QCoreApplication::setOrganizationDomain(OrganizationDomain);
    QCoreApplication::setApplicationName(ApplicationName);
    QSettings settings(QCoreApplication::applicationDirPath()+
                       QDir::separator()+"settings.ini", QSettings::IniFormat);

    settings.beginGroup("Server");
    settings.setValue("Hostname", serverHostname);
    settings.setValue("Port", serverPort);
    settings.setValue("Username", username);
    settings.setValue("Password", password);
    settings.endGroup();
    settings.beginGroup("Client");
    settings.setValue("UpdateInterval", updateInterval);
    settings.endGroup();

    qDebug()<<"Writing settings done "<<serverHostname;
}

