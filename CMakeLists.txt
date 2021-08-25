cmake_minimum_required(VERSION 3.1.0)

project(QtAppVeyor)
set(APP_VERSION "0.1.0")
# [Using CMake with Qt 5](http://www.kdab.com/using-cmake-with-qt-5/)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
#
if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()
#
find_package(Qt5 COMPONENTS REQUIRED Core Gui Widgets Sql PrintSupport Network LinguistTools LinguistTools Concurrent)
#3DAnimation             Help                    QuickWidgets
#3DCore                  LinguistTools           RemoteObjects
#3DExtras                Location                RepParser
#3DInput                 Multimedia              Scxml
#3DLogic                 MultimediaWidgets       Sensors
#3DQuick                 Network                 SerialPort
#3DQuickAnimation        Nfc                     Sql
#3DQuickExtras           OpenGL                  Svg
#3DQuickInput            OpenGLExtensions        Test
#3DQuickRender           Positioning             TextToSpeech
#3DQuickScene2D          PositioningQuick        UiPlugin
#3DRender                PrintSupport            UiTools
#AndroidExtras           Qml                     WebChannel
#Bluetooth               Quick                   WebSockets
#Concurrent              QuickCompiler           WebView
#Core                    QuickControls2          Widgets
#Gamepad                 QuickTemplates2         Xml
#Gui                     QuickTest               XmlPatterns
# Libraries
set(QT5_LIBRARIES Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Sql Qt5::PrintSupport Qt5::Network)
#
set(TARGET ${CMAKE_PROJECT_NAME})
# Source
set(SOURCES
    src/main.cpp
    src/MainWindow.cpp
    src/MyDatatables.cpp
    src/MyLocalization.cpp
    src/MyOrgSettings.cpp
    src/MySqlDbtModel.cpp
    src/SimpleCrypt.cpp
)
# UI
set(UI_SOURCES src/MainWindow.ui)
#
qt5_add_resources(SOURCES QtAppVeyor.qrc)
# https://github.com/pedrolcl/qt5-i18n
# not sure if I need to add en since it is the default
set(TS_FILES
    translations/QtAppVeyor_ar.ts
    translations/QtAppVeyor_de.ts
    translations/QtAppVeyor_en.ts
    translations/QtAppVeyor_es.ts
    translations/QtAppVeyor_fr.ts
    translations/QtAppVeyor_it.ts
    translations/QtAppVeyor_ja.ts
    translations/QtAppVeyor_no.ts
    translations/QtAppVeyor_ru.ts
    translations/QtAppVeyor_sv.ts
    translations/QtAppVeyor_zh_CN.ts
)
set(TRANSLATION_QM
    translations/QtAppVeyor_ar.qm
    translations/QtAppVeyor_de.qm
    translations/QtAppVeyor_en.qm
    translations/QtAppVeyor_es.qm
    translations/QtAppVeyor_fr.qm
    translations/QtAppVeyor_it.qm
    translations/QtAppVeyor_ja.qm
    translations/QtAppVeyor_no.qm
    translations/QtAppVeyor_ru.qm
    translations/QtAppVeyor_sv.qm
    translations/QtAppVeyor_zh_CN.qm
)#
if (QT_VERSION VERSION_LESS 5.15.0)
    qt5_add_translation(QM_FILES ${TS_FILES})
else()
    qt_add_translation(QM_FILES ${TS_FILES})
endif()
#
if (UNIX AND NOT APPLE)
    install (FILES ${TRANSLATION_QM} DESTINATION ${CMAKE_SOURCE_DIR}/translations)
endif (UNIX AND NOT APPLE)
#
#qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} QtAppVeyor_en_US.ts)
# The qm files are generated in the build tree, but the qrc file is inside the
# source directory and the path to resources are relative to the location of
# the qrc file itself. We use configure_file() to copy the qrc file in the build
# directory such that it can find the qm translations files. The qrc file is
# copied if it doesn't exist in the destination or if it is modified.
#configure_file(QtAppVeyor.qrc ${CMAKE_BINARY_DIR} COPYONLY)
# The Qt5Widgets_INCLUDES also includes the include directories for dependencies QtCore and QtGui
include_directories(${Qt5Widgets_INCLUDES})
# We need add -DQT_WIDGETS_LIB when using QtWidgets in Qt 5.
add_definitions(${Qt5Widgets_DEFINITIONS})
#
include_directories(${CMAKE_CURRENT_BINARY_DIR})
# Executables fail to build with Qt 5 in the default configuration without -fPIE, added here.
set(CMAKE_CXX_FLAGS "${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
#
# Generate necessary headers from .ui files. (qmake lets `uic` do this job.)
# hint from [Cross-platform Qt5 project using cmake](http://stackoverflow.com/questions/21174586/cross-platform-qt5-project-using-cmake)
#
qt5_wrap_ui(UI_GENERATED_HEADERS ${UI_SOURCES})
#
#
# IMPORTANT: Adding generated headers to target as dependencies
# hint from [unable to include a ui_form header of QT5 in cmake](http://stackoverflow.com/questions/16245147/unable-to-include-a-ui-form-header-of-qt5-in-cmake)
#
add_executable(${TARGET} ${SOURCES} ${UI_GENERATED_HEADERS} ${APP_RES} ${QT_RES})
#
# `target_link_libraries()` rather than `qt5_use_modules()` for CMake 2.8.11 or later
# hint from [CMake & QT5 - QT5_WRAP_UI not generating ui header files](http://stackoverflow.com/questions/25875255/cmake-qt5-qt5-wrap-ui-not-generating-ui-header-files)
#
target_link_libraries(${TARGET} ${QT5_LIBRARIES})
# libQt5Sql.so.5 missing tried this with and without lib changes
install(TARGETS ${TARGET}
  RUNTIME DESTINATION /usr/bin
  LIBRARY DESTINATION /usr/lib
  ARCHIVE DESTINATION /usr/lib
)
# ***************************** End of cmake **********************************
