# QtAppVeyor

Every program needs a reason to exist,
this one exist because I was working on a project to update my [Galaxy Calculator](https://github.com/Light-Wizzard/galaxy-calculator) from QML,
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
and have it cross-complile into as many platforms as possible.

This is a simple application written in Qt C++ using Widgets,
it uses SQL to store projects,
it is a simple app that has a settings page to enter in all the Variables needed to make an AppVeyor Yaml file,
so with a click of a bottom you can automate the creation of an .appveyor.yml file.

This App is basically just to show you how to deploy Qt C++ QtCreator Projects,
on Linux, Mac, Windows, and maybe WebAssembly and iOS, as well as Android,
and how to use the Qt Installer Framework to make Installable applications,
that are also update-able.

This project is not just geared for Qt Software developers,
it should be able to handle many different Environments,
but currently Qt is the only Environment I have been working on,
but I did add a button for different Environments,
this way this tool will be useful to every Software developer.

My biggest issue is lack of Windows Scripting experience, 
I have not used Windows in Decades, and only recently bought Windows 10 Pro,
just to use Word, and I do not do Mac, so Linux is really all I can get to work,
so I can really use some help writing the Scripts.

Qt is moving to cmake in version 6, so I have no choice but to move away from qmake.

For Windows I am not sure if MingW is the right tool, or if VS is,
or if I should use MSYS, or Cygwin.

## Table of Content

1. [Broken](https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Status](https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Development-Progress](https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Working-On](https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variables](https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Database](https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Help](https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Screen-Shots](https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile](https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen Documention](https://light-wizzard.github.io/QtAppVeyor)

# Broken

Things that are Broken need to be worked on first, 
these are the things I need help with.

1. Qt installer Framework.
2. Mac, WebAssembly, iOS, and Android.
3. cmake, the future of Qt 6.

Issues: Windows complies but does not run due to dll's that are in the same folder, this is a qmake project, 
and I have created a working cmake file, and I really do need to switch over to cmake for all the whole project,
and that is what I am currently working on, but my lack of Windows scripting, PowerShell or Command,
I understand the languge somewhat, having had to write some over the years,
my goal is to put all the scripts into two files, one for Install, the other for the Build,
I want to make a Qt Installer Framework package with [Qt Auto Updates](https://github.com/Skycoder42/QtAutoUpdater),
this GitHub project is geared to Qt Installer Framework,
as such, I want to only make one zip file with the Qt Installer package.

If I can get all these things working, I would like to see if AppVeyor would fork it,
and we can work on it there, I wrote this for them to give to others, 
to help them get their Applications published with ease,
the concept is simple, this application use most of the features most people want, 
Qt Settings to store variables, and SQL,
so if you can get this to work for all the OS's that Qt Supports,
it will make it much easier for peopel to copy how this was done,
so this project needs a lot of work to make it a best practist example,
so you can see that I have only added a minimal number of features that are easy to expand on.

I need feedback on what you think about the concept,
than the Application, what features you would want to see in it,
and really I need to know what scripts to run to make this all work,
I am good at bash, but not so much PowerShell or CMD,
and not much into Mac, iOS, but I do have an Android.

I want to see this Application become the Standard for AppVeyor to recommend using,
and why they need to fork it, and make it theirs,
I am just trying to give them something worth taking over,
and why I have branded it QtAppVeyor, and tried to make all the documention easy to clean,
and Doxygen ready, the Translation needs to be done,
but I always wait to till the end to start on it.

# Status

[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

### :package: **Downloads:**

 - :penguin: [Linux x86 zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip) [Linux x64 zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x64.zip)
 - :office: [Windows x86 zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip) [Windows x64 zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x64.zip)
 - :apple: Currenty unavalible [Apple zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Currenty, Windows is not working, if it was, it would say something like this:

Windows (Tested on 7 and 10 let me know if 8 works): Download zip and extract it, 
and run the file QtAppVeyor.exe inside of the deploy AppDir folder.

When completed, it will only have one Artifact, the Qt Installer Framework with Qt Auto Update in a zip file.

# Development-Progress

For more information see: [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

This is a work in progress, please report any bugs, and leave comments.

# Working-On

* cmake instead of qmake
* Qt Installer Framework
* Updateable AppImage 
* Windows scripts instead of inline
* Mac
* Android
* WebAssembly
* iOS
* MSVS build of Qt Project

# Variables

If you use this Application to make .appveyor.yml files, 
you will need to know all these Variables,
even if you make your own file, you will have know these,
and manually maintain changes,
where as this app lets you just change the Variables and make a new file.

Each Variable is used in scripts to set up the application for deployment.

* MY_BIN_PRO_RES_NAME: Qt Projects name, ie. QtAppVeyor.pro, assumes exe name is the same.
* MY_OS: This is used to make package names, so no spaces
* MY_VS_VERSION: Qt Version
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
MY_QT_VERSION:        5.15.2     # Qt Version
MY_QT_IF_VERSION:     '4.1.1'    # QT Installer Framework Version
MY_QIF_PACKAGE_URI:   'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER:        3.8        # Last version Windows 7 can run is 3.8.x
MY_PYTHON_REQUIRED:   false      # if Python is required
MY_UPGRADE_OS:        false      # apt-get upgrade: true or false only
MY_RUN_DOXYFILE:      false;     # run Doxygen
```

Windows 

```yaml
MY_BIN_PRO_RES_NAME:  QtAppVeyor  #
MY_OS:                Windows     # No Spaces, this shows up the file name, project-os-configuration-plateform format
MY_QT_VERSION:        5.15.2      # Qt Version
MY_VS_VERSION:        2019        # Vs Version
MY_QT_MINGW32:        mingw81_32  # Windows only Qt folder Variables
MY_QT_MINGW64:        mingw81_64  # Windows only Qt folder Variables
MY_QT_TOOLS_MINGW32:  mingw810_32 # Windows only Qt folder Variables
MY_QT_TOOLS_MINGW64:  mingw810_64 # Windows only Qt folder Variables
MY_QT_IF_VERSION:     '4.1.1'     # QT Installer Framework Version
MY_QIF_PACKAGE_URI:   'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER:        3.8         # Last version Windows 7 can run is 3.8.x
MY_PYTHON_REQUIRED:   false       # if Python is required
MY_RUN_DOXYFILE:      false;      # run Doxygen
```

# Database

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

# Help

This Application has built in [Help](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) on the app itself,
and an [About](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
as well as an [Author](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) button on both Dialog boxes,
that you can remove easily by just removing the button from the two forms, and removing the file itself,
this button and content is about me the Orginal Author, but is not required,
nor are any Licenses, this project has an [Unlicnsed](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) License,
this is to make it easier for anyone to Fork and use as a template,
and I will try to expand on the Help sections,
and add more [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki) Content,
that might help.

# Screen-Shots

![Settings](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

![Defaults](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

# PowerShell

```bash
$env:ProgramFiles

$env:ProgramFiles(x86)
```

### End-of-README.md
