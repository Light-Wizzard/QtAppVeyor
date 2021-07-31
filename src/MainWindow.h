#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QDebug>
#include <QFile>
#include <QFileDialog>
#include <QtSql>
#include <QPrinter>
#include "ui_MainWindow.h"
#include "AboutDialog.h"
#include "HelpDialog.h"
#include "MyOrgSettings.h"
#include "MySqlDbtModel.h"
//
#include <QMainWindow>
#include <QtWidgets>
#include <QTabWidget>
#include <QFile>
#include <QFileDialog>
#include <QTextStream>
#include <QtDebug>
#include <QProgressDialog>
#include <QtSql>
#include <QCloseEvent>
#include <QPrinter>
#include <QPrintDialog>
#include <QPrintPreviewDialog>
#include <QtMath>
#include <QList>
#include <QAbstractItemView>
//
QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE
/******************************************************************************
* \class MainWindow
*******************************************************************************/
class MainWindow : public QMainWindow
{
        Q_OBJECT

    public:
        MainWindow(QWidget *parent = nullptr);              //!< MainWindow
        ~MainWindow();                                      //!< ~MainWindow
        //
        /*!
            \enum MainTabs
            \brief Tabs must be forced to be int 0 based indexes that match the actual ui for widgetTab, this enforces compile-time checks.
         */
        enum MainTabs
        {
            TabSettings    = 0,  //!< \c TabSettings    \brief Tab Settings.
            TabSql         = 1,  //!< \c TabSql         \brief Tab SQL
            TabUbuntu      = 2,  //!< \c TabUbuntu      \brief Tab Ubuntu.
            TabMac         = 3,  //!< \c TabMac         \brief Tab Mac.
            TabAndroid     = 4,  //!< \c TabAndroid     \brief Tab Android.
            TabWebAssembly = 5,  //!< \c TabWebAssembly \brief Tab WebAssembly.
            TabIOS         = 6,  //!< \c TabIOS         \brief Tab IOS.
            TabWindows     = 7,  //!< \c TabWindows     \brief Tab Windows.
            TabDefaults    = 8,  //!< \c TabDefaults    \brief Tab Defaults.
            TabYaml        = 9,  //!< \c TabYaml        \brief Tab Yaml.
            TabAll         = 10  //!< \c TabAll         \brief Tab All used for Actions on all Tabs.
        }; // end enum MainTabs

        Q_ENUM(MainTabs) // I enumerate the Tabs to make it easier to travers
        //
        void readSettings();                                     //!< Read Settings
        void readSqlDatabaseStates();                            //!< read Sql DatabaseStates
        void readSqlDatabaseInfo();                              //!< read Sql DatabaseInfo
        //
        bool writeSettings();                                    //!< Write Settings
        void writeSqlDatabaseStates();                           //!< write Sql Database Info
        void writeSqlDatabaseInfo();                             //!< write Sql DatabaseInfo
        //
        bool setQtProjectCombo();                                //!< set Projects Combo
        //
        void setMyProjectConfigurationClass(int tabNumber);      //!< set MyProject and MyConfiguration Class
        //
        void settingsButtons(bool thisEnabled);                  //!< Settings Buttons
        void setSqlBrowseButton();                               //!< setSqlBrowseButton
        //
        void fillForms(const QString &thisProjectID);            //!< fill Forms
        //
        void onHelp();                                           //!< Help
        //
        void clearForms(int tabNumber);                          //!< clear Forms
        void clearTabSettings();                                 //!< clear TabSettings
        void clearTabUbuntu();                                   //!< clear TabUbuntu
        void clearTabMac();                                      //!< clear TabMac
        void clearTabAndroid();                                  //!< clear TabAndroid
        void clearTabWebAssembly();                              //!< clear TabWebAssembly
        void clearTabIOS();                                      //!< clear TabIOS
        void clearTabWindows();                                  //!< clear TabWindows
        void clearTabDefaults();                                 //!< clear TabDefaults
        void clearTabYaml();                                     //!< clear TabYaml

    public slots:
        void onAbout();                       //!< ui->actionAbout
        void onCreate();                      //!< ui->actionCreate
        void onSaveAsYmlFile();               //!< ui->actionSave
        void onRunOnStartup();                //!< onRunOnStartup One Shot call on start up
        void onClipboard();                   //!< onClipboard

