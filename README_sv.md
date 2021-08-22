# QtAppVeyor

Varje program behöver en anledning att existera,
den här finns eftersom jag arbetade med ett projekt för att uppdatera min [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) från QML,
till C ++, så den här Qt -applikationen vill jag arbeta med så många plattformar som möjligt,
efter att ha haft Galaxy Calculator -programmet på [AppVeyor] (https://appveyor.com) ett tag,
Jag bestämde mig för att prova,
men fann det snart svårt att få mitt projekt att fungera på Windows och Linux,
det programmet är mer komplext med bibliotekets,
så jag ville skriva en kort applikation som gjorde något användbart att existera,
men samtidigt var det bara att testa mina AppVeyor -skript,
det var då jag bestämde mig för varför inte göra ett AppVeyor Script Automation Tool,
och nu är mitt koncept att använda Yaml -skriptet som den här applikationen lägger ut för att distribuera den här applikationen.

Detta projekt är för AppVeyor om de vill gaffla det och ta över det som ett samhällsprojekt,
för att göra det till en bättre applikation och ge utvecklare något som fungerar,
så att de kan basera sina projekt på detta projekt,
och få det att komplettera till så många plattformar som möjligt.

Detta är en enkel applikation skriven i Qt C ++ med widgets,
den använder SQL för att lagra projekt,
det är en enkel app som har en inställningssida för att ange alla variabler som behövs för att skapa en AppVeyor Yaml -fil,
så med ett klick på en botten kan du automatisera skapandet av en .appveyor.yml -fil.

Denna app är i princip bara för att visa dig hur du distribuerar Qt C ++ QtCreator -projekt,
på Linux, Mac, Windows och kanske WebAssemble och iOS, samt Android,
och hur man använder Qt Installer Framework för att göra installerbara applikationer,
som också kan uppdateras.

Detta projekt är inte bara inriktat på Qt -mjukvaruutvecklare,
den ska kunna hantera många olika miljöer,
men för närvarande är Qt den enda miljö jag har arbetat med,
men jag lade till en knapp för olika miljöer,
på så sätt kommer det här verktyget att vara användbart för alla mjukvaruutvecklare.

Mitt största problem är bristen på Windows Scripting -erfarenhet,
Jag har inte använt Windows i decennier och köpte nyligen Windows 10 Pro,
bara för att använda Word, och jag gör inte Mac, så Linux är verkligen allt jag kan få till jobbet,
så jag kan verkligen använda lite hjälp med att skriva manus.

Qt flyttar till cmake i version 6, så jag har inget annat val än att gå bort från qmake.

För Windows är jag inte säker på om MingW är rätt verktyg, eller om VS är,
eller om jag ska använda MSYS eller Cygwin.

## Innehållsförteckning

1. [Trasig] (https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Status] (https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Development-Progress] (https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Working-On] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variabler] (https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Databas] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Hjälp] (https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Screen-Shots] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile] (https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen Documention] (https://light-wizzard.github.io/QtAppVeyor)

# Trasigt

Saker som är trasiga måste bearbetas först,
det är saker jag behöver hjälp med.

1. Windows x86 och x64 builds fungerar inte, jag använder windeploy, alla dll är där, men det körs inte.
2. Qt installer Framework.
3. Mac, WebAssemble, iOS och Android.
4. cmake, framtiden för Qt 6.

Problem: Windows uppfyller men körs inte på grund av dll -filer som finns i samma mapp, detta är ett qmake -projekt,
och jag har skapat en fungerande cmake -fil, och jag behöver verkligen byta till cmake för hela projektet,
och det är vad jag för närvarande arbetar med, men min brist på Windows -skript, PowerShell eller Command,
Jag förstår svagheten något, efter att ha behövt skriva en del genom åren,
mitt mål är att lägga alla skript i två filer, en för Install, den andra för Build,
Jag vill göra ett Qt Installer Framework -paket med [Qt Auto Updates] (https://github.com/Skycoder42/QtAutoUpdater),
detta GitHub -projekt är inriktat på Qt Installer Framework,
som sådan vill jag bara göra en zip -fil med Qt Installer -paketet.

Om jag kan få alla dessa saker att fungera, skulle jag vilja se om AppVeyor skulle gaffla det,
och vi kan arbeta med det där, jag skrev detta för dem att ge till andra,
för att hjälpa dem att enkelt publicera sina applikationer,
konceptet är enkelt, den här applikationen använder de flesta funktioner de flesta vill ha,
Qt -inställningar för att lagra variabler och SQL,
så om du kan få detta att fungera för alla operativsystem som Qt stöder,
det kommer att göra det mycket lättare för människor att kopiera hur detta gjordes,
så det här projektet behöver mycket arbete för att göra det till ett bästa exempel på praktiker,
så du kan se att jag bara har lagt till ett minimalt antal funktioner som är lätta att utöka.

Jag behöver feedback om vad du tycker om konceptet,
än applikationen, vilka funktioner du skulle vilja se i den,
och verkligen måste jag veta vilka skript som ska köras för att allt ska fungera,
Jag är bra på bash, men inte så mycket PowerShell eller CMD,
och inte mycket till Mac, iOS, men jag har en Android.

Jag vill se denna applikation bli standarden för AppVeyor att rekommendera att använda,
och varför de behöver gaffla det och göra det till deras,
Jag försöker bara ge dem något som är värt att ta över,
och varför jag har märkt det QtAppVeyor och försökt göra all dokumentation lätt att rengöra,
och Doxygen redo måste översättningen göras,
men jag väntar alltid till slutet för att börja med det.

# Status

[! [Status för Appveyor Build] [https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true]] (https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###: paket: ** Nedladdningar: **

 -: penguin: [Linux zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 -: office: [Windows zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 -: apple: För närvarande otillgänglig [Apple zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

För närvarande fungerar inte Windows, om det var det skulle det säga ungefär så här:

Windows (Testad på 7 och 10 meddela mig om 8 fungerar): Ladda ner zip och extrahera det,
och kör filen QtAppVeyor.exe inuti distribuerade AppDir -mappen.

När den är klar kommer den bara att ha en Artifact, Qt Installer Framework med Qt Auto Update i en zip -fil.

# Utveckling-Framsteg

För mer information se: [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Detta pågår, rapportera eventuella buggar och lämna kommentarer.

# Jobbar på

* cmake istället för qmake
* Qt Installer Framework
* Uppdaterbar AppImage
* Windows -skript istället för inline
* Mac
* Android
* WebAssemble
* iOS
* MSVS -byggnad av Qt -projekt

# Variabler

Om du använder det här programmet för att skapa .appveyor.yml -filer,
du måste känna till alla dessa variabler,
även om du skapar din egen fil, kommer du att känna till dessa,
och manuellt underhålla ändringar,
där som den här appen låter dig bara ändra variablerna och skapa en ny fil.

Varje variabel används i skript för att konfigurera programmet för distribution.

* MY_BIN_PRO_RES_NAME: Qt -projektnamn, dvs. QtAppVeyor.pro, förutsätter att exe -namnet är detsamma.
* MY_OS: Detta används för att skapa paketnamn, så inga mellanslag
* MY_VS_VERSION: Qt -version
* MY_QT_IF_VERSION: Qt Installer Framework (QIF) version
* MY_QIF_PACKAGE_URI: Mapp för QIF -paket
* MY_PYTHON_VER: Python -version, observera att Windows 7 stannar vid 3.8
* MY_PYTHON_REQUIRED: Python krävs
* MY_UPGRADE_OS: Unix systemuppgradering
* MY_QT_MINGW32: MingW -sökvägar
* MY_QT_MINGW32: MingW -sökvägar
* MY_QT_TOOLS_MINGW32: MingW -sökvägar
* MY_QT_TOOLS_MINGW64: MingW -sökvägar

Unix

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, detta visar filnamnet, projekt-os-konfiguration-plattformformat
MY_QT_VERSION: 5.15.2 # Qt -version
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Senaste version Windows 7 kan köras är 3.8.x
MY_PYTHON_REQUIRED: false # om Python krävs
MY_UPGRADE_OS: false # apt-get-uppgradering: endast sant eller falskt
MY_RUN_DOXYFILE: false; # kör Doxygen
''

Windows

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, detta visar filnamnet, projekt-os-konfiguration-plattformformat
MY_QT_VERSION: 5.15.2 # Qt -version
MY_VS_VERSION: 2019 # Vs -version
MY_QT_MINGW32: mingw81_32 # Endast Windows Qt -mappvariabler
MY_QT_MINGW64: mingw81_64 # Endast Windows Qt -mappvariabler
MY_QT_TOOLS_MINGW32: mingw810_32 # Endast Windows Qt -mappvariabler
MY_QT_TOOLS_MINGW64: mingw810_64 # Endast Windows Qt -mappvariabler
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Senaste version Windows 7 kan köras är 3.8.x
MY_PYTHON_REQUIRED: false # om Python krävs
MY_RUN_DOXYFILE: false; # kör Doxygen
''

# Databas

'' kvm
Projekt: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssemble, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

SKAPA TABELL Projekt (id heltal PRIMÄR KEY autoinkrement,
                      QtProject varchar,
                      Hemlig varchar,
                      IsOsUbuntu varchar,
                      IsOsMac varchar,
                      IsOsWebAssemble varchar,
                      IsOSiOS varchar,
                      IsOsWindows varchar,
                      IsOsAndroid varchar,
                      IsX64 varchar,
                      IsX86 varchar,
                      IsDebug varchar,
                      IsRelease varchar

Konfiguration: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID är Projects id

SKAPA TABELL Konfiguration (id heltal PRIMÄR KEY autoinkrement,
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

''

# Hjälp

Denna applikation har byggt in [Hjälp] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) på själva appen,
och en [Om] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
samt en [Author] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) -knapp på båda dialogrutorna,
som du enkelt kan ta bort genom att bara ta bort knappen från de två formulärerna och ta bort själva filen,
den här knappen och innehållet handlar om mig, den ursprungliga författaren, men krävs inte,
inte heller några licenser, detta projekt har en [Olicensierad] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) licens,
detta är för att göra det lättare för alla att gaffla och använda som en mall,
och jag kommer att försöka expandera på hjälpavsnitten,
och lägg till mer [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki) innehåll,
det kan hjälpa.

# Skärmbilder

! [Inställningar] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

! [SQL] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

! [Ubuntu] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

! [Windows] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

! [Standardvärden] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

! [YML] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### End-of-README.md