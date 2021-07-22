#include "mainwindow.h"
/******************************************************************************
* \class MainWindow
*******************************************************************************/
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // Ubuntu
    ui->lineEditSettingsQtVersionUbuntu->setText("5.15.2");
    ui->lineEditSettingsQtInstallerVersionUbuntu->setText("3.1.1");
    ui->lineEditSettingsQtInstallerPackageUbuntu->setText("packages/com.lightwizzard.qtappveyor/data");
    ui->checkBoxSettingsUpgradeUbuntu->setCheckState(Qt::CheckState::Checked);
    ui->lineEditSettingsPythonVersionUbuntu->setText("3.8");
    // Mac
    ui->lineEditSettingsQtVersionMac->setText("5.15.2");
    ui->lineEditSettingsQtInstallerVersionMac->setText("3.1.1");
    ui->lineEditSettingsQtInstallerPackageMac->setText("packages/com.lightwizzard.qtappveyor/data");
    ui->checkBoxSettingsUpgradeMac->setCheckState(Qt::CheckState::Checked);
    ui->lineEditSettingsPythonVersionMac->setText("3.8");
    // Windows
    ui->lineEditSettingsQtVersionWindows->setText("5.15.2");
    ui->lineEditSettingsQtInstallerVersionWindows->setText("3.1.1");
    ui->lineEditSettingsQtInstallerPackageWindows->setText("packages/com.lightwizzard.qtappveyor/data");
    ui->lineEditSettingsMingW32Windows->setText("mingw81_32");
    ui->lineEditSettingsMingW64Windows->setText("mingw81_64");
    ui->lineEditSettingsQtToolsMingW32Windows->setText("mingw810_32");
    ui->lineEditSettingsQtToolsMingW64Windows->setText("mingw810_64");
    ui->lineEditSettingsVisualStudioWindows->setText("Visual Studio 2019");
    ui->lineEditSettingsPythonVersionWindows->setText("3.8");
    // Common
    ui->lineEditSettingsProjectBin->setText("QtAppVeyor");
    ui->checkBoxSettingsUbuntu->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsConfigurationDebug->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsConfigurationRelease->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsPlatformX64->setCheckState(Qt::CheckState::Checked);
    ui->checkBoxSettingsPlatformX86->setCheckState(Qt::CheckState::Checked);
    // Triggers
    connect(ui->actionExit,   &QAction::triggered, this, &MainWindow::close);
    connect(ui->actionAbout,  &QAction::triggered, this, &MainWindow::onAbout);
    connect(ui->actionCreate, &QAction::triggered, this, &MainWindow::onCreate);
    connect(ui->actionSave,   &QAction::triggered, this, &MainWindow::onSave);

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
* \fn onSave
*******************************************************************************/
void MainWindow::onSave()
{
    if (isDebugMessage) qDebug() << "onSave";
    if (!isLoaded) { onCreate(); }
    QString qPath = QFileDialog::getSaveFileName(this, tr("Save File"), ".appveyor.yml", tr("Yaml (*.yml)"));
    QFile qFile(qPath);
    if (qFile.open(QIODevice::WriteOnly))
    {
      QTextStream out(&qFile); out << ui->textEditYml->toPlainText();
      qFile.close();
    }
} // end onSave
/******************************************************************************
* \fn onCreate
* QtAppVeyor appveyor configuration files
* https://ci.appveyor.com/tools/validate-yaml
* https://www.appveyor.com/docs/build-environment/#qt
* https://download.qt.io/snapshots/ifw/installer-framework/30/
*******************************************************************************/
void MainWindow::onCreate()
{
    if (isDebugMessage) qDebug() << "onCreate";
    isLoaded = true;
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
        thisYaml.append(QString("  - %1\n").arg(ui->lineEditSettingsVisualStudioWindows->text()));
    }
    // Python
    bool theAppendPython = false;
    if (ui->checkBoxSettingsPythonUbuntu->isChecked() || ui->checkBoxSettingsPythonMac->isChecked() || ui->checkBoxSettingsPythonWindows->isChecked())
    {
        thisYaml.append("stack: ");
    }
    // Ubuntu
    if (ui->checkBoxSettingsPythonUbuntu->isChecked())
    {
        thisYaml.append(QString("%1\n").arg(ui->lineEditSettingsPythonVersionUbuntu->text()));
        theAppendPython = true;
    }
    // Mac
    if (ui->checkBoxSettingsPythonMac->isChecked())
    {
        if (theAppendPython)
        {
            thisYaml.append(QString(", %1\n").arg(ui->lineEditSettingsPythonVersionMac->text()));
        }
        else
        {
            thisYaml.append(QString("%1\n").arg(ui->lineEditSettingsPythonVersionMac->text()));
            theAppendPython = true;
        }
    }
    // Windows
    if (ui->checkBoxSettingsPythonWindows->isChecked())
    {
        if (theAppendPython)
        {
            thisYaml.append(QString(", %1\n").arg(ui->lineEditSettingsPythonVersionMac->text()));
        }
        else
        {
            thisYaml.append(QString("%1\n").arg(ui->lineEditSettingsPythonVersionMac->text()));
        }
    }
    // Begin for Matrix
    thisYaml.append("for:\n");
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append("      - image: Ubuntu\n");
        thisYaml.append("  environment:\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: Ubuntu\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditSettingsQtVersionUbuntu->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersionUbuntu->text()));
        if (ui->checkBoxSettingsPythonUbuntu->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        // Qt Installer Framework version
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersionUbuntu->text()));
        // Update OS
        if (ui->checkBoxSettingsUpgradeUbuntu->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackageUbuntu->text()));
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
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: Mac\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditSettingsQtVersionMac->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersionMac->text()));
        if (ui->checkBoxSettingsPythonMac->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersionMac->text()));
        if (ui->checkBoxSettingsUpgradeMac->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackageMac->text()));
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
        thisYaml.append(QString("      - image: %1\n").arg(ui->lineEditSettingsVisualStudioWindows->text()));
        thisYaml.append("  environment:\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: Windows\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditSettingsQtVersionWindows->text()));
        thisYaml.append(QString("    MY_QT_MINGW32: %1\n").arg(ui->lineEditSettingsMingW32Windows->text()));
        thisYaml.append(QString("    MY_QT_MINGW64: %1\n").arg(ui->lineEditSettingsMingW64Windows->text()));
        thisYaml.append(QString("    MY_QT_TOOLS_MINGW32: %1\n").arg(ui->lineEditSettingsQtToolsMingW32Windows->text()));
        thisYaml.append(QString("    MY_QT_TOOLS_MINGW64: %1\n").arg(ui->lineEditSettingsQtToolsMingW64Windows->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditSettingsPythonVersionWindows->text()));
        if (ui->checkBoxSettingsPythonWindows->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditSettingsQtInstallerVersionWindows->text()));
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsProjectBin->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditSettingsQtInstallerPackageWindows->text()));
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
