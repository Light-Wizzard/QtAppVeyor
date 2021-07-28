#ifndef QTAPPVEYOR_DATATABLE_H
#define QTAPPVEYOR_DATATABLE_H

#include <QObject>
#include <QtWidgets>
#include <QtSql>
#include <QtDebug>
#include <QDir>
//
#include "MyOrgSettings.h"

/******************************************************************************
* \fn MyProjectClass
* Projects: id, QtProject, Secret, IsOsUbuntu, IsOsMac, IsOsWebAssembly, IsOSiOS, IsOsWindows, IsOsAndroid, IsX64, IsX86, IsDebug, IsRelease
*
*******************************************************************************/
class MyProjectClass
{
        QString myID, myQtProject, mySecret, myEnvironment, myIsOsUbuntu, myIsOsMac, myIsOsWebAssembly, myIsOSiOS, myIsOsWindows, myIsOsAndroid, myIsX64, myIsX86, myIsDebug, myIsRelease;
    public:
        MyProjectClass(const QString &thisID, const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease)
            : myID{thisID}, myQtProject{thisQtProject}, mySecret{thisSecret}, myEnvironment{thisEnvironment}, myIsOsUbuntu{thisIsOsUbuntu}, myIsOsMac{thisIsOsMac}, myIsOsWebAssembly{thisIsOsWebAssembly}, myIsOSiOS{thisIsOSiOS}, myIsOsWindows{thisIsOsWindows}, myIsOsAndroid{thisIsOsAndroid}, myIsX64{thisIsX64}, myIsX86{thisIsX86}, myIsDebug{thisIsDebug}, myIsRelease{thisIsRelease} {}
        // Getters
        QString getID()              const { return myID;              }
        QString getQtProject()       const { return myQtProject;       }
        QString getSecret()          const { return mySecret;          }
        QString getEnvironment()     const
        {
            return myEnvironment;
        }
        QString getIsOsUbuntu()      const { return myIsOsUbuntu;      }
        QString getIsOsMac()         const { return myIsOsMac;         }
        QString getIsOsWebAssembly() const { return myIsOsWebAssembly; }
        QString getIsOSiOS()         const { return myIsOSiOS;         }
        QString getIsOsWindows()     const { return myIsOsWindows;     }
        QString getIsOsAndroid()     const { return myIsOsAndroid;     }
        QString getIsX64()           const { return myIsX64;           }
        QString getIsX86()           const { return myIsX86;           }
        QString getIsDebug()         const { return myIsDebug;         }
        QString getIsRelease()       const { return myIsRelease;       }
        // Setters
        void setID(const QString &s)              { myID = s;              }
        void setQtProject(const QString &s)       { myQtProject = s;       }
        void setSecret(const QString &s)          { mySecret = s;          }
        void setEnvironment(const QString &s)
        {
            myEnvironment = s;
        }
        void setIsOsUbuntu(const QString &s)      { myIsOsUbuntu = s;      }
        void setIsOsMac(const QString &s)         { myIsOsMac = s;         }
        void setIsOsWebAssembly(const QString &s) { myIsOsWebAssembly = s; }
        void setIsOSiOS(const QString &s)         { myIsOSiOS = s;         }
        void setIsOsWindows(const QString &s)     { myIsOsWindows = s;     }
        void setIsOsAndroid(const QString &s)     { myIsOsAndroid = s;     }
        void setIsX64(const QString &s)           { myIsX64 = s;           }
        void setIsX86(const QString &s)           { myIsX86 = s;           }
        void setIsDebug(const QString &s)         { myIsDebug = s;         }
        void setIsRelease(const QString &s)       { myIsRelease = s;       }
};
/******************************************************************************
* \fn MyConfigurationClass
* Configuration: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
*******************************************************************************/
class MyConfigurationClass
{
        QString myID, myProjectsID, myOS, myQtVersion, myQtIfVersion, myQtIfPackageUri, myPythonVersion, myPythonRequired, myQtMingW32, myQtMingW64, myQtToolsMingW32, myQtToolsMingW64, myVisualStudio, myOsUpgrade;
    public:
        MyConfigurationClass(const QString &thisID, const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade)
            : myID{thisID}, myProjectsID{thisProjectsID}, myOS{thisOS}, myQtVersion{thisQtVersion}, myQtIfVersion{thisQtIfVersion}, myQtIfPackageUri{thisQtIfPackageUri}, myPythonVersion{thisPythonVersion}, myPythonRequired{thisPythonRequired}, myQtMingW32{thisQtMingW32}, myQtMingW64{thisQtMingW64}, myQtToolsMingW32{thisQtToolsMingW32}, myQtToolsMingW64{thisQtToolsMingW64}, myVisualStudio{thisVisualStudio}, myOsUpgrade{thisOsUpgrade} {}
        // Getters
        QString getID()             const { return myID;             }
        QString getProjectsID()     const { return myProjectsID;     }
        QString getOS()             const { return myOS;             }
        QString getQtVersion()      const { return myQtVersion;      }
        QString getQtIfVersion()    const { return myQtIfVersion;    }
        QString getQtIfPackageUri() const { return myQtIfPackageUri; }
        QString getPythonVersion()  const { return myPythonVersion;  }
        QString getPythonRequired() const { return myPythonRequired; }
        QString getQtMingW32()      const { return myQtMingW32;      }
        QString getQtMingW64()      const { return myQtMingW64;      }
        QString getQtToolsMingW32() const { return myQtToolsMingW32; }
        QString getQtToolsMingW64() const { return myQtToolsMingW64; }
        QString getVisualStudio()   const { return myVisualStudio;   }
        QString getOsUpgrade()      const { return myOsUpgrade;      }
        // Setters
        void setID(const QString &s)             { myID = s;             }
        void setProjectsID(const QString &s)     { myProjectsID = s;     }
        void setOS(const QString &s)             { myOS = s;             }
        void setQtVersion(const QString &s)      { myQtVersion = s;      }
        void setQtIfVersion(const QString &s)    { myQtIfVersion = s;    }
        void setQtIfPackageUri(const QString &s) { myQtIfPackageUri = s; }
        void setPythonVersion(const QString &s)  { myPythonVersion = s;  }
        void setPythonRequired(const QString &s) { myPythonRequired = s; }
        void setQtMingW32(const QString &s)      { myQtMingW32 = s;      }
        void setQtMingW64(const QString &s)      { myQtMingW64 = s;      }
        void setQtToolsMingW32(const QString &s) { myQtToolsMingW32 = s; }
        void setQtToolsMingW64(const QString &s) { myQtToolsMingW64 = s; }
        void setVisualStudio(const QString &s)   { myVisualStudio = s;   }
        void setOsUpgrade(const QString &s)      { myOsUpgrade = s;      }
};
/******************************************************************************
* \class MySqlDbtModel
*******************************************************************************/
class MySqlDbtModel : public QObject
{
        Q_OBJECT
    public:
        MySqlDbtModel(QObject *parent = 0);                         //!< MySqlDbtModel
        ~MySqlDbtModel();                                           //!< ~MySqlDbtModel
        // Public
        MyConfigurationClass *myConfigurationVariables;             //!< \c MyMemoryConfiguration \brief MyMemory Configuration
        MyProjectClass       *myProjectVariables;                   //!< \c MyMemoryProject \brief MyMemory Project
        //
        bool createDataBaseConnection();                            //!< create DataBase Connection
        bool isDbTable(const QString &thisTable);                   //!< isDbTable
        //
        void setSqlDriver(const QString &thisDriver);               //!< setSqlDriver
        QString getSqlDriver();                                     //!< getSqlDriver
        //
        void setSqlTableName(const QString &thisTableName);         //!< setSqlTableName
        QString getSqlTableName();                                  //!< getSqlTableName
        //
        void setSqlHostName(const QString &thisHostName);           //!< setSqlHostName
        QString getSqlHostName();                                   //!< getSqlHostName
        //
        void setSqlUserName(const QString &thisUserName);           //!< setSqlUserName
        QString getSqlUserName();                                   //!< getSqlUserName
        //
        void setSqlPassword(const QString &thisPassword);           //!< setSqlPassword
        QString getSqlPassword();                                   //!< getSqlPassword
        //
        void setSqlDatabaseName(const QString &thisPassword);       //!< setSqlDatabaseName
        QString getSqlDatabaseName();                               //!< getSqlDatabaseName
        //
        void setSqlDatabase(QSqlDatabase thisDatabase);             //!< set Sql Database
        QSqlDatabase getSqlDatabase();                              //!< get Sql Database
        //
        QString getConnectionName();                                //!< get Connection Name
        void setConnectionName(const QString &thisConnectionName);  //!< set Connection Name
        //
        void setProjectID(const QString &thisProjectID);            //!< setProjectID
        QString getProjectID();                                     //!< getProjectID
        //
        void setComboBoxSqlValue(const QString &thisComboBoxSqlValue); //!< set ComboBox SqlValue
        QString getComboBoxSqlValue();                                 //!< get ComboBox SqlValue
        //
        bool checkDatabase();                                       //!< checkDatabase
        bool runQuery(const QString &thisQuery);                    //!< runQuery
        //
        bool insertConfiguration();                                 //!< insertConfiguration
        bool insertProjects();                                      //!< insertConfigurations
        //
        void setConfiguration(const QString &thisID, const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade);
        void setProject(const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease);
        //
        QString getConfigurationSelectQuery(const QString &thisWhereID); //!< getConfigurationSelectQuery
        QString getConfigurationProjectIdOsSelectQuery(const QString &thisWhereID, const QString &thisOS); //!< getConfigurationProjectIdOsSelectQuery
        QString getThisConfigurationProjectIDSelectQuery(const QString &thisProjectsID); //!< getThisConfigurationProjectIDSelectQuery
        QString getQtProjectsSelectQueryID(const QString &thisWhereID);    //!< get Projects Select Query ID
        QString getQtProjectSelectQuery();                                 //!< get Projects Select Query
        QString getProjectsFullSelectQueryID(const QString &thisWhereID);  //!< get Projects Full Select Query ID
        QString getQtProjectByNameQuery(const QString &thisProject);       //!< get Projects By Name Query
        bool isProjectQuery(const QString &thisProject);                   //!< is Project Query
        bool moveDb(const QString &thisSourceFile, const QString &thisSourcePath, const QString &thisDestinationFolder); //!<  Move Db
        bool addProject();                                                 //!< addProject
        void addConfiguration();                                           //!< addConfiguration
        void saveConfiguration();                                          //!< saveConfiguration
        void deleteConfiguration(const QString &thisID);                   //!< deleteConfiguration
        void saveProject();                                                //!< saveProject

