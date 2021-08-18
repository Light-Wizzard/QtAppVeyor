#ifndef MYDATATABLES_H
#define MYDATATABLES_H

#include <QObject>
#include <QtDebug>
#include "MySqlDbtModel.h"
/************************************************
 * \class MyProjectClass
 * @brief Project Class.
 * @author Jeffrey Scott Flesher
 ***********************************************/
class MyProjectClass
{
    public:
        MyProjectClass(const QString &thisID, const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease)
            : myID{thisID}, myQtProject{thisQtProject}, mySecret{thisSecret}, myEnvironment{thisEnvironment}, myIsOsUbuntu{thisIsOsUbuntu}, myIsOsMac{thisIsOsMac}, myIsOsWebAssembly{thisIsOsWebAssembly}, myIsOSiOS{thisIsOSiOS}, myIsOsWindows{thisIsOsWindows}, myIsOsAndroid{thisIsOsAndroid}, myIsX64{thisIsX64}, myIsX86{thisIsX86}, myIsDebug{thisIsDebug}, myIsRelease{thisIsRelease} {}
        // Getters
        QString getID()              const { return myID;              }
        QString getQtProject()       const { return myQtProject;       }
        QString getSecret()          const { return mySecret;          }
        QString getEnvironment()     const { return myEnvironment;     }
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

    private:
        QString myID, myQtProject, mySecret, myEnvironment, myIsOsUbuntu, myIsOsMac, myIsOsWebAssembly, myIsOSiOS, myIsOsWindows;
        QString myIsOsAndroid, myIsX64, myIsX86, myIsDebug, myIsRelease;
}; // end class MyProjectClass
/******************************************************************************
 * \class MyConfigurationClass
 * Configuration: id, ProjectsID, OS, QtVersion, QtIfVersion, QtIfPackageUri, PythonVersion, PythonRequired, QtMingW32, QtMingW64, QtToolsMingW32, QtToolsMingW64, VisualStudio, OsUpgrade
 *******************************************************************************/
class MyConfigurationClass
{
    public:
        MyConfigurationClass(const QString &thisID, const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisVsVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade)
            : myID{thisID}, myProjectsID{thisProjectsID}, myOS{thisOS}, myQtVersion{thisQtVersion}, myVsVersion{thisVsVersion}, myQtIfVersion{thisQtIfVersion}, myQtIfPackageUri{thisQtIfPackageUri}, myPythonVersion{thisPythonVersion}, myPythonRequired{thisPythonRequired}, myQtMingW32{thisQtMingW32}, myQtMingW64{thisQtMingW64}, myQtToolsMingW32{thisQtToolsMingW32}, myQtToolsMingW64{thisQtToolsMingW64}, myVisualStudio{thisVisualStudio}, myOsUpgrade{thisOsUpgrade} {}
        // Getters
        QString getID()             const { return myID;             }
        QString getProjectsID()     const { return myProjectsID;     }
        QString getOS()             const { return myOS;             }
        QString getQtVersion()      const { return myQtVersion;      }
        QString getVsVersion()      const { return myVsVersion;      }
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
        void setVsVersion(const QString &s)      { myVsVersion = s;      }
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

    private:
        QString myID, myProjectsID, myOS, myQtVersion, myVsVersion, myQtIfVersion, myQtIfPackageUri, myPythonVersion, myPythonRequired;
        QString myQtMingW32, myQtMingW64, myQtToolsMingW32, myQtToolsMingW64, myVisualStudio, myOsUpgrade;

}; // end class MyConfigurationClass
/************************************************
 * \class MyDatatables
 * @brief My Datatables.
 * @author Jeffrey Scott Flesher
 ***********************************************/
