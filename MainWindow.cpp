#include "MainWindow.h"
/******************************************************************************
* \class MainWindow
*******************************************************************************/
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    // QtAppVeyor Settings
    myOrgDomainSetting = new MyOrgSettings(this);
    // Create table model:
    myAccessSqlDbtModel = new MySqlDbtModel(this);
    // ui stuff
    ui->setupUi(this);
    // SQL Database Types
    ui->comboBoxSqlDatabaseType->addItem(":memory:");
    ui->comboBoxSqlDatabaseType->addItem("QSQLITE");
    ui->comboBoxSqlDatabaseType->addItem("QMYSQL");
    ui->comboBoxSqlDatabaseType->addItem("QPSQL");
    ui->comboBoxSqlDatabaseType->addItem("QDB2");
    ui->comboBoxSqlDatabaseType->addItem("QIBASE");
    ui->comboBoxSqlDatabaseType->addItem("QOCI");
    ui->comboBoxSqlDatabaseType->addItem("QTDS");
    // Triggers
    connect(ui->actionExit,      &QAction::triggered, this, &MainWindow::close);
    connect(ui->actionAbout,     &QAction::triggered, this, &MainWindow::onAbout);
    connect(ui->actionHelp,      &QAction::triggered, this, &MainWindow::onHelp);
    connect(ui->actionCreate,    &QAction::triggered, this, &MainWindow::onCreate);
    connect(ui->actionSave,      &QAction::triggered, this, &MainWindow::onSaveAsYmlFile);
    connect(ui->actionClipboard, &QAction::triggered, this, &MainWindow::onClipboard);
    // Set Window Title to Application Name
    setWindowTitle(QApplication::applicationName());
    // Do a one time Single Shot call to onRunOnStartup to allow the GUI to load before calling what is in that call
    QTimer::singleShot(200, this, &MainWindow::onRunOnStartup);
}
/******************************************************************************
* \fn ~MainWindow
*******************************************************************************/
MainWindow::~MainWindow()
{
    Q_CLEANUP_RESOURCE(QtAppVeyor);
    delete ui;
}
/******************************************************************************
* closeEvent
*******************************************************************************/
void MainWindow::closeEvent(QCloseEvent *event)
{
    if (isDebugMessage) qDebug() << "closeEvent";
    if (isSaveSettings) on_pushButtonSettingsSave_clicked();
    myOrgDomainSetting->setGeometry(pos(), size(), isMaximized(), isMinimized());
    writeSettings();
    QMainWindow::closeEvent(event);
    close();
} // end closeEvent
/******************************************************************************
* \fn onRunOnStartup
*******************************************************************************/
void MainWindow::onRunOnStartup()
{
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabSettings")));
    // Read Settings First
    readSettings();
    //
    if (!myAccessSqlDbtModel->checkDatabase()) close();
    setQtProjectCombo();
    // FIXME read database to ui
    isMainLoaded = true;
    // FIXME save last combobox ID
    fillForms(myAccessSqlDbtModel->getProjectID());
    //
    setSqlBrowseButton();
}
/******************************************************************************
* \fn readSettings
*******************************************************************************/
void MainWindow::readSettings()
{
    if (isDebugMessage) qDebug() << "readSettings";
    // SQL Memory option Chech
     // default set to myProjectID="-1"
    QString theProjectID = myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_PROJECT_ID, myAccessSqlDbtModel->getProjectID());
    // We cannot read from the database yet, we are only getting the last states we know of
    if (theProjectID != "-1") { myAccessSqlDbtModel->setProjectID(theProjectID); } else { myAccessSqlDbtModel->setProjectID("1"); }
    //resize(myMySettings->getGeometrySize());
    //move(myMySettings->getGeometryPos());
    //
    //if(myMySettings->getGeometryMax()) setWindowState(windowState() | Qt::WindowMaximized);
    //if(myMySettings->getGeometryMin()) setWindowState(windowState() | Qt::WindowMinimized);
    //
    //
    readSqlDatabaseStates();
    readSqlDatabaseInfo();
}
/******************************************************************************
* \fn writeSettings
*******************************************************************************/
bool MainWindow::writeSettings()
{
    writeSqlDatabaseStates();
    writeSqlDatabaseInfo();
    return true;
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
* \fn onHelp
*******************************************************************************/
void MainWindow::onHelp()
{
    if (isDebugMessage) qDebug() << "onHelp";
    HelpDialog *myHelp = new HelpDialog();
    myHelp->show();
} // end onHelp
/******************************************************************************
* \fn onClipboard
*******************************************************************************/
void MainWindow::onClipboard()
{
    if (isDebugMessage) qDebug() << "onClipboard";
    if (!isYamlLoaded) { onCreate();}
    clipboard->setText(ui->textEditYml->toPlainText());
}
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
    QList<QString> thePythonList;
    isYamlLoaded = true;
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabYml")));
    QString thisYaml;
    thisYaml.append("version: '{branch}-{build}'\n");
    thisYaml.append("branches:\n");
    thisYaml.append("  only:\n");
    thisYaml.append("    - master\n");
    thisYaml.append("\n");
    if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        thisYaml.append("build: off\n");
    if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        thisYaml.append("build: on\n");

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
    // Ubuntu
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        thisYaml.append("  - Ubuntu\n");
    }
    // Web Assembly
    if (ui->checkBoxSettingsWebAssembly->isChecked() && !ui->checkBoxSettingsUbuntu->isChecked())
    {
        thisYaml.append("  - Ubuntu \n");
    }
    // Mac
    if (ui->checkBoxSettingsMac->isChecked())
    {
        thisYaml.append("  - MacOs \n");
    }
    // iOS
    if (ui->checkBoxSettingsiOS->isChecked() && !ui->checkBoxSettingsMac->isChecked())
    {
        thisYaml.append("  - MacOs \n");
    }
    // Windows
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        thisYaml.append(QString("  - %1\n").arg(ui->lineEditVisualStudioWindows->text()));
    }
    // Python
    bool theAppendPython = false;
    if (ui->checkBoxPythonUbuntu->isChecked() || ui->checkBoxPythonAndroid->isChecked() || ui->checkBoxPythonMac->isChecked() || ui->checkBoxPythonIOS->isChecked() || ui->checkBoxPythonWebAssembly->isChecked() || ui->checkBoxPythonWindows->isChecked())
    {
        thisYaml.append("stack: ");
    }
    // Ubuntu
    if (ui->checkBoxPythonUbuntu->isChecked())
    {
        thisYaml.append(QString("%1").arg(ui->lineEditPythonVersionUbuntu->text()));
        thePythonList.append(ui->lineEditPythonVersionUbuntu->text());
        theAppendPython = true;
    }
    // Mac
    if (ui->checkBoxPythonMac->isChecked())
    {
        if (!thePythonList.contains(ui->lineEditPythonVersionMac->text()))
        {
            if (theAppendPython)
            {
                thisYaml.append(QString(", %1").arg(ui->lineEditPythonVersionMac->text()));
            }
            else
            {
                thisYaml.append(QString("%1").arg(ui->lineEditPythonVersionMac->text()));
            }
            thePythonList.append(ui->lineEditPythonVersionMac->text());
            theAppendPython = true;
        }
    }
    // WebAssembly
    if (ui->checkBoxPythonWebAssembly->isChecked())
    {
        if (!thePythonList.contains(ui->lineEditPythonVersionWebAssembly->text()))
        {
            if (theAppendPython)
            {
                thisYaml.append(QString(", %1").arg(ui->lineEditPythonVersionWebAssembly->text()));
            }
            else
            {
                thisYaml.append(QString("%1").arg(ui->lineEditPythonVersionWebAssembly->text()));
            }
            thePythonList.append(ui->lineEditPythonVersionWebAssembly->text());
            theAppendPython = true;
        }
    }
    // IOS
    if (ui->checkBoxPythonIOS->isChecked() && ! ui->checkBoxPythonMac->isChecked())
    {
        if (!thePythonList.contains(ui->checkBoxPythonIOS->text()))
        {
            if (theAppendPython)
            {
                thisYaml.append(QString(", %1").arg(ui->checkBoxPythonIOS->text()));
            }
            else
            {
                thisYaml.append(QString("%1").arg(ui->checkBoxPythonIOS->text()));
            }
            thePythonList.append(ui->checkBoxPythonIOS->text());
            theAppendPython = true;
        }
    }
    // Windows
    if (ui->checkBoxPythonWindows->isChecked())
    {
        if (!thePythonList.contains(ui->lineEditPythonVersionMac->text()))
        {
            if (theAppendPython)
            {
                thisYaml.append(QString(", %1").arg(ui->lineEditPythonVersionMac->text()));
            }
            else
            {
                thisYaml.append(QString("%1").arg(ui->lineEditPythonVersionMac->text()));
            }
            //thePythonList.append(ui->checkBoxPythonIOS->text());
            //theAppendPython = true;
        }
    }
    thisYaml.append("\n");
    // Begin for Matrix
    thisYaml.append("for:\n");
    // Ubuntu
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
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionUbuntu->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditPythonVersionUbuntu->text()));
        if (ui->checkBoxPythonUbuntu->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        // Qt Installer Framework version
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditQtIfVersionUbuntu->text()));
        // Update OS
        if (ui->checkBoxUpgradeUbuntu->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsQtProject->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditQtIfPackageUriUbuntu->text()));
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
    // Mac
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
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionMac->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditPythonVersionMac->text()));
        if (ui->checkBoxPythonMac->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditQtIfVersionMac->text()));
        if (ui->checkBoxUpgradeMac->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsQtProject->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditQtIfPackageUriMac->text()));
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
    // WebAssembly
    if (ui->checkBoxSettingsWebAssembly->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append("      - image: Ubuntu\n");
        thisYaml.append("  environment:\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: WebAssembly\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionWebAssembly->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditPythonVersionWebAssembly->text()));
        if (ui->checkBoxPythonWebAssembly->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        // Qt Installer Framework version
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditQtIfVersionWebAssembly->text()));
        // Update OS
        if (ui->checkBoxUpgradeWebAssembly->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsQtProject->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditQtIfPackageUriWebAssembly->text()));
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
    // IOS
    if (ui->checkBoxSettingsiOS->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append("      - image: macos\n");
        thisYaml.append("  environment:\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: IOS\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionIOS->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditPythonVersionIOS->text()));
        if (ui->checkBoxPythonIOS->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        // Qt Installer Framework version
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditQtIfVersionIOS->text()));
        // Update OS
        if (ui->checkBoxUpgradeIOS->isChecked())
        {
            thisYaml.append("    MY_UPGRADE_OS: true\n");
        }
        else
        {
            thisYaml.append("    MY_UPGRADE_OS: false\n");
        }
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsQtProject->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditQtIfPackageUriIOS->text()));
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
    // Windows
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        thisYaml.append("-\n");
        thisYaml.append("  matrix:\n");
        thisYaml.append("    only:\n");
        thisYaml.append(QString("      - image: %1\n").arg(ui->lineEditVisualStudioWindows->text()));
        thisYaml.append("  environment:\n");
        thisYaml.append("    RUNTIME_LINKAGE: static\n");
        thisYaml.append("    COVERITY_BUILD_CANDIDATE: True\n");
        thisYaml.append("    MY_OS: Windows\n"); // Used in Zip and Exe Name: name-os-configuration-platform
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionWindows->text()));
        thisYaml.append(QString("    MY_QT_MINGW32: %1\n").arg(ui->lineEditQtMingW32Windows->text()));
        thisYaml.append(QString("    MY_QT_MINGW64: %1\n").arg(ui->lineEditQtMingW64Windows->text()));
        thisYaml.append(QString("    MY_QT_TOOLS_MINGW32: %1\n").arg(ui->lineEditQtToolsMingW32Windows->text()));
        thisYaml.append(QString("    MY_QT_TOOLS_MINGW64: %1\n").arg(ui->lineEditQtToolsMingW64Windows->text()));
        thisYaml.append(QString("    MY_PYTHON_VER: %1\n").arg(ui->lineEditPythonVersionWindows->text()));
        if (ui->checkBoxPythonWindows->isChecked())
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: true\n");
        }
        else
        {
            thisYaml.append("    MY_PYTHON_REQUIRED: false\n");
        }
        thisYaml.append(QString("    MY_QT_IF_VERSION: %1\n").arg(ui->lineEditQtIfVersionWindows->text()));
        thisYaml.append(QString("    MY_BIN_PRO_RES_NAME: %1\n").arg(ui->lineEditSettingsQtProject->text()));
        thisYaml.append(QString("    MY_QIF_PACKAGE_URI: %1\n").arg(ui->lineEditQtIfPackageUriWindows->text()));
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
/******************************************************************************
* \fn setQtProjectCombo
*******************************************************************************/
bool MainWindow::setQtProjectCombo()
{
    QSqlQueryModel *modalQtAppVeyor = new QSqlQueryModel; //!< SQL Query Model
    //  SELECT id, QtProject FROM Projects
    const auto SELECTED_PROJECTS_SQL = QLatin1String(R"(%1)").arg(myAccessSqlDbtModel->getQtProjectSelectQuery());
    modalQtAppVeyor->setQuery(SELECTED_PROJECTS_SQL);
    if (modalQtAppVeyor->lastError().isValid())
    {
        qDebug() << modalQtAppVeyor->lastError();
    }
    modalQtAppVeyor->setHeaderData(0,Qt::Horizontal, tr("ID"));
    modalQtAppVeyor->setHeaderData(1, Qt::Horizontal, tr("Project"));
    QTableView *view = new QTableView;
    view->setSelectionBehavior(QAbstractItemView::SelectRows);
    view->setSelectionMode(QAbstractItemView::SingleSelection);
    ui->comboBoxSettingsProjects->setModel(nullptr);
    ui->comboBoxSettingsProjects->setModel(modalQtAppVeyor);
    ui->comboBoxSettingsProjects->setView(view);
    view->setColumnHidden(0, true);
    ui->comboBoxSettingsProjects->setModelColumn(1);
    ui->comboBoxSettingsProjects->setCurrentIndex(0);
    view->setColumnWidth(1, 166);
    return true;
}
/******************************************************************************
* \fn onSaveAsYmlFile File appveyor.yml
*******************************************************************************/
void MainWindow::onSaveAsYmlFile()
{
    if (isDebugMessage) qDebug() << "onSaveAsYmlFile";
    if (!isYamlLoaded) { onCreate(); }
    QString qPath = QFileDialog::getSaveFileName(this, tr("Save File As"), ".appveyor.yml", tr("Yaml (*.yml)"));
    QFile qFile(qPath);
    if (qFile.open(QIODevice::WriteOnly))
    {
        QTextStream out(&qFile); out << ui->textEditYml->toPlainText();
        qFile.close();
    }
} // end onSaveAsYmlFile
/******************************************************************************
* \fn clearTabSettings
*******************************************************************************/
void MainWindow::clearTabSettings()
{
    // Settings
    ui->labelRecordIdSettings->setText("0");
    ui->lineEditSettingsQtProject->setText("");
    ui->lineEditSettingsSecret->setText("");
    ui->checkBoxSettingsUbuntu->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsPlatformX64->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsPlatformX86->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsConfigurationDebug->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxSettingsConfigurationRelease->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabUbuntu
*******************************************************************************/
void MainWindow::clearTabUbuntu()
{
    // Ubuntu
    ui->labelRecordIdUbuntu->setText("0");
    ui->lineEditQtVersionUbuntu->setText("");
    ui->lineEditQtIfVersionUbuntu->setText("");
    ui->lineEditQtIfPackageUriUbuntu->setText("");
    ui->lineEditPythonVersionUbuntu->setText("");
    ui->checkBoxPythonUbuntu->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeUbuntu->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabMac
*******************************************************************************/
void MainWindow::clearTabMac()
{
    // Mac
    ui->labelRecordIdMac->setText("0");
    ui->lineEditQtVersionMac->setText("");
    ui->lineEditQtIfVersionMac->setText("");
    ui->lineEditQtIfPackageUriMac->setText("");
    ui->lineEditPythonVersionMac->setText("");
    ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeMac->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabAndroid
*******************************************************************************/
void MainWindow::clearTabAndroid()
{
    // Android
    ui->labelRecordIdAndroid->setText("0");
    ui->lineEditQtVersionAndroid->setText("");
    ui->lineEditQtIfVersionAndroid->setText("");
    ui->lineEditQtIfPackageUriAndroid->setText("");
    ui->lineEditPythonVersionAndroid->setText("");
    ui->checkBoxPythonAndroid->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeAndroid->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabWebAssembly
*******************************************************************************/
void MainWindow::clearTabWebAssembly()
{
    // WebAssembly
    ui->labelRecordIdWebAssembly->setText("0");
    ui->lineEditQtVersionWebAssembly->setText("");
    ui->lineEditQtIfVersionWebAssembly->setText("");
    ui->lineEditQtIfPackageUriWebAssembly->setText("");
    ui->lineEditPythonVersionWebAssembly->setText("");
    ui->checkBoxPythonWebAssembly->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeWebAssembly->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabIOS
*******************************************************************************/
void MainWindow::clearTabIOS()
{
    // IOS
    ui->labelRecordIdIOS->setText("0");
    ui->lineEditQtVersionIOS->setText("");
    ui->lineEditQtIfVersionIOS->setText("");
    ui->lineEditQtIfPackageUriIOS->setText("");
    ui->lineEditPythonVersionIOS->setText("");
    ui->checkBoxPythonIOS->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeIOS->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabWindows
*******************************************************************************/
void MainWindow::clearTabWindows()
{
    // Windows
    ui->labelRecordIdWindows->setText("0");
    ui->lineEditQtVersionWindows->setText("");
    ui->lineEditQtIfVersionWindows->setText("");
    ui->lineEditQtIfPackageUriWindows->setText("");
    ui->lineEditPythonVersionWindows->setText("");
    ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxPythonWindows->setCheckState(Qt::CheckState::Unchecked);
    ui->lineEditQtMingW32Windows->setText("");
    ui->lineEditQtMingW64Windows->setText("");
    ui->lineEditQtToolsMingW32Windows->setText("");
    ui->lineEditQtToolsMingW64Windows->setText("");
    ui->lineEditVisualStudioWindows->setText("");
}
/******************************************************************************
* \fn clearTabDefaults
*******************************************************************************/
void MainWindow::clearTabDefaults()
{
    // Defaults
    ui->labelRecordIdDefaults->setText("0");
    ui->lineEditQtVersionDefaults->setText("");
    ui->lineEditQtIfVersionDefaults->setText("");
    ui->lineEditQtIfPackageUriDefaults->setText("");
    ui->lineEditPythonVersionDefaults->setText("");
    ui->lineEditQtMingW32Defaults->setText("");
    ui->lineEditQtMingW64Windows->setText("");
    ui->lineEditQtToolsMingW32Defaults->setText("");
    ui->lineEditQtToolsMingW64Defaults->setText("");
    ui->lineEditVisualStudioDefaults->setText("");
    ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Unchecked);
}
/******************************************************************************
* \fn clearTabYaml
*******************************************************************************/
void MainWindow::clearTabYaml()
{
    ui->textEditYml->setText("");
}
/******************************************************************************
* \fn clearForms
*******************************************************************************/
void MainWindow::clearForms(int tabNumber)
{

    switch (tabNumber)
    {
        case TabSettings:    clearTabSettings();    break; // 0
        case TabUbuntu:      clearTabUbuntu();      break; // 1
        case TabMac:         clearTabMac();         break; // 2
        case TabAndroid:     clearTabAndroid();     break; // 3
        case TabWebAssembly: clearTabWebAssembly(); break; // 4
        case TabIOS:         clearTabIOS();         break; // 5
        case TabWindows:     clearTabWindows();     break; // 6
        case TabDefaults:    clearTabDefaults();    break; // 7
        case TabYaml:        clearTabYaml();        break; // 8
        case TabAll:                                       // 9
            ui->labelRecordIdSettings->setText("");
            clearTabSettings();    // 0
            clearTabUbuntu();      // 1
            clearTabMac();         // 2
            clearTabAndroid();     // 3
            clearTabWebAssembly(); // 4
            clearTabIOS();         // 5
            clearTabWindows();     // 6
            clearTabDefaults();    // 7
            clearTabYaml();        // 8
            break;
    }
}
/******************************************************************************
* \fn on_comboBoxSettingsProjects_currentIndexChanged
*******************************************************************************/
void MainWindow::on_comboBoxSettingsProjects_currentIndexChanged(int index)
{
    Q_UNUSED(index)
    if (isDebugMessage) qDebug() << "on_comboBoxSettingsProjects_currentIndexChanged";
    if (!isMainLoaded) { return; }
    QString thisIndex = ui->comboBoxSettingsProjects->model()->data(ui->comboBoxSettingsProjects->model()->index(ui->comboBoxSettingsProjects->currentIndex(), 0)).toString();
    fillForms(thisIndex);
}
/******************************************************************************
* \fn on_actionPrint_triggered
*******************************************************************************/
void MainWindow::on_actionPrint_triggered()
{
    QPrinter printer(QPrinter::HighResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("appveyor.pdf");

    QPrintDialog dialog(&printer, this);
    if(dialog.exec() == QDialog::Rejected) return;

    ui->textEditYml->print(&printer);
}
/******************************************************************************
* \fn settingsButtons
*******************************************************************************/
void MainWindow::settingsButtons(bool thisEnabled)
{
    if (isDebugMessage) qDebug() << "settingsButtons";
    ui->pushButtonSettingsAdd->setEnabled(thisEnabled);
    ui->pushButtonSettingsSave->setEnabled(thisEnabled);
    ui->pushButtonSettingsDelete->setEnabled(thisEnabled);
}
/******************************************************************************
* \fn setSqlBrowseButton
*******************************************************************************/
void MainWindow::setSqlBrowseButton()
{
    if (isDebugMessage) qDebug() << "settingsButtons";
    ui->pushButtonSqlFileBrowswer->setEnabled(ui->comboBoxSqlDatabaseType->currentText() == myOrgDomainSetting->myConstants->MY_SQL_DEFAULT || ui->comboBoxSqlDatabaseType->currentText() == ":memory:");
}
/******************************************************************************
* \fn on_comboBoxSqlDatabaseType_currentIndexChanged
*******************************************************************************/
void MainWindow::on_comboBoxSqlDatabaseType_currentIndexChanged(const QString &arg1)
{
    if (isDebugMessage) qDebug() << "on_comboBoxSqlDatabaseType_currentIndexChanged=" << arg1;
    if (isMainLoaded)
    {
        myAccessSqlDbtModel->setSqlDriver(arg1);
        writeSqlDatabaseStates();
        setSqlBrowseButton();
    }
}
/******************************************************************************
* \fn fillForms
*******************************************************************************/
void MainWindow::fillForms(const QString &thisProjectID)
{
    if (isDebugMessage) qDebug() << "fillForms=" << thisProjectID;
    clearForms(TabAll);
    ui->labelRecordIdSettings->setText(thisProjectID); // Project id and Configuration ProjectID
    // Declare all variable in function scope
    QSqlQuery query; //!< SQL Query
    bool theIsOsUbuntu, theIsOsMac, theIsOsWindows, theIsOsAndroid, theIsOsWebAssembly, theIsOSiOS;
    theIsOsUbuntu = theIsOsMac = theIsOsWindows = theIsOsAndroid = theIsOsWebAssembly = theIsOSiOS = false;
    QString myConfigurationSelectQuery = myAccessSqlDbtModel->getProjectsFullSelectQueryID(thisProjectID);
    if (isDebugMessage) qDebug() << " myConfigurationSelectQuery=|" << myConfigurationSelectQuery << "|";
    /*
    Projects
    id
    QtProject
    Secret
    IsOsUbuntu
    IsOsMac
    IsOsWindows
    IsOsAndroid
    IsX64
    IsX86
    IsDebug
    IsRelease

 SELECT Projects, id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease FROM Projects WHERE id =


    Configuration
    id
    ProjectsID
    OS
    QtVersion
    QtIfVersion
    QtIfPackageUri
    PythonVersion
    PythonRequired
    QtMingW32
    QtMingW64
    QtToolsMingW32
    QtToolsMingW64
    VisualStudio
    OsUpgrade
SELECT id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired,
QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade FROM Configuration WHERE ProjectsID = 1
    */
    if (query.exec(myConfigurationSelectQuery))
    {
        if (query.first())
        {
            if (isDebugMessage) qDebug() << " QtProject=|" << query.value("QtProject").toString() << "|" << " IsOsUbuntu=|" << query.value("IsOsUbuntu").toString() << "|" << " IsOsMac=|" << query.value("IsOsMac").toString() << "|" << " IsOsWindows=|" << query.value("IsOsWindows").toString() << "|" << " IsX64=|" << query.value("IsX64").toString() << "|";
            // Set Record ID
            ui->labelRecordIdSettings->setText(query.value("id").toString());

            ui->lineEditSettingsQtProject->setText(query.value("QtProject").toString());
            ui->lineEditSettingsSecret->setText(query.value("Secret").toString());
            // Environment Qt
            if (query.value("Environment").toString() == "Qt")
            {
                ui->radioButtonSettingsEnvironmentQt->setChecked(true);
            }
            else
            {
                ui->radioButtonSettingsEnvironmentQt->setChecked(false);
            }
            // Environment VS
            if (query.value("Environment").toString() == "MSVS")
            {
                ui->radioButtonSettingsEnvironmentVs->setChecked(true);
            }
            else
            {
                ui->radioButtonSettingsEnvironmentVs->setChecked(false);
            }
            //
            theIsOsUbuntu = query.value("IsOsUbuntu").toBool();
            theIsOsMac = query.value("IsOsMac").toBool();
            theIsOsWindows = query.value("IsOsWindows").toBool();
            theIsOsAndroid = query.value("IsOsAndroid").toBool();
            theIsOsWebAssembly = query.value("IsOsWebAssembly").toBool();
            theIsOSiOS = query.value("IsOSiOS").toBool();
            // Ubunt
            if (theIsOsUbuntu)
            { ui->checkBoxSettingsUbuntu->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsUbuntu->setCheckState(Qt::CheckState::Unchecked); }
            // Mac
            if (theIsOsMac)
            { ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Unchecked); }
            // Windows
            if (theIsOsWindows)
            { ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsWindows->setCheckState(Qt::CheckState::Unchecked); }
            // Android
            if (theIsOsAndroid)
            { ui->checkBoxSettingsAndroid->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsAndroid->setCheckState(Qt::CheckState::Unchecked); }
            // WebAssembly
            if (theIsOsWebAssembly)
            { ui->checkBoxSettingsWebAssembly->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsWebAssembly->setCheckState(Qt::CheckState::Unchecked); }
            // iOS
            if (theIsOSiOS)
            { ui->checkBoxSettingsiOS->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsiOS->setCheckState(Qt::CheckState::Unchecked); }
            // x64
            if (query.value("IsX64").toString() == "true" || query.value("IsX64").toString() == "Checked")
            { ui->checkBoxSettingsPlatformX64->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsPlatformX64->setCheckState(Qt::CheckState::Unchecked); }
            // x86
            if (query.value("IsX86").toString() == "true" || query.value("IsX86").toString() == "Checked")
            { ui->checkBoxSettingsPlatformX86->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsPlatformX86->setCheckState(Qt::CheckState::Unchecked); }
            // Debug
            if (query.value("IsDebug").toString() == "true" || query.value("IsDebug").toString() == "Checked")
            { ui->checkBoxSettingsConfigurationDebug->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsConfigurationDebug->setCheckState(Qt::CheckState::Unchecked); }
            // Release
            if (query.value("IsRelease").toString() == "true" || query.value("IsRelease").toString() == "Checked")
            { ui->checkBoxSettingsConfigurationRelease->setCheckState(Qt::CheckState::Checked); }
            else
            { ui->checkBoxSettingsConfigurationRelease->setCheckState(Qt::CheckState::Unchecked); }
        }
        else
        {
            QMessageBox::critical(nullptr, QObject::tr("Could not read from the Database"), QObject::tr("Unable to find record in database.\nClick Cancel to exit."), QMessageBox::Cancel);
        }
    }
    else
    {
        QMessageBox::critical(nullptr, QObject::tr("Could not read from the Database"), QObject::tr("Unable to find record in database.\nClick Cancel to exit."), QMessageBox::Cancel);
        return;
    }
    // Ubuntu
    if (theIsOsUbuntu)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_UBUNTU);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdUbuntu->setText(query.value("id").toString());
                ui->lineEditQtVersionUbuntu->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionUbuntu->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriUbuntu->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionUbuntu->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonUbuntu->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonUbuntu->setCheckState(Qt::CheckState::Checked); }
                //
                if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeUbuntu->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxUpgradeUbuntu->setCheckState(Qt::CheckState::Checked); }
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_UBUNTU), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // Mac
    if (theIsOsMac)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_MAC);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdMac->setText(query.value("id").toString());
                ui->lineEditQtVersionMac->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionMac->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriMac->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionMac->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonMac->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonMac->setCheckState(Qt::CheckState::Checked); }
                //
                if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeMac->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxUpgradeMac->setCheckState(Qt::CheckState::Checked); }
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_MAC), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // Android
    if (theIsOsAndroid)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_ANDROID);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdAndroid->setText(query.value("id").toString());
                ui->lineEditQtVersionAndroid->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionAndroid->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriAndroid->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionAndroid->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonAndroid->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonAndroid->setCheckState(Qt::CheckState::Checked); }
                //
                if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeAndroid->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxUpgradeAndroid->setCheckState(Qt::CheckState::Checked); }
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_ANDROID), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // WebAssembly
    if (theIsOsWebAssembly)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_WEBASSEMBLY);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdWebAssembly->setText(query.value("id").toString());
                ui->lineEditQtVersionWebAssembly->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionWebAssembly->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriWebAssembly->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionWebAssembly->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonWebAssembly->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonWebAssembly->setCheckState(Qt::CheckState::Checked); }
                //
                if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeWebAssembly->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxUpgradeWebAssembly->setCheckState(Qt::CheckState::Checked); }
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_WEBASSEMBLY), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // iOS
    if (theIsOSiOS)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_IOS);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdIOS->setText(query.value("id").toString());
                ui->lineEditQtVersionIOS->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionIOS->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriIOS->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionIOS->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonIOS->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonIOS->setCheckState(Qt::CheckState::Checked); }
                //
                if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeIOS->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxUpgradeIOS->setCheckState(Qt::CheckState::Checked); }
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_IOS), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // Windows
    if (theIsOsWindows)
    {
        myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_WINDOWS);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdWindows->setText(query.value("id").toString());
                ui->lineEditQtVersionWindows->setText(query.value("QtVersion").toString());
                ui->lineEditQtIfVersionWindows->setText(query.value("QtIfVersion").toString());
                ui->lineEditQtIfPackageUriWindows->setText(query.value("QtIfPackageUri").toString());
                ui->lineEditPythonVersionWindows->setText(query.value("PythonVersion").toString());
                if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonWindows->setCheckState(Qt::CheckState::Checked); }
                else { ui->checkBoxPythonWindows->setCheckState(Qt::CheckState::Checked); }
                ui->lineEditQtMingW32Windows->setText(query.value("QtMingW32").toString());
                ui->lineEditQtMingW64Windows->setText(query.value("QtMingW64").toString());
                ui->lineEditQtToolsMingW32Windows->setText(query.value("QtToolsMingW32").toString());
                ui->lineEditQtToolsMingW64Windows->setText(query.value("QtToolsMingW64").toString());
                ui->lineEditVisualStudioWindows->setText(query.value("VisualStudio").toString());
            }
            else
            {
                QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_WINDOWS), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // Defaults
    myConfigurationSelectQuery = myAccessSqlDbtModel->getConfigurationProjectIdOsSelectQuery(thisProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_DEFAULTS);
    if (query.exec(myConfigurationSelectQuery))
    {
        if (query.first())
        {
            // Set Record ID
            ui->labelRecordIdDefaults->setText(query.value("id").toString());
            ui->lineEditQtVersionDefaults->setText(query.value("QtVersion").toString());
            ui->lineEditQtIfVersionDefaults->setText(query.value("QtIfVersion").toString());
            ui->lineEditQtIfPackageUriDefaults->setText(query.value("QtIfPackageUri").toString());
            ui->lineEditPythonVersionDefaults->setText(query.value("PythonVersion").toString());
            if (query.value("PythonRequired").toString() == "true" || query.value("PythonRequired").toString() == "Checked") { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked); }
            else { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked); }
            //
            if (query.value("OsUpgrade").toString() == "true" || query.value("OsUpgrade").toString() == "Checked") { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked); }
            else { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked); }
            ui->lineEditQtMingW32Defaults->setText(query.value("QtMingW32").toString());
            ui->lineEditQtMingW64Defaults->setText(query.value("QtMingW64").toString());
            ui->lineEditQtToolsMingW32Defaults->setText(query.value("QtToolsMingW32").toString());
            ui->lineEditQtToolsMingW64Defaults->setText(query.value("QtToolsMingW64").toString());
            ui->lineEditVisualStudioDefaults->setText(query.value("VisualStudio").toString());
        }
        else
        {
            QMessageBox::critical(nullptr, QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(myOrgDomainSetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(myOrgDomainSetting->myConstants->MY_OS_NAME_DEFAULTS), QMessageBox::Cancel);
        }
    }
    else
    {
        qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
    isSaveSettings = false;
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsUbuntu_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsUbuntu_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionUbuntu->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfVersionUbuntu->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriUbuntu->setText(ui->lineEditQtIfPackageUriDefaults->text());
    ui->lineEditPythonVersionUbuntu->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonUbuntu->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeDefaults->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsMac_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsMac_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionMac->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfVersionMac->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriMac->setText(ui->lineEditQtIfPackageUriDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditPythonVersionMac->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonMac->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeDefaults->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsAndroid_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsAndroid_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionAndroid->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfVersionAndroid->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriAndroid->setText(ui->lineEditQtIfPackageUriDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditPythonVersionAndroid->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonAndroid->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeAndroid->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsWebAssembly_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsWebAssembly_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionWebAssembly->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfVersionWebAssembly->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriWebAssembly->setText(ui->lineEditQtIfPackageUriDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditPythonVersionWebAssembly->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonWebAssembly->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeWebAssembly->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsIOS_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsIOS_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionIOS->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfVersionIOS->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriIOS->setText(ui->lineEditQtIfPackageUriDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditPythonVersionIOS->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonIOS->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeIOS->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaultsWindows_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaultsWindows_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        ui->lineEditQtVersionWindows->setText(ui->lineEditQtVersionDefaults->text());
    if (!ui->lineEditQtIfVersionDefaults->text().isEmpty())
        ui->lineEditQtIfVersionWindows->setText(ui->lineEditQtIfVersionDefaults->text());
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        ui->lineEditQtIfPackageUriWindows->setText(ui->lineEditQtIfPackageUriDefaults->text());
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        ui->lineEditPythonVersionWindows->setText(ui->lineEditPythonVersionDefaults->text());
    if (!ui->lineEditQtMingW32Defaults->text().isEmpty())
        ui->lineEditQtMingW32Windows->setText(ui->lineEditQtMingW32Defaults->text());
    if (!ui->lineEditQtMingW64Defaults->text().isEmpty())
        ui->lineEditQtMingW64Windows->setText(ui->lineEditQtMingW64Defaults->text());
    if (!ui->lineEditQtToolsMingW32Defaults->text().isEmpty())
        ui->lineEditQtToolsMingW32Windows->setText(ui->lineEditQtToolsMingW32Defaults->text());
    if (!ui->lineEditQtToolsMingW64Defaults->text().isEmpty())
        ui->lineEditQtToolsMingW64Windows->setText(ui->lineEditQtToolsMingW64Defaults->text());
    if (!ui->lineEditVisualStudioDefaults->text().isEmpty())
        ui->lineEditVisualStudioWindows->setText(ui->lineEditVisualStudioDefaults->text());
    if (!ui->checkBoxPythonDefaults->text().isEmpty())
        ui->checkBoxPythonWindows->setCheckState(ui->checkBoxPythonDefaults->checkState());
}
/******************************************************************************
* \fn on_pushButtonResetDefaults_clicked
*******************************************************************************/
void MainWindow::on_pushButtonResetDefaults_clicked()
{
    if (myOrgDomainSetting->isSetting(ui->lineEditQtVersionDefaults->objectName()))
    {
        ui->lineEditQtVersionDefaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtVersionDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_QT_VERSION));
        ui->lineEditQtIfVersionDefaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtIfVersionDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_QTIF_VERSION));
        ui->lineEditQtIfPackageUriDefaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtIfPackageUriDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER));
        ui->lineEditPythonVersionDefaults->setText(myOrgDomainSetting->readSettings(ui->lineEditPythonVersionDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_VERSION));
        ui->lineEditQtMingW32Defaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtMingW32Defaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32));
        ui->lineEditQtMingW64Defaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtMingW64Defaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64));
        ui->lineEditQtToolsMingW32Defaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtToolsMingW32Defaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS));
        ui->lineEditQtToolsMingW64Defaults->setText(myOrgDomainSetting->readSettings(ui->lineEditQtToolsMingW64Defaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS));
        ui->lineEditVisualStudioDefaults->setText(myOrgDomainSetting->readSettings(ui->lineEditVisualStudioDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO));
        if (myOrgDomainSetting->readSettings(ui->checkBoxPythonDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED) == "true")
        { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Unchecked); }
        if (myOrgDomainSetting->readSettings(ui->checkBoxUpgradeDefaults->objectName(), myOrgDomainSetting->myConstants->MY_DEFAULTS_UPGRADE_OS) == "true")
        { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Unchecked); }
    }
    else
    {
        ui->lineEditQtVersionDefaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_QT_VERSION);
        ui->lineEditQtIfVersionDefaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_QTIF_VERSION);
        ui->lineEditQtIfPackageUriDefaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER);
        ui->lineEditPythonVersionDefaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_VERSION);
        ui->lineEditQtMingW32Defaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32);
        ui->lineEditQtMingW64Defaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64);
        ui->lineEditQtToolsMingW32Defaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS);
        ui->lineEditQtToolsMingW64Defaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS);
        ui->lineEditVisualStudioDefaults->setText(myOrgDomainSetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO);
        if (myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED == "true")
        { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Unchecked); }
        if (myOrgDomainSetting->myConstants->MY_DEFAULTS_UPGRADE_OS == "true")
        { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Unchecked); }
    }
}
/******************************************************************************
* \fn on_pushButtonSqlPasswordShowHide_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSqlPasswordShowHide_clicked()
{
    QMessageBox::critical(nullptr, QObject::tr("Password Revieled"), QObject::tr("%1").arg(ui->lineEditSqlPassword->text()), QMessageBox::Ok);
}
/******************************************************************************
* \fn writeSqlDatabaseStates
*******************************************************************************/
void MainWindow::writeSqlDatabaseStates()
{
    if (isDebugMessage) qDebug() << "writeSqlDatabaseStates";
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_COMBO_STATE, QString::number(ui->comboBoxSqlDatabaseType->currentIndex()));
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_COMBO_VALUE, ui->comboBoxSqlDatabaseType->currentText());
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_PROJECT_ID, myAccessSqlDbtModel->getProjectID());
}
/******************************************************************************
* \fn readSqlDatabaseStates
*******************************************************************************/
void MainWindow::readSqlDatabaseStates()
{
    ui->comboBoxSqlDatabaseType->setCurrentIndex(myOrgDomainSetting->readSettingsInt(myOrgDomainSetting->myConstants->MY_SQL_COMBO_STATE, 1));
    // Set ComboBox for SQL
    ui->comboBoxSqlDatabaseType->setCurrentIndex(myOrgDomainSetting->readSettingsInt(myOrgDomainSetting->myConstants->MY_SQL_COMBO_STATE, 1));
    myAccessSqlDbtModel->setComboBoxSqlValue(myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_COMBO_VALUE, myOrgDomainSetting->myConstants->MY_SQL_DEFAULT));
}
/******************************************************************************
* \fn writeSqlDatabaseInfo
* Uses SimpleCrypt to encrypt and decrypt Password
*******************************************************************************/
void MainWindow::writeSqlDatabaseInfo()
{
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_NAME,  ui->lineEditSqlDatabaseName->text());
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_TYPE,  ui->comboBoxSqlDatabaseType->currentText());
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_HOST,  ui->lineEditSqlHostName->text());
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_USER,  ui->lineEditSqlUserName->text());
    // Encrypt Password, it is saved in Ini file
    if (!ui->lineEditSqlPassword->text().isEmpty())
        myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_PASS, myOrgDomainSetting->encryptThis(ui->lineEditSqlPassword->text()));
}
/******************************************************************************
* \fn readSqlDatabaseInfo
* Uses SimpleCrypt to encrypt and decrypt Password
*******************************************************************************/
void MainWindow::readSqlDatabaseInfo()
{
    QString theDb = QString("%1%2%3.db").arg(myOrgDomainSetting->getAppDataLocation(), QDir::separator(), myAccessSqlDbtModel->getSqlDatabaseName());
    ui->lineEditSqlDatabaseName->setText(myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_NAME, theDb));
    //myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_TYPE, ""); // No Default
    ui->lineEditSqlHostName->setText(myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_HOST, "")); // No Default
    ui->lineEditSqlUserName->setText(myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_USER, "")); // No Default
    // Decrypt Password, it is saved in Ini file
    QString thePassword = myOrgDomainSetting->decryptThis(myOrgDomainSetting->readSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_PASS, ""));
    if (!thePassword.isEmpty())
        ui->lineEditSqlPassword->setText(thePassword);
    else
        ui->lineEditSqlPassword->setText("");
}
/******************************************************************************
* \fn on_lineEditSqlDatabaseName_textChanged
*******************************************************************************/
void MainWindow::on_lineEditSqlDatabaseName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeSqlDatabaseStates();
}
/******************************************************************************
* \fn on_lineEditSqlHostName_selectionChanged
*******************************************************************************/
void MainWindow::on_lineEditSqlHostName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeSqlDatabaseStates();
}
/******************************************************************************
* \fn on_lineEditSqlUserName_textChanged
*******************************************************************************/
void MainWindow::on_lineEditSqlUserName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeSqlDatabaseStates();
}
/******************************************************************************
* \fn on_lineEditSqlPassword_textChanged
*******************************************************************************/
void MainWindow::on_lineEditSqlPassword_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeSqlDatabaseStates();
}
/******************************************************************************
* \fn on_pushButtonSqlFileBrowswer_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSqlFileBrowswer_clicked()
{
    QFileDialog dialogSqlDbFolder;
    dialogSqlDbFolder.setFileMode(QFileDialog::Directory);
    dialogSqlDbFolder.setOption(QFileDialog::ShowDirsOnly);
    dialogSqlDbFolder.setOption(QFileDialog::DontResolveSymlinks);
    //
    QString theSqlFolder = dialogSqlDbFolder.getExistingDirectory(this, tr("Sqlite Folder Location"), "/");
    if (!theSqlFolder.isEmpty())
    {
        QString theDbLocation = ui->lineEditSqlDatabaseName->text();
        QString theDbNewLocation = QString("%1/%2.db").arg(theSqlFolder, myAccessSqlDbtModel->getSqlDatabaseName());
        if (theDbLocation != theDbNewLocation)
        {
            //
            if (myOrgDomainSetting->getFileInfo(MyOrgSettings::IsFile, ui->lineEditSqlDatabaseName->text()) == "true")
            {
                QString thePath = myOrgDomainSetting->getFileInfo(MyOrgSettings::CanonicalFilePath, ui->lineEditSqlDatabaseName->text());
                // moveDb
                if (myAccessSqlDbtModel->moveDb(theDbNewLocation, thePath, theDbNewLocation))
                    ui->lineEditSqlDatabaseName->setText(theDbNewLocation);
                else
                    QMessageBox::critical(nullptr, QObject::tr("Database Move Failed"), QObject::tr("Failed to move Database"), QMessageBox::Ok);
            }
        }
    }
}
/******************************************************************************
* \fn setMyProjectConfigurationClass
*******************************************************************************/
void MainWindow::setMyProjectConfigurationClass(int tabNumber)
{
    //                  Configuration: id, ProjectsID,    OS,    QtVersion,      QtIfVersion,     QtIfPackageUri,     PythonVersion,     PythonRequired,     QtMingW32,     QtMingW64,     QtToolsMingW32,     QtToolsMingW64,     VisualStudio,     OsUpgrade
    //MyConfigurationClass theConfiguration( thisProjectsID, thisOS, thisQtVersion, thisQtIfVersion, thisQtIfPackageUri, thisPythonVersion, thisPythonRequired, thisQtMingW32, thisQtMingW64, thisQtToolsMingW32, thisQtToolsMingW64, thisVisualStudio, thisOsUpgrade);
    //MyProjectClass theProject();
    // Common to all records
    myAccessSqlDbtModel->myConfigurationVariables->setProjectsID(ui->labelRecordIdSettings->text());
    //
    switch (tabNumber)
    {
        case TabSettings: // 0
            // IsOsUbuntu
            if (ui->checkBoxSettingsUbuntu->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsUbuntu("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsUbuntu("false");
            //IsOsMac
            if (ui->checkBoxSettingsMac->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsMac("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsMac("false");
            // IsOSiOS
            if (ui->checkBoxSettingsiOS->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOSiOS("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOSiOS("false");
            // IsOsAndroid
            if (ui->checkBoxSettingsAndroid->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsAndroid("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsAndroid("false");
            // IsOsWebAssembly
            if (ui->checkBoxSettingsWebAssembly->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsWebAssembly("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsWebAssembly("false");
            // IsOsAndroid
            if (ui->checkBoxSettingsAndroid->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsAndroid("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsAndroid("false");
            // IsOsWindows
            if (ui->checkBoxSettingsWindows->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsOsWindows("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsOsWindows("false");
            // IsDebug
            if (ui->checkBoxSettingsConfigurationDebug->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsDebug("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsDebug("false");
            // IsRelease
            if (ui->checkBoxSettingsConfigurationRelease->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsRelease("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsRelease("false");
            // IsX64
            if (ui->checkBoxSettingsPlatformX64->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsX64("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsX64("false");
            // IsX86
            if (ui->checkBoxSettingsPlatformX86->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setIsX86("true");
            else
                myAccessSqlDbtModel->myProjectVariables->setIsX86("false");
            // Environment Qt
            if (ui->radioButtonSettingsEnvironmentQt->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setEnvironment("Qt");
            // Environment MSVS
            if (ui->radioButtonSettingsEnvironmentVs->isChecked())
                myAccessSqlDbtModel->myProjectVariables->setEnvironment("MSVS");
            //
            myAccessSqlDbtModel->myProjectVariables->setID(ui->labelRecordIdSettings->text());
            myAccessSqlDbtModel->myProjectVariables->setQtProject(ui->lineEditSettingsQtProject->text());
            myAccessSqlDbtModel->myProjectVariables->setSecret(ui->lineEditSettingsSecret->text());
            break;
        case TabSql:      // 1
            //
            break;
        case TabUbuntu:   // 2
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdUbuntu->text());
            // Clear Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio("");
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_UBUNTU);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionUbuntu->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionUbuntu->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriUbuntu->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionUbuntu->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeUbuntu->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonUbuntu->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");

            break;
        case TabMac: // 3
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdMac->text());
            // Clear Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio("");
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_MAC);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionMac->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionMac->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriMac->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionMac->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeMac->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonMac->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
        case TabAndroid: // 4
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdAndroid->text());
            // Clear Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio("");
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_ANDROID);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionAndroid->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionAndroid->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriAndroid->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionAndroid->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeAndroid->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonAndroid->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
        case TabWebAssembly: // 5
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdWebAssembly->text());
            // Clear Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio("");
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_WEBASSEMBLY);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionWebAssembly->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionWebAssembly->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriWebAssembly->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionWebAssembly->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeWebAssembly->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonWebAssembly->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
        case TabIOS: // 6
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdIOS->text());
            // Clear Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32("");
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64("");
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio("");
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_IOS);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionIOS->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionIOS->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriIOS->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionIOS->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeIOS->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonIOS->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
        case TabWindows: // 7
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdWindows->text());
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_WINDOWS);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionWindows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionWindows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriWindows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionWindows->text());
            // Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32(ui->lineEditQtMingW32Windows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64(ui->lineEditQtMingW64Windows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32(ui->lineEditQtToolsMingW32Windows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64(ui->lineEditQtToolsMingW64Windows->text());
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio(ui->lineEditVisualStudioWindows->text());
            // Python Required
            if (ui->checkBoxPythonWindows->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
        case TabDefaults: // 8
            // Set Record ID
            myAccessSqlDbtModel->myConfigurationVariables->setID(ui->labelRecordIdDefaults->text());
            // Common
            myAccessSqlDbtModel->myConfigurationVariables->setOS(myOrgDomainSetting->myConstants->MY_OS_NAME_DEFAULTS);
            myAccessSqlDbtModel->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionDefaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionDefaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriDefaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionDefaults->text());
            // Windows
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW32(ui->lineEditQtMingW32Defaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtMingW64(ui->lineEditQtMingW64Defaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW32(ui->lineEditQtToolsMingW32Defaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setQtToolsMingW64(ui->lineEditQtToolsMingW64Defaults->text());
            myAccessSqlDbtModel->myConfigurationVariables->setVisualStudio(ui->lineEditVisualStudioDefaults->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeDefaults->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setOsUpgrade("false");
            // Python Required
            if (ui->checkBoxPythonDefaults->isChecked())
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("true");
            else
                myAccessSqlDbtModel->myConfigurationVariables->setPythonRequired("false");
            break;
    }

} // end setMyConfigurationClass
/******************************************************************************
* \fn on_pushButtonSettingsDelete_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSettingsDelete_clicked()
{
    QString thisIndex = ui->comboBoxSettingsProjects->model()->data(ui->comboBoxSettingsProjects->model()->index(ui->comboBoxSettingsProjects->currentIndex(), 0)).toString();
    myAccessSqlDbtModel->deleteConfiguration(thisIndex);
    setQtProjectCombo();
}
/******************************************************************************
* \fn on_pushButtonSettingsSave_clicked Configuration
*******************************************************************************/
void MainWindow::on_pushButtonSettingsSave_clicked()
{
    setMyProjectConfigurationClass(TabSettings);
    myAccessSqlDbtModel->saveProject();
    // Ubuntu
    // Set Variables in Class
    setMyProjectConfigurationClass(TabUbuntu);
    myAccessSqlDbtModel->saveConfiguration();
    // Mac
    // Set Variables in Class
    setMyProjectConfigurationClass(TabMac);
    myAccessSqlDbtModel->saveConfiguration();
    // Android
    // Set Variables in Class
    setMyProjectConfigurationClass(TabAndroid);
    myAccessSqlDbtModel->saveConfiguration();
    // WebAssembly
    // Set Variables in Class
    setMyProjectConfigurationClass(TabWebAssembly);
    myAccessSqlDbtModel->saveConfiguration();
    // IOS
    // Set Variables in Class
    setMyProjectConfigurationClass(TabIOS);
    myAccessSqlDbtModel->saveConfiguration();
    // Windows
    // Set Variables in Class
    setMyProjectConfigurationClass(TabWindows);
    myAccessSqlDbtModel->saveConfiguration();
    // Defaults
    // Set Variables in Class
    setMyProjectConfigurationClass(TabDefaults);
    myAccessSqlDbtModel->saveConfiguration();

}
/******************************************************************************
* \fn on_pushButtonSettingsAdd_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSettingsAdd_clicked()
{

    if (myAccessSqlDbtModel->isProjectQuery(ui->lineEditSettingsQtProject->text()))
    {
        QString theMessage = QString("Record found in database: %1").arg(ui->lineEditSettingsQtProject->text());
        myOrgDomainSetting->showMessageBox("Record found!", theMessage.toLocal8Bit(), "warning");
        return;
    }
    //
    setMyProjectConfigurationClass(TabSettings);
    if (!myAccessSqlDbtModel->addProject())
    {
        return;
    }
    ui->labelRecordIdSettings->setText(myAccessSqlDbtModel->getProjectID());
    // Ubuntu
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabUbuntu);
        myAccessSqlDbtModel->addConfiguration();
    }
    // Mac
    if (ui->checkBoxSettingsMac->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabMac);
        myAccessSqlDbtModel->addConfiguration();
    }
    // Android
    if (ui->checkBoxSettingsAndroid->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabAndroid);
        myAccessSqlDbtModel->addConfiguration();
    }
    // WebAssembly
    if (ui->checkBoxSettingsWebAssembly->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabWebAssembly);
        myAccessSqlDbtModel->addConfiguration();
    }
    // IOS
    if (ui->checkBoxSettingsiOS->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabIOS);
        myAccessSqlDbtModel->addConfiguration();
    }
    // Windows
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabWindows);
        myAccessSqlDbtModel->addConfiguration();
    }
    // Defaults
    // Set Variables in Class
    setMyProjectConfigurationClass(TabDefaults);
    myAccessSqlDbtModel->addConfiguration();
    setQtProjectCombo();
}
/******************************************************************************
* \fn on_pushButtonSaveSql_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveSql_clicked()
{
    setMyProjectConfigurationClass(TabSql);
}
/******************************************************************************
* \fn on_pushButtonSaveUbuntu_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveUbuntu_clicked()
{
    setMyProjectConfigurationClass(TabUbuntu);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveMac_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveMac_clicked()
{
    setMyProjectConfigurationClass(TabMac);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveAndroid_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveAndroid_clicked()
{
    setMyProjectConfigurationClass(TabAndroid);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveWebAssembly_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveWebAssembly_clicked()
{
    setMyProjectConfigurationClass(TabWebAssembly);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveIOS_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveIOS_clicked()
{
    setMyProjectConfigurationClass(TabIOS);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveWindows_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveWindows_clicked()
{
    setMyProjectConfigurationClass(TabWindows);
    myAccessSqlDbtModel->saveConfiguration();
}
/******************************************************************************
* \fn on_pushButtonSaveDefaults_clicked
*******************************************************************************/
void MainWindow::on_pushButtonSaveDefaults_clicked()
{
    setMyProjectConfigurationClass(TabDefaults);
    myAccessSqlDbtModel->saveConfiguration();
}
/*** ************************* End of File ***********************************/
