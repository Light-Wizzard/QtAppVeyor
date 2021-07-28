# QtAppVeyor

Every program needs a reason to exist,
this one exist becasue I was working on a project to update my [Galaxy Calculator](https://github.com/Light-Wizzard/galaxy-calculator) from QML,
to C++, so this Qt Application I want to work on as many Platforms as possible,
having had Galaxy Calculator program on [AppVeyor](https://appveyor.com) for a while,
I decided to give it a try,
but soon found it hard to get my project to work on Windows and Linux,
that program is more complex with Library's,
so I wanted to write a short Application that did something usefull to exist,
but at the same time it was only to test my AppVeyor Scripts,
it was then I decided why not make an AppVeyor Script Automation Tool,
and now my concept is to use the Yaml Script this Application puts out to deploy this Application.

This is project is for AppVeyor if they want to fork it and take it over as a community project,
to make it a better application, and give developers something that works,
so they can base their projects on this project,
and have it cross-complile into as many plateforms as possible.

This is a simple application written in Qt C++ using Widgets,
it uses SQL to store projects,
it is a simple app that has a settings page to enter in all the Variables needed to make an AppVeyor Yaml file,
so with a click of a bottom you can automate the creation of an .appveyor.yml file.

This App is basically just to show you how to deploy Qt C++ QtCreator Projects,
on Linux, Mac, Windows, and maybe WebAssembly and iOS, as well as Android,
and how to use the Qt Installer Framework to make Installable applications,
that are also updateable.

This project is not just geared for Qt Software developers,
it should be able to handle many different Envirnoments,
but currently Qt is the only Envirnoment I have been working on,
but I did add a button for different Envirnoments,
this way this tool will be usefull to every Software developer.

Index
1. [Status](https://github.com/Light-Wizzard/QtAppVeyor#Status)
2. [Development-Progress](https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
3. [Working-On](https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
4. [Variables](https://github.com/Light-Wizzard/QtAppVeyor#Variables)
5. [Database](https://github.com/Light-Wizzard/QtAppVeyor#Database)
6. [Help](https://github.com/Light-Wizzard/QtAppVeyor#Help)
7. [Screen-Shots](https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
8. [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

## Status
Unix: [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)
Windows: [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

### :package: **Downloads:**
 - :penguin: [Linux](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 - :penguin: :outbox_tray: [Linux Installer in work](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Linux-Installer)
 - :office: [Windows zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 - :office: :outbox_tray: [Windows Installer exe in work](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.exe)
 - :apple: [Apple](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.dmg)

Windows (Tested on 7 and 10 let me know if 8 works): Download zip and extract it, 
and run the file QtAppVeyor.exe inside of the deploy folder.

## Development-Progress

For more information see: [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

This is a work in progress, please report any bugs, and comments.

## Working-On

* Qt Installer Framework
* Updateable AppImage 
* Windows scripts instead of inline
* Mac
* Android
* WebAssembly
* iOS
* MSVS build of Qt Project

## Variables

If you use this Application to make .appveyor.yml files, 
you will need to know all these Variables,
even if you make your own file, you will have know these,
and manually maintain changes,
where as this app lets you just change the Variables and make a new file.

Each Variable is used in scripts to set up the application for deployment.

* MY_BIN_PRO_RES_NAME: Qt Projects name, ie. QtAppVeyor.pro, assumes exe name is the same.
* MY_OS: This is used to make package names, so no spaces
* MY_QT_VERSION: Qt Version
* MY_QT_IF_VERSION: Qt Installer Framework (QIF) Version
* MY_QIF_PACKAGE_URI: Folder for QIF Packages
* MY_PYTHON_VER: Python Version, note that Windows 7 stops at 3.8
* MY_PYTHON_REQUIRED: Is Python required
* MY_UPGRADE_OS: Unix system Upgrade
* MY_QT_MINGW32: MingW Paths
* MY_QT_MINGW32: MingW Paths
* MY_QT_TOOLS_MINGW32: MingW Paths
* MY_QT_TOOLS_MINGW64: MingW Paths

Unix

```yaml
MY_BIN_PRO_RES_NAME:  QtAppVeyor #
MY_OS:                Windows    # No Spaces, this shows up the file name, project-os-configuration-plateform format
MY_QT_VERSION:       5.15.2      # Qt Version
MY_QT_IF_VERSION:     '4.1.1'    # QT Installer Framework Version
MY_QIF_PACKAGE_URI:   'packages\com.url.qtappveyor\data' #
MY_PYTHON_VER:        3.8        # Last version Windows 7 can run is 3.8.x
MY_PYTHON_REQUIRED:   false      # if Python is required
MY_UPGRADE_OS: false             # apt-get upgrade: true or false only
```

Windows 

```yaml
MY_BIN_PRO_RES_NAME:  QtAppVeyor #
MY_OS:                Windows    # No Spaces, this shows up the file name, project-os-configuration-plateform format
MY_QT_VERSION:       5.15.2      # Qt Version
MY_QT_MINGW32:       mingw81_32  # Windows only Qt folder Variables
MY_QT_MINGW64:       mingw81_64  # Windows only Qt folder Variables
MY_QT_TOOLS_MINGW32: mingw810_32 # Windows only Qt folder Variables
MY_QT_TOOLS_MINGW64: mingw810_64 # Windows only Qt folder Variables
MY_QT_IF_VERSION:     '4.1.1'    # QT Installer Framework Version
MY_QIF_PACKAGE_URI:   'packages\com.url.qtappveyor\data' #
MY_PYTHON_VER:        3.8        # Last version Windows 7 can run is 3.8.x
MY_PYTHON_REQUIRED:   false      # if Python is required
```
## Database

```sql
Projects: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREATE TABLE Projects(id integer PRIMARY KEY autoincrement, 
                      QtProject varchar, 
                      Secret varchar, 
                      IsOsUbuntu varchar, 
                      IsOsMac varchar, 
                      IsOsWebAssembly varchar, 
                      IsOSiOS varchar, 
                      IsOsWindows varchar, 
                      IsOsAndroid varchar, 
                      IsX64 varchar, 
                      IsX86 varchar, 
                      IsDebug varchar, 
                      IsRelease varchar

Configuration: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID is Projects id

CREATE TABLE Configuration(id integer PRIMARY KEY autoincrement, 
                           ProjectsID varchar, 
                           OS varchar, 
                           QtVersion varchar, 
                           QtIfVersion varchar, 
                           QtIfPackageUri varchar, 
                           PythonVersion varchar, 
                           PythonRequired varchar, 
                           QtMingW32 varchar, 
                           QtMingW64 varchar, 
                           QtToolsMingW32 varchar, 
                           QtToolsMingW64 varchar, 
                           VisualStudio varchar, 
                           OsUpgrade varchar

```

## Help
This Application has built in Help on the app itself, 
but I will try to expand on the Help sections,
and add Wiki Content,
that might help.

## Screen-Shots
![Settings](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)
![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)
![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)
![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)
![Defaults](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)
![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

## End-of-README.md
