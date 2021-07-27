#include "MyOrgSettings.h"

/**************************************************************************
* \class MySettings
* Creates QSettings for organizationName, organizationDomain, applicationName
***************************************************************************/
MyOrgSettings::MyOrgSettings(QObject *parent) : QObject(parent)
{
    // Fixed random number, change it before using it, then leave it,
    // all data stored with this key will only work with this key.
    myCrypto = new SimpleCrypt(Q_UINT64_C(0x0c6add66acdcf066));
    // Constants
    myConstants = new MyConstants();
    // Run after GUI loads
    QTimer::singleShot(200, this, &MyOrgSettings::onRunOnStartup);
}
/**************************************************************************
* \fn class ~MySettings
* Creates QSettings for organizationName, organizationDomain, applicationName
***************************************************************************/
MyOrgSettings::~MyOrgSettings()
{

}
/******************************************************************************
* \fn onRunOnStartup
*******************************************************************************/
void MyOrgSettings::onRunOnStartup()
{
    if (isDebugMessage)
    {
        QString theTest = "This is my Secret";
        if (theTest != decryptThis(encryptThis(theTest)))
        {
            qDebug() << "decryptThis Failed";
            QMessageBox::critical(nullptr, QObject::tr("Crypto Fail"), QObject::tr("Crypto Fail: MyOrgSettings::onRunOnStartup()"), QMessageBox::Ok);
        }
    }
}
/**************************************************************************
* \fn void getSettings()
* Creates QSettings for organizationName, organizationDomain, applicationName
***************************************************************************/
QSettings *MyOrgSettings::getSettings()
{
    if (isDebugMessage) qDebug() << "getSettings";
    // organizationName, organizationDomain, applicationName and applicationName
    // are set in main.cpp, and passed into Constuctor, so they are set
    QCoreApplication::setOrganizationName(getOrgName());
    QCoreApplication::setOrganizationDomain(getOrgDomain());
    QCoreApplication::setApplicationName(getAppName());
    //QCoreApplication::setApplicationDisplayName(getAppName());
    // see *.pro file where it is: DEFINES *= APP_VERSION=$${VERSION}
    QCoreApplication::setApplicationVersion(QObject::tr(APP_VERSION));
    QString myIni = QString("%1%2%3").arg(getAppDataLocation(), QDir::separator(), myConstants->MY_INI_FILE);
    if (!isFileMake(getAppDataLocation(), myConstants->MY_INI_FILE))
    {
        qDebug() << "Failed to make File in getSettings " << getAppDataLocation() << QDir::separator() << myConstants->MY_INI_FILE;
    }
    return new QSettings(myIni, QSettings::IniFormat);
} // end qSettingsInstance
/**************************************************************************
* \fn bool isSetting(const QString &thisFieldName)
***************************************************************************/
bool MyOrgSettings::isSetting(const QString &thisFieldName)
{
    if (isDebugMessage) qDebug() << "isSetting";
    QSettings *mySettings = getSettings();
    return mySettings->contains(thisFieldName);
} // end isSetting
/******************************************************************************
* \fn readSettings
*******************************************************************************/
QString MyOrgSettings::readSettings(const QString &thisSetting, const QString &thisDefault)
{
    if (isDebugMessage) qDebug() << "readSettings";
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    QString theSetting = mySettings->value(thisSetting, thisDefault).toString();
    mySettings->endGroup();
    return theSetting;
}
/******************************************************************************
* \fn readSettingsBool
*******************************************************************************/
bool MyOrgSettings::readSettingsBool(const QString &thisSetting, bool thisDefault)
{
    if (isDebugMessage) qDebug() << "readSettingsBool";
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    bool theSetting = mySettings->value(thisSetting, thisDefault).toBool();
    mySettings->endGroup();
    return theSetting;
}
/******************************************************************************
* \fn readSettingsInt
*******************************************************************************/
int MyOrgSettings::readSettingsInt(const QString &thisSetting, int thisDefault)
{
    if (isDebugMessage) qDebug() << "readSettingsInt";
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    int theSetting = mySettings->value(thisSetting, thisDefault).toInt();
    mySettings->endGroup();
    return theSetting;
}
/******************************************************************************
* \fn writeSettings
*******************************************************************************/
void MyOrgSettings::writeSettings(const QString &thisSetting, const QString &thisValue)
{
    if (isDebugMessage) qDebug() << "writeSettings";
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    mySettings->setValue(thisSetting, thisValue);
    mySettings->endGroup();
}
/******************************************************************************
* \fn getDataPath
*******************************************************************************/
QString MyOrgSettings::getDataPath(const QString &thisFileName)
{
    if (isDebugMessage) qDebug() << "getDataPath";
    //
    QDir settingsPath;
    // FIXME Path
    QString myDataPath = QString(settingsPath.currentPath()).append(QDir::separator()).append(thisFileName);
    if (isDebugMessage) qDebug() << "getDataPath = " << myDataPath;
    return myDataPath;
}
/**************************************************************************
* \fn QString combinePathFileName(QString thisPath, QString thisFileName)
***************************************************************************/
QString MyOrgSettings::combinePathFileName(const QString &thisPath,const  QString &thisFileName)
{
    if (isDebugMessage) qDebug() << "combinePathFileName";
    return QString("%1%2%3").arg(thisPath, QDir::separator(), thisFileName);
} // end combinePathFileName
/**************************************************************************
* \fn bool isPathExists(QString thisPath)
***************************************************************************/
bool MyOrgSettings::isPathExists(QString thisPath)
{
    return QDir(thisPath).exists() && QFileInfo(thisPath).isDir();
} // end isPathExists
/**************************************************************************
* \fn bool isFileExists(QString thisFile)
***************************************************************************/
bool MyOrgSettings::isFileExists(QString thisFile)
{
    if (isDebugMessage) qDebug() << "isFileExists";
    // check if file exists and if yes: Is it really a file and not directory?
    return QFileInfo::exists(thisFile) && QFileInfo(thisFile).isFile();
} // end isFileExists
/**************************************************************************
* \fn bool isFileMake(const QString &thisPath, const QString &thisFileName)
***************************************************************************/
bool MyOrgSettings::isFileMake(const QString &thisPath, const QString &thisFileName)
{
    if (isDebugMessage) qDebug() << "isFileMake";
    if (!isMakeDir(thisPath)) return false;
    if (!isFileExists(combinePathFileName(thisPath, thisFileName)))
    {
        QFile file(combinePathFileName(thisPath, thisFileName));
        if (file.open(QIODevice::WriteOnly))
        {
            file.close();
            return isFileExists(combinePathFileName(thisPath, thisFileName));
        }
        else return false;
    }
    return true;
} // end isFileMake
/**************************************************************************
* \fn bool isMakeDir(const QString &thisPath)
***************************************************************************/
bool MyOrgSettings::isMakeDir(const QString &thisPath)
{
    if (isDebugMessage) qDebug() << "isMakeDir";
    QDir dir(thisPath);
    if (!dir.exists())
    {
        if (!dir.mkpath("."))
        {
            qFatal("%s", QString("Error: cannot create file %1").arg(thisPath).toLocal8Bit().constData());
        }
        else return true;
    }
    return isPathExists(thisPath);
} // end isMakeDir
/**************************************************************************
* \fn QString getOrgName()
* This value is used for Qt Settings: GitHub Account Name is one example
***************************************************************************/
QString MyOrgSettings::getOrgName()
{
    if (isDebugMessage) qDebug() << "getOrgName";
    return myOrganizationName;
} // end getOrgName
/**************************************************************************
* \fn void setOrgName(const QString &thisOrgName)
***************************************************************************/
void MyOrgSettings::setOrgName(const QString &thisOrgName)
{
    if (isDebugMessage) qDebug() << "setOrgName";
    if (QString::compare(myOrganizationName, thisOrgName, Qt::CaseInsensitive))
    {
        myOrganizationName = thisOrgName;
    }
} // end setOrgName
/**************************************************************************
* \fn QString getOrgDomain()
***************************************************************************/
QString MyOrgSettings::getOrgDomain()
{
    if (isDebugMessage) qDebug() << "getOrgDomain";
    return myOrganizationDomain;
} // end getOrgDomain
/**************************************************************************
* \fn void setOrgDomain(const QString &thisOrgDomain)
***************************************************************************/
void MyOrgSettings::setOrgDomain(const QString &thisOrgDomain)
{
    if (isDebugMessage) qDebug() << "setOrgDomain";
    if (QString::compare(myOrganizationDomain, thisOrgDomain, Qt::CaseInsensitive))
    {
        myOrganizationDomain = thisOrgDomain;
    }
} // end setOrgDomain
/**************************************************************************
* \fn QString getAppName()
***************************************************************************/
QString MyOrgSettings::getAppName()
{
    if (isDebugMessage) qDebug() << "getAppName";
    return myApplicationName;
} // end getAppName
/**************************************************************************
* \fn void setAppName(const QString &thisAppName)
***************************************************************************/
void MyOrgSettings::setAppName(const QString &thisAppName)
{
    if (isDebugMessage) qDebug() << "setAppName";
    if (QString::compare(myApplicationName, thisAppName, Qt::CaseInsensitive))
    {
        myApplicationName = thisAppName;
    }
} // end setAppName
/**************************************************************************
* \fn void setGeometry(QPoint thisPos, QSize thisSize, bool isMax, bool isMin)
***************************************************************************/
void MyOrgSettings::setGeometry(QPoint thisPos, QSize thisSize, bool isMax, bool isMin)
{
    if (isDebugMessage) qDebug() << "isSetting";
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    mySettings->setValue(myConstants->MY_GEOMETRY_POS, thisPos);
    mySettings->setValue(myConstants->MY_GEOMETRY_MAX, isMax);
    mySettings->setValue(myConstants->MY_GEOMETRY_MIN, isMin);
    if(!isMax && !isMin) mySettings->setValue(myConstants->MY_GEOMETRY_SIZE, thisSize);
    mySettings->endGroup();
} // end setGeometry
/**************************************************************************
* \fn QPoint getGeometry(const QPoint &thisDefaultValue)
***************************************************************************/
void MyOrgSettings::getGeometry()
{
    if (isDebugMessage) qDebug() << "readSettingsBool";
    // Geometry
    QSettings *mySettings = getSettings();
    mySettings->beginGroup("General");
    myGeometryPos  = mySettings->value(myConstants->MY_GEOMETRY_POS, ConstDefaultGeometryPos).toPoint();
    myGeometrySize = mySettings->value(myConstants->MY_GEOMETRY_SIZE, ConstDefaultGeometrySize).toSize();
    myGeometryMax  = mySettings->value(myConstants->MY_GEOMETRY_MAX, true).toBool();
    myGeometryMin  = mySettings->value(myConstants->MY_GEOMETRY_MIN, false).toBool();
    mySettings->endGroup();
} // end getGeometry
/**************************************************************************
* \fn QPoint getGeometryPos(const QPoint &thisDefaultValue)
***************************************************************************/
QPoint MyOrgSettings::getGeometryPos()
{
    if (isDebugMessage) qDebug() << "getGeometryPos";
    return myGeometryPos;
} // end getGeometryPos
/**************************************************************************
* \fn QSize getGeometrySize(const QSize &thisDefaultValue)
***************************************************************************/
QSize MyOrgSettings::getGeometrySize()
{
    if (isDebugMessage) qDebug() << "getGeometrySize";
    return myGeometrySize;
} // end getGeometrySize
/**************************************************************************
* \fn bool getGeometryMax(const bool &thisDefaultValue)
***************************************************************************/
bool MyOrgSettings::getGeometryMax()
{
    if (isDebugMessage) qDebug() << "getGeometryMax";
    return myGeometryMax;
} // end getGeometryMax
/**************************************************************************
* \fn bool getGeometryMin(const bool &thisDefaultValue)
***************************************************************************/
bool MyOrgSettings::getGeometryMin()
{
    if (isDebugMessage) qDebug() << "getGeometryMin";
    return myGeometryMin;
} // end getGeometryMin
/**************************************************************************
* \fn QString readFile(const bool &thisFileName)
***************************************************************************/
QString MyOrgSettings::readFile(const QString &thisFileName)
{
    if (isDebugMessage) qDebug() << "readFile";
    QFile file(thisFileName);
    if(!file.open(QFile::ReadOnly | QFile::Text))
    {
        qDebug() << " Could not open the file for reading";
        return "";
    }
    QTextStream in(&file);
    QString thisText = in.readAll();
    file.close();
    return thisText;
}
/**************************************************************************
* \fn encryptThis
* Crypto using SimpleCrypt
***************************************************************************/
QString MyOrgSettings::encryptThis(const QString &thisSecret)
{
    if (isDebugMessage) qDebug() << "encryptThis";
    return myCrypto->encryptToString(thisSecret);
}
/**************************************************************************
* \fn decryptThis
* Crypto using SimpleCrypt
***************************************************************************/
QString MyOrgSettings::decryptThis(const QString &thisSecret)
{
    if (isDebugMessage) qDebug() << "decryptThis";
    return myCrypto->decryptToString(thisSecret);
}
/**************************************************************************
* \fn questionYesNo
* Titel and Question Yes No
***************************************************************************/
bool MyOrgSettings::questionYesNo(const char *thisTitle, const char *thisQuestion)
{
    QMessageBox theMsgBox;
    theMsgBox.setWindowTitle(QObject::tr(thisTitle));
    theMsgBox.setText(QObject::tr(thisQuestion));
    theMsgBox.setStandardButtons(QMessageBox::Yes);
    theMsgBox.addButton(QMessageBox::No);
    theMsgBox.setDefaultButton(QMessageBox::No);
    if(theMsgBox.exec() == QMessageBox::Yes)
    {
        qDebug() << "Yes was clicked";
        return true;
    }
    else
    {
        qDebug() << "Yes was *not* clicked";
        return false;
    }
}
/**************************************************************************
* \fn showMessageBox
* theMessage.toLocal8Bit()
*  information
*  question: 1 = true, 0 = false
*  warning
*  critical
***************************************************************************/
int MyOrgSettings::showMessageBox(const char *thisTitle, const char *thisMessage, const QString &thisMessageType)
{
    if (thisMessageType == "information")
    {
        return QMessageBox::information(nullptr, QObject::tr(thisTitle), QObject::tr(thisMessage), QMessageBox::Ok);
    }
    else if (thisMessageType == "question")
    {
        if (questionYesNo(thisTitle, thisMessage)) return 1; else return 0;
    }
    else if (thisMessageType == "warning")
    {
        return QMessageBox::warning(nullptr, QObject::tr(thisTitle), QObject::tr(thisMessage), QMessageBox::Ok);
    }
    else if (thisMessageType == "critical")
    {
        return QMessageBox::critical(nullptr, QObject::tr(thisTitle), QObject::tr(thisMessage), QMessageBox::Ok);
    }
    return 0;
}
/**************************************************************************
* \fn getFileInfo
* theMessage.toLocal8Bit()
***************************************************************************/
QString MyOrgSettings::getFileInfo(MyOrgSettings::MyFileinfo thisInfo, const QString &thisFileFolder)
{
    if (isDebugMessage) qDebug() << "getFileInfo";
    if (thisFileFolder.isEmpty()) { return ""; }
    //
    QFileInfo theFileInfo(thisFileFolder);
    //
    switch (thisInfo)
    {
        case AbsoluteFilePath:
            // The absolute path name consists of the full path and the file name.
            return theFileInfo.absoluteFilePath();
        case AbsolutePath:
            // Returns a file's path absolute path. This doesn't include the file name..
            return theFileInfo.absolutePath();
        case BaseName:
            // Returns the base name of the file without the path.
            return theFileInfo.baseName();
        case BirthTime:
            // Returns the date and time when the file was created / born.
            return theFileInfo.birthTime().toString();
        case CanonicalPath:
            // Returns the file's path canonical path (excluding the file name), i.e. an absolute path without symbolic links or redundant "." or ".." elements.
            return theFileInfo.canonicalPath();
        case CanonicalFilePath:
            // Returns the canonical path including the file name, i.e. an absolute path without symbolic links or redundant "." or ".." elements.
            return theFileInfo.canonicalFilePath();
        case CompleteBaseName:
            // Returns the complete base name of the file without the path.
            // "/tmp/archive.tar.gz" == "archive.tar"
            return theFileInfo.completeBaseName();
        case CompleteSuffix:
            // Returns the complete suffix (extension) of the file.
            // "/tmp/archive.tar.gz" == "tar.gz"
            return theFileInfo.completeSuffix();
        case Directory:
            // Returns the path of the object's parent directory as a QDir object.
            return theFileInfo.dir().currentPath();
        case FileName:
            // Returns the name of the file, excluding the path.
            return theFileInfo.fileName();
        case FilePath:
            // Returns the file name, including the path (which may be absolute or relative).
            return theFileInfo.filePath();
        case IsWritable:
            // Returns true if the user can write to the file; otherwise returns false.
            if (theFileInfo.isWritable()) return "true"; else return "false";
        case FileSize:
            return QString::number(theFileInfo.size());
        case IsFile:
            if (isFileExists(thisFileFolder)) return "true"; else return "false";
        case IsFolder:
            if (isPathExists(thisFileFolder)) return "true"; else return "false";
        case IsSymLink:
            if (theFileInfo.isSymLink()) return "true"; else return "false";
        case SymLinkTarget:
            if (theFileInfo.isSymLink()) return theFileInfo.symLinkTarget(); else return "";
    }
    return "";
}
/**************************************************************************
* \fn isAppDataLocationGood
***************************************************************************/
bool MyOrgSettings::isAppDataLocationGood(const QString &thisFolder)
{
    bool isGood = true;

    if (isFileMake(thisFolder, "ReadMe.txt"))
    {
        if (getFileInfo(IsWritable, combinePathFileName(thisFolder, "ReadMe.txt")) == "false")
        {
            isGood = false;
        }
    }
    else
    {
        isGood = false;
    }

    if (getFileInfo(IsFolder, thisFolder) == "false")
    {
        isGood = false;
    }
    return isGood;
}
/**************************************************************************
* \fn getAppDataLocation
***************************************************************************/
QString MyOrgSettings::getAppDataLocation()
{
    QString theAppDataLocation = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (theAppDataLocation.isEmpty())
    {
        theAppDataLocation = QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation);
        if (theAppDataLocation.isEmpty())
        { theAppDataLocation = QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation); }
    }
    if (!isAppDataLocationGood(theAppDataLocation))
    {
        return QDir::currentPath(); // FIXME
    }
    return theAppDataLocation;
}
/*** ************************* End of File ***********************************/
