＃QtAppVeyor

すべてのプログラムには存在する理由が必要です、
これは、[Galaxy Calculator]（https://github.com/Light-Wizzard/galaxy-calculator）をQMLから更新するプロジェクトに取り組んでいたために存在します。
C ++に移行するため、このQtアプリケーションはできるだけ多くのプラットフォームで作業したいと思います。
[AppVeyor]（https://appveyor.com）でGalaxy Calculatorプログラムをしばらく使用していたので、
試してみることにしました、
しかし、すぐに私のプロジェクトをWindowsとLinuxで動作させるのが難しいことに気づきました。
そのプログラムは図書館のものとより複雑です、
だから私は、存在するのに役立つ何かをした短いアプリケーションを書きたかったのです。
しかし同時に、AppVeyorスクリプトをテストするだけでした。
それから、AppVeyorスクリプト自動化ツールを作成しない理由を決めました。
そして今、私のコンセプトは、このアプリケーションが出力するYamlスクリプトを使用してこのアプリケーションをデプロイすることです。

これは、AppVeyorがフォークしてコミュニティプロジェクトとして引き継ぐ場合のプロジェクトです。
それをより良いアプリケーションにし、開発者に機能するものを提供するために、
彼らはこのプロジェクトに基づいてプロジェクトを行うことができます。
できるだけ多くのプラットフォームにクロスコンプリートさせます。

これは、ウィジェットを使用してQt C ++で記述された単純なアプリケーションです。
SQLを使用してプロジェクトを保存します。
これは、AppVeyorYamlファイルを作成するために必要なすべての変数を入力するための設定ページがあるシンプルなアプリです。
そのため、下部をクリックするだけで、.appveyor.ymlファイルの作成を自動化できます。

このアプリは基本的に、Qt C ++ QtCreatorプロジェクトをデプロイする方法を示すためのものです。
Linux、Mac、Windows、そしておそらくWebAssemblyとiOS、そしてAndroidでは、
Qtインストーラーフレームワークを使用してインストール可能なアプリケーションを作成する方法、
更新も可能です。

このプロジェクトは、Qtソフトウェア開発者だけを対象としたものではありません。
多くの異なる環境を処理できるはずです。
しかし現在、Qtは私が取り組んできた唯一の環境です。
しかし、私はさまざまな環境用のボタンを追加しました、
このように、このツールはすべてのソフトウェア開発者に役立ちます。

私の最大の問題は、Windowsスクリプトの経験が不足していることです。
私は何十年もの間Windowsを使用しておらず、最近Windows 10Proを購入したばかりです。
Wordを使うだけで、私はMacを使っていないので、Linuxだけで仕事ができます。
だから私はスクリプトを書くのに本当に役立つことができます。

Qtはバージョン6でcmakeに移行しているので、qmakeから離れるしかありません。

Windowsの場合、MingWが適切なツールであるかどうか、またはVSが適切であるかどうかはわかりません。
または、MSYSまたはCygwinを使用する必要がある場合。

##目次

1. [壊れた]（https://github.com/Light-Wizzard/QtAppVeyor#Broken）
2. [ステータス]（https://github.com/Light-Wizzard/QtAppVeyor#Status）
3. [開発-進捗状況]（https://github.com/Light-Wizzard/QtAppVeyor#Development-Progress）
4. [Working-On]（https://github.com/Light-Wizzard/QtAppVeyor#Working-On）
5. [変数]（https://github.com/Light-Wizzard/QtAppVeyor#Variables）
6. [データベース]（https://github.com/Light-Wizzard/QtAppVeyor#Database）
7. [ヘルプ]（https://github.com/Light-Wizzard/QtAppVeyor#Help）
8. [スクリーンショット]（https://github.com/Light-Wizzard/QtAppVeyor#Screen-Shots）
9. [Wiki]（https://github.com/Light-Wizzard/QtAppVeyor/wiki）
10. [クロスコンパイル]（https://github.com/Light-Wizzard/QtAppVeyor/wiki/Cross-Compile）
11. [Doxygen Documention]（https://light-wizzard.github.io/QtAppVeyor）

＃ 壊れた

壊れているものは最初に取り組む必要があります、
これらは私が助けを必要としているものです。

1. Windows x86およびx64ビルドが機能していません。windeployを使用しています。すべてのdllがありますが、実行されません。
2.Qtインストーラーフレームワーク。
3. Mac、WebAssembly、iOS、およびAndroid。
4.4。 cmake、Qt6の未来。

