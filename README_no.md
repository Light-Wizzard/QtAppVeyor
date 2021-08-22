# QtAppVeyor

Hvert program trenger en grunn til å eksistere,
denne eksisterer fordi jeg jobbet med et prosjekt for å oppdatere [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) fra QML,
til C ++, så denne Qt -applikasjonen vil jeg jobbe med så mange plattformer som mulig,
etter å ha hatt Galaxy Calculator -programmet på [AppVeyor] (https://appveyor.com) en stund,
Jeg bestemte meg for å prøve det,
men fant det snart vanskelig å få prosjektet mitt til å fungere på Windows og Linux,
at programmet er mer komplekst med bibliotekets,
så jeg ønsket å skrive en kort applikasjon som gjorde noe nyttig å eksistere,
men samtidig var det bare å teste AppVeyor -skriptene mine,
det var da jeg bestemte meg for hvorfor ikke lage et AppVeyor Script Automation Tool,
og nå er mitt konsept å bruke Yaml -skriptet dette programmet legger ut for å distribuere dette programmet.

Dette er prosjektet er for AppVeyor hvis de vil punge det og ta det over som et fellesskapsprosjekt,
for å gjøre det til en bedre applikasjon, og gi utviklere noe som fungerer,
slik at de kan basere prosjektene sine på dette prosjektet,
og få det til å krysskompilere til så mange plattformer som mulig.

Dette er en enkel applikasjon skrevet i Qt C ++ ved hjelp av widgets,
den bruker SQL til å lagre prosjekter,
det er en enkel app som har en innstillingsside for å skrive inn alle variablene som trengs for å lage en AppVeyor Yaml -fil,
så med et klikk på bunnen kan du automatisere opprettelsen av en .appveyor.yml -fil.

Denne appen er i utgangspunktet bare for å vise deg hvordan du distribuerer Qt C ++ QtCreator -prosjekter,
på Linux, Mac, Windows og kanskje WebAssemble og iOS, samt Android,
og hvordan du bruker Qt Installer Framework til å lage installerbare applikasjoner,
som også kan oppdateres.

Dette prosjektet er ikke bare rettet for utviklere av Qt Software,
den skal kunne håndtere mange forskjellige miljøer,
men for tiden er Qt det eneste miljøet jeg har jobbet med,
men jeg la til en knapp for forskjellige miljøer,
på denne måten vil dette verktøyet være nyttig for alle programvareutviklere.

Mitt største problem er mangel på Windows Scripting -erfaring,
Jeg har ikke brukt Windows i flere tiår, og har nylig kjøpt Windows 10 Pro,
bare for å bruke Word, og jeg gjør ikke Mac, så Linux er egentlig alt jeg kan få til å fungere,
så jeg kan virkelig bruke litt hjelp til å skrive skriptene.

Qt flytter til cmake i versjon 6, så jeg har ikke noe annet valg enn å gå bort fra qmake.

For Windows er jeg ikke sikker på om MingW er det riktige verktøyet, eller om VS er,
eller hvis jeg skulle bruke MSYS, eller Cygwin.

## Innholdsfortegnelse

1. [Broken] (https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Status] (https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Development-Progress] (https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Working-On] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variabler] (https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Database] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Hjelp] (https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Skjermbilder] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile] (https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen Documention] (https://light-wizzard.github.io/QtAppVeyor)

# Gått i stykker

Ting som er ødelagt må jobbes med først,
dette er tingene jeg trenger hjelp til.

1. Windows x86 og x64 builds fungerer ikke, jeg bruker windeploy, alle dll er der, men det vil ikke kjøre.
2. Qt installer Framework.
3. Mac, WebAssemble, iOS og Android.
4. cmake, fremtiden til Qt 6.

Problemer: Windows overholder, men kjører ikke på grunn av dll -er som er i samme mappe, dette er et qmake -prosjekt,
og jeg har opprettet en fungerende cmake -fil, og jeg trenger virkelig å bytte til cmake for hele prosjektet,
og det er det jeg jobber med for tiden, men min mangel på Windows -skripting, PowerShell eller Command,
Jeg forstår slangingen noe, etter å ha måttet skrive noen gjennom årene,
målet mitt er å sette alle skriptene i to filer, den ene for Install, den andre for Build,
Jeg vil lage en Qt Installer Framework -pakke med [Qt Auto Updates] (https://github.com/Skycoder42/QtAutoUpdater),
dette GitHub -prosjektet er rettet mot Qt Installer Framework,
som sådan vil jeg bare lage en zip -fil med Qt Installer -pakken.

Hvis jeg kan få alle disse tingene til å fungere, vil jeg gjerne se om AppVeyor ville klare det,
og vi kan jobbe med det der, jeg skrev dette for dem å gi til andre,
for å hjelpe dem med å få publisert applikasjonene sine enkelt,
konseptet er enkelt, denne applikasjonen bruker de fleste funksjonene de fleste ønsker,
Qt -innstillinger for å lagre variabler og SQL,
så hvis du kan få dette til å fungere for alle operativsystemene som Qt støtter,
det vil gjøre det mye lettere for folk å kopiere hvordan dette ble gjort,
så dette prosjektet trenger mye arbeid for å gjøre det til et beste eksempel på praksis,
så du kan se at jeg bare har lagt til et minimalt antall funksjoner som er enkle å utvide.

Jeg trenger tilbakemelding på hva du synes om konseptet,
hvilke funksjoner du ønsker å se i programmet, enn programmet
og virkelig trenger jeg å vite hvilke skript jeg skal kjøre for at alt skal fungere,
Jeg er god på bash, men ikke så mye PowerShell eller CMD,
og ikke mye til Mac, iOS, men jeg har en Android.

Jeg vil se denne applikasjonen bli standarden for AppVeyor å anbefale,
og hvorfor de trenger å punge det og gjøre det til deres,
Jeg prøver bare å gi dem noe verdt å ta over,
og hvorfor jeg har merket det QtAppVeyor, og prøvd å gjøre all dokumentasjon enkel å rengjøre,
og Doxygen klar, må oversettelsen gjøres,
men jeg venter alltid til slutten for å begynne med det.

# Status

[! [Status for transportørbygger] (https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)] (https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###: pakke: ** Nedlastinger: **

 -: penguin: [Linux zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 -: office: [Windows zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 -: apple: For øyeblikket utilgjengelig [Apple zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

For øyeblikket fungerer ikke Windows, hvis det var det, ville det si noe slikt:

Windows (Testet på 7 og 10, gi meg beskjed om 8 fungerer): Last ned zip og trekk det ut,
og kjør filen QtAppVeyor.exe inne i AppDir -mappen.

Når den er fullført, vil den bare ha en Artifact, Qt Installer Framework med Qt Auto Update i en zip -fil.

# Utvikling-fremgang

For mer informasjon, se: [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Dette pågår, vennligst rapporter eventuelle feil og legg igjen kommentarer.

# Working-On

* cmake i stedet for qmake
* Qt Installer Framework
* Oppdaterbar AppImage
* Windows -skript i stedet for inline
* Mac
* Android
* WebAssemble
* iOS
* MSVS -bygging av Qt Project

# Variabler

Hvis du bruker dette programmet til å lage .appveyor.yml -filer,
du må kjenne alle disse variablene,
selv om du lager din egen fil, vil du ha kjennskap til disse,
og manuelt vedlikeholde endringer,
hvor som denne appen lar deg bare endre variablene og lage en ny fil.

Hver variabel brukes i skript for å konfigurere programmet for distribusjon.

* MY_BIN_PRO_RES_NAME: Qt Projects navn, dvs. QtAppVeyor.pro, forutsetter at exe -navnet er det samme.
* MY_OS: Dette brukes til å lage pakkenavn, så ingen mellomrom
* MY_VS_VERSION: Qt -versjon
* MY_QT_IF_VERSION: Qt Installer Framework (QIF) versjon
* MY_QIF_PACKAGE_URI: Mappe for QIF -pakker
* MY_PYTHON_VER: Python -versjon, vær oppmerksom på at Windows 7 stopper på 3.8
* MY_PYTHON_REQUIRED: Er Python påkrevd
* MY_UPGRADE_OS: Unix systemoppgradering
* MY_QT_MINGW32: MingW -stier
* MY_QT_MINGW32: MingW -stier
* MY_QT_TOOLS_MINGW32: MingW -baner
* MY_QT_TOOLS_MINGW64: MingW -baner

Unix

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, dette viser filnavnet, prosjekt-os-konfigurasjon-plattformformat
MY_QT_VERSION: 5.15.2 # Qt -versjon
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Siste versjon Windows 7 kan kjøre er 3.8.x
MY_PYTHON_REQUIRED: false # hvis Python kreves
MY_UPGRADE_OS: false # apt-get upgrade: true eller false only
MY_RUN_DOXYFILE: false; # kjør Doxygen
``

Windows

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, dette viser filnavnet, prosjekt-os-konfigurasjon-plattformformat
MY_QT_VERSION: 5.15.2 # Qt -versjon
MY_VS_VERSION: # Vs -versjon 2019
MY_QT_MINGW32: mingw81_32 # Kun Windows -Qt -mappevariabler
MY_QT_MINGW64: mingw81_64 # Variabler i Qt -mappe bare i Windows
MY_QT_TOOLS_MINGW32: mingw810_32 # Kun Qt -mappevariabler i Windows
MY_QT_TOOLS_MINGW64: mingw810_64 # Variabler i Qt -mappe bare for Windows
MY_QT_IF_VERSION: '4.1.1' # QT Installer Framework Version
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # Siste versjon Windows 7 kan kjøre er 3.8.x
MY_PYTHON_REQUIRED: false # hvis Python kreves
MY_RUN_DOXYFILE: false; # kjør Doxygen
``

# Database

`` kvm
Prosjekter: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssemble, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

LAG TABELL Prosjekter (id heltall PRIMÆR NØKKEL autoinkrement,
                      QtProject varchar,
                      Hemmelig varchar,
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

Konfigurasjon: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID er Projects id

CREATE TABLE Configuration (id heltall PRIMÆR KEY autoincrement,
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

``

# Hjelp

Denne applikasjonen har innebygd [Hjelp] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) på selve appen,
og en [Om] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
samt en [Author] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) -knapp på begge dialogboksene,
som du enkelt kan fjerne ved å fjerne knappen fra de to skjemaene og fjerne selve filen,
denne knappen og innholdet handler om meg, den opprinnelige forfatteren, men er ikke nødvendig,
Det er heller ingen lisenser, dette prosjektet har en [ulisensiert] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) lisens,
dette er for å gjøre det lettere for alle å gaffel og bruke som en mal,
og jeg vil prøve å utvide på Hjelp -seksjonene,
og legg til mer [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki) innhold,
det kan hjelpe.

# Skjermbilder

! [Innstillinger] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

! [SQL] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

! [Ubuntu] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

! [Windows] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

! [Standardinnstillinger] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

! [YML] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### End-of-README.md