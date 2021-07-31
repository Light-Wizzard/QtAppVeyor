#include "MySqlDbtModel.h"
/******************************************************************************
* \class QtAppVeyorDataTable
*******************************************************************************/
MySqlDbtModel::MySqlDbtModel(QObject *parent)
{
    // MySettings Settings
    myOrgDomainSetting = new MyOrgSettings(parent);
    // Create Variable Trackers and Set to Empty
    myConfigurationVariables = new MyConfigurationClass("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
    myProjectVariables = new MyProjectClass("", "", "", "", "", "", "", "", "", "", "", "", "", "");
}
/******************************************************************************
* \fn ~QtAppVeyorDataTable
*******************************************************************************/
MySqlDbtModel::~MySqlDbtModel()
{
    if (myDb.isOpen()) { myDb.close(); }
}
/******************************************************************************
* \fn isDbTable
*******************************************************************************/
bool MySqlDbtModel::isDbTable(const QString &thisTable)
{
    if (isDebugMessage) qDebug() << "isDatabase";
    QStringList theTables = myDb.tables();
    if (theTables.contains(thisTable, Qt::CaseInsensitive))  { return true; }
    else                                                     { return false; }
}
/******************************************************************************
* \fn setSqlDatabase
*******************************************************************************/
void MySqlDbtModel::setSqlDatabase(QSqlDatabase thisDatabase)
{
    if (isDebugMessage) qDebug() << "setSqlDatabase";
    myDb = thisDatabase;
}
/******************************************************************************
* \fn getSqlDatabase
*******************************************************************************/
QSqlDatabase MySqlDbtModel::getSqlDatabase()
{
    if (isDebugMessage) qDebug() << "getSqlDatabase";
    return myDb;
}
/******************************************************************************
* \fn getSqlDriver
*******************************************************************************/
QString MySqlDbtModel::getSqlDriver()
{
    if (isDebugMessage) qDebug() << "getSqlDriver";
    return mySqlDriver;
}
/******************************************************************************
* \fn setSqlTableName
*******************************************************************************/
void MySqlDbtModel::setSqlTableName(const QString &thisTableName)
{
    if (isDebugMessage) qDebug() << "setSqlTableName";
    myTableName = thisTableName;
}
/******************************************************************************
* \fn getSqlTableName
*******************************************************************************/
QString MySqlDbtModel::getSqlTableName()
{
    if (isDebugMessage) qDebug() << "getSqlTableName";
    return myTableName;
}
/******************************************************************************
* \fn setSqlHostName
*******************************************************************************/
void MySqlDbtModel::setSqlHostName(const QString &thisHostName)
{
    if (isDebugMessage) qDebug() << "setSqlHostName";
    myHostName = thisHostName;
}
/******************************************************************************
* \fn getSqlHostName
*******************************************************************************/
QString MySqlDbtModel::getSqlHostName()
{
    if (isDebugMessage) qDebug() << "getSqlHostName";
    return myHostName;
}
/******************************************************************************
* \fn setSqlUserName
*******************************************************************************/
void MySqlDbtModel::setSqlUserName(const QString &thisUserName)
{
    if (isDebugMessage) qDebug() << "setSqlUserName";
    myUserName = thisUserName;
}
/******************************************************************************
* \fn getSqlUserName
*******************************************************************************/
QString MySqlDbtModel::getSqlUserName()
{
    if (isDebugMessage) qDebug() << "getSqlUserName";
    return myUserName;
}
/******************************************************************************
* \fn setSqlDatabaseName
*******************************************************************************/
void MySqlDbtModel::setSqlDatabaseName(const QString &thisPassword)
{
    if (isDebugMessage) qDebug() << "setSqlDatabaseName";
    myDatabaseName = thisPassword;
}
/******************************************************************************
* \fn getSqlDatabaseName
*******************************************************************************/
QString MySqlDbtModel::getSqlDatabaseName()
{
    if (isDebugMessage) qDebug() << "getSqlDatabaseName";
    return myDatabaseName;
}
/******************************************************************************
* \fn setSqlPassword
*******************************************************************************/
void MySqlDbtModel::setSqlPassword(const QString &thisPassword)
{
    if (isDebugMessage) qDebug() << "setSqlPassword";
    myPassword = thisPassword;
}
/******************************************************************************
* \fn getSqlPassword
*******************************************************************************/
QString MySqlDbtModel::getSqlPassword()
{
    if (isDebugMessage) qDebug() << "getSqlPassword";
    return myPassword;
}
/******************************************************************************
* \fn setConnectionName
*******************************************************************************/
void MySqlDbtModel::setConnectionName(const QString &thisConnectionName)
{
    if (isDebugMessage) qDebug() << "setConnectionName";
    myConnectionName = thisConnectionName;
}
/******************************************************************************
* \fn getConnectionName
*******************************************************************************/
QString MySqlDbtModel::getConnectionName()
{
    if (isDebugMessage) qDebug() << "getConnectionName";
    return myConnectionName;
}
/******************************************************************************
* \fn setComboBoxSqlValue
*******************************************************************************/
void MySqlDbtModel::setComboBoxSqlValue(const QString &thisComboBoxSqlValue)
{
    myComboBoxSqlValue = thisComboBoxSqlValue;
}
/******************************************************************************
* \fn getComboBoxSqlValue
*******************************************************************************/
QString MySqlDbtModel::getComboBoxSqlValue()
{
    return myComboBoxSqlValue;
}
/******************************************************************************
* \fn setProjectID
*******************************************************************************/
void MySqlDbtModel::setProjectID(const QString &thisProjectID)
{
    myProjectID = thisProjectID;
}
/******************************************************************************
* \fn getProjectID
*******************************************************************************/
QString MySqlDbtModel::getProjectID()
{
    return myProjectID;
}
/******************************************************************************
* \fn setSqlDriver
* setSqlDriver(":memory:");
*******************************************************************************/
void MySqlDbtModel::setSqlDriver(const QString &thisDriver)
{
    if (isDebugMessage) qDebug() << "setSqlDriver";
    QString theDriver = thisDriver;
    if (theDriver.length() == 0)  { theDriver = myOrgDomainSetting->myConstants->MY_SQL_DEFAULT; }
    // Check for Database memory setting
    // ui->checkBoxSettingsMemory->isChecked() || combobox
    // Database Driver
    if (theDriver == ":memory:")
    {
        // SQLite version 3 SQLite version 2 Note: obsolete since Qt 5.14
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QSQLITE" || theDriver == "QSQLITE2")
    {
        // SQLite version 3 SQLite version 2 Note: obsolete since Qt 5.14
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QMYSQL" || theDriver == "MARIADB")
    {
        // MySQL or MariaDB (version 5.0 and above)
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QPSQL")
    {
        // PostgreSQL (versions 7.3 and above)
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QDB2")
    {
        // IBM DB2 (version 7.1 and above)
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QIBASE")
    {
        // Borland InterBase
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QOCI")
    {
        // Oracle Call Interface Driver
        mySqlDriver = theDriver;
    }
    else if (theDriver == "QTDS")
    {
        // Sybase Adaptive Server - Note: obsolete since Qt 4.7
        mySqlDriver = theDriver;
    }
    else
    {
        mySqlDriver = theDriver;
    }
}
/******************************************************************************
* \fn createDataBaseConnection
*******************************************************************************/
bool MySqlDbtModel::createDataBaseConnection()
{
    if (isDebugMessage) qDebug() << "createDataBaseConnection";
    // Make sure Drive is set
    if (mySqlDriver == "NOTSET") { setSqlDriver(myOrgDomainSetting->myConstants->MY_SQL_DEFAULT); }
    QString theDb = getSqlDatabaseName();
    // Database Driver
    if (mySqlDriver == ":memory:")
    {
        myDb = QSqlDatabase::addDatabase("QSQLITE"); //!< set myDb SQLite
        myDb.setDatabaseName(":memory:");
    }
    else
    {
        if (mySqlDriver == "QSQLITE" || mySqlDriver == "QSQLITE2")
        {   //!< set myDb QSQLITE or QSQLITE2
            // SQLite version 3 and SQLite version 2 Note: obsolete since Qt 5.14
            if (theDb.contains(".db"))
            {
                if (!myOrgDomainSetting->isFileExists(theDb))
                {
                    qDebug() << "createDataBaseConnection new DB: " << theDb;
                }
            }
            else
            {
                theDb = QString("%1%2%3.db").arg(myOrgDomainSetting->getAppDataLocation(), QDir::separator(), getSqlDatabaseName());
            }
            //
            myDb = QSqlDatabase::addDatabase(mySqlDriver); //!< set myDb SQLite
            myDb.setDatabaseName(theDb);
            //    myDb.setHostName(getSqlHostName());
            //    myDb.setUserName(getSqlUserName());
            //    myDb.setPassword(getSqlPassword());
            //
        }
        else if (mySqlDriver == "QDB2")
        {   //!< set myDb QDB2
            // IBM DB2 (version 7.1 and above)
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
        else if (mySqlDriver == "QIBASE")
        {   //!< set myDb QIBASE
            // Borland InterBase
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
        else if (mySqlDriver == "QMYSQL" || mySqlDriver == "MARIADB")
        {   //!< set myDb QMYSQL or MARIADB
            // MySQL or MariaDB (version 5.0 and above)
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
        else if (mySqlDriver == "QOCI")
        {   //!< set myDb QOCI
            // Oracle Call Interface Driver
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
        else if (mySqlDriver == "QPSQL")
        {   //!< set myDb QPSQL
            // PostgreSQL (versions 7.3 and above)
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
        else if (mySqlDriver == "QTDS")
        {   //!< set myDb QTDS
            // Sybase Adaptive Server - Note: obsolete since Qt 4.7
            myDb = QSqlDatabase::addDatabase(mySqlDriver, myConnectionName);
            myDb.setHostName(getSqlHostName());
            myDb.setDatabaseName(getSqlDatabaseName());
            myDb.setUserName(getSqlUserName());
            myDb.setPassword(getSqlPassword());
        }
    } // end ! if (:memory:)
    if (!myDb.open())
    {
        if(!QSqlDatabase::isDriverAvailable(mySqlDriver))
        { QMessageBox::critical(nullptr, QObject::tr("Database SQL Driver is missing"), QObject::tr("Install SQL"), QMessageBox::Cancel); return false; }
        else
        { QMessageBox::critical(nullptr, QObject::tr("Cannot open database: %1").arg(myDb.lastError().text()), QObject::tr("Unable to establish a database connection.\nClick Cancel to exit."), QMessageBox::Cancel); return false; }
    }
    // Set Settings
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_NAME, theDb);
    myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_DB_TYPE, "QSQLITE");
    return true;
} // end createDataBaseConnection
/******************************************************************************
* \fn checkDatabase
*******************************************************************************/
bool MySqlDbtModel::checkDatabase()
{
    if (isDebugMessage) { qDebug() << "checkDatabase"; }
    // Database
    setSqlDriver(myComboBoxSqlValue);
    if (! createDataBaseConnection()) { return false; }
    //
    // Configuration
    //
    if (!isDbTable("Projects"))
    {
        // Table Projects holds the name of the Qt Project
        /*
         * QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsOsWebAssembly, IsOSiOS, IsX64, IsX86, IsDebug, IsRelease
         * id integer PRIMARY KEY autoincrement,
         * QtProject varchar,
         * Secret varchar,
         * IsOsUbuntu varchar,
         * IsOsMac varchar,
         * IsOsWindows varchar,
         * IsOsAndroid varchar,
         * IsOsWebAssembly varchar,
         * IsOSiOS varchar,
         * IsX64 varchar,
         * IsX86 varchar,
         * IsDebug varchar,
         * IsRelease varchar
        */
        if (runQuery(QLatin1String(R"(CREATE TABLE Projects(id integer PRIMARY KEY autoincrement, QtProject varchar, Secret varchar, Environment varchar, IsOsUbuntu varchar, IsOsMac varchar, IsOsWebAssembly varchar, IsOSiOS varchar, IsOsWindows varchar, IsOsAndroid varchar, IsX64 varchar, IsX86 varchar, IsDebug varchar, IsRelease varchar))")))
        {
            setProject(myOrgDomainSetting->myConstants->MY_PROJECT_QT, myOrgDomainSetting->myConstants->MY_PROJECT_SECRET, myOrgDomainSetting->myConstants->MY_PROJECT_ENVIRONMENT, myOrgDomainSetting->myConstants->MY_PROJECT_UBUNTU, myOrgDomainSetting->myConstants->MY_PROJECT_MAC, myOrgDomainSetting->myConstants->MY_PROJECT_WINDOWS, myOrgDomainSetting->myConstants->MY_PROJECT_ANDROID, myOrgDomainSetting->myConstants->MY_PROJECT_WEB_ASSEMBLY, myOrgDomainSetting->myConstants->MY_PROJECT_IOS, myOrgDomainSetting->myConstants->MY_PROJECT_X64, myOrgDomainSetting->myConstants->MY_PROJECT_X86, myOrgDomainSetting->myConstants->MY_PROJECT_DEBUG, myOrgDomainSetting->myConstants->MY_PROJECT_RELEASE);
            if (insertProjects())
            {
                myProjectID = myInsertID;
                myOrgDomainSetting->writeSettings(myOrgDomainSetting->myConstants->MY_SQL_PROJECT_ID, myProjectID);
                //
                if (runQuery(QLatin1String(R"(CREATE TABLE Configuration(id integer PRIMARY KEY autoincrement, ProjectsID varchar, OS varchar, QtVersion varchar, VsVersion varchar, QtIfVersion varchar, QtIfPackageUri varchar, PythonVersion varchar, PythonRequired varchar, QtMingW32 varchar, QtMingW64 varchar, QtToolsMingW32 varchar, QtToolsMingW64 varchar, VisualStudio varchar, OsUpgrade varchar))")))
                {
                    //
                    /*
                     * id integer PRIMARY KEY autoincrement,
                     * ProjectsID varchar,
                     * OS varchar,
                     * QtVersion varchar,
                     * VsVersion varchar,
                     * QtIfVersion varchar,
                     * QtIfPackageUri varchar,
                     * PythonVersion varchar,
                     * PythonRequired varchar,
                     * QtMingW32 varchar,
                     * QtMingW64 varchar,
                     * QtToolsMingW32 varchar,
                     * QtToolsMingW64 varchar,
                     * VisualStudio varchar,
                     * OsUpgrade varchar
                     */
                    // Ubuntu
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_UBUNTU, myOrgDomainSetting->myConstants->MY_UBUNTU_QT_VERSION, myOrgDomainSetting->myConstants->MY_UBUNTU_VS_VERSION, myOrgDomainSetting->myConstants->MY_UBUNTU_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_UBUNTU_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_UBUNTU_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_UBUNTU_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_UBUNTU_MINGW32, myOrgDomainSetting->myConstants->MY_UBUNTU_MINGW64, myOrgDomainSetting->myConstants->MY_UBUNTU_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_UBUNTU_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_UBUNTU_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_UBUNTU_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // Mac
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_MAC, myOrgDomainSetting->myConstants->MY_MAC_QT_VERSION, myOrgDomainSetting->myConstants->MY_MAC_VS_VERSION, myOrgDomainSetting->myConstants->MY_MAC_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_MAC_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_MAC_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_MAC_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_MAC_MINGW32, myOrgDomainSetting->myConstants->MY_MAC_MINGW64, myOrgDomainSetting->myConstants->MY_MAC_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_MAC_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_MAC_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_MAC_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // Android
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_ANDROID, myOrgDomainSetting->myConstants->MY_ANDROID_QT_VERSION, myOrgDomainSetting->myConstants->MY_ANDROID_VS_VERSION, myOrgDomainSetting->myConstants->MY_ANDROID_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_ANDROID_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_ANDROID_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_ANDROID_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_ANDROID_MINGW32, myOrgDomainSetting->myConstants->MY_ANDROID_MINGW64, myOrgDomainSetting->myConstants->MY_ANDROID_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_ANDROID_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_ANDROID_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_ANDROID_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // WEBASSEMBLY
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_WEBASSEMBLY, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_QT_VERSION, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_VS_VERSION, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_MINGW32, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_MINGW64, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_WEBASSEMBLY_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // IOS
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_IOS, myOrgDomainSetting->myConstants->MY_IOS_QT_VERSION, myOrgDomainSetting->myConstants->MY_IOS_VS_VERSION, myOrgDomainSetting->myConstants->MY_IOS_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_IOS_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_IOS_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_IOS_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_IOS_MINGW32, myOrgDomainSetting->myConstants->MY_IOS_MINGW64, myOrgDomainSetting->myConstants->MY_IOS_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_IOS_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_IOS_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_IOS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // Windows
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_WINDOWS, myOrgDomainSetting->myConstants->MY_WINDOWS_QT_VERSION, myOrgDomainSetting->myConstants->MY_WINDOWS_VS_VERSION, myOrgDomainSetting->myConstants->MY_WINDOWS_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_WINDOWS_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_WINDOWS_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_WINDOWS_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_WINDOWS_MINGW32, myOrgDomainSetting->myConstants->MY_WINDOWS_MINGW64, myOrgDomainSetting->myConstants->MY_WINDOWS_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_WINDOWS_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_WINDOWS_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_WINDOWS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                    // Defaults
                    setConfiguration("", myProjectID, myOrgDomainSetting->myConstants->MY_OS_NAME_DEFAULTS, myOrgDomainSetting->myConstants->MY_DEFAULTS_QT_VERSION, myOrgDomainSetting->myConstants->MY_DEFAULTS_VS_VERSION, myOrgDomainSetting->myConstants->MY_DEFAULTS_QTIF_VERSION, myOrgDomainSetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER, myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_VERSION, myOrgDomainSetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED, myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32, myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64, myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS, myOrgDomainSetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS, myOrgDomainSetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO, myOrgDomainSetting->myConstants->MY_DEFAULTS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qDebug() << "Error INSERT Configuration";
                    }
                } // end if (createDb("CREATE TABLE Configuration
            }
            else
            {
                qDebug() << getSqlDriver() <<  "  INSERT TABLE Projects error:";
            }
        }
        //
    } // end if (!isDbTable("Projects"))
    //
    return true;
}
/******************************************************************************
* \fn runQuery
* Set myInsertID, returns true or false
*******************************************************************************/
bool MySqlDbtModel::runQuery(const QString &thisQuery)
{
    if (isDebugMessage) { qDebug() << "runQuery=" << thisQuery; }
    QSqlQuery theQuery; //!< SQL Query
    if (theQuery.exec(thisQuery))
    {
        myInsertID = theQuery.lastInsertId().toString();
        return true;
    }
    else
    {
        qDebug() << "Error running Query: " << thisQuery << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
        myInsertID = "-1";
        return false;
    }
}
/******************************************************************************
* \fn insertProjects
* insertProjects(const QString &thisQtProject, const QString &thisSecret, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease);         //!< insertConfigurations
*******************************************************************************/
bool MySqlDbtModel::insertProjects()
{
    if (isDebugMessage) { qDebug() << "insertProjects"; }
    // QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
    QString theQuery = QLatin1String(R"(INSERT INTO Projects (QtProject, Secret, Environment, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsOsWebAssembly, IsOSiOS, IsX64, IsX86, IsDebug, IsRelease) values('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9', '%10', '%11', '%12', '%13'))").arg(myProjectVariables->getQtProject(), myProjectVariables->getSecret(), myProjectVariables->getEnvironment(), myProjectVariables->getIsOsUbuntu(), myProjectVariables->getIsOsMac(), myProjectVariables->getIsOsWindows(), myProjectVariables->getIsOsAndroid(), myProjectVariables->getIsOsWebAssembly(), myProjectVariables->getIsOSiOS(), myProjectVariables->getIsX64(), myProjectVariables->getIsX86(), myProjectVariables->getIsDebug(), myProjectVariables->getIsRelease());
    if (isDebugMessage) { qDebug() << "insertProjects: " << theQuery; }
    //
    if (!runQuery(theQuery))
    {
        qDebug() << "INSERT Projects error: " << theQuery;
        return false;
    }
    myProjectID = myInsertID;
    myConfigurationVariables->setProjectsID(myInsertID);
    return true;
}
/******************************************************************************
* \fn insertConfiguration
* INSERT INTO Configuration
* ProjectsID varchar, OS varchar, QtVersion varchar, VsVersion varchar, QtIfVersion varchar, QtIfPackageUri varchar, PythonVersion varchar, PythonRequired varchar, QtMingW32 varchar, QtMingW64 varchar, QtToolsMingW32 varchar, QtToolsMingW64 varchar
*******************************************************************************/
bool MySqlDbtModel::insertConfiguration()
{
    if (isDebugMessage) { qDebug() << "insertConfiguration"; }
    QString myQuery = QString("INSERT INTO Configuration (ProjectsID, OS, QtVersion, VsVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade) VALUES('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9', '%10', '%11', '%12', '%13', '%14')").arg(myConfigurationVariables->getProjectsID(), myConfigurationVariables->getOS(), myConfigurationVariables->getQtVersion(), myConfigurationVariables->getVsVersion(), myConfigurationVariables->getQtIfVersion(), myConfigurationVariables->getQtIfPackageUri(), myConfigurationVariables->getPythonVersion(), myConfigurationVariables->getPythonRequired(), myConfigurationVariables->getQtMingW32(), myConfigurationVariables->getQtMingW64(), myConfigurationVariables->getQtToolsMingW32(), myConfigurationVariables->getQtToolsMingW64(), myConfigurationVariables->getVisualStudio(), myConfigurationVariables->getOsUpgrade());
    if (isDebugMessage) { qDebug() << "insertConfiguration: " << myQuery; }
    //
    if (!runQuery(myQuery))
    {
        qDebug() << "INSERT Configuration error: " << myQuery;
        return false;
    }
    return true;
}
/******************************************************************************
* \fn addProject
* Assumes you have ran setProject
* Projects: QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
* Configuration: ProjectsID, OS, QtVersion, VsVersion varchar, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
*******************************************************************************/
bool MySqlDbtModel::addProject()
{
    // SELECT id, QtProject FROM Projects WHERE QtProject =
    if (isProjectQuery(myProjectVariables->getQtProject()))
    {
        QString theMessage = QString("Not adding: Record found in database: %1").arg(myProjectVariables->getQtProject());
        myOrgDomainSetting->showMessageBox("Record found!", theMessage.toLocal8Bit(), "warning");
        return false;
    }
    return insertProjects();
}
/******************************************************************************
* \fn addConfiguration
* Assumes you have ran setMyConfigurationClass
* Projects: QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
* Configuration: ProjectsID, OS, QtVersion, VsVersion varchar, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
*******************************************************************************/
void MySqlDbtModel::addConfiguration()
{
    if (isDebugMessage) qDebug() << "onAddConfiguration";
    QSqlQuery theQuery; //!< SQL Query

    // Check the Configuration table and exist if record found
    QString myConfigurationSelectQuery = getConfigurationProjectIdOsSelectQuery(myConfigurationVariables->getProjectsID(), myConfigurationVariables->getOS());
    if (isDebugMessage) qDebug() << "myConfigurationSelectQuery: " << myConfigurationSelectQuery;
    if (theQuery.exec(myConfigurationSelectQuery))
    {
        if (theQuery.first())
        {
            QMessageBox::critical(nullptr, QObject::tr("Record already exists in Database"), QObject::tr("Unable to add this record to databasen.\nClick Cancel to exit."), QMessageBox::Cancel);
            return;
        }
    }
    else
    {
        qDebug() << "SqLite error onAddConfiguration:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    //
    insertConfiguration();
}
/******************************************************************************
* \fn deleteConfiguration
*******************************************************************************/
void MySqlDbtModel::deleteConfiguration(const QString &thisID)
{
    if (isDebugMessage) qDebug() << "onDeleteConfiguration";
    QSqlQuery query; //!< SQL Query
    QString theQuery = QString("DELETE FROM Projects WHERE id = ").append(thisID);
    qDebug() << "thisQuery: " << theQuery;
    if (!query.exec(theQuery))
    {
        qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
    // FIXME Delete from both tables
    theQuery = QString("DELETE FROM Configuration WHERE ProjectsID = '").append(thisID).append("'");
    qDebug() << "thisQuery: " << theQuery;
    if (!query.exec(theQuery))
    {
        qDebug() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
}
/******************************************************************************
 * \fn getQtProjectSelectQuery
 * SELECT id, QtProject FROM Projects
 *******************************************************************************/
QString MySqlDbtModel::getQtProjectSelectQuery()
{
    if (isDebugMessage) qDebug() << "getQtProjectSelectQuery";
    return QString("SELECT id, QtProject FROM Projects");
}
/******************************************************************************
 * \fn getQtProjectByNameQuery
 * SELECT id, QtProject FROM Projects WHERE QtProject =
 *******************************************************************************/
QString MySqlDbtModel::getQtProjectByNameQuery(const QString &thisProject)
{
    if (isDebugMessage) qDebug() << "getQtProjectByNameQuery";
    return QString("SELECT id, QtProject FROM Projects WHERE QtProject = '%1'").arg(thisProject);
}
/******************************************************************************
 * \fn isProjectQuery
 * myAccessSqlDbtModel->isProjectQuery(ui->lineEditSettingsProjectBin->text());
 *******************************************************************************/
bool MySqlDbtModel::isProjectQuery(const QString &thisProject)
{
    if (isDebugMessage) qDebug() << "getProjectsSelectQuery";
    QSqlQuery theQuery; //!< SQL Query
    QString theQueryCommand = getQtProjectByNameQuery(thisProject);
    if (theQuery.exec(theQueryCommand))
    {
        if (theQuery.first()) { return true;  }
        else                  { return false; }
    }
    else
    {
        qDebug() << "SqLite error isProjectQuery:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    return false;
}
/******************************************************************************
 * \fn getProjectsFullSelectQueryID
 * SELECT * FROM Projects WHERE id =
 *******************************************************************************/
QString MySqlDbtModel::getProjectsFullSelectQueryID(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getProjectsFullSelectQueryID";
    return QString("SELECT * FROM Projects WHERE id = ").append(thisWhereID);
}
/******************************************************************************
* \fn getProjectsSelectQueryID
* SELECT id, getQtProjectsSelectQueryID FROM Projects WHERE id
*******************************************************************************/
QString MySqlDbtModel::getQtProjectsSelectQueryID(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getQtProjectsSelectQueryID";
    return QString("SELECT id, QtProject FROM Projects WHERE id = ").append(thisWhereID);
}
/******************************************************************************
* \fn getConfigurationSelectQuery
* FROM Configuration WHERE id
*******************************************************************************/
QString MySqlDbtModel::getConfigurationSelectQuery(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getConfigurationSelectQuery";
    return QString("SELECT * FROM Configuration WHERE id = ").append(thisWhereID);
}
/******************************************************************************
* \fn getConfigurationProjectIdOsSelectQuery
* FROM Configuration WHERE ProjectsID = 'thisWhereID' AND OS = ''
*******************************************************************************/
QString MySqlDbtModel::getConfigurationProjectIdOsSelectQuery(const QString &thisWhereID, const QString &thisOS)
{
    if (isDebugMessage) qDebug() << "getConfigurationProjectIdOsSelectQuery";
    return QString("SELECT * FROM Configuration WHERE ProjectsID = '").append(thisWhereID).append("' AND OS = '").append(thisOS).append("'");
}
/******************************************************************************
* \fn getThisConfigurationSelectQuery
* FROM Configuration WHERE ProjectsID
*******************************************************************************/
QString MySqlDbtModel::getThisConfigurationProjectIDSelectQuery(const QString &thisProjectsID)
{
    if (isDebugMessage) qDebug() << "getThisConfigurationSelectQuery";
    return QString("SELECT * FROM Configuration WHERE ProjectsID = '").append(thisProjectsID).append("'");
}
/******************************************************************************
* \fn saveProject
* Projects: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
*******************************************************************************/
void MySqlDbtModel::saveProject()
{
    if (isDebugMessage) qDebug() << "saveProject";
    QSqlQuery theQuery; //!< SQL Query
    QString theQueryString = QString("UPDATE Projects set QtProject = '%1', Secret = '%2', Environment = '%3', IsOsUbuntu = '%4', IsOsMac = '%5', IsOsWebAssembly = '%6', IsOSiOS = '%7', IsOsWindows = '%8', IsOsAndroid = '%9', IsX64 ='%10', IsX86 = '%11', IsDebug = '%12', IsRelease = '%13' WHERE id = %14").arg(myProjectVariables->getQtProject(), myProjectVariables->getSecret(), myProjectVariables->getEnvironment(), myProjectVariables->getIsOsUbuntu(), myProjectVariables->getIsOsMac(), myProjectVariables->getIsOsWebAssembly(), myProjectVariables->getIsOSiOS(), myProjectVariables->getIsOsWindows(), myProjectVariables->getIsOsAndroid(), myProjectVariables->getIsX64(), myProjectVariables->getIsX86(), myProjectVariables->getIsDebug(), myProjectVariables->getIsRelease(), myProjectVariables->getID());
    if (isDebugMessage) qDebug() << "thisQuery: |" << theQueryString << "|  QtProject = " << myProjectVariables->getQtProject() << "| Secret=" << myProjectVariables->getSecret() << "| Environment=" << myProjectVariables->getEnvironment() << "| IsOsUbuntu=" << myProjectVariables->getIsOsUbuntu() << "| IsOsMac=" << myProjectVariables->getIsOsMac() << "| IsOsWebAssembly=" << myProjectVariables->getIsOsWebAssembly() << "| IsOSiOS=" << myProjectVariables->getIsOSiOS() << "| IsOsWindows=" << myProjectVariables->getIsOsWindows() << "| IsOsAndroid=" << myProjectVariables->getIsOsAndroid() << "| IsX64=" << myProjectVariables->getIsX64() << "| IsX86=" << myProjectVariables->getIsX86() << "| IsDebug=" << myProjectVariables->getIsDebug() << "| IsRelease=" << myProjectVariables->getIsRelease() << "| ID=" << myProjectVariables->getID() << "|";
    if (!theQuery.exec(theQueryString))
    {
        qDebug() << "SqLite error saveProject:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    isSaveSettings = false;
}
/******************************************************************************
* \fn saveConfiguration
* Configuration: ProjectsID, OS, QtVersion, VsVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
*******************************************************************************/
void MySqlDbtModel::saveConfiguration()
{
    if (isDebugMessage) qDebug() << "saveConfiguration";
    QSqlQuery theQuery; //!< SQL Query
    //                                                                                                                                                                                                                                       , , , , , ,
    QString theQueryString = QString("UPDATE Configuration set ProjectsID = '%1', OS = '%2', QtVersion = '%3', VsVersion = '%4', QtIfVersion = '%5', QtIfPackageUri = '%6', PythonVersion = '%7', PythonRequired = '%8', QtMingW32 = '%9', QtMingW64 ='%10', QtToolsMingW32 = '%11', QtToolsMingW64 = '%12', VisualStudio = '%13', OsUpgrade = '%14' WHERE id = %15").arg(myConfigurationVariables->getProjectsID(), myConfigurationVariables->getOS(), myConfigurationVariables->getQtVersion(), myConfigurationVariables->getVsVersion(), myConfigurationVariables->getQtIfVersion(), myConfigurationVariables->getQtIfPackageUri(), myConfigurationVariables->getPythonVersion(), myConfigurationVariables->getPythonRequired(), myConfigurationVariables->getQtMingW32(), myConfigurationVariables->getQtMingW64(), myConfigurationVariables->getQtToolsMingW32(), myConfigurationVariables->getQtToolsMingW64(), myConfigurationVariables->getVisualStudio(), myConfigurationVariables->getOsUpgrade(), myConfigurationVariables->getID());
    if (isDebugMessage) qDebug() << "thisQuery: " << theQueryString;
    if (!theQuery.exec(theQueryString))
    {
        qDebug() << "SqLite error saveConfiguration:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    isSaveSettings = false;
}
/******************************************************************************
* \fn setConfiguration
* Sets all Variables used in the Configuarion Database in one Place
*******************************************************************************/
void MySqlDbtModel::setConfiguration(const QString &thisID,const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisVsVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade)
{
    if (isDebugMessage) qDebug() << "setConfiguration";
    // Common
    myConfigurationVariables->setID(thisID);                          // ID is per record for Update
    myConfigurationVariables->setProjectsID(thisProjectsID);          // ProjectID is per Project id
    myConfigurationVariables->setOS(thisOS);                          // OS: Ubuntu, Android, WebAssembly, Mac, iOs, Windows, and Default
    myConfigurationVariables->setQtVersion(thisQtVersion);
    myConfigurationVariables->setVsVersion(thisVsVersion);
    myConfigurationVariables->setQtIfVersion(thisQtIfVersion);
    myConfigurationVariables->setQtIfPackageUri(thisQtIfPackageUri);
    myConfigurationVariables->setPythonVersion(thisPythonVersion);
    // Windows
    myConfigurationVariables->setQtMingW32(thisQtMingW32);
    myConfigurationVariables->setQtMingW64(thisQtMingW64);
    myConfigurationVariables->setQtToolsMingW32(thisQtToolsMingW32);
    myConfigurationVariables->setQtToolsMingW64(thisQtToolsMingW64);
    myConfigurationVariables->setVisualStudio(thisVisualStudio);
    myConfigurationVariables->setOsUpgrade(thisOsUpgrade);
    myConfigurationVariables->setPythonRequired(thisPythonRequired);
}
/******************************************************************************
* \fn setProject
* Sets all Variables used in the Configuarion Database in one Place
*******************************************************************************/
void MySqlDbtModel::setProject(const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease)
{
    if (isDebugMessage) qDebug() << "setProject";
    myProjectVariables->setQtProject(thisQtProject);
    myProjectVariables->setSecret(thisSecret);
    myProjectVariables->setEnvironment(thisEnvironment);
    myProjectVariables->setIsOsUbuntu(thisIsOsUbuntu);
    myProjectVariables->setIsOsMac(thisIsOsMac);
    myProjectVariables->setIsOsWindows(thisIsOsWindows);
    myProjectVariables->setIsOsAndroid(thisIsOsAndroid);
    myProjectVariables->setIsOsWebAssembly(thisIsOsWebAssembly);
    myProjectVariables->setIsOSiOS(thisIsOSiOS);
    myProjectVariables->setIsX64(thisIsX64);
    myProjectVariables->setIsX86(thisIsX86);
    myProjectVariables->setIsDebug(thisIsDebug);
    myProjectVariables->setIsRelease(thisIsRelease);
}
/******************************************************************************
* \fn moveDb
*
*******************************************************************************/
bool MySqlDbtModel::moveDb(const QString &thisSourceFile,const QString &thisSourcePath, const QString &thisDestinationFolder)
{
    if (isDebugMessage) qDebug() << "moveDb";

    QFile file(QString("%1%2%3").arg(thisSourcePath, QDir::separator(), thisSourceFile));
    //
    QString theNewDatabaseName = QString("%1%2%3").arg(thisDestinationFolder, QDir::separator(), thisSourceFile);
    //
    if (myOrgDomainSetting->isFileExists(theNewDatabaseName))
    {
        if (!myOrgDomainSetting->questionYesNo("Overwrite Database", "Are you sure you want to overwrite existing Database?"))
        {
            return true;
        }
    }
    //
    if (myDb.isOpen()) { myDb.close(); }
    if (file.rename(theNewDatabaseName))
    {
        myDatabaseName = theNewDatabaseName;
        return createDataBaseConnection();
    }
    else { return true; }
}
/*** ************************* End of File ***********************************/
