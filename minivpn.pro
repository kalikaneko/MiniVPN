CONFIG += qt staticlib
# TODO remove this in cross build?
unix:CONFIG += debug
lessThan(QT_MAJOR_VERSION, 5): error("requires Qt 5")

QT += qml quick

SOURCES += \
    src/main.cpp \
    src/qjsonmodel.cpp \
    src/handlers.cpp

RESOURCES += src/qml.qrc

HEADERS += \
    src/handlers.h \
    src/qjsonmodel.h \
    lib/libgoshim.h


TARGET=minivpn
LIBS += -L./lib -lgoshim -lpthread

DISTFILES += \
    README.md
