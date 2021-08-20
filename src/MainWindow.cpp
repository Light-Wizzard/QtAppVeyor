/************************************************
* @file MainWindow.cpp
* @brief MainWindow.
* @author Jeffrey Scott Flesher <Jeffrey.Scott.Flesher@>
* @version 1.0
* @section LICENSE
* Unlicenced, Free, CopyLeft.
* @section DESCRIPTION
* Main Window of GUI
* @mainpage
* QtAppVeyor is designed to deploy on AppVeyor,
* and at the same time it is designed to create the .appveyor.yml file used to deploy it.
 ***********************************************/
#include "MainWindow.h"
/************************************************
 * @brief MainWindow Constructor.
 * MainWindow
 ***********************************************/
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    // App Icon
    QApplication::setWindowIcon(QIcon(":/images/logo32.png"));
    // ui stuff
    ui->setupUi(this);
    mySqlDb         = new MyDatatables(this);
    myLocalization  = new MyLocalization(this, mySqlDb->mySqlModel->mySetting);
    // Read in Settings First
    readSettingsFirst();
    // Set to defaults
    myLocalization->setTransFilePrefix("QtAppVeyor");       //!< Prefix of Translation files
    myLocalization->setTranslationSource("translations");   //!< Relative Folder for Translation files
    myLocalization->setHelpSource("help");                  //!< Relative Folder for Help files
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
    connect(ui->actionAuthor,    &QAction::triggered, this, &MainWindow::onAuthor);
    // Set Window Title to Application Name
    setWindowTitle(QApplication::applicationName());
    // Do a one time Single Shot call to onRunOnStartup to allow the GUI to load before calling what is in that call
    QTimer::singleShot(200, this, &MainWindow::onRunOnStartup);
}
/************************************************
 * @brief MainWindow Deconstructor.
 * ~MainWindow
 ***********************************************/
MainWindow::~MainWindow()
{
    Q_CLEANUP_RESOURCE(QtAppVeyor);
    delete ui;
}
/************************************************
 * @brief close Event.
 * closeEvent
 ***********************************************/
void MainWindow::closeEvent(QCloseEvent *event)
{
    if (isDebugMessage) qDebug() << "closeEvent";
    if (isSaveSettings) on_pushButtonSettingsSave_clicked();
    mySqlDb->mySqlModel->mySetting->setGeometry(pos(), size(), isMaximized(), isMinimized());
    writeAllSettings();
    QMainWindow::closeEvent(event);
    close();
} // end closeEvent
/************************************************
 * @brief change Event.
 * changeEvent
 ***********************************************/
void MainWindow::changeEvent(QEvent *event)
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "changeEvent"; }
    if (event ->type() == QEvent::LanguageChange && isMainLoaded)
    {
        // retranslate designer form (single inheritance approach)
        ui->retranslateUi(this);
        // retranslate other widgets which weren't added in designer
        retranslate();
    }
    // remember to call base class implementation
    QMainWindow::changeEvent(event);
}
/************************************************
 * @brief retranslate.
 * retranslate
 ***********************************************/
void MainWindow::retranslate()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "retranslate"; }
    // FIXME
    loadLanguageComboBox();
}
/************************************************
 * @brief load Language ComboBox.
 * loadLanguageComboBox
 ***********************************************/
void MainWindow::loadLanguageComboBox()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "loadLanguageComboBox"; }
    bool lastIsMainLoaded = isMainLoaded;
    isMainLoaded = false;
    myLocalization->setMainLoaded(false);
    int theCurrentIndex = ui->comboBoxSettingsLanguage->currentIndex();
    if (theCurrentIndex < 0) { theCurrentIndex = myLanguageCombBoxIndex; }
    ui->comboBoxSettingsLanguage->clear();
    const QStringList theQmFiles =  myLocalization->findQmFiles(myLocalization->getTranslationSource());
    QStandardItemModel *theLangModel = new QStandardItemModel(this);
    theLangModel->setColumnCount(2);
    for (int i = 0; i < theQmFiles.size(); ++i)
    {
        QString theLanguageName = myLocalization->getLanguageFromFile(myLocalization->getTransFilePrefix(), theQmFiles.at(i));
        QStandardItem* theCol0 = new QStandardItem(theLanguageName);
        QStandardItem* theCol1 = new QStandardItem(tr(theLanguageName.toLocal8Bit()));
        theLangModel->setItem(i, 0, theCol0);
        theLangModel->setItem(i, 1, theCol1);
    } // end for
    QTableView* theTableView = new QTableView(this);
    theTableView->setModel(theLangModel);
    theTableView->verticalHeader()->setVisible(false);
    theTableView->horizontalHeader()->setVisible(false);
    theTableView->setHorizontalScrollBarPolicy(Qt::ScrollBarAsNeeded);
    theTableView->setSelectionBehavior(QAbstractItemView::SelectRows);
    theTableView->setSelectionMode(QAbstractItemView::SingleSelection);
    theTableView->setAutoScroll(false);
    theTableView->setColumnWidth(0, 196);
    theTableView->setColumnWidth(1, 196);
    // Set comboBox
    ui->comboBoxSettingsLanguage->setMinimumWidth(400);
    ui->comboBoxSettingsLanguage->setModel(theLangModel);
    ui->comboBoxSettingsLanguage->setView(theTableView);
    ui->comboBoxSettingsLanguage->setCurrentIndex(theCurrentIndex);
    isMainLoaded = lastIsMainLoaded;
    myLocalization->setMainLoaded(lastIsMainLoaded);
}
/************************************************
 * @brief set Qt Project Combo.
 * setQtProjectCombo
 ***********************************************/
bool MainWindow::setQtProjectCombo()
{
    QSqlQueryModel *theModalQtAppVeyor = new QSqlQueryModel; //!< SQL Query Model
    //  SELECT id, QtProject FROM Projects
    const auto SELECTED_PROJECTS_SQL = QLatin1String(R"(%1)").arg(mySqlDb->getQtProjectSelectQuery());
    theModalQtAppVeyor->setQuery(SELECTED_PROJECTS_SQL);
    if (theModalQtAppVeyor->lastError().isValid())
    {
        qDebug() << theModalQtAppVeyor->lastError();
    }
    theModalQtAppVeyor->setHeaderData(0,Qt::Horizontal, tr("ID"));
    theModalQtAppVeyor->setHeaderData(1, Qt::Horizontal, tr("Project"));
    QTableView *theTableView = new QTableView;
    theTableView->setModel(theModalQtAppVeyor);
    theTableView->setSelectionBehavior(QAbstractItemView::SelectRows);
    theTableView->setSelectionMode(QAbstractItemView::SingleSelection);
    theTableView->verticalHeader()->setVisible(false);
    theTableView->horizontalHeader()->setVisible(false);
    theTableView->setHorizontalScrollBarPolicy(Qt::ScrollBarAsNeeded);
    theTableView->setAutoScroll(false);
    theTableView->setColumnWidth(0, 6);
    theTableView->setColumnWidth(1, 196);
    theTableView->setColumnHidden(0, true);
    ui->comboBoxSettingsProjects->setModel(nullptr);
    ui->comboBoxSettingsProjects->setModel(theModalQtAppVeyor);
    ui->comboBoxSettingsProjects->setView(theTableView);
    ui->comboBoxSettingsProjects->setModelColumn(1);
    ui->comboBoxSettingsProjects->setCurrentIndex(0);
    ui->comboBoxSettingsProjects->setMinimumWidth(200);
    return true;
}
/************************************************
 * @brief on Run On Startup.
 * onRunOnStartup
 ***********************************************/
