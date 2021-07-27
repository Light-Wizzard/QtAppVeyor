# QtAppVeyor

I have Qt C++ and QML applications that I wanted to make Qt Installers for, 
and I wanted to use [AppVeyor](https://appveyor.com),
figuring out how is a lot of work, and I could not find a Site that had a Turial on how to do this,
so I decided to make a Project just for AppVeyor deployments in Linux, Mac, and Windows,
I would like to add Android at some point, but I need to get these 3 working,
I was having issues getting an application to run, it has a lot of Library calls that can add to the mix,
making it hard to figure out what is going on, so I needed a simple application,
that can compile without the need of extra Library's.

This is project is for AppVeyor if they want to move it to their account and take it over.

This is a simple application written in Qt C++ using Widgets, 
it is a simple app that has a settings page to enter in all the Variables needed to make an AppVeyor Yaml file,
so with a click of a bottom you can automate the creation of .appveyor.yml file.

This App is basically just to show you how to deploy Qt C++ QtCreator Projects,
on Linux, Mac, and Windows,
and how to use the Qt Installer Framework to make Installable applications.


## Status
Unix: [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)
Windows: [![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

## :package: **Downloads:**
 - :penguin: [Linux](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-x86_64.AppImage)
 - :penguin: :outbox_tray: [Linux Installer in work](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Linux-Installer)
 - :office: [Windows zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows.zip)
 - :office: :outbox_tray: [Windows Installer exe](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.exe)
 - :apple: [Apple](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.dmg)


Windows (Tested on 7 and 10 let me know if 8 works): Download zip and extract it, 
and run the file QtAppVeyor.exe inside of the deploy folder.


## Development Progress


For more information see: [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

This is a work in progress, please report any bugs, and comments.

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

## More Help
This Application has built in Help on the app itself.


End of README.md
