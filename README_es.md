# QtAppVeyor

Todo programa necesita una razón para existir,
este existe porque estaba trabajando en un proyecto para actualizar mi [Galaxy Calculator] (https://github.com/Light-Wizzard/galaxy-calculator) de QML,
a C ++, por lo que esta aplicación Qt quiero trabajar en tantas plataformas como sea posible,
habiendo tenido el programa Galaxy Calculator en [AppVeyor] (https://appveyor.com) durante un tiempo,
Decidí probarlo,
pero pronto me resultó difícil hacer que mi proyecto funcionara en Windows y Linux,
ese programa es más complejo con la biblioteca,
así que quería escribir una aplicación corta que hiciera algo útil para existir,
pero al mismo tiempo fue solo para probar mis scripts de AppVeyor,
Fue entonces cuando decidí por qué no hacer una herramienta de automatización de secuencias de comandos de AppVeyor,
y ahora mi concepto es usar el script Yaml que esta aplicación lanza para implementar esta aplicación.

Este proyecto es para AppVeyor si quieren bifurcarlo y asumirlo como un proyecto comunitario,
para convertirla en una mejor aplicación y ofrecer a los desarrolladores algo que funcione,
para que puedan basar sus proyectos en este proyecto,
y hacer que se compile de forma cruzada en tantas plataformas como sea posible.

Esta es una aplicación simple escrita en Qt C ++ usando Widgets,
usa SQL para almacenar proyectos,
es una aplicación simple que tiene una página de configuración para ingresar todas las Variables necesarias para hacer un archivo AppVeyor Yaml,
por lo que con un clic en la parte inferior puede automatizar la creación de un archivo .appveyor.yml.

Esta aplicación es básicamente solo para mostrarle cómo implementar Qt C ++ QtCreator Projects,
en Linux, Mac, Windows y tal vez WebAssembly e iOS, así como Android,
y cómo usar Qt Installer Framework para hacer aplicaciones instalables,
que también se pueden actualizar.

Este proyecto no solo está dirigido a desarrolladores de Qt Software,
debería poder manejar muchos entornos diferentes,
pero actualmente Qt es el único entorno en el que he estado trabajando,
pero agregué un botón para diferentes entornos,
de esta manera esta herramienta será útil para todos los desarrolladores de software.

Mi mayor problema es la falta de experiencia en Windows Scripting,
No he usado Windows en décadas, y solo compré Windows 10 Pro recientemente,
solo para usar Word, y yo no uso Mac, así que Linux es realmente todo lo que puedo hacer para trabajar,
así que realmente me vendría bien un poco de ayuda para escribir los scripts.

Qt se está moviendo a cmake en la versión 6, así que no tengo más remedio que alejarme de qmake.

Para Windows, no estoy seguro de si MingW es la herramienta adecuada, o si lo es VS,
o si debería usar MSYS o Cygwin.

## Tabla de contenidos

1. [Roto] (https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [Estado] (https://github.com/Light-Wizzard/QtAppVeyor#Status)
3. [Desarrollo-Progreso] (https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Trabajando en] (https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [Variables] (https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [Base de datos] (https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [Ayuda] (https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [Capturas de pantalla] (https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10. [Compilación cruzada] (https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen Documention] (https://light-wizzard.github.io/QtAppVeyor)

# Roto

Las cosas que están rotas deben trabajarse primero,
estas son las cosas con las que necesito ayuda.

1. Las compilaciones de Windows x86 y x64 no funcionan, estoy usando windeploy, todos los dll están ahí, pero no se ejecutarán.
2. Marco de instalación de Qt.
3. Mac, WebAssembly, iOS y Android.
4. cmake, el futuro de Qt 6.

Problemas: Windows cumple pero no se ejecuta debido a dll que están en la misma carpeta, este es un proyecto de qmake,
y he creado un archivo cmake funcional, y realmente necesito cambiar a cmake para todo el proyecto,
y eso es en lo que estoy trabajando actualmente, pero mi falta de scripts de Windows, PowerShell o Command,
Entiendo un poco el idioma, habiendo tenido que escribir algunos a lo largo de los años,
mi objetivo es poner todos los scripts en dos archivos, uno para Instalar, el otro para Build,
Quiero hacer un paquete Qt Installer Framework con [Actualizaciones automáticas de Qt] (https://github.com/Skycoder42/QtAutoUpdater),
este proyecto de GitHub está orientado a Qt Installer Framework,
como tal, solo quiero crear un archivo zip con el paquete Qt Installer.

Si puedo hacer que todas estas cosas funcionen, me gustaría ver si AppVeyor lo bifurcaría,
y podemos trabajar en ello allí, escribí esto para que se lo dieran a otros,
para ayudarlos a publicar sus Aplicaciones con facilidad,
el concepto es simple, esta aplicación utiliza la mayoría de las funciones que la mayoría de la gente quiere,
Qt Settings para almacenar variables y SQL,
Entonces, si puede hacer que esto funcione para todos los sistemas operativos compatibles con Qt,
hará que sea mucho más fácil para las personas copiar cómo se hizo esto,
por lo que este proyecto necesita mucho trabajo para convertirlo en un mejor ejemplo para la práctica,
para que pueda ver que solo he agregado una cantidad mínima de funciones que son fáciles de ampliar.

Necesito comentarios sobre lo que piensas sobre el concepto
que la Aplicación, qué características le gustaría ver en ella,
y realmente necesito saber qué scripts ejecutar para que todo esto funcione,
Soy bueno en bash, pero no tanto en PowerShell o CMD,
y no mucho en Mac, iOS, pero tengo un Android.

Quiero que esta aplicación se convierta en el estándar de AppVeyor para recomendar su uso,
y por qué necesitan bifurcarlo y hacerlo suyo,
Solo estoy tratando de darles algo que valga la pena asumir
y por qué lo llamé QtAppVeyor y traté de que toda la documentación fuera fácil de limpiar,
y Doxygen listo, la traducción debe realizarse,
pero siempre espero hasta el final para empezar.

# Estado

[! [Estado de compilación de Appveyor] (https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)] (https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###: paquete: ** Descargas: **

 -: pingüino: [zip de Linux] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 -: oficina: [zip de Windows] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 -: apple: Actualmente no disponible [Apple zip] (https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

Actualmente, Windows no funciona, si lo fuera, diría algo como esto:

Windows (probado en 7 y 10, avíseme si 8 funciona): descargue zip y extráigalo,
y ejecute el archivo QtAppVeyor.exe dentro de la carpeta de implementación de AppDir.

Cuando se complete, solo tendrá un artefacto, el marco de instalación de Qt con actualización automática de Qt en un archivo zip.

# El progreso del desarrollo

Para obtener más información, consulte: [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki)

Este es un trabajo en progreso, informe cualquier error y deje comentarios.

# Trabajando en

* cmake en lugar de qmake
* Marco de instalación de Qt
* AppImage actualizable
* Scripts de Windows en lugar de en línea
* Mac
* Android
* WebAssembly
* iOS
* Compilación MSVS del proyecto Qt

# Variables

Si usa esta aplicación para crear archivos .appveyor.yml,
necesitará conocer todas estas variables,
incluso si crea su propio archivo, los sabrá,
y mantener manualmente los cambios,
donde esta aplicación le permite simplemente cambiar las Variables y crear un nuevo archivo.

Cada variable se utiliza en scripts para configurar la aplicación para su implementación.

* MY_BIN_PRO_RES_NAME: Nombre del proyecto Qt, es decir. QtAppVeyor.pro, asume que el nombre del exe es el mismo.
* MY_OS: esto se usa para hacer nombres de paquetes, por lo que no hay espacios
* MY_VS_VERSION: Versión Qt
* MY_QT_IF_VERSION: Versión de Qt Installer Framework (QIF)
* MY_QIF_PACKAGE_URI: Carpeta para paquetes QIF
* MY_PYTHON_VER: Versión de Python, tenga en cuenta que Windows 7 se detiene en 3.8
* MY_PYTHON_REQUIRED: ¿Se requiere Python?
* MY_UPGRADE_OS: Actualización del sistema Unix
* MY_QT_MINGW32: Rutas MingW
* MY_QT_MINGW32: Rutas MingW
* MY_QT_TOOLS_MINGW32: Rutas MingW
* MY_QT_TOOLS_MINGW64: Rutas MingW

Unix

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Sin espacios, esto muestra el nombre del archivo, formato project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Versión Qt
MY_QT_IF_VERSION: '4.1.1' # Versión del marco de instalación de QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # La última versión que puede ejecutar Windows 7 es 3.8.x
MY_PYTHON_REQUIRED: falso # si se requiere Python
MY_UPGRADE_OS: false # apt-get upgrade: solo verdadero o falso
MY_RUN_DOXYFILE: falso; # ejecutar Doxygen
''

Ventanas

`` yaml
MY_BIN_PRO_RES_NAME: QtAppVeyor #
MY_OS: Windows # Sin espacios, esto muestra el nombre del archivo, formato project-os-configuration-plateform
MY_QT_VERSION: 5.15.2 # Versión Qt
MY_VS_VERSION: Versión 2019 # Vs
MY_QT_MINGW32: mingw81_32 # Variables de carpeta Qt solo para Windows
MY_QT_MINGW64: mingw81_64 # Variables de carpeta Qt solo para Windows
MY_QT_TOOLS_MINGW32: mingw810_32 # Variables de la carpeta Qt solo para Windows
MY_QT_TOOLS_MINGW64: mingw810_64 # Variables de la carpeta Qt solo para Windows
MY_QT_IF_VERSION: '4.1.1' # Versión del marco de instalación de QT
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor \ data' #
MY_PYTHON_VER: 3.8 # La última versión que puede ejecutar Windows 7 es 3.8.x
MY_PYTHON_REQUIRED: falso # si se requiere Python
MY_RUN_DOXYFILE: falso; # ejecutar Doxygen
''

# Base de datos

`` `sql
Proyectos: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease

CREAR TABLA Proyectos (id integer PRIMARY KEY autoincrement,
                      QtProject varchar,
                      Varchar secreto,
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

Configuración: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade

ProjectsID es ID de proyectos

CREAR TABLA Configuración (id integer PRIMARY KEY autoincrement,
                           ProyectosID varchar,
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

# Ayudar

Esta aplicación se ha integrado en [Ayuda] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html) en la propia aplicación,
y un [Acerca de] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html),
así como un botón [Autor] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) en ambos cuadros de diálogo,
que puede eliminar fácilmente simplemente quitando el botón de los dos formularios y eliminando el archivo en sí,
este botón y el contenido es sobre mí, el autor original, pero no es obligatorio,
ni hay Licencias, este proyecto tiene una Licencia [Sin licencia] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt),
esto es para que sea más fácil para cualquier persona usar la bifurcación y usarla como plantilla,
e intentaré ampliar las secciones de Ayuda,
y agregue más contenido de [Wiki] (https://github.com/Light-Wizzard/QtAppVeyor/wiki),
eso podría ayudar.

# Capturas de pantalla

! [Configuración] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

! [SQL] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

! [Ubuntu] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

! [Windows] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

! [Valores predeterminados] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

! [YML] (https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### End-of-README.md