void MainWindow::onRunOnStartup()
{
    isMainLoaded = false;
    myLocalization->setMainLoaded(false);
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabSettings")));
    // Read Settings First
    readAllSettings();
    // Read Saved Language
    myLocalization->readLanguage();
    // Get Language File
    QString theQmLanguageFile = myLocalization->getLanguageFile(myLocalization->getLanguageCode(), myLocalization->getTranslationSource(), myLocalization->getTransFilePrefix());
    // Load Language
    myLocalization->loadLanguage(theQmLanguageFile);
    QString theLastLanguage = myLocalization->getLanguageFromFile(myLocalization->getTransFilePrefix(), theQmLanguageFile);
    loadLanguageComboBox();
    ui->comboBoxSettingsLanguage->setCurrentIndex(ui->comboBoxSettingsLanguage->findText(theLastLanguage));
    //
    if (!mySqlDb->checkDatabase()) close();
    setQtProjectCombo();
    // FIXME save last combobox ID
    fillForms(mySqlDb->getProjectID());
    //
    setSqlBrowseButton();
    // FIXME read database to ui
    isMainLoaded = true;
    myLocalization->setMainLoaded(true);
}
/************************************************
 * @brief read Settings First.
 * readSettingsFirst
 ***********************************************/
void MainWindow::readSettingsFirst()
{
    isDebugMessage = mySqlDb->mySqlModel->mySetting->readSettingsBool(mySqlDb->mySqlModel->mySetting->myConstants->MY_IS_DEBUG_MESSAGE, isDebugMessage);
    if (isDebugMessage)
        { ui->checkBoxSettignsMessaging->setCheckState(Qt::CheckState::Checked); }
    else
        { ui->checkBoxSettignsMessaging->setCheckState(Qt::CheckState::Unchecked); }
    setMessagingStates(isDebugMessage);
}
/************************************************
 * @brief Read All Settings.
 * readAllSettings
 ***********************************************/
void MainWindow::readAllSettings()
{
    if (isDebugMessage) { qDebug() << "readAllSettings"; }
    //resize(myMySettings->getGeometrySize());
    //move(myMySettings->getGeometryPos());
    //
    //if(myMySettings->getGeometryMax()) setWindowState(windowState() | Qt::WindowMaximized);
    //if(myMySettings->getGeometryMin()) setWindowState(windowState() | Qt::WindowMinimized);
    //
    //
    readStatesChanges();
    readSqlDatabaseInfo();
}
/************************************************
 * @brief Write All Settings.
 * writeAllSettings
 ***********************************************/
bool MainWindow::writeAllSettings()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "writeAllSettings"; }
    //
    writeStatesChanges();
    writeSqlDatabaseInfo();
    return true;
}
/************************************************
 * @brief write SQL Database States.
 * writeSqlDatabaseStates
 ***********************************************/
void MainWindow::writeStatesChanges()
{
    if (isDebugMessage) qDebug() << "writeSqlDatabaseStates";
    // Project ID
    mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_PROJECT_ID, mySqlDb->getProjectID());
    // Debug Messaging
    mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_IS_DEBUG_MESSAGE, isDebugMessage ? "true" : "false");
    // Language ComboBox
    myLocalization->setLanguageCode(myLocalization->languageNameToCode(ui->comboBoxSettingsLanguage->currentText()));
    myLocalization->writeLanguage(myLocalization->getLanguageCode());
}
/************************************************
 * @brief read SQL Database States.
 * readSqlDatabaseStates
 ***********************************************/
void MainWindow::readStatesChanges()
{
    // Project ID
    // default set to myProjectID="-1"
    QString theProjectID = mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_PROJECT_ID, mySqlDb->getProjectID());
    // We cannot read from the database yet, we are only getting the last states we know of
    if (theProjectID != "-1") { mySqlDb->setProjectID(theProjectID); } else { mySqlDb->setProjectID("1"); }
    ui->labelRecordIdSettings->setText(mySqlDb->getProjectID());
}
/************************************************
 * @brief write SQL Database Info.
 * writeSqlDatabaseInfo
 ***********************************************/
void MainWindow::writeSqlDatabaseInfo()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << ""; }
    // SQL Database Name
    mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_NAME,  ui->lineEditSqlDatabaseName->text());
    // SQL Database Type State
    ui->comboBoxSqlDatabaseType->setCurrentIndex(mySqlDb->mySqlModel->mySetting->readSettingsInt(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_COMBO_STATE, 1));
    // SQL Database Type Value
    mySqlDb->setComboBoxSqlValue(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_COMBO_VALUE, mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DEFAULT));
    // SQL Host
    mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_HOST,  ui->lineEditSqlHostName->text());
    // SQL User
    mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_USER,  ui->lineEditSqlUserName->text());
    // SQL Encrypted Password, it is saved in Ini file
    if (!ui->lineEditSqlPassword->text().isEmpty())
        { mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_PASS, mySqlDb->mySqlModel->mySetting->encryptThis(ui->lineEditSqlPassword->text())); }
}
/************************************************
 * @brief read SQL Database Info.
 * readSqlDatabaseInfo
 ***********************************************/
void MainWindow::readSqlDatabaseInfo()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "readSqlDatabaseInfo"; }
    QString theDb = QString("%1%2%3.db").arg(mySqlDb->mySqlModel->mySetting->getAppDataLocation(), QDir::separator(), mySqlDb->mySqlModel->getSqlDatabaseName());
    // SQL Database Name
    ui->lineEditSqlDatabaseName->setText(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_NAME, theDb));
    // SQL Database Type State
    ui->comboBoxSqlDatabaseType->setCurrentIndex(mySqlDb->mySqlModel->mySetting->readSettingsInt(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_COMBO_STATE, 1));
    // SQL Database Type Value
    mySqlDb->setComboBoxSqlValue(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_COMBO_VALUE, mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DEFAULT));
    // SQL Host
    ui->lineEditSqlHostName->setText(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_HOST, "")); // No Default
    // SQL User
    ui->lineEditSqlUserName->setText(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_USER, "")); // No Default
    // SQL Decrypted Password, it is saved in Ini file
    QString thePassword = mySqlDb->mySqlModel->mySetting->decryptThis(mySqlDb->mySqlModel->mySetting->readSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DB_PASS, ""));
    if (!thePassword.isEmpty())
        { ui->lineEditSqlPassword->setText(thePassword); }
    else
        { ui->lineEditSqlPassword->setText(""); }
}
/************************************************
 * on_comboBoxSettingsLanguage_currentIndexChanged
 * @brief on comboBox Settings Language current Index Changed.
 ***********************************************/
