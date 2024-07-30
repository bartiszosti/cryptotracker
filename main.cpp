#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlExtensionPlugin>

Q_IMPORT_QML_PLUGIN(CryptocurrenciesPlugin)

int main(int argc, char *argv[])
{
  const QGuiApplication app{argc, argv};

  QQmlApplicationEngine engine;
  QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app, [] {
    QCoreApplication::exit(-1);
  }, Qt::QueuedConnection);
  engine.load(QUrl{"qrc:/CryptoTracker/Main.qml"});

  return QGuiApplication::exec();
}
