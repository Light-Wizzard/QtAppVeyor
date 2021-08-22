# QtAppVeyor

Каждой программе нужна причина для существования,
этот существует, потому что я работал над проектом по обновлению моего [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) из QML,
на C ++, поэтому с этим приложением Qt я хочу работать на как можно большем количестве платформ,
некоторое время имея программу Galaxy Calculator на [AppVeyor] (https://appveyor.com),
Я решил попробовать,
но вскоре стало трудно заставить мой проект работать в Windows и Linux,
эта программа более сложна с библиотекой,
поэтому я хотел написать короткое приложение, которое могло бы существовать что-то полезное,
но в то же время это было только для тестирования моих скриптов AppVeyor,
тогда я решил, почему бы не сделать инструмент автоматизации сценариев AppVeyor,
и теперь моя идея состоит в том, чтобы использовать сценарий Yaml, который это приложение выпускает, для развертывания этого приложения.

Это проект для AppVeyor, если они хотят его разветвить и взять на себя как проект сообщества,
чтобы сделать приложение лучше и дать разработчикам то, что работает,
чтобы они могли основывать свои проекты на этом проекте,
и сделайте кросс-компилирование на как можно большем количестве платформ.

Это простое приложение, написанное на Qt C ++ с использованием виджетов,
он использует SQL для хранения проектов,
это простое приложение со страницей настроек для ввода всех переменных, необходимых для создания файла AppVeyor Yaml,
так что одним щелчком нижней части вы можете автоматизировать создание файла .appveyor.yml.

Это приложение в основном предназначено только для того, чтобы показать вам, как развертывать проекты Qt C ++ QtCreator,
в Linux, Mac, Windows и, возможно, WebAssembly и iOS, а также Android,
и как использовать Qt Installer Framework для создания устанавливаемых приложений,
которые также можно обновлять.

Этот проект ориентирован не только на разработчиков Qt Software,
он должен быть в состоянии обрабатывать множество различных сред,
но в настоящее время Qt - единственная среда, над которой я работал,
но я добавил кнопку для разных сред,
Таким образом, этот инструмент будет полезен каждому разработчику ПО.

Моя самая большая проблема - это отсутствие опыта работы со сценариями Windows,
Я не использовал Windows десятилетиями и только недавно купил Windows 10 Pro,
просто использовать Word, а я не Mac, так что Linux - это все, что я могу заставить работать,
так что мне действительно нужна помощь в написании скриптов.

Qt переходит на cmake в версии 6, поэтому у меня нет другого выбора, кроме как отойти от qmake.

Для Windows я не уверен, подходит ли MingW, или если VS,
или если я должен использовать MSYS или Cygwin.

## Таблица содержания

1. [Сломано] (https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Статус] (https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Прогресс разработки] (https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Работа над] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Переменные] (https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [База данных] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Справка] (https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Снимки экрана] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Кросс-компиляция] (https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Документация Doxygen] (https://light-wizzard.github.io/QtAppVeyor)

# Сломанный

В первую очередь нужно поработать над сломанными вещами,
вот с чем мне нужна помощь.

1. Сборки Windows x86 и x64 не работают, я использую windeploy, все dll есть, но он не запускается.
2. Фреймворк установщика Qt.
3. Mac, WebAssembly, iOS и Android.
4. cmake, будущее Qt 6.

Проблемы: Windows соответствует требованиям, но не запускается из-за того, что библиотеки DLL находятся в той же папке, это проект qmake,
и я создал рабочий файл cmake, и мне действительно нужно переключиться на cmake для всего проекта,
и это то, над чем я сейчас работаю, но мое отсутствие сценариев Windows, PowerShell или команд,
Я немного понимаю этот язык, так как за эти годы мне пришлось кое-что написать,
Моя цель - поместить все сценарии в два файла, один для установки, другой для сборки,
Я хочу создать пакет Qt Installer Framework с [Qt Auto Updates] (https://github.com/Skycoder42/QtAutoUpdater),
этот проект GitHub ориентирован на Qt Installer Framework,
поэтому я хочу создать только один zip-файл с пакетом Qt Installer.

Если я смогу заставить все эти вещи работать, я хотел бы увидеть, сможет ли AppVeyor его форкнуть,
и мы можем поработать над этим там, я написал это, чтобы они раздавали другим,
чтобы помочь им легко опубликовать свои приложения,
концепция проста, это приложение использует большинство функций, которые нужны большинству людей,
Qt Settings для хранения переменных и SQL,
поэтому, если вы можете заставить это работать для всех ОС, которые поддерживает Qt,
людям будет намного проще скопировать, как это было сделано,
так что этот проект требует большой работы, чтобы сделать его лучшим практическим примером,
Итак, вы можете видеть, что я добавил лишь минимальное количество функций, которые легко расширить.

Мне нужен отзыв о том, что вы думаете о концепции,
чем Приложение, какие функции вы бы хотели в нем видеть,
и мне действительно нужно знать, какие скрипты нужно запустить, чтобы все это работало,
Я хорошо разбираюсь в bash, но не в PowerShell или CMD,
и не очень в Mac, iOS, но у меня есть Android.

Я хочу, чтобы это приложение стало стандартом для AppVey, или рекомендую использовать,
и почему им нужно его разветвить и сделать своим,
Я просто пытаюсь дать им что-то стоящее,
и почему я назвал его QtAppVeyor и попытался упростить очистку всей документации,
и Doxygen готовы, перевод должен быть выполнен,
но я всегда жду до конца, чтобы начать.

# Положение дел

[! [Статус сборки приложения] (https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)] (https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###: package: ** Загрузки: **

 -: penguin: [Linux zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 -: office: [Windows zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 -: apple: В настоящее время недоступен [Apple zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

В настоящее время Windows не работает, если бы это было так, она бы сказала что-то вроде этого:

Windows (проверено на 7 и 10, дайте мне знать, работает ли 8): загрузите zip и распакуйте его,
и запустите файл QtAppVeyor.exe внутри папки развертывания AppDir.

По завершении у него будет только один артефакт, среда установки Qt с автоматическим обновлением Qt в zip-файле.

# Развитие-Прогресс

Для получения дополнительной информации см .: [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Это работа, пожалуйста, сообщайте о любых ошибках и оставляйте комментарии.

# Работа над

* cmake вместо qmake
* Фреймворк установщика Qt
* Обновляемый AppImage
* Скрипты Windows вместо встроенных
* Mac
* Android
* WebAssembly
* iOS
* Сборка MSVS Qt Project

# Переменные

Если вы используете это приложение для создания файлов .appveyor.yml,
вам нужно будет знать все эти переменные,
даже если вы создадите свой собственный файл, вы будете знать это,
и вручную поддерживать изменения,
где, поскольку это приложение позволяет вам просто изменить переменные и создать новый файл.

Каждая переменная используется в сценариях для настройки приложения для развертывания.

* MY_BIN_PRO_RES_NAME: имя проекта Qt, т.е. QtAppVeyor.pro предполагает, что имя exe совпадает.
* MY_OS: используется для создания имен пакетов, поэтому без пробелов
* MY_VS_VERSION: Версия Qt
* MY_QT_IF_VERSION: Версия Qt Installer Framework (QIF)
* MY_QIF_PACKAGE_URI: папка для пакетов QIF
* MY_PYTHON_VER: версия Python, обратите внимание, что Windows 7 останавливается на 3.8
* MY_PYTHON_REQUIRED: требуется ли Python
* MY_UPGRADE_OS: Обновление системы Unix
* MY_QT_MINGW32: Пути MingW
* MY_QT_MINGW32: Пути MingW
* MY_QT_TOOLS_MINGW32: Пути MingW
* MY_QT_TOOLS_MINGW64: Пути MingW

Unix

ямл
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Без пробелов, здесь отображается имя файла в формате project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Версия Qt
MY_QT_IF_VERSION: '4.1.1' # Версия среды установки QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Последняя версия, которую может запустить Windows 7, - 3.8.x
MY_PYTHON_REQUIRED: false # если требуется Python
MY_UPGRADE_OS: false # apt-get upgrade: только true или false
MY_RUN_DOXYFILE: ложь; # запустить Doxygen
`` ''

Окна

ямл
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Без пробелов, здесь отображается имя файла в формате project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Версия Qt
MY_VS_VERSION: 2019 # Версия по сравнению с
MY_QT_MINGW32: mingw81_32 # Переменные папки Qt только для Windows
MY_QT_MINGW64: mingw81_64 # Переменные папки Qt только для Windows
MY_QT_TOOLS_MINGW32: mingw810_32 # Переменные папки Qt только для Windows
MY_QT_TOOLS_MINGW64: mingw810_64 # Переменные папки Qt только для Windows
MY_QT_IF_VERSION: '4.1.1' # Версия среды установки QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Последняя версия, которую может запустить Windows 7, - 3.8.x
MY_PYTHON_REQUIRED: false # если требуется Python
MY_RUN_DOXYFILE: ложь; # запустить Doxygen
`` ''

# База данных

`` sql
Проекты: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREATE TABLE Projects (id integer, автоинкремент PRIMARY KEY,
                      QtProject varchar,
                      Секретный варчар,
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

Конфигурация: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID - это идентификатор проекта.

CREATE TABLE Configuration (id integer PRIMARY KEY автоинкремент,
                           ProjectsID varchar,
                           ОС varchar,
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

`` ''

# Помощь

Это приложение имеет встроенную [Справку] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) в самом приложении,
и [О программе] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
а также кнопку [Автор] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) в обоих диалоговых окнах,
которые вы можете легко удалить, просто удалив кнопку из двух форм и удалив сам файл,
эта кнопка и контент обо мне, как о первоначальном авторе, но не обязательны,
также нет никаких Лицензий, у этого проекта есть [Нелицензированная] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) Лицензия,
это сделано для того, чтобы кому-либо было проще форкнуть и использовать его в качестве шаблона,
и я постараюсь расширить разделы справки,
и добавить больше [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki) Контента,
это может помочь.

# Скриншоты

! [Настройки] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

! [SQL] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

! [Ubuntu] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

! [Windows] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

! [По умолчанию] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

! [YML] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### End-of-README.md