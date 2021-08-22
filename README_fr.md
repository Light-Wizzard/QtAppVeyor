# QtAppVeyor

Chaque programme a besoin d'une raison d'exister,
celui-ci existe parce que je travaillais sur un projet pour mettre à jour mon [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) à partir de QML,
en C++, donc cette application Qt, je veux travailler sur autant de plates-formes que possible,
avoir eu le programme Galaxy Calculator sur [AppVeyor](https://appveyor.com) pendant un certain temps,
J'ai décidé de lui laisser une chance,
mais j'ai vite eu du mal à faire fonctionner mon projet sous Windows et Linux,
ce programme est plus complexe avec celui de Library,
j'ai donc voulu écrire une petite application qui faisait quelque chose d'utile pour exister,
mais en même temps c'était uniquement pour tester mes scripts AppVeyor,
c'est alors que j'ai décidé pourquoi ne pas créer un outil d'automatisation de script AppVeyor,
et maintenant mon concept est d'utiliser le script Yaml que cette application sort pour déployer cette application.

Ce projet est destiné à AppVeyor s'ils veulent le partager et le reprendre en tant que projet communautaire,
pour en faire une meilleure application et donner aux développeurs quelque chose qui fonctionne,
pour qu'ils puissent fonder leurs projets sur ce projet,
et faites-le effectuer une compilation croisée sur autant de plates-formes que possible.

Il s'agit d'une application simple écrite en Qt C++ à l'aide de Widgets,
il utilise SQL pour stocker les projets,
c'est une application simple qui a une page de paramètres pour entrer toutes les variables nécessaires pour créer un fichier AppVeyor Yaml,
ainsi, d'un simple clic, vous pouvez automatiser la création d'un fichier .appveyor.yml.

Cette application est essentiellement juste pour vous montrer comment déployer des projets Qt C++ QtCreator,
sur Linux, Mac, Windows, et peut-être WebAssembly et iOS, ainsi qu'Android,
et comment utiliser Qt Installer Framework pour créer des applications installables,
qui peuvent également être mis à jour.

Ce projet n'est pas seulement destiné aux développeurs de Qt Software,
il devrait être capable de gérer de nombreux environnements différents,
mais actuellement Qt est le seul environnement sur lequel j'ai travaillé,
mais j'ai ajouté un bouton pour différents environnements,
de cette façon, cet outil sera utile à chaque développeur de logiciels.

Mon plus gros problème est le manque d'expérience des scripts Windows,
Je n'ai pas utilisé Windows depuis des décennies et j'ai acheté récemment Windows 10 Pro,
juste pour utiliser Word, et je ne fais pas de Mac, donc Linux est vraiment tout ce que je peux utiliser pour travailler,
donc je peux vraiment utiliser de l'aide pour écrire les scripts.

Qt passe à cmake dans la version 6, je n'ai donc pas d'autre choix que de m'éloigner de qmake.

Pour Windows, je ne sais pas si MingW est le bon outil, ou si VS l'est,
ou si je devais utiliser MSYS, ou Cygwin.

## Table des matières

1. [Cassé](https://github.com/Light-Wizzard/QtAppVeyor#Cassé)
2. [Statut](https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Développement-Progrès](https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Travail sur] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variables](https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Base de données] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Aide](https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Captures d'écran] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Cross-Compile](https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Documentation Doxygen] (https://light-wizzard.github.io/QtAppVeyor)

# Cassé

Les choses qui sont cassées doivent être travaillées en premier,
ce sont les choses pour lesquelles j'ai besoin d'aide.

1. Les versions Windows x86 et x64 ne fonctionnent pas, j'utilise windeploy, toutes les dll sont là, mais elles ne fonctionneront pas.
2. Cadre d'installation de Qt.
3. Mac, WebAssembly, iOS et Android.
4. cmake, le futur de Qt 6.

Problèmes : Windows est conforme mais ne fonctionne pas à cause des dll qui se trouvent dans le même dossier, il s'agit d'un projet qmake,
et j'ai créé un fichier cmake fonctionnel, et j'ai vraiment besoin de passer à cmake pour tout le projet,
et c'est sur quoi je travaille actuellement, mais mon manque de scripts Windows, PowerShell ou Command,
Je comprends un peu le langage, ayant dû en écrire au fil des ans,
mon objectif est de mettre tous les scripts dans deux fichiers, un pour l'installation, l'autre pour le build,
Je souhaite créer un package Qt Installer Framework avec [Qt Auto Updates] (https://github.com/Skycoder42/QtAutoUpdater),
ce projet GitHub est adapté à Qt Installer Framework,
en tant que tel, je ne souhaite créer qu'un seul fichier zip avec le package Qt Installer.

Si je peux faire fonctionner toutes ces choses, j'aimerais voir si AppVeyor le ferait,
et on peut y travailler là-bas, j'ai écrit ça pour qu'ils le donnent aux autres,
pour les aider à publier leurs Applications en toute simplicité,
le concept est simple, cette application utilise la plupart des fonctionnalités que la plupart des gens veulent,
Paramètres Qt pour stocker les variables, et SQL,
donc si vous pouvez faire en sorte que cela fonctionne pour tous les systèmes d'exploitation pris en charge par Qt,
il sera beaucoup plus facile pour les gens de copier comment cela a été fait,
ce projet a donc besoin de beaucoup de travail pour en faire un exemple de meilleure pratique,
vous pouvez donc voir que je n'ai ajouté qu'un nombre minimal de fonctionnalités faciles à développer.

J'ai besoin de vos commentaires sur ce que vous pensez du concept,
que l'Application, quelles fonctionnalités vous voudriez y voir,
et vraiment j'ai besoin de savoir quels scripts exécuter pour que tout cela fonctionne,
Je suis bon en bash, mais pas tellement en PowerShell ou CMD,
et pas grand-chose dans Mac, iOS, mais j'ai un Android.

Je veux voir cette application devenir la norme pour AppVeyor à recommander d'utiliser,
et pourquoi ils ont besoin de le forger, et de le faire leur,
J'essaie juste de leur donner quelque chose qui vaut la peine d'être repris,
et pourquoi je l'ai marqué QtAppVeyor, et essayé de rendre toute la documentation facile à nettoyer,
et Doxygen ready, la traduction doit être faite,
mais j'attends toujours la fin pour commencer.

# Statut

[![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

### :package : **Téléchargements :**

 - :pingouin : [Linux zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 - :office : [Windows zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 - :apple : actuellement indisponible [Apple zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Actuellement, Windows ne fonctionne pas, si c'était le cas, il dirait quelque chose comme ceci :

Windows (Testé sur 7 et 10, dites-moi si 8 fonctionne) : Téléchargez le zip et extrayez-le,
et exécutez le fichier QtAppVeyor.exe dans le dossier deploy AppDir.

Une fois terminé, il n'aura qu'un seul artefact, le Qt Installer Framework avec Qt Auto Update dans un fichier zip.

# Développement-Progrès

Pour plus d'informations, consultez : [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Ceci est un travail en cours, veuillez signaler tout bug et laisser des commentaires.

# Travaille sur

* cmake au lieu de qmake
* Cadre d'installation Qt
* AppImage pouvant être mise à jour
* Scripts Windows au lieu d'inline
* Mac
* Android
* WebAssemblage
* iOS
* Version MSVS du projet Qt

# Variables

Si vous utilisez cette application pour créer des fichiers .appveyor.yml,
vous aurez besoin de connaître toutes ces variables,
même si vous faites votre propre fichier, vous les aurez connus,
et maintenir manuellement les modifications,
alors que cette application vous permet simplement de modifier les variables et de créer un nouveau fichier.

Chaque variable est utilisée dans les scripts pour configurer l'application pour le déploiement.

* MY_BIN_PRO_RES_NAME : nom de Qt Projects, c'est-à-dire. QtAppVeyor.pro, suppose que le nom de l'exe est le même.
* MY_OS : Ceci est utilisé pour créer des noms de packages, donc pas d'espaces
* MY_VS_VERSION : version Qt
* MY_QT_IF_VERSION : version Qt Installer Framework (QIF)
* MY_QIF_PACKAGE_URI : Dossier pour les packages QIF
* MY_PYTHON_VER : Version Python, notez que Windows 7 s'arrête à 3.8
* MY_PYTHON_REQUIRED : Python est-il requis
* MY_UPGRADE_OS : mise à niveau du système Unix
* MY_QT_MINGW32 : chemins MingW
* MY_QT_MINGW32 : chemins MingW
* MY_QT_TOOLS_MINGW32 : chemins MingW
* MY_QT_TOOLS_MINGW64 : chemins MingW

Unix

```yaml
MY_BIN_PRO_RES_NAME : QtAppVeyor #
MY_OS : Windows # Pas d'espaces, cela affiche le nom du fichier, format project-os-configuration-plateform
MY_QT_VERSION : 5.15.2 # Version Qt
MY_QT_IF_VERSION : '4.1.1' # Version du cadre d'installation de QT
MY_QIF_PACKAGE_URI : 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER : 3.8 # La dernière version que Windows 7 peut exécuter est la 3.8.x
MY_PYTHON_REQUIRED : false # si Python est requis
MY_UPGRADE_OS : false # apt-get upgrade : true ou false uniquement
MY_RUN_DOXYFILE : faux ; # exécuter Doxygen
```

les fenêtres

```yaml
MY_BIN_PRO_RES_NAME : QtAppVeyor #
MY_OS : Windows # Pas d'espaces, cela affiche le nom du fichier, format project-os-configuration-plateform
MY_QT_VERSION : 5.15.2 # Version Qt
MY_VS_VERSION : 2019 # Vs Version
MY_QT_MINGW32 : mingw81_32 # Variables du dossier Qt pour Windows uniquement
MY_QT_MINGW64: mingw81_64 # Windows uniquement Dossier Qt Variables
MY_QT_TOOLS_MINGW32 : mingw810_32 # Variables du dossier Qt pour Windows uniquement
MY_QT_TOOLS_MINGW64 : mingw810_64 # Windows uniquement Dossier Qt Variables
MY_QT_IF_VERSION : '4.1.1' # Version du cadre d'installation de QT
MY_QIF_PACKAGE_URI : 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER : 3.8 # La dernière version que Windows 7 peut exécuter est la 3.8.x
MY_PYTHON_REQUIRED : false # si Python est requis
MY_RUN_DOXYFILE : faux ; # exécuter Doxygen
```

# Base de données

```sql
Projets : id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREATE TABLE Projects(id entier PRIMARY KEY auto-incrément,
                      QtProject varchar,
                      Varchar secret,
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

Configuration : ID, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID est l'identifiant du projet

CREATE TABLE Configuration(id entier PRIMARY KEY auto-incrémentation,
                           ProjectsID varchar,
                           OS varchar,
                           QtVersion varchar,
                           QtIfVersion varchar,
                           QtIfPackageUri varchar,
                           PythonVersion varchar,
                           PythonRequis varchar,
                           QtMingW32 varchar,
                           QtMingW64 varchar,
                           QtToolsMingW32 varchar,
                           QtToolsMingW64 varchar,
                           VisualStudio varchar,
                           OsUpgrade varchar

```

# Aider

Cette application a intégré [Aide](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) sur l'application elle-même,
et un [À propos](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
ainsi qu'un bouton [Auteur](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) sur les deux boîtes de dialogue,
que vous pouvez supprimer facilement en supprimant simplement le bouton des deux formulaires, et en supprimant le fichier lui-même,
ce bouton et ce contenu sont à propos de moi, l'auteur original, mais n'est pas obligatoire,
ni aucune licence, ce projet a une licence [Unlicnsed](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt),
cela permet à quiconque de fork et de l'utiliser plus facilement comme modèle,
et je vais essayer de développer les sections d'aide,
et ajoutez plus de contenu [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki),
ça pourrait aider.

# Captures d'écran

![Paramètres](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

![Par défaut](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### Fin du fichier README.md