void MainWindow::on_comboBoxSettingsLanguage_currentIndexChanged(const QString &thisLanguage)
{
    if (!isMainLoaded) { return; }
    if (isDebugMessage && isMainLoaded) { qDebug() << "on_comboBoxSettingsLanguage_currentIndexChanged"; }
    myLocalization->writeLanguage(myLocalization->languageNameToCode(thisLanguage));
    myLocalization->loadLanguage(myLocalization->getLanguageFile(myLocalization->languageNameToCode(thisLanguage), myLocalization->getTranslationSource(), myLocalization->getTransFilePrefix()));
}
/************************************************
 * @brief on About.
 * onAbout
 ***********************************************/
void MainWindow::onAbout()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "onAbout"; }
    // Go to Tab
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabHelp")));
    //
    QString theFileName = QString(":help/About_%1.md").arg(myLocalization->getLanguageCode());
    if (!mySqlDb->mySqlModel->mySetting->isFileExists(theFileName))
        { theFileName = QString(":help/About_%1.md").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULT_LANGUAGE_CODE); }
    ui->textEditHelp->setMarkdown(mySqlDb->mySqlModel->mySetting->readFile(theFileName));
} // end onAbout
/************************************************
 * @brief on Author.
 * onAuthor
 ***********************************************/
void MainWindow::onAuthor()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "onAuthor"; }
    // Go to Tab
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabHelp")));
    //
    QString theFileName = QString(":help/About-Author_%1.md").arg(myLocalization->getLanguageCode());
    if (!mySqlDb->mySqlModel->mySetting->isFileExists(theFileName))
        { theFileName = QString(":help/About-Author_%1.md").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULT_LANGUAGE_CODE); }
    ui->textEditHelp->setMarkdown(mySqlDb->mySqlModel->mySetting->readFile(theFileName));
} // end onAbout
/************************************************
 * @brief on Help.
 * onHelp
 ***********************************************/
void MainWindow::onHelp()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "onHelp"; }
    // Go to Tab
    ui->tabWidget->setCurrentIndex(ui->tabWidget->indexOf(ui->tabWidget->findChild<QWidget*>("tabHelp")));
    //
    QString theFileName = QString(":help/Help_%1.md").arg(myLocalization->getLanguageCode());
    if (!mySqlDb->mySqlModel->mySetting->isFileExists(theFileName))
        { theFileName = QString(":help/Help_%1.md").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULT_LANGUAGE_CODE); }
    QString theFileContent = mySqlDb->mySqlModel->mySetting->readFile(theFileName);
    // Do not translate this file
    QString theLanguageFileName = QString(":help/Language.txt").arg(myLocalization->getLanguageCode());
    if (mySqlDb->mySqlModel->mySetting->isFileExists(theLanguageFileName))
    {
        theFileContent.append(mySqlDb->mySqlModel->mySetting->readFile(theLanguageFileName));
    }
    ui->textEditHelp->setMarkdown(theFileContent);
} // end onHelp
/************************************************
 * @brief onClipboard.
 * onClipboard
 ***********************************************/
void MainWindow::onClipboard()
{
    if (isDebugMessage) qDebug() << "onClipboard";
    if (!isYamlLoaded) { onCreate();}
    clipboard->setText(ui->textEditYml->toPlainText());
}
/************************************************
 * @brief on Create.
 * onCreate
 * QtAppVeyor appveyor configuration files
 * https://ci.appveyor.com/tools/validate-yaml
 * https://www.appveyor.com/docs/build-environment/#qt
 * https://download.qt.io/snapshots/ifw/installer-framework/30/
 ***********************************************/
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
        { thisYaml.append("build: off\n"); }
    if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        { thisYaml.append("build: on\n"); }

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
        if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditQtVersionUbuntu->text()));
        }
        if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditVsVersionUbuntu->text()));
        }
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
        if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditQtVersionMac->text()));
        }
        if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditVsVersionMac->text()));
        }
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
        if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditQtVersionWebAssembly->text()));
        }
        if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditVsVersionWebAssembly->text()));
        }
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
        if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditQtVersionIOS->text()));
        }
        if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditVsVersionIOS->text()));
        }
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
        if (ui->radioButtonSettingsEnvironmentQt->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT));
        }
        thisYaml.append(QString("    MY_QT_VERSION: %1\n").arg(ui->lineEditQtVersionWindows->text()));
        if (ui->radioButtonSettingsEnvironmentVs->isChecked())
        {
            thisYaml.append(QString("    MY_COMPILER: %1\n").arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS));
            thisYaml.append(QString("    MY_VS_VERSION: %1\n").arg(ui->lineEditVsVersionWindows->text()));
        }
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
/************************************************
 * @brief on Save As Yml File.
 * onSaveAsYmlFile
 ***********************************************/
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
/************************************************
 * @brief clear Tab Settings.
 * clearTabSettings
 ***********************************************/
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
/************************************************
 * @brief clear Tab Ubuntu.
 * clearTabUbuntu
 ***********************************************/
void MainWindow::clearTabUbuntu()
{
    // Ubuntu
    ui->labelRecordIdUbuntu->setText("0");
    ui->lineEditQtVersionUbuntu->setText("");
    ui->lineEditVsVersionUbuntu->setText("");
    ui->lineEditQtIfVersionUbuntu->setText("");
    ui->lineEditQtIfPackageUriUbuntu->setText("");
    ui->lineEditPythonVersionUbuntu->setText("");
    ui->checkBoxPythonUbuntu->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeUbuntu->setCheckState(Qt::CheckState::Unchecked);
}
/************************************************
 * @brief clear Tab Mac.
 * clearTabMac
 ***********************************************/
void MainWindow::clearTabMac()
{
    // Mac
    ui->labelRecordIdMac->setText("0");
    ui->lineEditQtVersionMac->setText("");
    ui->lineEditVsVersionMac->setText("");
    ui->lineEditQtIfVersionMac->setText("");
    ui->lineEditQtIfPackageUriMac->setText("");
    ui->lineEditPythonVersionMac->setText("");
    ui->checkBoxSettingsMac->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeMac->setCheckState(Qt::CheckState::Unchecked);
}
/************************************************
 * @brief clear Tab Android.
 * clearTabAndroid
 ***********************************************/
void MainWindow::clearTabAndroid()
{
    // Android
    ui->labelRecordIdAndroid->setText("0");
    ui->lineEditQtVersionAndroid->setText("");
    ui->lineEditVsVersionAndroid->setText("");
    ui->lineEditQtIfVersionAndroid->setText("");
    ui->lineEditQtIfPackageUriAndroid->setText("");
    ui->lineEditPythonVersionAndroid->setText("");
    ui->checkBoxPythonAndroid->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeAndroid->setCheckState(Qt::CheckState::Unchecked);
}
/************************************************
 * @brief clearTabWebAssembly.
 * clear Tab Web Assembly
 ***********************************************/
