#include "MyDatatables.h"

/************************************************
 * @brief My Datatables Constructor.
 * MyDatatables
 ***********************************************/
MyDatatables::MyDatatables(QObject *parent) : QObject(parent)
{
    mySqlModel = new MySqlDbtModel(this);
    // Create Variable Trackers and Set to Empty
    myProject = new MyProjectClass("", "", "", "", "", "", "", "", "", "", "", "", "", "");
    // Create Variable Trackers and Set to Empty
    myConfigurationVariables = new MyConfigurationClass("", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
}
/************************************************
 * @brief My Datatables Deconstructor.
 * MyDatatables
 ***********************************************/
MyDatatables::~MyDatatables()
{

}
/************************************************
 * @brief set Debug Message.
 * setDebugMessage
 ***********************************************/
void MyDatatables::setDebugMessage(bool thisState)
{
    isDebugMessage = thisState;
    if (isDebugMessage) { qDebug() << "setDebugMessage"; }
}
/************************************************
 * @brief get Debug Message.
 * getDebugMessage
 ***********************************************/
bool MyDatatables::getDebugMessage()
{
    if (isDebugMessage) { qDebug() << "getDebugMessage"; }
    return isDebugMessage;
}
/************************************************
 * @brief set Project Folder.
 * setProjectFolder
 ***********************************************/
void MyDatatables::setProjectFolder(const QString &thisProjectFolder)
{
    if (isDebugMessage) { qDebug() << "setProjectFolder"; }
    myProjectFolder = thisProjectFolder;
}
/************************************************
 * @brief get Project Folder.
 * getProjectFolder
 ***********************************************/
QString MyDatatables::getProjectFolder()
{
    if (isDebugMessage) { qDebug() << "getProjectFolder"; }
    return myProjectFolder;
}
/************************************************
 * @brief set Project Name.
 * setProjectName
 ***********************************************/
void MyDatatables::setProjectName(const QString &thisProjectName)
{
    if (isDebugMessage) { qDebug() << "setProjectName"; }
    myProjectName = thisProjectName;
}
/************************************************
 * @brief get Project Name.
 * getProjectName
 ***********************************************/
QString MyDatatables::getProjectName()
{
    if (isDebugMessage) { qDebug() << "getProjectName"; }
    return myProjectName;
}
/************************************************
 * @brief set Project ID.
 * setProjectID
 ***********************************************/
void MyDatatables::setProjectID(const QString &thisProjectID)
{
    if (isDebugMessage) { qDebug() << "setProjectID"; }
    myProjectID = thisProjectID;
}
/************************************************
 * @brief get Project ID.
 * getProjectID
 ***********************************************/
QString MyDatatables::getProjectID()
{
    if (isDebugMessage) { qDebug() << "getProjectID"; }
    return myProjectID;
}
/************************************************
 * @brief set ComboBox SQL Value.
 * setComboBoxSqlValue
 ***********************************************/
void MyDatatables::setComboBoxSqlValue(const QString &thisComboBoxSqlValue)
{
    if (isDebugMessage) { qDebug() << "setComboBoxSqlValue"; }
    myComboBoxSqlValue = thisComboBoxSqlValue;
}
/************************************************
 * @brief get ComboBox SQL Value.
 * getComboBoxSqlValue
 ***********************************************/
QString MyDatatables::getComboBoxSqlValue()
{
    if (isDebugMessage) { qDebug() << "getComboBoxSqlValue"; }
    return myComboBoxSqlValue;
}
/************************************************
 * @brief check Database.
 * checkDatabase
 ***********************************************/
bool MyDatatables::checkDatabase()
{
    if (isDebugMessage) { qDebug() << "checkDatabase"; }
    // Database
    mySqlModel->setSqlDriver(myComboBoxSqlValue);
    if (!mySqlModel->createDataBaseConnection()) { return false; }
    //
    // Configuration
    //
    if (!mySqlModel->isDbTable("Projects"))
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
        if (mySqlModel->runQuery(QLatin1String(R"(CREATE TABLE Projects(id integer PRIMARY KEY autoincrement, QtProject varchar, Secret varchar, Environment varchar, IsOsUbuntu varchar, IsOsMac varchar, IsOsWebAssembly varchar, IsOSiOS varchar, IsOsWindows varchar, IsOsAndroid varchar, IsX64 varchar, IsX86 varchar, IsDebug varchar, IsRelease varchar))")))
        {

            QString theQtProjectName   = mySqlModel->mySetting->myConstants->MY_PROJECT_QT;
            QString theQtProjectSecret = mySqlModel->mySetting->myConstants->MY_PROJECT_SECRET;
            QString theProjectEnv      = mySqlModel->mySetting->myConstants->MY_PROJECT_ENVIRONMENT;
            QString theProjectUbuntu   = mySqlModel->mySetting->myConstants->MY_PROJECT_UBUNTU;
            QString theProjectMac      = mySqlModel->mySetting->myConstants->MY_PROJECT_MAC;
            QString theProjectWindows  = mySqlModel->mySetting->myConstants->MY_PROJECT_WINDOWS;
            QString theProjectAndroid  = mySqlModel->mySetting->myConstants->MY_PROJECT_ANDROID;
            QString theProjectWebAss   = mySqlModel->mySetting->myConstants->MY_PROJECT_WEB_ASSEMBLY;
            QString theProjectIOS      = mySqlModel->mySetting->myConstants->MY_PROJECT_IOS;
            QString theProjectX64      = mySqlModel->mySetting->myConstants->MY_PROJECT_X64;
            QString theProjectX86      = mySqlModel->mySetting->myConstants->MY_PROJECT_X86;
            QString theProjectDebug    = mySqlModel->mySetting->myConstants->MY_PROJECT_DEBUG;
            QString theProjectRelease  = mySqlModel->mySetting->myConstants->MY_PROJECT_RELEASE;

            setProject(theQtProjectName, theQtProjectSecret, theProjectEnv, theProjectUbuntu, theProjectMac, theProjectWindows, theProjectAndroid, theProjectWebAss, theProjectIOS, theProjectX64, theProjectX86, theProjectDebug, theProjectRelease);
            if (insertProjects())
            {
                myProjectID = mySqlModel->getRecordID();
                mySqlModel->mySetting->writeSettings(mySqlModel->mySetting->myConstants->MY_SQL_PROJECT_ID, myProjectID);
                //
                if (mySqlModel->runQuery(QLatin1String(R"(CREATE TABLE Configuration(id integer PRIMARY KEY autoincrement, ProjectsID varchar, OS varchar, QtVersion varchar, VsVersion varchar, QtIfVersion varchar, QtIfPackageUri varchar, PythonVersion varchar, PythonRequired varchar, QtMingW32 varchar, QtMingW64 varchar, QtToolsMingW32 varchar, QtToolsMingW64 varchar, VisualStudio varchar, OsUpgrade varchar))")))
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
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_UBUNTU, mySqlModel->mySetting->myConstants->MY_UBUNTU_QT_VERSION, mySqlModel->mySetting->myConstants->MY_UBUNTU_VS_VERSION, mySqlModel->mySetting->myConstants->MY_UBUNTU_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_UBUNTU_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_UBUNTU_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_UBUNTU_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_UBUNTU_MINGW32, mySqlModel->mySetting->myConstants->MY_UBUNTU_MINGW64, mySqlModel->mySetting->myConstants->MY_UBUNTU_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_UBUNTU_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_UBUNTU_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_UBUNTU_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // Mac
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_MAC, mySqlModel->mySetting->myConstants->MY_MAC_QT_VERSION, mySqlModel->mySetting->myConstants->MY_MAC_VS_VERSION, mySqlModel->mySetting->myConstants->MY_MAC_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_MAC_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_MAC_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_MAC_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_MAC_MINGW32, mySqlModel->mySetting->myConstants->MY_MAC_MINGW64, mySqlModel->mySetting->myConstants->MY_MAC_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_MAC_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_MAC_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_MAC_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // Android
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_ANDROID, mySqlModel->mySetting->myConstants->MY_ANDROID_QT_VERSION, mySqlModel->mySetting->myConstants->MY_ANDROID_VS_VERSION, mySqlModel->mySetting->myConstants->MY_ANDROID_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_ANDROID_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_ANDROID_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_ANDROID_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_ANDROID_MINGW32, mySqlModel->mySetting->myConstants->MY_ANDROID_MINGW64, mySqlModel->mySetting->myConstants->MY_ANDROID_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_ANDROID_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_ANDROID_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_ANDROID_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // WEBASSEMBLY
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_WEBASSEMBLY, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_QT_VERSION, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_VS_VERSION, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_MINGW32, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_MINGW64, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_WEBASSEMBLY_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // IOS
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_IOS, mySqlModel->mySetting->myConstants->MY_IOS_QT_VERSION, mySqlModel->mySetting->myConstants->MY_IOS_VS_VERSION, mySqlModel->mySetting->myConstants->MY_IOS_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_IOS_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_IOS_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_IOS_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_IOS_MINGW32, mySqlModel->mySetting->myConstants->MY_IOS_MINGW64, mySqlModel->mySetting->myConstants->MY_IOS_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_IOS_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_IOS_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_IOS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // Windows
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_WINDOWS, mySqlModel->mySetting->myConstants->MY_WINDOWS_QT_VERSION, mySqlModel->mySetting->myConstants->MY_WINDOWS_VS_VERSION, mySqlModel->mySetting->myConstants->MY_WINDOWS_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_WINDOWS_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_WINDOWS_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_WINDOWS_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_WINDOWS_MINGW32, mySqlModel->mySetting->myConstants->MY_WINDOWS_MINGW64, mySqlModel->mySetting->myConstants->MY_WINDOWS_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_WINDOWS_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_WINDOWS_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_WINDOWS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                    // Defaults
                    setConfiguration("", myProjectID, mySqlModel->mySetting->myConstants->MY_OS_NAME_DEFAULTS, mySqlModel->mySetting->myConstants->MY_DEFAULTS_QT_VERSION, mySqlModel->mySetting->myConstants->MY_DEFAULTS_VS_VERSION, mySqlModel->mySetting->myConstants->MY_DEFAULTS_QTIF_VERSION, mySqlModel->mySetting->myConstants->MY_DEFAULTS_PACKAGE_FOLDER, mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_VERSION, mySqlModel->mySetting->myConstants->MY_DEFAULTS_PYTHON_REQUIRED, mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32, mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64, mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW32_TOOLS, mySqlModel->mySetting->myConstants->MY_DEFAULTS_MINGW64_TOOLS, mySqlModel->mySetting->myConstants->MY_DEFAULTS_VISUAL_STUIDIO, mySqlModel->mySetting->myConstants->MY_DEFAULTS_UPGRADE_OS);
                    if (!insertConfiguration())
                    {
                        qCritical() << "Error INSERT Configuration";
                    }
                } // end if (createDb("CREATE TABLE Configuration
            }
            else
            {
                qCritical() << mySqlModel->getSqlDriver() <<  "  INSERT TABLE Projects error:";
            }
        }
        //
    } // end if (!isDbTable("Projects"))
    //
    return true;
}
/******************************************************************************
 * @brief insertProjects.
 * insertProjects(const QString &thisQtProject, const QString &thisSecret, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease);         //!< insertConfigurations
 *******************************************************************************/