問題：Windowsは準拠していますが、同じフォルダーにあるdllが原因で実行されません。これは、qmakeプロジェクトです。
動作するcmakeファイルを作成しましたが、プロジェクト全体でcmakeに切り替える必要があります。
それが私が現在取り組んでいることですが、Windowsスクリプト、PowerShell、またはコマンドが不足しています。
何年にもわたって書かなければならなかったので、私は言語をいくらか理解しています、
私の目標は、すべてのスクリプトを2つのファイルにまとめることです。1つはインストール用、もう1つはビルド用です。
[Qt Auto Updates]（https://github.com/Skycoder42/QtAutoUpdater）を使用してQtインストーラーフレームワークパッケージを作成したいのですが、
このGitHubプロジェクトは、Qtインストーラーフレームワークを対象としています。
そのため、Qtインストーラーパッケージで1つのzipファイルのみを作成したいと思います。

これらすべてを機能させることができれば、AppVeyorがそれをフォークするかどうかを確認したいと思います。
私たちはそこで取り組むことができます、私は彼らが他の人に与えるためにこれを書きました、
アプリケーションを簡単に公開できるように、
コンセプトはシンプルで、このアプリケーションはほとんどの人が望む機能のほとんどを使用しています。
変数を格納するQt設定、およびSQL、
したがって、QtがサポートするすべてのOSでこれを機能させることができれば、
これにより、人々はこれがどのように行われたかをコピーするのがはるかに簡単になります。
したがって、このプロジェクトを最良の実践者の例にするためには、多くの作業が必要です。
ですから、拡張しやすい最小限の機能しか追加していないことがわかります。

コンセプトについてのあなたの考えについてのフィードバックが必要です、
アプリケーションよりも、どの機能をアプリケーションに表示したいか、
そして本当に、これをすべて機能させるために実行するスクリプトを知る必要があります。
私はbashは得意ですが、PowerShellやCMDはそれほど得意ではありません。
Mac、iOSにはあまり興味がありませんが、私はAndroidを持っています。

このアプリケーションがAppVeyorの使用を推奨する標準になることを望んでいます。
そして、なぜ彼らはそれをフォークし、それを彼らのものにする必要があるのか​​、
私は彼らに引き継ぐ価値のある何かを与えようとしているだけです、
そして、なぜ私がそれをQtAppVeyorと名付け、すべての文書を簡単に掃除できるようにしようとしたのか、
Doxygenの準備ができたら、翻訳を行う必要があります。
しかし、私はいつも最後までそれを始めるのを待ちます。

＃ 状態

