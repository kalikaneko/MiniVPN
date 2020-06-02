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
    gui/libgoshim.h


TARGET=minivpn
LIBS += -L./lib -lgoshim -lpthread

DISTFILES += \
    README.md