bool MyDatatables::insertProjects()
{
    if (isDebugMessage) { qDebug() << "insertProjects"; }
    // QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
    QString theQuery = QLatin1String(R"(INSERT INTO Projects (QtProject, Secret, Environment, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsOsWebAssembly, IsOSiOS, IsX64, IsX86, IsDebug, IsRelease) values('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9', '%10', '%11', '%12', '%13'))").arg(myProject->getQtProject(), myProject->getSecret(), myProject->getEnvironment(), myProject->getIsOsUbuntu(), myProject->getIsOsMac(), myProject->getIsOsWindows(), myProject->getIsOsAndroid(), myProject->getIsOsWebAssembly(), myProject->getIsOSiOS(), myProject->getIsX64(), myProject->getIsX86(), myProject->getIsDebug(), myProject->getIsRelease());
    if (isDebugMessage) { qDebug() << "insertProjects: " << theQuery; }
    //
    if (!mySqlModel->runQuery(theQuery))
    {
        qCritical() << "INSERT Projects error: " << theQuery;
        myProjectID = "-1";
        return false;
    }
    myProjectID = mySqlModel->getRecordID();
    myConfigurationVariables->setProjectsID(myProjectID);
    return true;
}
/******************************************************************************
 * @brief insert Configuration.
 * INSERT INTO Configuration
 * ProjectsID varchar, OS varchar, QtVersion varchar, VsVersion varchar, QtIfVersion varchar, QtIfPackageUri varchar, PythonVersion varchar, PythonRequired varchar, QtMingW32 varchar, QtMingW64 varchar, QtToolsMingW32 varchar, QtToolsMingW64 varchar
 *******************************************************************************/
