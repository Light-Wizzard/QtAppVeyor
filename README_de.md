# QtAppVeyor

Jedes Programm braucht einen Grund zu existieren,
dieses existiert, weil ich an einem Projekt arbeitete, um meinen [Galaxy-Rechner] (https://github.com/Light-Wizzard/galaxy-calculator) von QML zu aktualisieren,
zu C++, daher möchte ich mit dieser Qt-Anwendung auf so vielen Plattformen wie möglich arbeiten,
nachdem ich das Galaxy Calculator-Programm für eine Weile auf [AppVeyor](https://appveyor.com) hatte,
Ich beschloss, es zu versuchen,
fand es aber bald schwer, mein Projekt unter Windows und Linux zum Laufen zu bringen,
dieses Programm ist komplexer mit Bibliotheken,
Also wollte ich eine kurze Anwendung schreiben, die etwas Nützliches dazu beigetragen hat, zu existieren,
aber gleichzeitig nur um meine AppVeyor Scripts zu testen,
Dann habe ich beschlossen, warum nicht ein AppVeyor Script Automation Tool erstellen.
und jetzt besteht mein Konzept darin, das Yaml-Skript zu verwenden, das diese Anwendung ausgibt, um diese Anwendung bereitzustellen.

Dieses Projekt ist für AppVeyor, wenn sie es abspalten und als Community-Projekt übernehmen möchten.
um es zu einer besseren Anwendung zu machen und Entwicklern etwas zu geben, das funktioniert,
damit sie ihre Projekte auf diesem Projekt aufbauen können,
und lassen Sie es auf so vielen Plattformen wie möglich kompilieren.

Dies ist eine einfache Anwendung, die in Qt C++ mit Widgets geschrieben wurde.
es verwendet SQL, um Projekte zu speichern,
Es ist eine einfache App mit einer Einstellungsseite, um alle Variablen einzugeben, die zum Erstellen einer AppVeyor-Yaml-Datei erforderlich sind.
So können Sie mit einem Klick von unten die Erstellung einer .appveyor.yml-Datei automatisieren.

Diese App dient im Grunde nur dazu, Ihnen zu zeigen, wie Sie Qt C++ QtCreator-Projekte bereitstellen.
auf Linux, Mac, Windows und vielleicht WebAssembly und iOS sowie Android,
und wie man das Qt Installer Framework verwendet, um installierbare Anwendungen zu erstellen,
die auch updatefähig sind.

Dieses Projekt richtet sich nicht nur an Qt-Software-Entwickler,
es sollte in der Lage sein, viele verschiedene Umgebungen zu handhaben,
aber derzeit ist Qt die einzige Umgebung, an der ich gearbeitet habe,
aber ich habe eine Schaltfläche für verschiedene Umgebungen hinzugefügt,
Auf diese Weise wird dieses Tool für jeden Softwareentwickler nützlich sein.

Mein größtes Problem ist der Mangel an Windows Scripting-Erfahrung,
Ich habe Windows jahrzehntelang nicht verwendet und erst vor kurzem Windows 10 Pro gekauft.
nur um Word zu verwenden, und ich mache keinen Mac, also ist Linux wirklich alles, was ich zum Arbeiten bringen kann,
so kann ich wirklich etwas Hilfe beim Schreiben der Skripte gebrauchen.

Qt wechselt in Version 6 zu cmake, daher habe ich keine andere Wahl, als qmake zu verlassen.

Für Windows bin ich mir nicht sicher, ob MingW das richtige Tool ist, oder ob VS,
oder ob ich MSYS oder Cygwin verwenden soll.

## Inhaltsverzeichnis

1. [kaputt](https://github.com/Light-Wizzard/QtAppVeyor#kaputt)
2. [Status](https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Entwicklungsfortschritt](https://github.com/Light-Wizzard/QtAppVeyor#Entwicklungsfortschritt)
4. [Working-On](https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variablen](https://github.com/Light-Wizzard/QtAppVeyor#Variablen)
6. [Datenbank](https://github.com/Light-Wizzard/QtAppVeyor#Datenbank)
7. [Hilfe](https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Screenshots](https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile](https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen-Dokumentation](https://light-wizzard.github.io/QtAppVeyor)

# Gebrochen

Dinge, die kaputt sind, müssen zuerst bearbeitet werden,
bei diesen sachen brauche ich hilfe.

1. Windows x86- und x64-Builds funktionieren nicht, ich verwende windeploy, alle DLLs sind vorhanden, aber es wird nicht ausgeführt.
2. Qt-Installationsprogramm-Framework.
3. Mac, WebAssembly, iOS und Android.
4. cmake, die Zukunft von Qt 6.

Probleme: Windows erfüllt die Anforderungen, wird jedoch nicht ausgeführt, da sich DLLs im selben Ordner befinden. Dies ist ein qmake-Projekt.
und ich habe eine funktionierende cmake-Datei erstellt, und ich muss wirklich für das gesamte Projekt zu cmake wechseln.
und daran arbeite ich gerade, aber mein Mangel an Windows-Skripting, PowerShell oder Command,
Ich verstehe die Sprache einigermaßen, da ich im Laufe der Jahre einiges schreiben musste,
Mein Ziel ist es, alle Skripte in zwei Dateien zu speichern, eine für die Installation, die andere für den Build.
Ich möchte ein Qt Installer Framework-Paket mit [Qt Auto Updates](https://github.com/Skycoder42/QtAutoUpdater) erstellen.
dieses GitHub-Projekt ist auf das Qt Installer Framework ausgerichtet,
Daher möchte ich mit dem Qt Installer-Paket nur eine ZIP-Datei erstellen.

Wenn ich all diese Dinge zum Laufen bringen kann, würde ich gerne sehen, ob AppVeyor es abzweigen würde,
und wir können dort daran arbeiten, ich habe dies geschrieben, damit sie es anderen geben können,
um ihnen zu helfen, ihre Anwendungen mit Leichtigkeit zu veröffentlichen,
Das Konzept ist einfach, diese Anwendung verwendet die meisten Funktionen, die die meisten Leute wollen,
Qt Einstellungen zum Speichern von Variablen und SQL,
Wenn Sie dies also für alle von Qt unterstützten Betriebssysteme zum Laufen bringen können,
es wird viel einfacher für die Leute zu kopieren, wie dies gemacht wurde,
Daher braucht dieses Projekt viel Arbeit, um es zu einem Best-Practice-Beispiel zu machen.
Sie sehen also, dass ich nur eine minimale Anzahl von Funktionen hinzugefügt habe, die einfach erweitert werden können.

Ich brauche Feedback zu Ihrer Meinung zu dem Konzept,
als die Anwendung, welche Funktionen Sie darin sehen möchten,
Und ich muss wirklich wissen, welche Skripte ich ausführen muss, damit das alles funktioniert,
Ich bin gut in Bash, aber nicht so sehr in PowerShell oder CMD,
und nicht viel in Mac, iOS, aber ich habe ein Android.

Ich möchte, dass diese Anwendung zum Standard wird, den AppVeyor empfehlen kann.
und warum sie es forken müssen und es zu ihrem machen,
Ich versuche nur, ihnen etwas zu geben, das es wert ist, übernommen zu werden,
und warum ich es als QtAppVeyor gebrandmarkt habe und versucht habe, die gesamte Dokumentation leicht zu reinigen,
und Doxygen bereit, die Übersetzung muss gemacht werden,
Aber ich warte immer bis zum Ende, um damit anzufangen.

# Status

[![Appveyor-Build-Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

### :Paket: **Downloads:**

 - :pinguin: [Linux zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 - :office: [Windows zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 - :apple: Derzeit nicht verfügbar [Apple zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Derzeit funktioniert Windows nicht, wenn es so wäre, würde es ungefähr so ​​​​aussagen:

Windows (auf 7 und 10 getestet, lassen Sie mich wissen, ob 8 funktioniert): Laden Sie die ZIP-Datei herunter und entpacken Sie sie,
und führen Sie die Datei QtAppVeyor.exe im Ordner deploy AppDir aus.

Nach Abschluss enthält es nur ein Artefakt, das Qt Installer Framework mit Qt Auto Update in einer ZIP-Datei.

# Entwicklungsfortschritt

Weitere Informationen finden Sie unter: [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Dies ist in Arbeit, bitte melden Sie alle Fehler und hinterlassen Sie Kommentare.

# Arbeiten an

* cmake statt qmake
* Qt Installer-Framework
* Aktualisierbares AppImage
* Windows-Skripte statt Inline
* Mac
* Android
* WebAssembly
* iOS
* MSVS-Build des Qt-Projekts

# Variablen

Wenn Sie diese Anwendung verwenden, um .appveyor.yml-Dateien zu erstellen,
Sie müssen alle diese Variablen kennen,
Selbst wenn Sie Ihre eigene Datei erstellen, kennen Sie diese,
und Änderungen manuell pflegen,
Mit dieser App können Sie einfach die Variablen ändern und eine neue Datei erstellen.

Jede Variable wird in Skripts verwendet, um die Anwendung für die Bereitstellung einzurichten.

* MY_BIN_PRO_RES_NAME: Qt-Projektname, dh. QtAppVeyor.pro, geht davon aus, dass der exe-Name gleich ist.
* MY_OS: Dies wird verwendet, um Paketnamen zu erstellen, also keine Leerzeichen
* MY_VS_VERSION: Qt-Version
* MY_QT_IF_VERSION: Qt Installer Framework (QIF)-Version
* MY_QIF_PACKAGE_URI: Ordner für QIF-Pakete
* MY_PYTHON_VER: Python-Version, beachten Sie, dass Windows 7 bei 3.8 . stoppt
* MY_PYTHON_REQUIRED: Ist Python erforderlich?
* MY_UPGRADE_OS: Unix-System-Upgrade
* MY_QT_MINGW32: MingW-Pfade
* MY_QT_MINGW32: MingW-Pfade
* MY_QT_TOOLS_MINGW32: MingW-Pfade
* MY_QT_TOOLS_MINGW64: MingW-Pfade

Unix

```jaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Keine Leerzeichen, hier wird der Dateiname angezeigt, Projekt-OS-Konfiguration-Plattformformat
MY_QT_VERSION: 5.15.2 # Qt-Version
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework-Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # Die letzte Version, die Windows 7 ausführen kann, ist 3.8.x
MY_PYTHON_REQUIRED: false # wenn Python erforderlich ist
MY_UPGRADE_OS: false # apt-get upgrade: nur true oder false
MY_RUN_DOXYFILE: falsch; # Doxygen ausführen
```

Fenster

```jaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Keine Leerzeichen, hier wird der Dateiname angezeigt, Projekt-OS-Konfiguration-Plattformformat
MY_QT_VERSION: 5.15.2 # Qt-Version
MY_VS_VERSION: 2019 # vs. Version
MY_QT_MINGW32: mingw81_32 # Nur Windows Qt-Ordner Variablen
MY_QT_MINGW64: mingw81_64 # Nur Windows Qt-Ordner Variablen
MY_QT_TOOLS_MINGW32: mingw810_32 # Nur Windows Qt-Ordner Variablen
MY_QT_TOOLS_MINGW64: mingw810_64 # Nur Windows Qt-Ordner Variablen
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework-Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # Die letzte Version, die Windows 7 ausführen kann, ist 3.8.x
MY_PYTHON_REQUIRED: false # wenn Python erforderlich ist
MY_RUN_DOXYFILE: falsch; # Doxygen ausführen
```

# Datenbank

```sql
Projekte: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREATE TABLE Projects(id integer PRIMARY KEY Autoinkrement,
                      QtProject varchar,
                      Geheimer Varchar,
                      IsOsUbuntu varchar,
                      IsOsMac varchar,
                      IsOsWebAssembly-varchar,
                      IsOSiOS-varchar,
                      IsOsWindows varchar,
                      IsOsAndroid varchar,
                      IsX64-varchar,
                      IsX86-varchar,
                      IsDebug-varchar,
                      IsRelease varchar

Konfiguration: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID ist die Projekt-ID

CREATE TABLE Configuration (id integer PRIMARY KEY Autoinkrement,
                           ProjekteID varchar,
                           Betriebssystem varchar,
                           QtVersion varchar,
                           QtIfVersion varchar,
                           QtIfPackageUri varchar,
                           PythonVersion varchar,
                           PythonErforderliches varchar,
                           QtMingW32-varchar,
                           QtMingW64-varchar,
                           QtToolsMingW32 varchar,
                           QtToolsMingW64-varchar,
                           VisualStudio-varchar,
                           OsUpgrade varchar

```

# Hilfe

Diese Anwendung hat [Hilfe](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) in die App selbst integriert.
und ein [About](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
sowie eine Schaltfläche [Autor](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) in beiden Dialogfeldern,
die Sie leicht entfernen können, indem Sie einfach die Schaltfläche aus den beiden Formularen entfernen und die Datei selbst entfernen.
Diese Schaltfläche und dieser Inhalt beziehen sich auf mich, den ursprünglichen Autor, sind jedoch nicht erforderlich.
noch keine Lizenzen, dieses Projekt hat eine [Unlicnsed](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) Lizenz,
Dies soll es jedem erleichtern, Fork zu verwenden und als Vorlage zu verwenden.
und ich werde versuchen, die Hilfe-Abschnitte zu erweitern,
und füge weitere [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki) Inhalte hinzu,
das könnte helfen.

# Screenshots

![Einstellungen](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

![Defaults](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

###End-of-README.md