void MainWindow::clearTabWebAssembly()
{
    // WebAssembly
    ui->labelRecordIdWebAssembly->setText("0");
    ui->lineEditQtVersionWebAssembly->setText("");
    ui->lineEditVsVersionWebAssembly->setText("");
    ui->lineEditQtIfVersionWebAssembly->setText("");
    ui->lineEditQtIfPackageUriWebAssembly->setText("");
    ui->lineEditPythonVersionWebAssembly->setText("");
    ui->checkBoxPythonWebAssembly->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeWebAssembly->setCheckState(Qt::CheckState::Unchecked);
}
/************************************************
 * @brief clear Tab IOS.
 * clearTabIOS
 ***********************************************/
void MainWindow::clearTabIOS()
{
    // IOS
    ui->labelRecordIdIOS->setText("0");
    ui->lineEditQtVersionIOS->setText("");
    ui->lineEditVsVersionIOS->setText("");
    ui->lineEditQtIfVersionIOS->setText("");
    ui->lineEditQtIfPackageUriIOS->setText("");
    ui->lineEditPythonVersionIOS->setText("");
    ui->checkBoxPythonIOS->setCheckState(Qt::CheckState::Unchecked);
    ui->checkBoxUpgradeIOS->setCheckState(Qt::CheckState::Unchecked);
}
/************************************************
 * @brief clear Tab Windows.
 * clearTabWindows
 ***********************************************/