bool MyDatatables::insertConfiguration()
{
    if (isDebugMessage) { qDebug() << "insertConfiguration"; }
    QString myQuery = QString("INSERT INTO Configuration (ProjectsID, OS, QtVersion, VsVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade) VALUES('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9', '%10', '%11', '%12', '%13', '%14')").arg(myConfigurationVariables->getProjectsID(), myConfigurationVariables->getOS(), myConfigurationVariables->getQtVersion(), myConfigurationVariables->getVsVersion(), myConfigurationVariables->getQtIfVersion(), myConfigurationVariables->getQtIfPackageUri(), myConfigurationVariables->getPythonVersion(), myConfigurationVariables->getPythonRequired(), myConfigurationVariables->getQtMingW32(), myConfigurationVariables->getQtMingW64(), myConfigurationVariables->getQtToolsMingW32(), myConfigurationVariables->getQtToolsMingW64(), myConfigurationVariables->getVisualStudio(), myConfigurationVariables->getOsUpgrade());
    if (isDebugMessage) { qDebug() << "insertConfiguration: " << myQuery; }
    //
    if (!mySqlModel->runQuery(myQuery))
    {
        qCritical() << "INSERT Configuration error: " << myQuery;
        return false;
    }
    return true;
}
/******************************************************************************
 * @brief add Project.
 * Assumes you have ran setProject
 * Projects: QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
 * Configuration: ProjectsID, OS, QtVersion, VsVersion varchar, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
 *******************************************************************************/
