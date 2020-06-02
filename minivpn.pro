CONFIG += qt staticlib console
unix:CONFIG += debug
lessThan(QT_MAJOR_VERSION, 5): error("requires Qt 5")

QT += qml quick

SOURCES += \
    gui/main.cpp \
    gui/qjsonmodel.cpp \
    gui/handlers.cpp

RESOURCES += gui/qml.qrc

HEADERS += \
    gui/handlers.h \
    gui/qjsonmodel.h \
    lib/libgoshim.h


TARGET=minivpn
LIBS += -L./lib -lgoshim -lpthread

DISTFILES += \
    README.md

DESTDIR = release
DESTDIR = release
OBJECTS_DIR = release/.obj
MOC_DIR = release/.moc
RCC_DIR = release/.rcc
UI_DIR = release/.ui

Release:DESTDIR = release
Release:DESTDIR = release
Release:OBJECTS_DIR = release/.obj
Release:MOC_DIR = release/.moc
Release:RCC_DIR = release/.rcc
Release:UI_DIR = release/.ui

Debug:DESTDIR = debug
Debug:OBJECTS_DIR = debug/.obj
Debug:MOC_DIR = debug/.moc
Debug:RCC_DIR = debug/.rcc
Debug:UI_DIR = debug/.ui