    private slots:
        void on_actionPrint_triggered();              //!< on_actionPrint_triggered
        //
        void on_comboBoxSettingsProjects_currentIndexChanged(int index); //!< on_comboBoxSettingsProjects_currentIndexChanged
        void on_comboBoxSqlDatabaseType_currentIndexChanged(const QString &arg1); //!< on_comboBoxSqlDatabaseType_currentIndexChanged
        //
        void on_pushButtonSettingsAdd_clicked();      //!< Settings Add clicked
        void on_pushButtonSettingsDelete_clicked();   //!< Settings Delete clicked
        void on_pushButtonSettingsSave_clicked();     //!< Settings Save clicked
        //
        void on_pushButtonResetDefaultsUbuntu_clicked();       //!< Reset Defaults Ubuntu clicked
        void on_pushButtonResetDefaultsMac_clicked();          //!< Reset Defaults Mac clicked
        void on_pushButtonResetDefaultsAndroid_clicked();      //!< Reset Defaults Android clicked
        void on_pushButtonResetDefaultsWebAssembly_clicked();  //!< Reset Defaults WebAssembly clicked
        void on_pushButtonResetDefaultsIOS_clicked();          //!< Reset Defaults IOS clicked
        void on_pushButtonResetDefaultsWindows_clicked();      //!< Reset Defaults Windows clicked
        void on_pushButtonResetDefaults_clicked();             //!< Reset Defaults clicked
        //
        void on_pushButtonSaveDefaults_clicked();              //!< Save Defaults clicked
        void on_pushButtonSaveSql_clicked();                              //!< on_pushButtonSaveSql_clicked
        void on_pushButtonSaveUbuntu_clicked();                           //!< on_pushButtonSaveUbuntu_clicked
        void on_pushButtonSaveMac_clicked();                              //!< on_pushButtonSaveMac_clicked
        void on_pushButtonSaveAndroid_clicked();                          //!< on_pushButtonSaveAndroid_clicked
        void on_pushButtonSaveWebAssembly_clicked();                      //!< on_pushButtonSaveWebAssembly_clicked
        void on_pushButtonSaveIOS_clicked();                              //!< on_pushButtonSaveIOS_clicked
        void on_pushButtonSaveWindows_clicked();                          //!< on_pushButtonSaveWindows_clicked
        //
        void on_pushButtonSqlPasswordShowHide_clicked();       //!< Sql Password Show/Hide clicked
        void on_pushButtonSqlFileBrowswer_clicked();                      //!< Sql File Browswer clicked
        // Text Change Auto Save
        void on_lineEditSqlDatabaseName_textChanged(const QString &arg1); //!< Sql Database Name textChanged
        void on_lineEditSqlHostName_textChanged(const QString &arg1);     //!< Sql Host Name textChanged
        void on_lineEditSqlUserName_textChanged(const QString &arg1);     //!< Sql User Name textChanged
        void on_lineEditSqlPassword_textChanged(const QString &arg1);     //!< Sql Password textChanged

    protected:
        void closeEvent(QCloseEvent *event) override;   //!< close Event

    private:
        Ui::MainWindow           *ui = nullptr;             //!< \c ui                \brief Pointer to mainwindow.ui
        MySqlDbtModel            *myAccessSqlDbtModel;      //!< \c myQtAppVeyorTable \brief Pointer to DataTable QtAppVeyorTable
        MyOrgSettings            *myOrgDomainSetting;       //!< \c mySetting         \brief Org Domain Setting
        QClipboard               *clipboard;                //!< \c clipboard         \brief clipboard
        QSqlDatabase              myDb;                     //!< \c myDb              \brief Database
        bool                      isDebugMessage = true;    //!< \c isDebugMessage    \brief true of false for Debugging
        bool                      isYamlLoaded = false;     //!< \c isLoaded          \brief true of false for if Yaml screen is loaded
        bool                      isSaveSettings=false;     //!< \c isSaveSettings    \brief Auto Save
        bool                      isMainLoaded = false;     //!< \c isDebugMessage    \brief Set true in onRunOnStartup
};
#endif // MAINWINDOW_H
/*** ************************* End of File ***********************************/