bool MyDatatables::addProject()
{
    // SELECT id, QtProject FROM Projects WHERE QtProject =
    if (isProjectQuery(myProject->getQtProject()))
    {
        mySqlModel->mySetting->showMessageBox(QObject::tr("Record found!").toLocal8Bit(), QString("%1: %2").arg(tr("Not adding: Record found in database"), myProject->getQtProject()).toLocal8Bit(), mySqlModel->mySetting->Warning);
        return false;
    }
    return insertProjects();
}
/******************************************************************************
 * @brief add Configuration.
 * Assumes you have ran setMyConfigurationClass
 * Projects: QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
 * Configuration: ProjectsID, OS, QtVersion, VsVersion varchar, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
 *******************************************************************************/
void MyDatatables::addConfiguration()
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
            QMessageBox::critical(nullptr, QObject::tr("Record already exists in Database"), QObject::tr("Unable to add this record to databasen. Click Cancel to exit."), QMessageBox::Cancel);
            return;
        }
    }
    else
    {
        qCritical() << "SqLite error onAddConfiguration:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    //
    insertConfiguration();
}
/******************************************************************************
 * @brief delete Configuration.
 *******************************************************************************/
void MyDatatables::deleteConfiguration(const QString &thisID)
{
    if (isDebugMessage) qDebug() << "onDeleteConfiguration";
    QSqlQuery query; //!< SQL Query
    QString theQuery = QString("DELETE FROM Projects WHERE id = ").append(thisID);
    qDebug() << "thisQuery: " << theQuery;
    if (!query.exec(theQuery))
    {
        qCritical() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
    // FIXME Delete from both tables
    theQuery = QString("DELETE FROM Configuration WHERE ProjectsID = '").append(thisID).append("'");
    qDebug() << "thisQuery: " << theQuery;
    if (!query.exec(theQuery))
    {
        qCritical() << "SqLite error:" << query.lastError().text() << ", SqLite error code:" << query.lastError();
    }
}
/******************************************************************************
 * @brief get Qt Project Select Query.
 * SELECT id, QtProject FROM Projects
 *******************************************************************************/
QString MyDatatables::getQtProjectSelectQuery()
{
    if (isDebugMessage) qDebug() << "getQtProjectSelectQuery";
    return QString("SELECT id, QtProject FROM Projects");
}
/******************************************************************************
 * @brief get Qt Project By Name Query.
 * SELECT id, QtProject FROM Projects WHERE QtProject =
 *******************************************************************************/
QString MyDatatables::getQtProjectByNameQuery(const QString &thisProject)
{
    if (isDebugMessage) qDebug() << "getQtProjectByNameQuery";
    return QString("SELECT id, QtProject FROM Projects WHERE QtProject = '%1'").arg(thisProject);
}
/******************************************************************************
 * @brief is Project Query.
 * myAccessSqlDbtModel->isProjectQuery(ui->lineEditSettingsProjectBin->text());
 *******************************************************************************/
bool MyDatatables::isProjectQuery(const QString &thisProject)
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
        qCritical() << "SqLite error isProjectQuery:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    return false;
}
/******************************************************************************
 * @brief get Projects Full Select Query ID.
 * SELECT * FROM Projects WHERE id =
 *******************************************************************************/
