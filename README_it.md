#QtAppVeyor

Ogni programma ha bisogno di una ragione per esistere,
questo esiste perché stavo lavorando a un progetto per aggiornare il mio [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) da QML,
in C++, quindi questa applicazione Qt voglio lavorare su quante più piattaforme possibili,
avendo avuto il programma Galaxy Calculator su [AppVeyor](https://appveyor.com) per un po',
Ho deciso di fare un tentativo,
ma presto ho trovato difficile far funzionare il mio progetto su Windows e Linux,
quel programma è più complesso con Library's,
quindi volevo scrivere una breve applicazione che facesse qualcosa di utile per esistere,
ma allo stesso tempo era solo per testare i miei script AppVeyor,
è stato allora che ho deciso perché non creare uno strumento di automazione degli script AppVeyor,
e ora il mio concetto è usare lo script Yaml che questa applicazione mette a disposizione per distribuire questa applicazione.

Questo progetto è per AppVeyor se vogliono dividerlo e assumerlo come progetto della comunità,
per renderlo un'applicazione migliore e dare agli sviluppatori qualcosa che funzioni,
in modo che possano basare i loro progetti su questo progetto,
e fallo cross-compilable in quante più piattaforme possibili.

Questa è una semplice applicazione scritta in Qt C++ usando Widget,
utilizza SQL per archiviare progetti,
è una semplice app che ha una pagina delle impostazioni per inserire tutte le Variabili necessarie per creare un file AppVeyor Yaml,
quindi con un clic di un fondo puoi automatizzare la creazione di un file .appveyor.yml.

Questa app è fondamentalmente solo per mostrarti come distribuire progetti Qt C++ QtCreator,
su Linux, Mac, Windows e forse WebAssembly e iOS, oltre ad Android,
e come utilizzare Qt Installer Framework per creare applicazioni installabili,
che sono anche aggiornabili.

Questo progetto non è rivolto solo agli sviluppatori di software Qt,
dovrebbe essere in grado di gestire molti ambienti diversi,
ma attualmente Qt è l'unico ambiente su cui ho lavorato,
ma ho aggiunto un pulsante per diversi ambienti,
in questo modo questo strumento sarà utile a ogni sviluppatore di software.

Il mio problema più grande è la mancanza di esperienza di Windows Scripting,
Non uso Windows da decenni e solo di recente ho acquistato Windows 10 Pro,
solo per usare Word, e non uso Mac, quindi Linux è davvero tutto ciò che posso mettere al lavoro,
quindi posso davvero usare un po' di aiuto per scrivere gli script.

Qt sta passando a cmake nella versione 6, quindi non ho altra scelta che allontanarmi da qmake.

Per Windows non sono sicuro che MingW sia lo strumento giusto o se VS lo sia,
o se dovrei usare MSYS o Cygwin.

## Tabella dei contenuti

1. [Rotto](https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Stato](https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Progresso-sviluppo](https://github.com/Light-Wizzard/QtAppVeyor#Progresso-sviluppo)
4. [Working-On](https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variabili](https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Database](https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Aiuto](https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Screen-Shots](https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Compilazione incrociata](https://github.com/Light-Wizzard/QtAppVeyor/wiki/Compilazione incrociata)
11. [Documentazione Doxygen](https://light-wizzard.github.io/QtAppVeyor)

# Rotto

Le cose che sono rotte devono essere prima lavorate,
queste sono le cose per cui ho bisogno di aiuto.

1. Le build di Windows x86 e x64 non funzionano, sto usando windeploy, tutte le dll ci sono, ma non funzionerà.
2. Framework di installazione di Qt.
3. Mac, WebAssembly, iOS e Android.
4. cmake, il futuro di Qt 6.

Problemi: Windows è conforme ma non viene eseguito a causa di dll che si trovano nella stessa cartella, questo è un progetto qmake,
e ho creato un file cmake funzionante, e ho davvero bisogno di passare a cmake per l'intero progetto,
ed è quello su cui sto attualmente lavorando, ma la mia mancanza di script di Windows, PowerShell o Command,
Capisco un po' il linguaggio, avendone dovuto scrivere alcuni nel corso degli anni,
il mio obiettivo è mettere tutti gli script in due file, uno per Install, l'altro per Build,
Voglio creare un pacchetto Qt Installer Framework con [Qt Auto Updates](https://github.com/Skycoder42/QtAutoUpdater),
questo progetto GitHub è orientato a Qt Installer Framework,
in quanto tale, voglio creare un solo file zip con il pacchetto Qt Installer.

Se riesco a far funzionare tutte queste cose, vorrei vedere se AppVeyor lo farebbe,
e possiamo lavorarci lì, ho scritto questo per loro da dare ad altri,
per aiutarli a pubblicare facilmente le loro applicazioni,
il concetto è semplice, questa applicazione utilizza la maggior parte delle funzionalità che la maggior parte delle persone desidera,
Impostazioni Qt per memorizzare variabili e SQL,
quindi se riesci a farlo funzionare per tutti i sistemi operativi supportati da Qt,
renderà molto più facile per le persone copiare come è stato fatto,
quindi questo progetto ha bisogno di molto lavoro per renderlo un esempio di best practice,
quindi puoi vedere che ho aggiunto solo un numero minimo di funzionalità che sono facili da espandere.

Ho bisogno di feedback su cosa ne pensi del concetto,
rispetto all'Applicazione, quali caratteristiche vorresti vedere in essa,
e davvero ho bisogno di sapere quali script eseguire per far funzionare tutto questo,
Sono bravo a bash, ma non tanto PowerShell o CMD,
e non molto in Mac, iOS, ma ho un Android.

Voglio che questa applicazione diventi lo standard che AppVeyor consiglia di utilizzare,
e perché hanno bisogno di forcarlo e farlo loro,
Sto solo cercando di dare loro qualcosa che valga la pena prendere in consegna,
e perché l'ho marchiato QtAppVeyor e ho cercato di rendere tutta la documentazione facile da pulire,
e Doxygen pronto, la traduzione deve essere fatta,
ma aspetto sempre fino alla fine per iniziare.

# Stato

[![Stato build Appveyor](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

### :pacchetto: **Download:**

 - :penguin: [Zip Linux](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 - :office: [zip di Windows](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 - :apple: Attualmente non disponibile [Apple zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Attualmente, Windows non funziona, se lo fosse, direbbe qualcosa del genere:

Windows (testato su 7 e 10 fammi sapere se 8 funziona): scarica zip ed estrailo,
ed esegui il file QtAppVeyor.exe all'interno della cartella deploy AppDir.

Una volta completato, avrà solo un artefatto, il Qt Installer Framework con Qt Auto Update in un file zip.

# Sviluppo-Progresso

Per ulteriori informazioni, vedere: [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Questo è un lavoro in corso, si prega di segnalare eventuali bug e lasciare commenti.

# Lavorando su

* cmake invece di qmake
* Framework di installazione Qt
* Immagine app aggiornabile
* Script di Windows anziché in linea
* Mac
* Android
* WebAssembly
* iOS
* build MSVS di Qt Project

# Variabili

Se utilizzi questa Applicazione per creare file .appveyor.yml,
dovrai conoscere tutte queste variabili,
anche se crei il tuo file, li conoscerai,
e mantenere manualmente le modifiche,
dove questa app ti consente solo di cambiare le variabili e creare un nuovo file.

Ogni variabile viene utilizzata negli script per configurare l'applicazione per la distribuzione.

* MY_BIN_PRO_RES_NAME: nome dei progetti Qt, es. QtAppVeyor.pro, presuppone che il nome dell'exe sia lo stesso.
* MY_OS: questo è usato per creare nomi di pacchetti, quindi niente spazi
* MY_VS_VERSION: Versione Qt
* MY_QT_IF_VERSION: versione Qt Installer Framework (QIF)
* MY_QIF_PACKAGE_URI: Cartella per i pacchetti QIF
* MY_PYTHON_VER: versione Python, nota che Windows 7 si ferma a 3.8
* MY_PYTHON_REQUIRED: è richiesto Python?
* MY_UPGRADE_OS: aggiornamento del sistema Unix
* MY_QT_MINGW32: Percorsi MingW
* MY_QT_MINGW32: Percorsi MingW
* MY_QT_TOOLS_MINGW32: Percorsi MingW
* MY_QT_TOOLS_MINGW64: Percorsi MingW

Unix

```yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, questo mostra il nome del file, formato project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Versione Qt
MY_QT_IF_VERSION: '4.1.1' # Versione framework di installazione QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # L'ultima versione che Windows 7 può eseguire è 3.8.x
MY_PYTHON_REQUIRED: false # se Python è richiesto
MY_UPGRADE_OS: false # apt-get upgrade: solo vero o falso
MY_RUN_DOXYFILE: falso; # esegui Doxygen
```

finestre

```yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # No Spaces, questo mostra il nome del file, formato project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Versione Qt
MY_VS_VERSION: 2019 # Vs Version
MY_QT_MINGW32: mingw81_32 # Variabili della cartella Qt solo per Windows
MY_QT_MINGW64: mingw81_64 # Variabili della cartella Qt solo per Windows
MY_QT_TOOLS_MINGW32: mingw810_32 # Variabili cartella Qt solo Windows
MY_QT_TOOLS_MINGW64: mingw810_64 # Variabili cartella Qt solo Windows
MY_QT_IF_VERSION: '4.1.1' # Versione framework di installazione QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # L'ultima versione che Windows 7 può eseguire è 3.8.x
MY_PYTHON_REQUIRED: false # se Python è richiesto
MY_RUN_DOXYFILE: falso; # esegui Doxygen
```

# Banca dati

```sql
Progetti: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREATE TABLE Projects (id intero PRIMARY KEY autoincrement,
                      QtProject varchar,
                      Varchar segreto,
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

Configurazione: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID è Projects id

CREATE TABLE Configurazione (id intero PRIMARY KEY autoincrement,
                           ID progetti varchar,
                           varchar del sistema operativo,
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
                           OsAggiorna varchar

```

# Aiuto

Questa applicazione ha integrato [Help](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) nell'app stessa,
e un [Informazioni](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
nonché un pulsante [Author](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) su entrambe le finestre di dialogo,
che puoi rimuovere facilmente semplicemente rimuovendo il pulsante dai due moduli e rimuovendo il file stesso,
questo pulsante e questo contenuto riguardano me l'autore originale, ma non è obbligatorio,
né ci sono licenze, questo progetto ha una licenza [Unlicnsed](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt),
questo è per rendere più facile per chiunque effettuare il fork e utilizzarlo come modello,
e cercherò di espandere le sezioni della Guida,
e aggiungi altri contenuti [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki),
questo potrebbe aiutare.

# Schermate

![Impostazioni](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

![Predefiniti](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### Fine-LEGGIMI.md