void MainWindow::clearTabWindows()
{
    // Windows
    ui->labelRecordIdWindows->setText("0");
    ui->lineEditQtVersionWindows->setText("");
    ui->lineEditVsVersionWindows->setText("");
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
/************************************************
 * @brief clear Tab Defaults.
 * clearTabDefaults
 ***********************************************/
void MainWindow::clearTabDefaults()
{
    // Defaults
    ui->labelRecordIdDefaults->setText("0");
    ui->lineEditQtVersionDefaults->setText("");
    ui->lineEditVsVersionDefaults->setText("");
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
/************************************************
 * @brief clear Tab Yaml.
 * clearTabYaml
 ***********************************************/
void MainWindow::clearTabYaml()
{
    ui->textEditYml->setText("");
}
/************************************************
 * @brief clear Forms.
 * clearForms
 * @param tabNumber int enum TabX
 ***********************************************/
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
/************************************************
 * @brief on comboBox Settings Projects current Index Changed.
 * on_comboBoxSettingsProjects_currentIndexChanged
 ***********************************************/
void MainWindow::on_comboBoxSettingsProjects_currentIndexChanged(int index)
{
    Q_UNUSED(index)
    if (isDebugMessage) qDebug() << "on_comboBoxSettingsProjects_currentIndexChanged";
    if (!isMainLoaded) { return; }
    QString thisIndex = ui->comboBoxSettingsProjects->model()->data(ui->comboBoxSettingsProjects->model()->index(ui->comboBoxSettingsProjects->currentIndex(), 0)).toString();
    fillForms(thisIndex);
}
/************************************************
 * @brief on action Print triggered.
 * on_actionPrint_triggered
 ***********************************************/
void MainWindow::on_actionPrint_triggered()
{
    QPrinter printer(QPrinter::HighResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("appveyor.pdf");

    QPrintDialog dialog(&printer, this);
    if(dialog.exec() == QDialog::Rejected) return;

    ui->textEditYml->print(&printer);
}
/************************************************
 * @brief settings Buttons.
 * settingsButtons
 ***********************************************/
void MainWindow::settingsButtons(bool thisEnabled)
{
    if (isDebugMessage) { qDebug() << "settingsButtons"; }
    ui->pushButtonSettingsAdd->setEnabled(thisEnabled);
    ui->pushButtonSettingsSave->setEnabled(thisEnabled);
    ui->pushButtonSettingsDelete->setEnabled(thisEnabled);
}
/************************************************
 * @brief set SQL Browse Button.
 * setSqlBrowseButton
 ***********************************************/
void MainWindow::setSqlBrowseButton()
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "setSqlBrowseButton"; }
    ui->pushButtonSqlFileBrowswer->setEnabled(ui->comboBoxSqlDatabaseType->currentText() == mySqlDb->mySqlModel->mySetting->myConstants->MY_SQL_DEFAULT || ui->comboBoxSqlDatabaseType->currentText() == ":memory:");
}
/************************************************
 * @brief on comboBox SQL Database Type current Index Changed.
 * on_comboBoxSqlDatabaseType_currentIndexChanged
 ***********************************************/
void MainWindow::on_comboBoxSqlDatabaseType_currentIndexChanged(const QString &thisSqlType)
{
    if (isMainLoaded) { return; }
    if (isDebugMessage) qDebug() << "on_comboBoxSqlDatabaseType_currentIndexChanged=" << thisSqlType;
    mySqlDb->mySqlModel->setSqlDriver(thisSqlType);
    writeStatesChanges();
    setSqlBrowseButton();
}
/************************************************
 * @brief fill Forms.
 * fillForms
 ***********************************************/
void MainWindow::fillForms(const QString &thisProjectID)
{
    if (isDebugMessage && isMainLoaded) { qDebug() << "fillForms=" << thisProjectID; }
    clearForms(TabAll);
    ui->labelRecordIdSettings->setText(thisProjectID); // Project id and Configuration ProjectID
    // Declare all variable in function scope
    QSqlQuery query; //!< SQL Query
    bool theIsOsUbuntu, theIsOsMac, theIsOsWindows, theIsOsAndroid, theIsOsWebAssembly, theIsOSiOS;
    theIsOsUbuntu = theIsOsMac = theIsOsWindows = theIsOsAndroid = theIsOsWebAssembly = theIsOSiOS = false;
    QString myConfigurationSelectQuery = mySqlDb->getProjectsFullSelectQueryID(thisProjectID);
    if (isDebugMessage && isMainLoaded) { qDebug() << " myConfigurationSelectQuery=|" << myConfigurationSelectQuery << "|"; }
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
    VsVersion
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
SELECT id, ProjectsID, OS, QtVersion, VsVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired,
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
            QMessageBox::critical(nullptr, QObject::tr("Could not read from the Database"), QObject::tr("Unable to find record in database. Click Cancel to exit."), QMessageBox::Cancel);
        }
    }
    else
    {
        QMessageBox::critical(nullptr, QObject::tr("Could not read from the Database"), QObject::tr("Unable to find record in database. Click Cancel to exit."), QMessageBox::Cancel);
        return;
    }
    // Ubuntu
    if (theIsOsUbuntu)
    {
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_UBUNTU);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdUbuntu->setText(query.value("id").toString());
                ui->lineEditQtVersionUbuntu->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionUbuntu->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_UBUNTU), QMessageBox::Cancel);
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
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_MAC);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdMac->setText(query.value("id").toString());
                ui->lineEditQtVersionMac->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionMac->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_MAC), QMessageBox::Cancel);
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
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_ANDROID);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdAndroid->setText(query.value("id").toString());
                ui->lineEditQtVersionAndroid->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionAndroid->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_ANDROID), QMessageBox::Cancel);
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
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WEBASSEMBLY);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdWebAssembly->setText(query.value("id").toString());
                ui->lineEditQtVersionWebAssembly->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionWebAssembly->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WEBASSEMBLY), QMessageBox::Cancel);
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
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_IOS);
        if (isDebugMessage) qDebug() << "myConfigurationSelectQuery=" << myConfigurationSelectQuery;
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdIOS->setText(query.value("id").toString());
                ui->lineEditQtVersionIOS->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionIOS->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_IOS), QMessageBox::Cancel);
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
        myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WINDOWS);
        if (query.exec(myConfigurationSelectQuery))
        {
            if (query.first())
            {
                // Set Record ID
                ui->labelRecordIdWindows->setText(query.value("id").toString());
                ui->lineEditQtVersionWindows->setText(query.value("QtVersion").toString());
                ui->lineEditVsVersionWindows->setText(query.value("VsVersion").toString());
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
                QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WINDOWS), QMessageBox::Cancel);
            }
        }
        else
        {
            qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
        }
    }
    // Defaults
    myConfigurationSelectQuery = mySqlDb->getConfigurationProjectIdOsSelectQuery(thisProjectID, mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_DEFAULTS);
    if (query.exec(myConfigurationSelectQuery))
    {
        if (query.first())
        {
            // Set Record ID
            ui->labelRecordIdDefaults->setText(query.value("id").toString());
            ui->lineEditQtVersionDefaults->setText(query.value("QtVersion").toString());
            ui->lineEditVsVersionDefaults->setText(query.value("VsVersion").toString());
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
            QMessageBox::critical(nullptr, QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1), QObject::tr(mySqlDb->mySqlModel->mySetting->myConstants->MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2).arg(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_DEFAULTS), QMessageBox::Cancel);
        }
    }
    else
    {
        qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
    isSaveSettings = false;
}
/************************************************
 * @brief on pushButton Reset Defaults Ubuntu clicked.
 * on_pushButtonResetDefaultsUbuntu_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsUbuntu_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionUbuntu->setText(ui->lineEditQtVersionDefaults->text()); }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionUbuntu->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionUbuntu->setText(ui->lineEditQtIfVersionDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriUbuntu->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    ui->lineEditPythonVersionUbuntu->setText(ui->lineEditPythonVersionDefaults->text());
    ui->checkBoxPythonUbuntu->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeDefaults->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/************************************************
 * @brief on pushButton Reset Defaults Mac clicked.
 * on_pushButtonResetDefaultsMac_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsMac_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionMac->setText(ui->lineEditQtVersionDefaults->text()); }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionMac->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionMac->setText(ui->lineEditQtIfVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriMac->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditPythonVersionMac->setText(ui->lineEditPythonVersionDefaults->text()); }
    ui->checkBoxPythonMac->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeDefaults->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/************************************************
 * @brief on pushButton Reset Defaults Android clicked.
 * on_pushButtonResetDefaultsAndroid_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsAndroid_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionAndroid->setText(ui->lineEditQtVersionDefaults->text()); }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionAndroid->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionAndroid->setText(ui->lineEditQtIfVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriAndroid->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditPythonVersionAndroid->setText(ui->lineEditPythonVersionDefaults->text()); }
    ui->checkBoxPythonAndroid->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeAndroid->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/************************************************
 * @brief on pushButton Reset Defaults WebAssembly clicked.
 * on_pushButtonResetDefaultsWebAssembly_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsWebAssembly_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionWebAssembly->setText(ui->lineEditQtVersionDefaults->text()); }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionWebAssembly->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionWebAssembly->setText(ui->lineEditQtIfVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriWebAssembly->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditPythonVersionWebAssembly->setText(ui->lineEditPythonVersionDefaults->text()); }
    ui->checkBoxPythonWebAssembly->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeWebAssembly->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/************************************************
 * @brief on pushButton Reset Defaults IOS clicked.
 * on_pushButtonResetDefaultsIOS_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsIOS_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionIOS->setText(ui->lineEditQtVersionDefaults->text()); }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionIOS->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionIOS->setText(ui->lineEditQtIfVersionDefaults->text());  }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriIOS->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditPythonVersionIOS->setText(ui->lineEditPythonVersionDefaults->text()); }
    ui->checkBoxPythonIOS->setCheckState(ui->checkBoxPythonDefaults->checkState());
    ui->checkBoxUpgradeIOS->setCheckState(ui->checkBoxUpgradeDefaults->checkState());
}
/************************************************
 * @brief on pushButton Reset Defaults Windows clicked.
 * on_pushButtonResetDefaultsWindows_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaultsWindows_clicked()
{
    if (!ui->lineEditQtVersionDefaults->text().isEmpty())
        { ui->lineEditQtVersionWindows->setText(ui->lineEditQtVersionDefaults->text());  }
    if (!ui->lineEditVsVersionDefaults->text().isEmpty())
        { ui->lineEditVsVersionWindows->setText(ui->lineEditVsVersionDefaults->text()); }
    if (!ui->lineEditQtIfVersionDefaults->text().isEmpty())
        { ui->lineEditQtIfVersionWindows->setText(ui->lineEditQtIfVersionDefaults->text()); }
    if (!ui->lineEditQtIfPackageUriDefaults->text().isEmpty())
        { ui->lineEditQtIfPackageUriWindows->setText(ui->lineEditQtIfPackageUriDefaults->text()); }
    if (!ui->lineEditPythonVersionDefaults->text().isEmpty())
        { ui->lineEditPythonVersionWindows->setText(ui->lineEditPythonVersionDefaults->text());  }
    if (!ui->lineEditQtMingW32Defaults->text().isEmpty())
        { ui->lineEditQtMingW32Windows->setText(ui->lineEditQtMingW32Defaults->text()); }
    if (!ui->lineEditQtMingW64Defaults->text().isEmpty())
        { ui->lineEditQtMingW64Windows->setText(ui->lineEditQtMingW64Defaults->text()); }
    if (!ui->lineEditQtToolsMingW32Defaults->text().isEmpty())
        { ui->lineEditQtToolsMingW32Windows->setText(ui->lineEditQtToolsMingW32Defaults->text()); }
    if (!ui->lineEditQtToolsMingW64Defaults->text().isEmpty())
        { ui->lineEditQtToolsMingW64Windows->setText(ui->lineEditQtToolsMingW64Defaults->text()); }
    if (!ui->lineEditVisualStudioDefaults->text().isEmpty())
        { ui->lineEditVisualStudioWindows->setText(ui->lineEditVisualStudioDefaults->text()); }
    if (!ui->checkBoxPythonDefaults->text().isEmpty())
        { ui->checkBoxPythonWindows->setCheckState(ui->checkBoxPythonDefaults->checkState()); }
}
/************************************************
 * @brief on pushButton Reset Defaults clicked.
 * on_pushButtonResetDefaults_clicked
 ***********************************************/