QString MyDatatables::getProjectsFullSelectQueryID(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getProjectsFullSelectQueryID";
    return QString("SELECT * FROM Projects WHERE id = ").append(thisWhereID);
}
/******************************************************************************
 * @brief get Projects SelectQuery ID.
 * SELECT id, getQtProjectsSelectQueryID FROM Projects WHERE id
 *******************************************************************************/
QString MyDatatables::getQtProjectsSelectQueryID(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getQtProjectsSelectQueryID";
    return QString("SELECT id, QtProject FROM Projects WHERE id = ").append(thisWhereID);
}
/******************************************************************************
 * @brief get Configuration Select Query.
 * FROM Configuration WHERE id
 *******************************************************************************/
QString MyDatatables::getConfigurationSelectQuery(const QString &thisWhereID)
{
    if (isDebugMessage) qDebug() << "getConfigurationSelectQuery";
    return QString("SELECT * FROM Configuration WHERE id = ").append(thisWhereID);
}
/******************************************************************************
 * @brief get Configuration Project Id Os Select Query.
 * FROM Configuration WHERE ProjectsID = 'thisWhereID' AND OS = ''
 *******************************************************************************/
QString MyDatatables::getConfigurationProjectIdOsSelectQuery(const QString &thisWhereID, const QString &thisOS)
{
    if (isDebugMessage) qDebug() << "getConfigurationProjectIdOsSelectQuery";
    return QString("SELECT * FROM Configuration WHERE ProjectsID = '").append(thisWhereID).append("' AND OS = '").append(thisOS).append("'");
}
/******************************************************************************
 * @brief get This Configuration Select Query.
 * FROM Configuration WHERE ProjectsID
 *******************************************************************************/
QString MyDatatables::getThisConfigurationProjectIDSelectQuery(const QString &thisProjectsID)
{
    if (isDebugMessage) qDebug() << "getThisConfigurationSelectQuery";
    return QString("SELECT * FROM Configuration WHERE ProjectsID = '").append(thisProjectsID).append("'");
}
/******************************************************************************
 * @brief save Project.
 * Projects: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
 *******************************************************************************/
