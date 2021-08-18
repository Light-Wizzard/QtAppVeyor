#ifndef MY_SQL_DBT_MODEL_H
#define MY_SQL_DBT_MODEL_H

#include <QObject>
#include <QtWidgets>
#include <QtSql>
#include <QtDebug>
#include <QDir>
//
#include "MyOrgSettings.h"
/************************************************
 * \class MySqlDbtModel
 * @brief SQL Database Table Model.
 * @author Jeffrey Scott Flesher
 ***********************************************/
class MySqlDbtModel : public QObject
{
        Q_OBJECT
    public:
        MySqlDbtModel(QObject *parent = 0);                         //!< MySqlDbtModel
        ~MySqlDbtModel();                                           //!< ~MySqlDbtModel
        // Public
        MyOrgSettings  *mySetting;                                  //!< \c mySetting @brief Domain Settings
        // DataBase Connection
        bool createDataBaseConnection();                            //!< create DataBase Connection
        bool isDbTable(const QString &thisTable);                   //!< isDbTable
        // SQL Driver
        void setSqlDriver(const QString &thisDriver);               //!< setSqlDriver
        QString getSqlDriver();                                     //!< getSqlDriver
        // SQL Table Name
        void setSqlTableName(const QString &thisTableName);         //!< setSqlTableName
        QString getSqlTableName();                                  //!< getSqlTableName
        // SQL Host Name
        void setSqlHostName(const QString &thisHostName);           //!< setSqlHostName
        QString getSqlHostName();                                   //!< getSqlHostName
        // SQL User Name
        void setSqlUserName(const QString &thisUserName);           //!< setSqlUserName
        QString getSqlUserName();                                   //!< getSqlUserName
        // SQL Password
        void setSqlPassword(const QString &thisPassword);           //!< setSqlPassword
        QString getSqlPassword();                                   //!< getSqlPassword
        // SQL Database Name
        void setSqlDatabaseName(const QString &thisPassword);       //!< setSqlDatabaseName
        QString getSqlDatabaseName();                               //!< getSqlDatabaseName
        // SQL Database
        void setSqlDatabase(QSqlDatabase thisDatabase);             //!< set SQL Database
        QSqlDatabase getSqlDatabase();                              //!< get SQL Database
        // Connection Name
        QString getConnectionName();                                //!< get Connection Name
        void setConnectionName(const QString &thisConnectionName);  //!< set Connection Name
        // RecordID
        QString getRecordID();                                      //!< get RecordID
        void setRecordID(const QString &thisRecordID);              //!< set RecordID
        // run Query
        bool runQuery(const QString &thisQuery);                    //!< runQuery
        // move Db
        bool moveDb(const QString &thisSourceFile, const QString &thisSourcePath, const QString &thisDestinationFolder); //!<  Move Db
        QString runProcces(const QString &thisExePath, const QString &thisArgument, bool isWait, int thisWaitTimeSec);   //!< run Procces
        // Run Return Code
        int getRunReturnCode();                     //!< get Run Return Code
        // Is Debug Message
        void setDebugMessage(bool thisState);       //!< set Debug Message
        bool getDebugMessage();                     //!< get Debug Message

    private:
        QSqlDatabase myDb;                              //!< \c myDb               @brief Database
        QString      myDatabaseName   = "QtAppVeyor";   //!< \c myDatabaseName     @brief SQL Driver DatabaseName with extention for Sqlite
        QString      myTableName      = "QtAppVeyor" ;  //!< \c myTableName        @brief Table Name
        QString      mySqlDriver      = "NOTSET";       //!< \c mySqlDriver        @brief SQL Driver NOTSET
        QString      myHostName       = "localhost";    //!< \c myHostName         @brief SQL HostName location of your MySQL server and database, localhost
        QString      myUserName       = "";             //!< \c myUserName         @brief SQL User Name
        QString      myPassword       = "";             //!< \c myPassword         @brief SQL Password
        QString      myConnectionName = "QtAppVeyor";   //!< \c myConnectionName   @brief Connection Name
        QString      myInsertID       = "-1";           //!< \c myInsertID         @brief InsertID for last SQL insert
        bool         isDebugMessage   = true;           //!< \c isDebugMessage     @brief Debug Message
        bool         myUseEncryption  = false;          //!< \c myUseEncryption    @brief Use Encryption
        bool         isEncrypted      = false;          //!< \c isEncrypted        @brief is Encrypted
        int          myRunReturnCode  = 1;              //!< \c myRunReturnCode    @brief Run Return Code
};
#endif // MY_SQL_DBT_MODEL_H
/*** ************************* End of File ***********************************/