void MainWindow::on_pushButtonResetDefaults_clicked()
{
    if (mySqlDb->mySqlModel->mySetting->isSetting(ui->lineEditQtVersionDefaults->objectName()))
    {
        ui->lineEditQtVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtVersionDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_QT_VERSION));
        ui->lineEditVsVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditVsVersionDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_VS_VERSION));
        ui->lineEditQtIfVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtIfVersionDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_QTIF_VERSION));
        ui->lineEditQtIfPackageUriDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtIfPackageUriDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER));
        ui->lineEditPythonVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditPythonVersionDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_VERSION));
        ui->lineEditQtMingW32Defaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtMingW32Defaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32));
        ui->lineEditQtMingW64Defaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtMingW64Defaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64));
        ui->lineEditQtToolsMingW32Defaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtToolsMingW32Defaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS));
        ui->lineEditQtToolsMingW64Defaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditQtToolsMingW64Defaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS));
        ui->lineEditVisualStudioDefaults->setText(mySqlDb->mySqlModel->mySetting->readSettings(ui->lineEditVisualStudioDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO));
        if (mySqlDb->mySqlModel->mySetting->readSettings(ui->checkBoxPythonDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED) == "true")
             { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked);    }
        else { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Unchecked);  }
        if (mySqlDb->mySqlModel->mySetting->readSettings(ui->checkBoxUpgradeDefaults->objectName(), mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_UPGRADE_OS) == "true")
             { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked);   }
        else { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Unchecked); }
    }
    else
    {
        ui->lineEditQtVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_QT_VERSION);
        ui->lineEditVsVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_VS_VERSION);
        ui->lineEditQtIfVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_QTIF_VERSION);
        ui->lineEditQtIfPackageUriDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER);
        ui->lineEditPythonVersionDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_VERSION);
        ui->lineEditQtMingW32Defaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32);
        ui->lineEditQtMingW64Defaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64);
        ui->lineEditQtToolsMingW32Defaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS);
        ui->lineEditQtToolsMingW64Defaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS);
        ui->lineEditVisualStudioDefaults->setText(mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO);
        if (mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED == "true")
             { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxPythonDefaults->setCheckState(Qt::CheckState::Unchecked); }
        if (mySqlDb->mySqlModel->mySetting->myConstants->MY_DEFAULTS_UPGRADE_OS == "true")
             { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Checked); }
        else { ui->checkBoxUpgradeDefaults->setCheckState(Qt::CheckState::Unchecked); }
    }
}
/************************************************
 * @brief on push Button SQL Password Show Hide clicked.
 * on_pushButtonSqlPasswordShowHide_clicked
 ***********************************************/
void MainWindow::on_pushButtonSqlPasswordShowHide_clicked()
{
    QMessageBox::critical(nullptr, QObject::tr("Password Revieled"), QObject::tr("%1").arg(ui->lineEditSqlPassword->text()), QMessageBox::Ok);
}
/************************************************
 * @brief on lineEdit SQL Database Name text Changed.
 * on_lineEditSqlDatabaseName_textChanged
 ***********************************************/
void MainWindow::on_lineEditSqlDatabaseName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeStatesChanges();
}
/************************************************
 * @brief on lineEdit SQL Host Name textChanged.
 * on_lineEditSqlHostName_textChanged
 ***********************************************/
void MainWindow::on_lineEditSqlHostName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeStatesChanges();
}
/************************************************
 * @brief on lineEdit SQL User Name text Changed.
 * on_lineEditSqlUserName_textChanged
 ***********************************************/
void MainWindow::on_lineEditSqlUserName_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeStatesChanges();
}
/************************************************
 * @brief on lineEdit SQL Password text Changed.
 * on_lineEditSqlPassword_textChanged
 ***********************************************/
void MainWindow::on_lineEditSqlPassword_textChanged(const QString &arg1)
{
    Q_UNUSED(arg1)
    if (!isMainLoaded) { return; }
    writeStatesChanges();
}
/************************************************
 * @brief on push Button SQL File Browswer clicked.
 * on_pushButtonSqlFileBrowswer_clicked
 ***********************************************/
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
        QString theDbNewLocation = QString("%1/%2.db").arg(theSqlFolder, mySqlDb->mySqlModel->getSqlDatabaseName());
        if (theDbLocation != theDbNewLocation)
        {
            //
            if (mySqlDb->mySqlModel->mySetting->getFileInfo(MyOrgSettings::IsFile, ui->lineEditSqlDatabaseName->text()) == "true")
            {
                QString thePath = mySqlDb->mySqlModel->mySetting->getFileInfo(MyOrgSettings::CanonicalFilePath, ui->lineEditSqlDatabaseName->text());
                // moveDb
                if (mySqlDb->mySqlModel->moveDb(theDbNewLocation, thePath, theDbNewLocation))
                    { ui->lineEditSqlDatabaseName->setText(theDbNewLocation); }
                else
                    { QMessageBox::critical(nullptr, QObject::tr("Database Move Failed"), QObject::tr("Failed to move Database"), QMessageBox::Ok); }
            }
        }
    }
}
/************************************************
 * @brief set My Project Configuration Class.
 * setMyProjectConfigurationClass
 ***********************************************/