void MyDatatables::saveProject()
{
    if (isDebugMessage) qDebug() << "saveProject";
    QSqlQuery theQuery; //!< SQL Query
    QString theQueryString = QString("UPDATE Projects set QtProject = '%1', Secret = '%2', Environment = '%3', IsOsUbuntu = '%4', IsOsMac = '%5', IsOsWebAssembly = '%6', IsOSiOS = '%7', IsOsWindows = '%8', IsOsAndroid = '%9', IsX64 ='%10', IsX86 = '%11', IsDebug = '%12', IsRelease = '%13' WHERE id = %14").arg(myProject->getQtProject(), myProject->getSecret(), myProject->getEnvironment(), myProject->getIsOsUbuntu(), myProject->getIsOsMac(), myProject->getIsOsWebAssembly(), myProject->getIsOSiOS(), myProject->getIsOsWindows(), myProject->getIsOsAndroid(), myProject->getIsX64(), myProject->getIsX86(), myProject->getIsDebug(), myProject->getIsRelease(), myProject->getID());
    if (isDebugMessage) qDebug() << "thisQuery: |" << theQueryString << "|  QtProject = " << myProject->getQtProject() << "| Secret=" << myProject->getSecret() << "| Environment=" << myProject->getEnvironment() << "| IsOsUbuntu=" << myProject->getIsOsUbuntu() << "| IsOsMac=" << myProject->getIsOsMac() << "| IsOsWebAssembly=" << myProject->getIsOsWebAssembly() << "| IsOSiOS=" << myProject->getIsOSiOS() << "| IsOsWindows=" << myProject->getIsOsWindows() << "| IsOsAndroid=" << myProject->getIsOsAndroid() << "| IsX64=" << myProject->getIsX64() << "| IsX86=" << myProject->getIsX86() << "| IsDebug=" << myProject->getIsDebug() << "| IsRelease=" << myProject->getIsRelease() << "| ID=" << myProject->getID() << "|";
    if (!theQuery.exec(theQueryString))
    {
        qCritical() << "SqLite error saveProject:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    isSaveSettings = false;
}
/******************************************************************************
 * @brief save Configuration.
 * Configuration: ProjectsID, OS, QtVersion, VsVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
 *******************************************************************************/
void MyDatatables::saveConfiguration()
{
    if (isDebugMessage) qDebug() << "saveConfiguration";
    QSqlQuery theQuery; //!< SQL Query
    //                                                                                                                                                                                                                                       , , , , , ,
    QString theQueryString = QString("UPDATE Configuration set ProjectsID = '%1', OS = '%2', QtVersion = '%3', VsVersion = '%4', QtIfVersion = '%5', QtIfPackageUri = '%6', PythonVersion = '%7', PythonRequired = '%8', QtMingW32 = '%9', QtMingW64 ='%10', QtToolsMingW32 = '%11', QtToolsMingW64 = '%12', VisualStudio = '%13', OsUpgrade = '%14' WHERE id = %15").arg(myConfigurationVariables->getProjectsID(), myConfigurationVariables->getOS(), myConfigurationVariables->getQtVersion(), myConfigurationVariables->getVsVersion(), myConfigurationVariables->getQtIfVersion(), myConfigurationVariables->getQtIfPackageUri(), myConfigurationVariables->getPythonVersion(), myConfigurationVariables->getPythonRequired(), myConfigurationVariables->getQtMingW32(), myConfigurationVariables->getQtMingW64(), myConfigurationVariables->getQtToolsMingW32(), myConfigurationVariables->getQtToolsMingW64(), myConfigurationVariables->getVisualStudio(), myConfigurationVariables->getOsUpgrade(), myConfigurationVariables->getID());
    if (isDebugMessage) qDebug() << "thisQuery: " << theQueryString;
    if (!theQuery.exec(theQueryString))
    {
        qCritical() << "SqLite error saveConfiguration:" << theQuery.lastError().text() << ", SqLite error code:" << theQuery.lastError();
    }
    isSaveSettings = false;
}
/******************************************************************************
 * @brief set Configuration.
 * Sets all Variables used in the Configuarion Database in one Place
 *******************************************************************************/
void MyDatatables::setConfiguration(const QString &thisID,const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisVsVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade)
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
 * @brief set Project.
 * Sets all Variables used in the Configuarion Database in one Place
 *******************************************************************************/
void MyDatatables::setProject(const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease)
{
    if (isDebugMessage) qDebug() << "setProject";
    myProject->setQtProject(thisQtProject);
    myProject->setSecret(thisSecret);
    myProject->setEnvironment(thisEnvironment);
    myProject->setIsOsUbuntu(thisIsOsUbuntu);
    myProject->setIsOsMac(thisIsOsMac);
    myProject->setIsOsWindows(thisIsOsWindows);
    myProject->setIsOsAndroid(thisIsOsAndroid);
    myProject->setIsOsWebAssembly(thisIsOsWebAssembly);
    myProject->setIsOSiOS(thisIsOSiOS);
    myProject->setIsX64(thisIsX64);
    myProject->setIsX86(thisIsX86);
    myProject->setIsDebug(thisIsDebug);
    myProject->setIsRelease(thisIsRelease);
}
/*** ************************* End of File ***********************************/
