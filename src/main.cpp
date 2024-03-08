#include <qglobal.h>

#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
#include <QtGui/QApplication>
#else
#include <QtWidgets/QApplication>
#endif
#include <QTranslator>
#include <QLocale>

#include "qmlapplicationviewer.h"

#include "guibehind.h"
#include "duktowindow.h"

#include <QDebug>

#if defined(ANDROID)
#include "debug/qDebug2Logcat.h"
#include "LockHelper.h"
#endif

#if defined(Q_OS_S60)
#define SYMBIAN
#endif

#if defined(Q_OS_SIMULATOR)
#define SYMBIAN
#endif

#ifndef SYMBIAN
#include "qtsingleapplication.h"
#endif

int main(int argc, char *argv[])
{
#if defined(ANDROID)
    installLogcatMessageHandler("DUKTO:");
#endif
#if defined(Q_OS_UNIX)
#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
    QApplication::setGraphicsSystem("raster");
#endif
#elif defined (Q_OS_WIN)
    qputenv("QML_ENABLE_TEXT_IMAGE_CACHE", "true");
#endif

#if defined(SYMBIAN)
    QApplication app(argc, argv);
#else
    QApplication::setApplicationName("dukto");
    QApplication::setOrganizationName("idv.coolshou");
    QApplication::setApplicationVersion(APP_VERSION);
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

// Check for single running instance
#define SINGLE
#if defined(SINGLE)
    QtSingleApplication app(argc, argv);
    if (app.isRunning()) {
        app.sendMessage("FOREGROUND");
        return 0;
    }
#else
    QApplication app(argc, argv);
    app.setAcceptDrops(true);
    app.setWindowTitle("Dukto");
#endif
    app.setWindowIcon(QIcon(":/dukto.png"));

#endif
    //translator
    QString locale = QLocale::system().name();
    QTranslator translator;
    if (translator.load(locale, ":/language")) {
        app.installTranslator(&translator);
    } else {
        qDebug() << "Could not load translations language of " << locale;
    }

    //DuktoWindow viewer;
    DuktoWindow *viewer = new DuktoWindow();

#ifndef SYMBIAN
#if QT_VERSION < QT_VERSION_CHECK(5, 0, 0)
    //TODO: QtQuick 2 app.setActivationWindow
    app.setActivationWindow(viewer, true);
#endif
#endif
    //GuiBehind gb(&viewer);
    GuiBehind gb(viewer);

#ifndef Q_OS_S60
    //viewer.showExpanded();
    viewer->showExpanded();
    app.installEventFilter(&gb);

    // Disable the maximize button and set fixed window size
    viewer->setFlags(viewer->flags() & ~(Qt::WindowMaximizeButtonHint));
    viewer->setFlags( Qt::Window | Qt::CustomizeWindowHint | Qt::WindowTitleHint | Qt::WindowSystemMenuHint | Qt::WindowMinimizeButtonHint | Qt::WindowCloseButtonHint );
    viewer->setMinimumSize(QSize(360, 600));
    viewer->setMaximumSize(QSize(360, 600));
#else
    viewer.showFullScreen();
    gb.initConnection();
#endif

    int retVal = app.exec();
    qDebug() << "App exiting with code:" << QString::number(retVal);
    return retVal;
}