[！[Appveyorビルドステータス]（https://ci.appveyor.com/api/projects/status/j7htumuwfx31elf6?svg=true）]（https://ci.appveyor.com/project/Light-Wizzard/QtAppVeyor）

###：パッケージ：**ダウンロード：**

 -：penguin：[Linux zip]（https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Ubuntu-Release-x86.zip）
 -：office：[Windows zip]（https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor-Windows-Release-x86.zip）
 -：apple：現在利用できない[Apple zip]（https://github.com/Light-Wizzard/QtAppVeyor/releases/download/continuous/QtAppVeyor.zip）

現在、Windowsは機能していません。機能している場合は、次のように表示されます。

Windows（7および10でテスト済み）：zipをダウンロードして解凍し、
そして、デプロイAppDirフォルダー内のファイルQtAppVeyor.exeを実行します。

完了すると、アーティファクトは1つだけになります。これは、zipファイルにQt AutoUpdateを備えたQtインストーラーフレームワークです。

＃開発-進捗状況

詳細については、[Wiki]（https://github.com/Light-Wizzard/QtAppVeyor/wiki）を参照してください。

これは進行中の作業です。バグがあれば報告し、コメントを残してください。

＃ 取りかかっている

* qmakeの代わりにcmake
* Qtインストーラーフレームワーク
*更新可能なAppImage
*インラインではなくWindowsスクリプト
* マック
* Android
* WebAssembly
* iOS
* QtプロジェクトのMSVSビルド

＃変数

このアプリケーションを使用して.appveyor.ymlファイルを作成する場合、
これらすべての変数を知る必要があります、
あなたがあなた自身のファイルを作ったとしても、あなたはこれらを知っているでしょう、
手動で変更を維持し、
このアプリでは、変数を変更して新しいファイルを作成できます。

各変数は、デプロイメント用にアプリケーションをセットアップするためのスクリプトで使用されます。

* MY_BIN_PRO_RES_NAME：Qtプロジェクト名。 QtAppVeyor.proは、exe名が同じであることを前提としています。
* MY_OS：これはパッケージ名を作成するために使用されるため、スペースはありません
* MY_VS_VERSION：Qtバージョン
* MY_QT_IF_VERSION：Qtインストーラーフレームワーク（QIF）バージョン
* MY_QIF_PACKAGE_URI：QIFパッケージのフォルダー
* MY_PYTHON_VER：Pythonバージョン、Windows7は3.8で停止することに注意してください
* MY_PYTHON_REQUIRED：Pythonは必要ですか
* MY_UPGRADE_OS：Unixシステムのアップグレード
* MY_QT_MINGW32：MingWパス
* MY_QT_MINGW32：MingWパス
* MY_QT_TOOLS_MINGW32：MingWパス
* MY_QT_TOOLS_MINGW64：MingWパス

Unix

`` `yaml
MY_BIN_PRO_RES_NAME：QtAppVeyor＃
MY_OS：Windows＃スペースなし、これはファイル名、project-os-configuration-plateform形式を表示します
MY_QT_VERSION：5.15.2＃Qtバージョン
MY_QT_IF_VERSION： '4.1.1'＃QTインストーラーフレームワークバージョン
MY_QIF_PACKAGE_URI： 'com.appveyor.qtappveyor \ data'＃
MY_PYTHON_VER：3.8＃Windows7で実行できる最後のバージョンは3.8.xです
MY_PYTHON_REQUIRED：false＃Pythonが必要な場合
MY_UPGRADE_OS：false＃apt-get upgrade：trueまたはfalseのみ
MY_RUN_DOXYFILE：false; ＃Doxygenを実行する
`` `

ウィンドウズ

`` `yaml
MY_BIN_PRO_RES_NAME：QtAppVeyor＃
MY_OS：Windows＃スペースなし、これはファイル名、project-os-configuration-plateform形式を表示します
MY_QT_VERSION：5.15.2＃Qtバージョン
MY_VS_VERSION：2019＃対バージョン
MY_QT_MINGW32：mingw81_32＃WindowsのみのQtフォルダー変数
MY_QT_MINGW64：mingw81_64＃WindowsのみのQtフォルダー変数
MY_QT_TOOLS_MINGW32：mingw810_32＃WindowsのみのQtフォルダー変数
MY_QT_TOOLS_MINGW64：mingw810_64＃WindowsのみのQtフォルダー変数
MY_QT_IF_VERSION： '4.1.1'＃QTインストーラーフレームワークバージョン
MY_QIF_PACKAGE_URI： 'com.appveyor.qtappveyor \ data'＃
MY_PYTHON_VER：3.8＃Windows7で実行できる最後のバージョンは3.8.xです
MY_PYTHON_REQUIRED：false＃Pythonが必要な場合
MY_RUN_DOXYFILE：false; ＃Doxygenを実行する
`` `

＃データベース

`` `sql
プロジェクト：id、QtProject、Secret、IsOsUbuntu、IsOsMac、IsOsWebAssembly、IsOSiOS、IsOsWindows、IsOsAndroid、IsX64、IsX86、IsDebug、IsRelease

CREATE TABLE Projects（id integer PRIMARY KEY autoincrement、
                      QtProject varchar、
                      秘密のvarchar、
                      IsOsUbuntu varchar、
                      IsOsMac varchar、
                      IsOsWebAssembly varchar、
                      IsOSiOS varchar、
                      IsOsWindows varchar、
                      IsOsAndroid varchar、
                      IsX64 varchar、
                      IsX86 varchar、
                      IsDebug varchar、
                      IsRelease varchar

構成：id、ProjectsID、OS、QtVersion、QtIfVersion、QtIfPackageUri、PythonVersion、PythonRequired、QtMingW32、QtMingW64、QtToolsMingW32、QtToolsMingW64、VisualStudio、OsUpgrade

ProjectsIDはプロジェクトIDです

CREATE TABLE Con​​figuration（id integer PRIMARY KEY autoincrement、
                           ProjectsID varchar、
                           OS varchar、
                           QtVersion varchar、
                           QtIfVersion varchar、
                           QtIfPackageUri varchar、
                           PythonVersion varchar、
                           PythonRequired varchar、
                           QtMingW32 varchar、
                           QtMingW64 varchar、
                           QtToolsMingW32 varchar、
                           QtToolsMingW64 varchar、
                           VisualStudio varchar、
                           OsUpgrade varchar

`` `

＃ ヘルプ

このアプリケーションは、アプリ自体に[ヘルプ]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/Help-en.html）を組み込んでいます。
および[About]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-en.html）、
両方のダイアログボックスの[作成者]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/About-Author-en.html）ボタンと同様に、
2つのフォームからボタンを削除し、ファイル自体を削除するだけで簡単に削除できます。
このボタンとコンテンツは私に関するものですが、必須ではありません。
ライセンスもありません。このプロジェクトには[ライセンスなし]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/unlicense.txt）ライセンスがあります。
これは、誰でも簡単にフォークしてテンプレートとして使用できるようにするためです。
ヘルプセクションを拡張してみますが、
さらに[Wiki]（https://github.com/Light-Wizzard/QtAppVeyor/wiki）コンテンツを追加し、
それが役立つかもしれません。

＃ スクリーンショット

！[設定]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/settings.png）

！[SQL]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/sql.png）

！[Ubuntu]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/ubuntu.png）

！[Windows]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/windows.png）

！[デフォルト]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/defaults.png）

！[YML]（https://github.com/Light-Wizzard/QtAppVeyor/blob/main/help/images/yml.png）

### End-of-README.md