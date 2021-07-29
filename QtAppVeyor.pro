# QtAppVeyor.pro
# Specifies the name of the template to use when generating the project.
# The allowed values are: app, lib, subdirs, aux, vcapp or vclib
TEMPLATE = "app"
QT      += core gui sql
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport
#qtHaveModule(printsupport):       QT *= printsupport
CONFIG += c++11
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
# Specifies the name of the target file. Contains the base name of the project file by default.
# Do not use Spaces in Target Name
# This pro(ject) file is based on a pattern
TARGET = "QtAppVeyor"

win32:QMAKE_CC = gcc
win32:QMAKE_CXX = g++

SOURCES += main.cpp \
    AboutDialog.cpp \
    HelpDialog.cpp \
    MainWindow.cpp \
    MyOrgSettings.cpp \
    MySqlDbtModel.cpp \
    SimpleCrypt.cpp

HEADERS += \
    AboutDialog.h \
    HelpDialog.h \
    MainWindow.h \
    MyOrgSettings.h \
    MySqlDbtModel.h \
    QtAppVeyorConstants.h \
    SimpleCrypt.h

FORMS += AboutDialog.ui MainWindow.ui \
    HelpDialog.ui

# Resources
RESOURCES   += QtAppVeyor.qrc
#
TRANSLATIONS += QtAppVeyor_en_US.ts
CONFIG += lrelease
CONFIG += embed_translations

win32:CONFIG   *= windeployqt
win32:CONFIG   *= windows
# Version Numver Controls
win32:VERSION   = 0.1.0.0 # major.minor.patch.build
else:VERSION    = 0.1.0   # major.minor.patch
DEFINES         = APP_VERSION=\\\"$${VERSION}\\\"

DISTFILES += \
    .appveyor.yml \
    CMakeLists.txt \
    README.md \
    help/About-en.html \
    help/Help-en.html \
    scripts/build_script.cmd \
    scripts/build_script.ps1 \
    scripts/build_script.sh \
    scripts/install.cmd \
    scripts/install.ps1 \
    scripts/install.sh \
    scripts/upload.sh

###############################################################################
#
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
#DEFINES += QT_DEPRECATED_WARNINGS
#
# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
#
#
macos:QMAKE_INFO_PLIST = macos/Info.plist
ios:QMAKE_INFO_PLIST   = ios/Info.plist
#
#DESTDIR = "$${OUT_PWD}"
#release: DESTDIR = "$${OUT_PWD}/build/release"
#debug:   DESTDIR = "$${OUT_PWD}/build/debug"

#OBJECTS_DIR = "$${DESTDIR}/obj"
#MOC_DIR     = "$${DESTDIR}/moc"
#RCC_DIR     = "$${DESTDIR}/qrc"
#UI_DIR      = "$${DESTDIR}/ui"
#
unix {
    isEmpty(PREFIX) {
        PREFIX = /usr
    }
    target.path         = "$${PREFIX}/bin"
    shortcutfiles.files = "usr/share/applications/$${TARGET}.desktop"
    shortcutfiles.path  = usr/share/applications
    data.files         += "usr/share/icons/hicolor/48x48/apps/$${TARGET}.png"
    data.path           = usr/share/pixmaps
    INSTALLS           += shortcutfiles
    INSTALLS           += data
    INSTALLS           += target
    macx {
        RC_FILE = macos/Icon.icns
    }
} else {
    isEmpty(PREFIX) {
        PREFIX = /usr
    }
    target.path         = "$${PREFIX}/bin"
    shortcutfiles.files = "usr/share/applications/$${TARGET}.desktop"
    shortcutfiles.path  = usr/share/applications
    data.files         += "usr/share/icons/hicolor/48x48/apps/$${TARGET}.png"
    data.path           = usr/share/pixmaps
    INSTALLS           += shortcutfiles
    INSTALLS           += data
    INSTALLS           += target
}
################################ End of File ##################################
