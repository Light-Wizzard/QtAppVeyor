# QtAppVeyor

每个程序都需要存在的理由，
这个存在是因为我正在做一个项目，从 QML 更新我的 [Galaxy Calculator](https://github.com/Light-Wizzard/galaxy-calculator)，
到 C++，所以这个 Qt 应用程序我想在尽可能多的平台上工作，
在 [AppVeyor](https://appveyor.com) 上安装 Galaxy Calculator 程序已有一段时间了，
我决定试一试
但很快发现很难让我的项目在 Windows 和 Linux 上运行，
该程序与图书馆的更复杂，
所以我想写一个简短的应用程序来做一些有用的事情，
但同时也只是为了测试我的 AppVeyor 脚本，
那时我决定为什么不制作 AppVeyor 脚本自动化工具，
现在我的概念是使用这个应用程序推出的 Yaml 脚本来部署这个应用程序。

这是 AppVeyor 的项目，如果他们想将它分叉并作为社区项目接管，
使其成为更好的应用程序，并为开发人员提供有用的东西，
所以他们可以根据这个项目来做他们的项目，
并让它交叉编译到尽可能多的平台。

这是一个使用小部件用 Qt C++ 编写的简单应用程序，
它使用 SQL 来存储项目，
这是一个简单的应用程序，它有一个设置页面，可以输入制作 AppVeyor Yaml 文件所需的所有变量，
因此，只需单击底部，您就可以自动创建 .appveyor.yml 文件。

这个 App 基本上只是向你展示如何部署 Qt C++ QtCreator 项目，
在 Linux、Mac、Windows 上，也许还有 WebAssembly 和 iOS，以及 Android，
以及如何使用 Qt Installer Framework 制作可安装应用程序，
也可以更新。

该项目不仅适用于 Qt 软件开发人员，
它应该能够处理许多不同的环境，
但目前 Qt 是我一直在研究的唯一环境，
但我确实为不同的环境添加了一个按钮，
这样，这个工具对每个软件开发人员都很有用。

我最大的问题是缺乏 Windows 脚本经验，
我几十年没有用过 Windows，最近才买了 Windows 10 Pro，
只是为了使用 Word，而我不使用 Mac，所以 Linux 真的是我可以开始工作的全部，
所以我真的可以使用一些帮助来编写脚本。

Qt 在第 6 版中转向 cmake，所以我别无选择，只能离开 qmake。

对于 Windows，我不确定 MingW 是否是正确的工具，或者 VS 是否是，
或者我是否应该使用 MSYS 或 Cygwin。

## 目录

1. [Broken](https://github.com/Light-Wizzard/QtAppVeyor#Broken)
2. [状态](https://github.com/Light-Wizzard/QtAppVeyor#Status)
3.【开发进度】(https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress)
4. [Working-On](https://github.com/Light-Wizzard/QtAppVeyor#Working-On)
5. [变量](https://github.com/Light-Wizzard/QtAppVeyor#Variables)
6. [数据库](https://github.com/Light-Wizzard/QtAppVeyor#Database)
7. [帮助](https://github.com/Light-Wizzard/QtAppVeyor#Help)
8. [屏幕截图](https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots)
9. [维基](https://github.com/Light-Wizzard/QtAppVeyor/wiki)
10.【交叉编译】(https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile)
11. [Doxygen 文档](https://light-wizzard.github.io/QtAppVeyor)

# 坏了

破碎的东西需要先处理，
这些是我需要帮助的事情。

1. Windows x86 和 x64 版本不工作，我使用的是 Windeploy，所有的 dll 都在那里，但它不会运行。
2. Qt 安装程序框架。
3. Mac、WebAssembly、iOS 和 Android。
4. cmake，Qt 6 的未来。

问题：Windows 符合但由于 dll 位于同一文件夹中而无法运行，这是一个 qmake 项目，
我已经创建了一个有效的 cmake 文件，我确实需要为整个项目切换到 cmake，
这就是我目前正在做的工作，但我缺乏 Windows 脚本、PowerShell 或命令，
我有点理解语言，多年来不得不写一些，
我的目标是将所有脚本放入两个文件中，一个用于安装，另一个用于构建，
我想用[Qt Auto Updates](https://github.com/Skycoder42/QtAutoUpdater)制作一个Qt安装程序框架包，
这个 GitHub 项目面向 Qt 安装程序框架，
因此，我只想使用 Qt 安装程序包制作一个 zip 文件。

如果我能让所有这些东西都工作，我想看看 AppVeyor 是否会分叉它，
我们可以在那里工作，我写了这个给他们给别人，
帮助他们轻松发布应用程序，
这个概念很简单，这个应用程序使用了大多数人想要的大部分功能，
用于存储变量和 SQL 的 Qt 设置，
所以如果你能让它适用于 Qt 支持的所有操作系统，
这将使人们更容易复制这是如何完成的，
所以这个项目需要大量的工作才能使它成为一个最佳实践的例子，
所以你可以看到我只添加了少量易于扩展的功能。

我需要关于你对这个概念的看法的反馈，
除了应用程序，您希望在其中看到哪些功能，
我真的需要知道要运行哪些脚本才能使这一切正常进行，
我擅长 bash，但不太擅长 PowerShell 或 CMD，
对 Mac、iOS 并不多，但我确实有一个 Android。

我希望看到这个应用程序成为 AppVeyor 推荐使用的标准，
以及为什么他们需要分叉它，让它成为他们的，
我只是想给他们一些值得接管的东西，
以及为什么我将其命名为 QtAppVeyor，并试图使所有文档易于清理，
和 Doxygen 准备好了，翻译需要完成，
但我总是等到最后才开始。

# 状态

[![Appveyor 构建状态](https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true)](https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor)

###：包：**下载：**

 - :penguin: [Linux zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip)
 - :office: [Windows zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip)
 - :apple: 当前不可用 [Apple zip](https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip)

当前，Windows 不工作，如果是，它会说这样的话：

Windows（在 7 和 10 上测试过，如果 8 有效，请告诉我）：下载 zip 并解压缩，
并运行部署 AppDir 文件夹中的文件 QtAppVeyor.exe。

完成后，它将只有一个 Artifact，即 Qt 安装程序框架和 Qt 自动更新的 zip 文件。

# 发展-进步

更多信息请参见：[Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki)

这是一项正在进行的工作，请报告任何错误并发表评论。

# 工作

* cmake 而不是 qmake
* Qt 安装程序框架
* 可更新的 AppImage
* Windows 脚本而不是内联
* Mac
* 安卓
* WebAssembly
* iOS
* Qt 项目的 MSVS 构建

# 变量

如果您使用此应用程序制作 .appveyor.yml 文件，
你需要知道所有这些变量，
即使你制作自己的文件，你也会知道这些，
并手动维护更改，
因为这个应用程序允许您更改变量并创建一个新文件。

每个变量都在脚本中用于设置要部署的应用程序。

* MY_BIN_PRO_RES_NAME：Qt 项目名称，即。 QtAppVeyor.pro，假设 exe 名称相同。
* MY_OS：用于制作包名，所以没有空格
* MY_VS_VERSION：Qt 版本
* MY_QT_IF_VERSION：Qt 安装程序框架（QIF）版本
* MY_QIF_PACKAGE_URI：QIF 包的文件夹
* MY_PYTHON_VER：Python 版本，注意 Windows 7 停在 3.8
* MY_PYTHON_REQUIRED：是否需要 Python
* MY_UPGRADE_OS: Unix 系统升级
* MY_QT_MINGW32：MingW 路径
* MY_QT_MINGW32：MingW 路径
* MY_QT_TOOLS_MINGW32：MingW 路径
* MY_QT_TOOLS_MINGW64：MingW 路径

Unix

```yaml
MY_BIN_PRO_RES_NAME：QtAppVeyor #
MY_OS: Windows # No Spaces，显示文件名，project-os-configuration-plateform格式
MY_QT_VERSION: 5.15.2 # Qt 版本
MY_QT_IF_VERSION: '4.1.1' # QT 安装框架版本
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # Windows 7 可以运行的最新版本是 3.8.x
MY_PYTHON_REQUIRED: false # 如果需要 Python
MY_UPGRADE_OS: false # apt-get upgrade: true 或 false only
MY_RUN_DOXYFILE：假； # 运行 Doxygen
``

视窗

```yaml
MY_BIN_PRO_RES_NAME：QtAppVeyor #
MY_OS: Windows # No Spaces，显示文件名，project-os-configuration-plateform格式
MY_QT_VERSION: 5.15.2 # Qt 版本
MY_VS_VERSION: 2019 # Vs 版本
MY_QT_MINGW32: mingw81_32 # Windows 仅 Qt 文件夹变量
MY_QT_MINGW64: mingw81_64 # Windows 仅 Qt 文件夹变量
MY_QT_TOOLS_MINGW32: mingw810_32 # Windows 仅 Qt 文件夹变量
MY_QT_TOOLS_MINGW64: mingw810_64 # Windows 仅 Qt 文件夹变量
MY_QT_IF_VERSION: '4.1.1' # QT 安装框架版本
MY_QIF_PACKAGE_URI: 'com.appveyor.qtappveyor\data' #
MY_PYTHON_VER: 3.8 # Windows 7 可以运行的最新版本是 3.8.x
MY_PYTHON_REQUIRED: false # 如果需要 Python
MY_RUN_DOXYFILE：假； # 运行 Doxygen
``

# 数据库

```sql
项目：id、QtProject、Secret、IsOsUbuntu、IsOsMac、IsOsWebAssembly、IsOSiOS、IsOsWindows、IsOsAndroid、IsX64、IsX86、IsDebug、IsRelease

CREATE TABLE Projects(id integer PRIMARY KEY autoincrement,
                      QtProject varchar，
                      秘密变量，
                      IsOsUbuntu varchar，
                      IsOsMac varchar，
                      IsOsWebAssembly varchar，
                      IsOSiOS varchar,
                      IsOsWindows varchar，
                      IsOsAndroid varchar，
                      IsX64 varchar，
                      IsX86 varchar，
                      IsDebug varchar,
                      IsRelease varchar

配置：id、ProjectsID、OS、QtVersion、QtIfVersion、QtIfPackageUri、PythonVersion、PythonRequired、QtMingW32、QtMingW64、QtToolsMingW32、QtToolsMingW64、VisualStudio、OsUpgrade

ProjectsID 是项目 ID

CREATE TABLE Con​​figuration(id integer PRIMARY KEY autoincrement,
                           项目ID varchar，
                           操作系统 varchar，
                           QtVersion varchar，
                           QtIfVersion varchar，
                           QtIfPackageUri varchar，
                           Python版本的varchar，
                           Python必需的varchar，
                           QtMingW32 varchar，
                           QtMingW64 varchar，
                           QtToolsMingW32 varchar，
                           QtToolsMingW64 varchar，
                           VisualStudio varchar，
                           操作系统升级 varchar

``

# 帮助

此应用程序在应用程序本身上内置了 [Help](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html)，
和 [关于](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html)，
以及两个对话框上的 [作者](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html) 按钮，
您只需从两个表单中删除按钮并删除文件本身即可轻松删除，
这个按钮和内容是关于我的原始作者，但不是必需的，
也没有任何许可证，这个项目有一个 [Unlicnsed](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt) 许可证，
这是为了让任何人更容易分叉并用作模板，
我将尝试扩展帮助部分，
并添加更多 [Wiki](https://github.com/Light-Wizzard/QtAppVeyor/wiki) 内容，
这可能会有所帮助。

# 屏幕截图

![设置](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png)

![SQL](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png)

![Ubuntu](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png)

![Windows](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png)

![默认](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png)

![YML](https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png)

### README.md 结尾