QT       += gui
Debug:TARGET = Preprocessingd
Release:TARGET = Preprocessing
TEMPLATE = lib

DEFINES += PREPROCESSING_LIBRARY CPU_ONLY
DEFINES -= NO_CPU
DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += PRO_PWD=\\\"$$_PRO_FILE_PWD_\\\"
unix: PKGCONFIG += opencv
CONFIG += afcpu link_pkgconfig
QMAKE_CFLAGS_ISYSTEM=

SOURCES += preprocessing.cpp \
    orientationmap.cpp \
    thinning.cpp \
    binarization.cpp \
    gaborfiltermultithread.cpp \
    gaborthread.cpp \
    contrastenhancement.cpp \
    frequencymap.cpp \
    mask.cpp \
    qualitymap.cpp \
    gaborfiltergpu.cpp \
    preprocessing_caffenetwork.cpp

HEADERS += preprocessing.h\
        preprocessing_global.h \
    helper.h \
    orientationmap.h \
    thinning.h \
    binarization.h \
    gaborfiltermultithread.h \
    gaborthread.h \
    contrastenhancement.h \
    frequencymap.h \
    mask.h \
    imagecontour.h \
    qualitymap.h \
    gaborfiltergpu.h \
    preprocessing_config.h \
    preprocessing_caffenetwork.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

QMAKE_CFLAGS += lrt
unix:!macx: LIBS += -L/usr/local/lib -lafcpu \
                    -L/usr/lib/ -lprotobuf

unix:!macx: LIBS += -L/usr/lib/ -lboost_system\
                    -L/usr/lib/ -lpthread
INCLUDEPATH += /usr/include
DEPENDPATH += /usr/include

INCLUDEPATH += /usr/local/include
DEPENDPATH += /usr/local/include
