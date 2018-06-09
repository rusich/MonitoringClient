#include <QApplication>
#include <QQmlApplicationEngine>
#include "monitoringdata.h"
#include <QQmlPropertyMap>
#include <QQmlContext>
#include <QDir>
#include "settings.h"

static QObject *settings_qml_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    Settings * s = Settings::Instance();
    return s;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    //    qmlRegisterType<MonitoringData>("MonitoringData", 1, 0, "MonitoringData");

    qmlRegisterSingletonType<Settings>("MonitoringClient.Settings", 1, 0, "Settings", settings_qml_provider);
    QQmlApplicationEngine engine;
    //    engine.addImportPath(QCoreApplication::applicationDirPath()+
    //                          QDir::separator()+"imports"+QDir::separator());
    engine.load(QUrl(QStringLiteral("qrc:/dashboard.qml")));
    MonitoringData dat(engine.rootContext(), &app);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