void MainWindow::setMyProjectConfigurationClass(int tabNumber)
{
    //MyProjectClass theProject();
    // Common to all records
    mySqlDb->myConfigurationVariables->setProjectsID(ui->labelRecordIdSettings->text());
    //
    switch (tabNumber)
    {
        case TabSettings: // 0
            // IsOsUbuntu
            if (ui->checkBoxSettingsUbuntu->isChecked())
                { mySqlDb->myProject->setIsOsUbuntu("true"); }
            else
                { mySqlDb->myProject->setIsOsUbuntu("false"); }
            //IsOsMac
            if (ui->checkBoxSettingsMac->isChecked())
                { mySqlDb->myProject->setIsOsMac("true"); }
            else
                { mySqlDb->myProject->setIsOsMac("false"); }
            // IsOSiOS
            if (ui->checkBoxSettingsiOS->isChecked())
                { mySqlDb->myProject->setIsOSiOS("true"); }
            else
                { mySqlDb->myProject->setIsOSiOS("false"); }
            // IsOsAndroid
            if (ui->checkBoxSettingsAndroid->isChecked())
                { mySqlDb->myProject->setIsOsAndroid("true"); }
            else
                { mySqlDb->myProject->setIsOsAndroid("false"); }
            // IsOsWebAssembly
            if (ui->checkBoxSettingsWebAssembly->isChecked())
                { mySqlDb->myProject->setIsOsWebAssembly("true"); }
            else
                { mySqlDb->myProject->setIsOsWebAssembly("false"); }
            // IsOsAndroid
            if (ui->checkBoxSettingsAndroid->isChecked())
                { mySqlDb->myProject->setIsOsAndroid("true"); }
            else
                { mySqlDb->myProject->setIsOsAndroid("false"); }
            // IsOsWindows
            if (ui->checkBoxSettingsWindows->isChecked())
                { mySqlDb->myProject->setIsOsWindows("true"); }
            else
                { mySqlDb->myProject->setIsOsWindows("false"); }
            // IsDebug
            if (ui->checkBoxSettingsConfigurationDebug->isChecked())
                { mySqlDb->myProject->setIsDebug("true"); }
            else
                { mySqlDb->myProject->setIsDebug("false"); }
            // IsRelease
            if (ui->checkBoxSettingsConfigurationRelease->isChecked())
                { mySqlDb->myProject->setIsRelease("true"); }
            else
                { mySqlDb->myProject->setIsRelease("false"); }
            // IsX64
            if (ui->checkBoxSettingsPlatformX64->isChecked())
                { mySqlDb->myProject->setIsX64("true"); }
            else
                { mySqlDb->myProject->setIsX64("false"); }
            // IsX86
            if (ui->checkBoxSettingsPlatformX86->isChecked())
                { mySqlDb->myProject->setIsX86("true"); }
            else
                { mySqlDb->myProject->setIsX86("false"); }
            // Environment Qt
            if (ui->radioButtonSettingsEnvironmentQt->isChecked())
                { mySqlDb->myProject->setEnvironment(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_QT); }
            // Environment MSVS
            if (ui->radioButtonSettingsEnvironmentVs->isChecked())
                { mySqlDb->myProject->setEnvironment(mySqlDb->mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT_VS); }
            //
            mySqlDb->myProject->setID(ui->labelRecordIdSettings->text());
            mySqlDb->myProject->setQtProject(ui->lineEditSettingsQtProject->text());
            mySqlDb->myProject->setSecret(ui->lineEditSettingsSecret->text());
            break;
        case TabSql:      // 1
            writeSqlDatabaseInfo();
            break;
        case TabUbuntu:   // 2
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdUbuntu->text());
            // Clear Windows
            mySqlDb->myConfigurationVariables->setQtMingW32("");
            mySqlDb->myConfigurationVariables->setQtMingW64("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW32("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW64("");
            mySqlDb->myConfigurationVariables->setVisualStudio("");
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_UBUNTU);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionUbuntu->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionUbuntu->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionUbuntu->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriUbuntu->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionUbuntu->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeUbuntu->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonUbuntu->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }

            break;
        case TabMac: // 3
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdMac->text());
            // Clear Windows
            mySqlDb->myConfigurationVariables->setQtMingW32("");
            mySqlDb->myConfigurationVariables->setQtMingW64("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW32("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW64("");
            mySqlDb->myConfigurationVariables->setVisualStudio("");
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_MAC);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionMac->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionMac->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionMac->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriMac->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionMac->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeMac->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonMac->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
        case TabAndroid: // 4
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdAndroid->text());
            // Clear Windows
            mySqlDb->myConfigurationVariables->setQtMingW32("");
            mySqlDb->myConfigurationVariables->setQtMingW64("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW32("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW64("");
            mySqlDb->myConfigurationVariables->setVisualStudio("");
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_ANDROID);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionAndroid->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionAndroid->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionAndroid->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriAndroid->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionAndroid->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeAndroid->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonAndroid->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
        case TabWebAssembly: // 5
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdWebAssembly->text());
            // Clear Windows
            mySqlDb->myConfigurationVariables->setQtMingW32("");
            mySqlDb->myConfigurationVariables->setQtMingW64("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW32("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW64("");
            mySqlDb->myConfigurationVariables->setVisualStudio("");
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WEBASSEMBLY);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionWebAssembly->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionWebAssembly->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionWebAssembly->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriWebAssembly->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionWebAssembly->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeWebAssembly->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonWebAssembly->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
        case TabIOS: // 6
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdIOS->text());
            // Clear Windows
            mySqlDb->myConfigurationVariables->setQtMingW32("");
            mySqlDb->myConfigurationVariables->setQtMingW64("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW32("");
            mySqlDb->myConfigurationVariables->setQtToolsMingW64("");
            mySqlDb->myConfigurationVariables->setVisualStudio("");
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_IOS);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionIOS->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionIOS->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionIOS->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriIOS->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionIOS->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeIOS->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonIOS->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
        case TabWindows: // 7
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdWindows->text());
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_WINDOWS);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionWindows->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionWindows->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionWindows->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriWindows->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionWindows->text());
            // Windows
            mySqlDb->myConfigurationVariables->setQtMingW32(ui->lineEditQtMingW32Windows->text());
            mySqlDb->myConfigurationVariables->setQtMingW64(ui->lineEditQtMingW64Windows->text());
            mySqlDb->myConfigurationVariables->setQtToolsMingW32(ui->lineEditQtToolsMingW32Windows->text());
            mySqlDb->myConfigurationVariables->setQtToolsMingW64(ui->lineEditQtToolsMingW64Windows->text());
            mySqlDb->myConfigurationVariables->setVisualStudio(ui->lineEditVisualStudioWindows->text());
            // Python Required
            if (ui->checkBoxPythonWindows->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
        case TabDefaults: // 8
            // Set Record ID
            mySqlDb->myConfigurationVariables->setID(ui->labelRecordIdDefaults->text());
            // Common
            mySqlDb->myConfigurationVariables->setOS(mySqlDb->mySqlModel->mySetting->myConstants->MY_OS_NAME_DEFAULTS);
            mySqlDb->myConfigurationVariables->setQtVersion(ui->lineEditQtVersionDefaults->text());
            mySqlDb->myConfigurationVariables->setVsVersion(ui->lineEditVsVersionDefaults->text());
            mySqlDb->myConfigurationVariables->setQtIfVersion(ui->lineEditQtIfVersionDefaults->text());
            mySqlDb->myConfigurationVariables->setQtIfPackageUri(ui->lineEditQtIfPackageUriDefaults->text());
            mySqlDb->myConfigurationVariables->setPythonVersion(ui->lineEditPythonVersionDefaults->text());
            // Windows
            mySqlDb->myConfigurationVariables->setQtMingW32(ui->lineEditQtMingW32Defaults->text());
            mySqlDb->myConfigurationVariables->setQtMingW64(ui->lineEditQtMingW64Defaults->text());
            mySqlDb->myConfigurationVariables->setQtToolsMingW32(ui->lineEditQtToolsMingW32Defaults->text());
            mySqlDb->myConfigurationVariables->setQtToolsMingW64(ui->lineEditQtToolsMingW64Defaults->text());
            mySqlDb->myConfigurationVariables->setVisualStudio(ui->lineEditVisualStudioDefaults->text());
            // OS Upgrade
            if (ui->checkBoxUpgradeDefaults->isChecked())
                { mySqlDb->myConfigurationVariables->setOsUpgrade("true"); }
            else
                { mySqlDb->myConfigurationVariables->setOsUpgrade("false"); }
            // Python Required
            if (ui->checkBoxPythonDefaults->isChecked())
                { mySqlDb->myConfigurationVariables->setPythonRequired("true"); }
            else
                { mySqlDb->myConfigurationVariables->setPythonRequired("false"); }
            break;
    } // end switch (tabNumber)
} // end setMyConfigurationClass
/************************************************
 * @brief on pushButton Settings Delete clicked.
 * on_pushButtonSettingsDelete_clicked
 ***********************************************/
