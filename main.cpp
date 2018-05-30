#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "monitoringdata.h"
#include <QQmlPropertyMap>
#include <QQmlContext>
#include <QDir>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
//    qmlRegisterType<MonitoringData>("MonitoringData", 1, 0, "MonitoringData");


    QQmlApplicationEngine engine;
//    engine.addImportPath(QCoreApplication::applicationDirPath()+
//                          QDir::separator()+"imports"+QDir::separator());
    engine.load(QUrl(QStringLiteral("qrc:/dashboard.qml")));
    MonitoringData dat(engine.rootContext(), &app);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