class MyDatatables : public QObject
{
        Q_OBJECT
    public:
        explicit MyDatatables(QObject *parent = nullptr);
        ~MyDatatables();
        //
        MyProjectClass       *myProject;                            //!< \c myProject  @brief My Project Variables
        MyConfigurationClass *myConfigurationVariables;             //!< \c myConfigurationVariables  @brief Configuration Variables
        MySqlDbtModel        *mySqlModel;                           //!< \c mySqlModel @brief Pointer to DataTable
        //
        bool checkDatabase();                                       //!< check Database
        bool insertQtProjects();                                    //!< insert Qt Project
        //
        void setProject(const QString &thisQtProjectName, const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisSourceLanguage, const QString &thisLanguageIDs, const QString &thisMake);
        void setProjectName(const QString &thisProjectName);                //!< set Project Name
        QString getProjectName();                                           //!< get Project Name

        void setProjectID(const QString &thisProjectID);                    //!< set Project ID
        QString getProjectID();                                             //!< get Project ID
        //
        void setProjectFolder(const QString &thisProjectFolder);            //!< set Project Folder
        QString getProjectFolder();                                         //!< get Project Folder
        //
        void setComboBoxSqlValue(const QString &thisComboBoxSqlValue);      //!< set ComboBox SqlValue
        QString getComboBoxSqlValue();                                      //!< get ComboBox SqlValue
        // Is Debug Message
        void setDebugMessage(bool thisState);                               //!< set Debug Message
        bool getDebugMessage();                                             //!< get Debug Message

        bool insertProjects();
        bool insertConfiguration();
        bool addProject();
        void addConfiguration();
        void deleteConfiguration(const QString &thisID);
        QString getQtProjectSelectQuery();
        QString getQtProjectByNameQuery(const QString &thisProject);
        bool isProjectQuery(const QString &thisProject);
        QString getProjectsFullSelectQueryID(const QString &thisWhereID);
        QString getQtProjectsSelectQueryID(const QString &thisWhereID);
        QString getConfigurationSelectQuery(const QString &thisWhereID);
        QString getConfigurationProjectIdOsSelectQuery(const QString &thisWhereID, const QString &thisOS);
        QString getThisConfigurationProjectIDSelectQuery(const QString &thisProjectsID);
        void saveProject();
        void saveConfiguration();
        void setConfiguration(const QString &thisID, const QString &thisProjectsID, const QString &thisOS, const QString &thisQtVersion, const QString &thisVsVersion, const QString &thisQtIfVersion, const QString &thisQtIfPackageUri, const QString &thisPythonVersion, const QString &thisPythonRequired, const QString &thisQtMingW32, const QString &thisQtMingW64, const QString &thisQtToolsMingW32, const QString &thisQtToolsMingW64, const QString &thisVisualStudio, const QString &thisOsUpgrade);
        void setProject(const QString &thisQtProject, const QString &thisSecret, const QString &thisEnvironment, const QString &thisIsOsUbuntu, const QString &thisIsOsMac, const QString &thisIsOsWebAssembly, const QString &thisIsOSiOS, const QString &thisIsOsWindows, const QString &thisIsOsAndroid, const QString &thisIsX64, const QString &thisIsX86, const QString &thisIsDebug, const QString &thisIsRelease);

    private:
        QString myProjectID        = "-1";          //!< \c myProjectID         @brief Project ID
        QString myComboBoxSqlValue = "-1";          //!< \c myComboBoxSqlValue  @brief ComboBox SQL Value
        QString myProjectFolder    = "QtAppVeyor";  //!< \c myProjectFolder     @brief Project Folder
        QString myProjectName      = "QtAppVeyor";  //!< \c myProjectName       @brief Project Name
        QString myInsertID         = "-1";          //!< \c myInsertID          @brief InsertID for last SQL insert
        bool    isDebugMessage     = true;          //!< \c isDebugMessage      @brief Debug Message
        bool    isSaveSettings     = false;         //!< \c isSaveSettings      @brief is Save Settings for Auto Save

}; // end class MyDatatables
#endif // MYDATATABLES_H
/*** ************************* End of File ***********************************/