void MainWindow::on_pushButtonSettingsDelete_clicked()
{
    QString thisIndex = ui->comboBoxSettingsProjects->model()->data(ui->comboBoxSettingsProjects->model()->index(ui->comboBoxSettingsProjects->currentIndex(), 0)).toString();
    mySqlDb->deleteConfiguration(thisIndex);
    setQtProjectCombo();
}
/************************************************
 * @brief on pushButton Settings Save clicked.
 * on_pushButtonSettingsSave_clicked
 ***********************************************/
void MainWindow::on_pushButtonSettingsSave_clicked()
{
    setMyProjectConfigurationClass(TabSettings);
    mySqlDb->saveProject();
    // Ubuntu
    // Set Variables in Class
    setMyProjectConfigurationClass(TabUbuntu);
    mySqlDb->saveConfiguration();
    // Mac
    // Set Variables in Class
    setMyProjectConfigurationClass(TabMac);
    mySqlDb->saveConfiguration();
    // Android
    // Set Variables in Class
    setMyProjectConfigurationClass(TabAndroid);
    mySqlDb->saveConfiguration();
    // WebAssembly
    // Set Variables in Class
    setMyProjectConfigurationClass(TabWebAssembly);
    mySqlDb->saveConfiguration();
    // IOS
    // Set Variables in Class
    setMyProjectConfigurationClass(TabIOS);
    mySqlDb->saveConfiguration();
    // Windows
    // Set Variables in Class
    setMyProjectConfigurationClass(TabWindows);
    mySqlDb->saveConfiguration();
    // Defaults
    // Set Variables in Class
    setMyProjectConfigurationClass(TabDefaults);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Settings Add clicked.
 * on_pushButtonSettingsAdd_clicked
 ***********************************************/
void MainWindow::on_pushButtonSettingsAdd_clicked()
{

    if (mySqlDb->isProjectQuery(ui->lineEditSettingsQtProject->text()))
    {
        QString theMessage = QString("Record found in database: %1").arg(ui->lineEditSettingsQtProject->text());
        mySqlDb->mySqlModel->mySetting->showMessageBox("Record found!", theMessage.toLocal8Bit(), mySqlDb->mySqlModel->mySetting->Warning);
        return;
    }
    //
    setMyProjectConfigurationClass(TabSettings);
    if (!mySqlDb->addProject())
    {
        return;
    }
    ui->labelRecordIdSettings->setText(mySqlDb->getProjectID());
    // Ubuntu
    if (ui->checkBoxSettingsUbuntu->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabUbuntu);
        mySqlDb->addConfiguration();
    }
    // Mac
    if (ui->checkBoxSettingsMac->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabMac);
        mySqlDb->addConfiguration();
    }
    // Android
    if (ui->checkBoxSettingsAndroid->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabAndroid);
        mySqlDb->addConfiguration();
    }
    // WebAssembly
    if (ui->checkBoxSettingsWebAssembly->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabWebAssembly);
        mySqlDb->addConfiguration();
    }
    // IOS
    if (ui->checkBoxSettingsiOS->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabIOS);
        mySqlDb->addConfiguration();
    }
    // Windows
    if (ui->checkBoxSettingsWindows->isChecked())
    {
        // Set Variables in Class
        setMyProjectConfigurationClass(TabWindows);
        mySqlDb->addConfiguration();
    }
    // Defaults
    // Set Variables in Class
    setMyProjectConfigurationClass(TabDefaults);
    mySqlDb->addConfiguration();
    setQtProjectCombo();
}
/************************************************
 * @brief on pushButton Save SQL clicked.
 * on_pushButtonSaveSql_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveSql_clicked()
{
    setMyProjectConfigurationClass(TabSql);
}
/************************************************
 * @brief on pushButton Save Ubuntu clicked.
 * on_pushButtonSaveUbuntu_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveUbuntu_clicked()
{
    setMyProjectConfigurationClass(TabUbuntu);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save Mac clicked.
 * on_pushButtonSaveMac_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveMac_clicked()
{
    setMyProjectConfigurationClass(TabMac);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save Android clicked.
 * on_pushButtonSaveAndroid_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveAndroid_clicked()
{
    setMyProjectConfigurationClass(TabAndroid);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save WebAssembly clicked.
 * on_pushButtonSaveWebAssembly_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveWebAssembly_clicked()
{
    setMyProjectConfigurationClass(TabWebAssembly);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save IOS clicked.
 * on_pushButtonSaveIOS_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveIOS_clicked()
{
    setMyProjectConfigurationClass(TabIOS);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save Windows clicked.
 * on_pushButtonSaveWindows_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveWindows_clicked()
{
    setMyProjectConfigurationClass(TabWindows);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief on pushButton Save Defaults clicked.
 * on_pushButtonSaveDefaults_clicked
 ***********************************************/
void MainWindow::on_pushButtonSaveDefaults_clicked()
{
    setMyProjectConfigurationClass(TabDefaults);
    mySqlDb->saveConfiguration();
}
/************************************************
 * @brief set Messaging States.
 * @param thisMessageState bool Message State
 * setMessagingStates
 ***********************************************/
void MainWindow::setMessagingStates(bool thisMessageState)
{
    if (thisMessageState)
    {
        isDebugMessage = true;
        mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_IS_DEBUG_MESSAGE, "true");
        mySqlDb->setDebugMessage(true);
        mySqlDb->mySqlModel->setDebugMessage(true);
        mySqlDb->mySqlModel->mySetting->setDebugMessage(true);
        mySqlDb->mySqlModel->mySetting->myCrypto->setDebugMessage(true);
    }
    else
    {
        isDebugMessage = false;
        mySqlDb->mySqlModel->mySetting->writeSettings(mySqlDb->mySqlModel->mySetting->myConstants->MY_IS_DEBUG_MESSAGE, "false");
        mySqlDb->setDebugMessage(false);
        mySqlDb->mySqlModel->setDebugMessage(false);
        mySqlDb->mySqlModel->mySetting->setDebugMessage(false);
        mySqlDb->mySqlModel->mySetting->myCrypto->setDebugMessage(false);
    }
}
/************************************************
 * @brief on checkBox Settigns Messaging state Changed.
 * on_checkBoxSettignsMessaging_stateChanged
 ***********************************************/
void MainWindow::on_checkBoxSettignsMessaging_stateChanged(int thisCheckState)
{
    if (isMainLoaded)   { return; }
    if (isDebugMessage) { qDebug() << "on_checkBoxSettignsMessaging_stateChanged"; }
    if (thisCheckState == Qt::Checked)  { setMessagingStates(true);  }
    else                                { setMessagingStates(false); }
}
/*** ************************* End of File ***********************************/
