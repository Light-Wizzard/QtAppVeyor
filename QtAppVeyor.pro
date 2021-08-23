# QtAppVeyor.pro
# Specifies the name of the template to use when generating the project.
# The allowed values are: app, lib, subdirs, aux, vcapp or vclib
TEMPLATE = "app"
QT      += core gui sql widgets network printsupport
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
# Specifies the name of the target file. Contains the base name of the project file by default.
# Do not use Spaces in Target Name
# This pro(ject) file is based on a pattern
TARGET = "QtAppVeyor"
##-------------------------------------------------------------------------------------
INCLUDEPATH     += .
INCLUDEPATH     += src
INCLUDEPATH     += "${QT_INSTALL_LIBS}/qt"
##-------------------------------------------------------------------------------------
#CONFIG += c++17
#
#win32:QMAKE_CC     += "C:\Qt\Tools\$env:MY_QT_TOOLS_MINGW64\bin\gcc.exe"
#win32:QMAKE_CXX    += "C:\Qt\Tools\$env:MY_QT_TOOLS_MINGW64\bin\g++.exe"
##
#win32:CONFIG       += static
#win32:DEFINES      += STATIC
#win32:QMAKE_LFLAGS += -static
#
win32:CONFIG       *= windeployqt windows
# Source
SOURCES += src/main.cpp \
    src/MainWindow.cpp \
    src/MyDatatables.cpp \
    src/MyLocalization.cpp \
    src/MyOrgSettings.cpp \
    src/MySqlDbtModel.cpp \
    src/SimpleCrypt.cpp
# Headers
HEADERS += src/MainWindow.h \
    src/MyConstants.h \
    src/MyDatatables.h \
    src/MyLocalization.h \
    src/MyOrgSettings.h \
    src/MySqlDbtModel.h \
    src/SimpleCrypt.h
# Forms
FORMS += src/MainWindow.ui
# Resources
RESOURCES   += QtAppVeyor.qrc
# Translations
CONFIG += localize_deployment
SYMBIAN_SUPPORTED_LANGUAGES += zh_CN
SYMBIAN_LANG.zh_CN = 31
CONFIG += lrelease
CONFIG += embed_translations
LRELEASE_DIR=./translations
QM_FILES_RESOURCE_PREFIX=./translations
# ar,de,en,es,fr,it,ja,no,ru,sv,zh_CN
TRANSLATIONS += translations/QtAppVeyor_ar.ts \
                translations/QtAppVeyor_de.ts \
                translations/QtAppVeyor_en.ts \
                translations/QtAppVeyor_es.ts \
                translations/QtAppVeyor_fr.ts \
                translations/QtAppVeyor_it.ts \
                translations/QtAppVeyor_ja.ts \
                translations/QtAppVeyor_no.ts \
                translations/QtAppVeyor_ru.ts \
                translations/QtAppVeyor_sv.ts \
                translations/QtAppVeyor_zh_CN.ts
# Distrobution Files
DISTFILES += \
    .appveyor.yml \
    CMakeLists.txt \
    README.md \
    help/About-Author_en.md \
    help/About_en.md \
    help/Help_en.md \
    scripts/build_script.cmd \
    scripts/build_script.ps1 \
    scripts/build_script.sh \
    scripts/install.cmd \
    scripts/install.ps1 \
    scripts/install.sh \
    scripts/upload.sh \
    .github/workflows/main.yml \
    Doxyfile
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
win32-g++{
    contains(QMAKE_HOST.arch, x86_64) { #x64
        DEFINES += MINGW_X64
    } else { #x32
        DEFINES += MINGW_X32
    }
    CONFIG(release, debug|release) {
        #release
        QMAKE_CXXFLAGS += -O2 -Os -msse2 -ffp-contract=fast -fpic
    }
    else {
        #debug
        DEFINES += _DEBUG
        QMAKE_CXXFLAGS += -O0 -g3 -msse2 -fpic
    }
}
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
