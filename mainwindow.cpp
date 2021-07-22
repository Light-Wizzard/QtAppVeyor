#include "mainwindow.h"
/******************************************************************************
* \class MainWindow
*******************************************************************************/
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->lineEditSettingsProjectBin->setText("QtAppVeyor");
    ui->lineEditSettingsQtVersion->setText("5.15.2");
    ui->lineEditSettingsQtInstallerVersion->setText("3.1.1");
    ui->lineEditSettingsQtInstallerPackage->setText("packages/com.lightwizzard.qtappveyor/data");
    ui->lineEditSettingsMingW32->setText("mingw81_32");
    ui->lineEditSettingsMingW64->setText("mingw81_64");
    ui->lineEditSettingsQtToolsMingW32->setText("mingw810_32");
    ui->lineEditSettingsQtToolsMingW64->setText("mingw810_64");
    ui->checkBoxSettingsUbuntu->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsUpgrade->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsConfigurationDebug->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsConfigurationRelease->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsPlatformX64->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsPlatformX86->setCheckState(Qt::CheckState::Checked);
    ui->lineEditSettingsVisualStudio->setText("Visual Studio 2019");
    ui->lineEditSettingsPythonVersion->setText("3.8");

    connect(ui->actionExit,   &QAction::triggered, this, &MainWindow::close);
    connect(ui->actionAbout,  &QAction::triggered, this, &MainWindow::onAbout);
    connect(ui->actionCreate, &QAction::triggered, this, &MainWindow::onCreate);

}
/******************************************************************************
* \fn ~MainWindow
*******************************************************************************/
MainWindow::~MainWindow()
{
    delete ui;
}
/******************************************************************************
* \fn onAbout
*******************************************************************************/
void MainWindow::onAbout()
{
    if (isDebugMessage) qDebug() << "onAbout";
    AboutDialog *myAbout = new AboutDialog();
    myAbout->show();
} // end onAbout
/******************************************************************************
* \fn onCreate
*******************************************************************************/
void MainWindow::onCreate()
{
    if (isDebugMessage) qDebug() << "onCreate";
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabYml")));
    QString thisYaml;
    thisYaml.append("version: '{branch}-{build}'\n");
    thisYaml.append("branches:\n");
    thisYaml.append("  only:\n");
    thisYaml.append("    - master\n");
    thisYaml.append("\n");
    thisYaml.append("build: off\n");
    thisYaml.append("configuration:\n");
    if (ui->checkBoxSettingsConfigurationDebug->isChecked())
    {
        thisYaml.append("  Release\n");
    }
    if (ui->checkBoxSettingsConfigurationRelease->isChecked())
    {
        thisYaml.append("  Debug\n");
    }
    thisYaml.append("platform:\n");
    if (ui->checkBoxSettingsPlatformX64->isChecked())
    {
        thisYaml.append("  - x64\n");
    }
    if (ui->checkBoxSettingsPlatformX86->isChecked())
    {
        thisYaml.append("  - x86\n");
    }
    thisYaml.append("image:\n");
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        thisYaml.append("  - Ubuntu\n");
    }
    if (ui->checkBoxSettingsMac->isChecked())
    {
        thisYaml.append("  - MacOs \n");
    }
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        thisYaml.append(QString("  - %1\n").arg(ui->lineEditSettingsVisualStudio->text()));
    }
    if (ui->checkBoxSettingsPython->isChecked())
    {
        thisYaml.append(QString("stack: %1\n").arg(ui->lineEditSettingsPythonVersion->text()));
    }
    thisYaml.append("for:\n");
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append("      - image: Ubuntu\n");
        thisYaml.append("  environment:\n");
        thisYaml.append("    MY_OS: Ubuntu\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append(QString("    QT5_VERSION: %1\n").arg(ui->lineEditSettingsQtVersion->text()));
        thisYaml.append(QString("    PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersion->text()));
        thisYaml.append(QString("    QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersion->text()));
        if (ui->checkBoxSettingsUpgrade->isChecked())
        {
            thisYaml.append("    UPGRADE_UBUNTU: true\n");
        }
        else
        {
            thisYaml.append("    UPGRADE_UBUNTU: false\n");
        }
        thisYaml.append("    PRJLIBS: VCRUNTIME140.dll MSVCP140.dll\n");
        thisYaml.append(QString("    BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackage->text()));
        thisYaml.append("  install:\n");
        thisYaml.append("    - ps: $env:REPO_NAME =  $env:APPVEYOR_REPO_NAME.Substring($env:APPVEYOR_REPO_NAME.IndexOf('/') + 1)\n");
        thisYaml.append("    - ps: $env:package_version = ('$(git describe --tags --always --long)').trim()\n");
        thisYaml.append("    - ps: Update-AppveyorBuild -Version '$env:package_version-$env:APPVEYOR_BUILD_NUMBER'\n");
        thisYaml.append("    - sh: bash -c 'scripts/install.sh'\n");
        thisYaml.append("  build_script:\n");
        thisYaml.append("    - sh: bash -c 'scripts/build_script.sh'\n");
        thisYaml.append("  artifacts:\n");
        thisYaml.append("    - path: '*.zip'\n");
        thisYaml.append("      name: 'ZipInstaller'\n");
    }
    if (ui->checkBoxSettingsMac->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append("      - image: macos\n");
        thisYaml.append("  environment:\n");
        thisYaml.append("    MY_OS: Mac\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append(QString("    QT5_VERSION: %1\n").arg(ui->lineEditSettingsQtVersion->text()));
        thisYaml.append(QString("    PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersion->text()));
        thisYaml.append(QString("    QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersion->text()));
        if (ui->checkBoxSettingsUpgrade->isChecked())
        {
            thisYaml.append("    UPGRADE_UBUNTU: true\n");
        }
        else
        {
            thisYaml.append("    UPGRADE_UBUNTU: false\n");
        }
        thisYaml.append("    PRJLIBS: VCRUNTIME140.dll MSVCP140.dll\n");
        thisYaml.append(QString("    BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackage->text()));
        thisYaml.append("  install:\n");
        thisYaml.append("    - ps: $env:REPO_NAME =  $env:APPVEYOR_REPO_NAME.Substring($env:APPVEYOR_REPO_NAME.IndexOf('/') + 1)\n");
        thisYaml.append("    - ps: $env:package_version = ('$(git describe --tags --always --long)').trim()\n");
        thisYaml.append("    - ps: Update-AppveyorBuild -Version '$env:package_version-$env:APPVEYOR_BUILD_NUMBER'\n");
        thisYaml.append("    - sh: bash -c 'scripts/install.sh'\n");
        thisYaml.append("  build_script:\n");
        thisYaml.append("    - sh: bash -c 'scripts/build_script.sh'\n");
        thisYaml.append("  artifacts:\n");
        thisYaml.append("    - path: '*.zip'\n");
        thisYaml.append("      name: 'ZipInstaller'\n");
    }
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append(QString("      - image: %1\n").arg(ui->lineEditSettingsVisualStudio->text()));
        thisYaml.append("  environment:\n");
        thisYaml.append("    MY_OS: Windows\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append(QString("    QT5_VERSION: %1\n").arg(ui->lineEditSettingsQtVersion->text()));
        thisYaml.append(QString("    QT5_MINGW32: %1\n").arg(ui->lineEditSettingsMingW32->text()));
        thisYaml.append(QString("    QT5_MINGW64: %1\n").arg(ui->lineEditSettingsMingW64->text()));
        thisYaml.append(QString("    QT5_TOOLS_MINGW32: %1\n").arg(ui->lineEditSettingsQtToolsMingW32->text()));
        thisYaml.append(QString("    QT5_TOOLS_MINGW64: %1\n").arg(ui->lineEditSettingsQtToolsMingW64->text()));
        thisYaml.append(QString("    PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersion->text()));
        thisYaml.append(QString("    QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersion->text()));
        thisYaml.append("    PRJLIBS: VCRUNTIME140.dll MSVCP140.dll\n");
        thisYaml.append(QString("    BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackage->text()));
        thisYaml.append("  install:\n");
        thisYaml.append("    - ps: $env:REPO_NAME =  $env:APPVEYOR_REPO_NAME.Substring($env:APPVEYOR_REPO_NAME.IndexOf('/') + 1)\n");
        thisYaml.append("    - ps: $env:package_version = ('$(git describe --tags --always --long)').trim()\n");
        thisYaml.append("    - ps: Update-AppveyorBuild -Version '$env:package_version-$env:APPVEYOR_BUILD_NUMBER'\n");
        thisYaml.append("    - cmd: scripts\\install.cmd\n");
        thisYaml.append("  build_script:\n");
        thisYaml.append("    - cmd: scripts\\build_script.cmd\n");
        thisYaml.append("  artifacts:\n");
        thisYaml.append("    - path: '*.zip'\n");
        thisYaml.append("      name: 'ZipInstaller'\n");
    }
    thisYaml.append("deploy:\n");
    thisYaml.append("  - provider: GitHub\n");
    thisYaml.append("    release: continuous\n");
    thisYaml.append("    artifact: 'ZipInstaller'\n");
    thisYaml.append("    draft: false\n");
    thisYaml.append("    prerelease: true\n");
    thisYaml.append("    auth_token:\n");
    thisYaml.append(QString("      secure: %1\n").arg(ui->lineEditSettingsSecret->text()));
    thisYaml.append("############################################## End of File ####################\n");
    ui->textEditYml->setText(thisYaml);
} // end onCreate
/*** ************************* End of File ***********************************/