    private:
        MyOrgSettings     *myOrgDomainSetting;                 //!< \c myMySettings       \brief QtAppVeyor Settings
        QSqlDatabase       myDb;                               //!< \c myDb               \brief Database
        QString            myDatabaseName = "QtAppVeyor";      //!< \c myDatabaseName     \brief Sql Driver DatabaseName with extention for Sqlite
        QString            myTableName = "QtAppVeyor" ;        //!< \c myTableName        \brief Table Name
        QString            mySqlDriver = "NOTSET";             //!< \c mySqlDriver        \brief Sql Driver NOTSET
        QString            myHostName = "localhost";           //!< \c myHostName         \brief Sql HostName location of your MySQL server and database, localhost
        QString            myUserName = "";                    //!< \c myUserName         \brief Sql User Name
        QString            myPassword = "";                    //!< \c myPassword         \brief Sql Password
        QString            myConnectionName = "QtAppVeyor";    //!< \c myConnectionName   \brief Connection Name
        QString            myComboBoxSqlValue = "-1";          //!< \c myComboBoxSqlValue \brief ComboBox Sql Value
        QString            myProjectID = "-1";                 //!< \c myProjectID        \brief Project ID
        QString            myInsertID = "-1";                  //!< \c myInsertID         \brief InsertID for last SQL insert
        bool               isSaveSettings=false;               //!< \c isSaveSettings     \brief is Save Settings for Auto Save
        bool               isDebugMessage = true;              //!< \c isDebugMessage     \brief Debug Message
};
#endif // QTAPPVEYOR_DATATABLE_H
/*** ************************* End of File ***********************************/
