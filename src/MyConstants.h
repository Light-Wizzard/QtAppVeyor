#ifndef MYCONSTANTS_H
#define MYCONSTANTS_H
// Includes
#include <QObject>
#include <QtGlobal>
//
// Debugging Aid, sets all fields to a default value
//#define TEST_BUILD
//
#define MY_CRYPTO_SEED (Q_UINT64_C(0x0c6add66acdcf066)) //!< \c MY_CRYPTO_SEED      @brief Ini File Name
//
#if Q_OS_MSDOS || defined(Q_OS_WIN32) || defined(Q_OS_WINCE)
    #define VERSION "1.0.0"
#else
    #define VERSION "1.0"
#endif
/************************************************
 * \class MyConstants
 * @brief Constants are defined as const QString, starting with MY_ all capps.
 ***********************************************/
class MyConstants
{
    public:
        #ifdef TEST_BUILD
        // TabSettings Project
        const QString MY_PROJECT_QT = "QtAppVeyor";
        const QString MY_PROJECT_SECRET = "Secret";
        const QString MY_PROJECT_ENVIRONMENT  = "Qt";
        const QString MY_PROJECT_UBUNTU = "true";
        const QString MY_PROJECT_MAC = "true";
        const QString MY_PROJECT_WINDOWS = "true";
        const QString MY_PROJECT_ANDROID = "true";
        const QString MY_PROJECT_WEB_ASSEMBLY = "true";
        const QString MY_PROJECT_IOS = "true";
        const QString MY_PROJECT_X64 = "true";
        const QString MY_PROJECT_X86 = "true";
        const QString MY_PROJECT_DEBUG = "true";
        const QString MY_PROJECT_RELEASE = "true";
        // Ubuntu TabUbuntu
        const QString MY_UBUNTU_QT_VERSION = "Ubuntu-QT_VERSION";
        const QString MY_UBUNTU_VS_VERSION = "Ubuntu-VS_VERSION";
        const QString MY_UBUNTU_QTIF_VERSION = "Ubuntu-QTIF_VERSION";
        const QString MY_UBUNTU_PACKAGE_FOLDER = "Ubuntu-PACKAGE_FOLDER";
        const QString MY_UBUNTU_PYTHON_VERSION = "Ubuntu-PYTHON_VERSION";
        const QString MY_UBUNTU_PYTHON_REQUIRED = "true";
        const QString MY_UBUNTU_MINGW32 = "Ubuntu-MINGW32";
        const QString MY_UBUNTU_MINGW64 = "Ubuntu-MINGW64";
        const QString MY_UBUNTU_MINGW32_TOOLS = "Ubuntu-MINGW32_TOOLS";
        const QString MY_UBUNTU_MINGW64_TOOLS = "Ubuntu-MINGW64_TOOLS";
        const QString MY_UBUNTU_VISUAL_STUIDIO = "Ubuntu-VISUAL_STUIDIO";
        const QString MY_UBUNTU_UPGRADE_OS = "true";
        // TabMac Mac
        const QString MY_MAC_QT_VERSION = "Mac-QT_VERSION";
        const QString MY_MAC_VS_VERSION = "Mac-VS_VERSION";
        const QString MY_MAC_QTIF_VERSION = "Mac-QTIF_VERSION";
        const QString MY_MAC_PACKAGE_FOLDER = "Mac-PACKAGE_FOLDER";
        const QString MY_MAC_PYTHON_VERSION = "Mac-PYTHON_VERSION";
        const QString MY_MAC_PYTHON_REQUIRED = "true";
        const QString MY_MAC_MINGW32 = "Mac-MINGW32";
        const QString MY_MAC_MINGW64 = "Mac-MINGW64";
        const QString MY_MAC_MINGW32_TOOLS = "Mac-MINGW32_TOOLS";
        const QString MY_MAC_MINGW64_TOOLS = "Mac-MINGW64_TOOLS";
        const QString MY_MAC_VISUAL_STUIDIO = "Mac-VISUAL_STUIDIO";
        const QString MY_MAC_UPGRADE_OS = "true";
        // TabAndroid Android
        const QString MY_ANDROID_QT_VERSION = "Android-QT_VERSION";
        const QString MY_ANDROID_VS_VERSION = "Android-VS_VERSION";
        const QString MY_ANDROID_QTIF_VERSION = "Android-QTIF_VERSION";
        const QString MY_ANDROID_PACKAGE_FOLDER = "Android-PACKAGE_FOLDER";
        const QString MY_ANDROID_PYTHON_VERSION = "Android-PYTHON_VERSION";
        const QString MY_ANDROID_PYTHON_REQUIRED = "true";
        const QString MY_ANDROID_MINGW32 = "Android-MINGW32";
        const QString MY_ANDROID_MINGW64 = "Android-MINGW64";
        const QString MY_ANDROID_MINGW32_TOOLS = "Android-MINGW32_TOOLS";
        const QString MY_ANDROID_MINGW64_TOOLS = "Android-MINGW64_TOOLS";
        const QString MY_ANDROID_VISUAL_STUIDIO = "Android-VISUAL_STUIDIO";
        const QString MY_ANDROID_UPGRADE_OS = "true";
        // TabWebAssembly WEBASSEMBLY
        const QString MY_WEBASSEMBLY_QT_VERSION = "WEBASSEMBLY-QT_VERSION";
        const QString MY_WEBASSEMBLY_VS_VERSION = "WEBASSEMBLY-VS_VERSION";
        const QString MY_WEBASSEMBLY_QTIF_VERSION = "WEBASSEMBLY-QTIF_VERSION";
        const QString MY_WEBASSEMBLY_PACKAGE_FOLDER = "WEBASSEMBLY-PACKAGE_FOLDER";
        const QString MY_WEBASSEMBLY_PYTHON_VERSION = "WEBASSEMBLY-PYTHON_VERSION";
        const QString MY_WEBASSEMBLY_PYTHON_REQUIRED = "true";
        const QString MY_WEBASSEMBLY_MINGW32 = "WEBASSEMBLY-MINGW32";
        const QString MY_WEBASSEMBLY_MINGW64 = "WEBASSEMBLY-MINGW64";
        const QString MY_WEBASSEMBLY_MINGW32_TOOLS = "WEBASSEMBLY-MINGW32_TOOLS";
        const QString MY_WEBASSEMBLY_MINGW64_TOOLS = "WEBASSEMBLY-MINGW64_TOOLS";
        const QString MY_WEBASSEMBLY_VISUAL_STUIDIO = "WEBASSEMBLY-VISUAL_STUIDIO";
        const QString MY_WEBASSEMBLY_UPGRADE_OS = "true";
        // TabIOS IOS
        const QString MY_IOS_QT_VERSION = "IOS-QT_VERSION";
        const QString MY_IOS_VS_VERSION = "IOS-VS_VERSION";
        const QString MY_IOS_QTIF_VERSION = "IOS-QTIF_VERSION";
        const QString MY_IOS_PACKAGE_FOLDER = "IOS-PACKAGE_FOLDER";
        const QString MY_IOS_PYTHON_VERSION = "IOS-PYTHON_VERSION";
        const QString MY_IOS_PYTHON_REQUIRED = "true";
        const QString MY_IOS_MINGW32 = "IOS-MINGW32";
        const QString MY_IOS_MINGW64 = "IOS-MINGW64";
        const QString MY_IOS_MINGW32_TOOLS = "IOS-MINGW32_TOOLS";
        const QString MY_IOS_MINGW64_TOOLS = "IOS-MINGW64_TOOLS";
        const QString MY_IOS_VISUAL_STUIDIO = "IOS-VISUAL_STUIDIO";
        const QString MY_IOS_UPGRADE_OS = "true";
        // TabWindows Windows
        const QString MY_WINDOWS_QT_VERSION = "Windows-QT_VERSION";
        const QString MY_WINDOWS_VS_VERSION = "Windows-VS_VERSION";
        const QString MY_WINDOWS_QTIF_VERSION = "Windows-QTIF_VERSION";
        const QString MY_WINDOWS_PACKAGE_FOLDER = "Windows-PACKAGE_FOLDER";
        const QString MY_WINDOWS_PYTHON_VERSION = "Windows-PYTHON_VERSION";
        const QString MY_WINDOWS_PYTHON_REQUIRED = "true";
        const QString MY_WINDOWS_MINGW32 = "Windows-MINGW32";
        const QString MY_WINDOWS_MINGW64 = "Windows-MINGW64";
        const QString MY_WINDOWS_MINGW32_TOOLS = "Windows-MINGW32_TOOLS";
        const QString MY_WINDOWS_MINGW64_TOOLS = "Windows-MINGW64_TOOLS";
        const QString MY_WINDOWS_VISUAL_STUIDIO = "Windows-VISUAL_STUIDIO";
        const QString MY_WINDOWS_UPGRADE_OS = "true";
        // TabDefaults Defaults
        const QString MY_DEFAULTS_QT_VERSION = "Defaults-QT_VERSION";
        const QString MY_DEFAULTS_VS_VERSION = "Defaults-VS_VERSION";
        const QString MY_DEFAULTS_QTIF_VERSION = "Defaults-QTIF_VERSION";
        const QString MY_DEFAULTS_PACKAGE_FOLDER = "Defaults-PACKAGE_FOLDER";
        const QString MY_DEFAULTS_PYTHON_VERSION = "Defaults-PYTHON_VERSION";
        const QString MY_DEFAULTS_PYTHON_REQUIRED = "true";
        const QString MY_DEFAULTS_MINGW32 = "Defaults-MINGW32";
        const QString MY_DEFAULTS_MINGW64 = "Defaults-MINGW64";
        const QString MY_DEFAULTS_MINGW32_TOOLS = "Defaults-MINGW32_TOOLS";
        const QString MY_DEFAULTS_MINGW64_TOOLS = "Defaults-MINGW64_TOOLS";
        const QString MY_DEFAULTS_VISUAL_STUIDIO = "Defaults-VISUAL_STUIDIO";
        const QString MY_DEFAULTS_UPGRADE_OS = "true";
        #else
        // TabSettings Project
        const QString MY_PROJECT_QT             = "QtAppVeyor";
        const QString MY_PROJECT_SECRET         = "";
        const QString MY_PROJECT_ENVIRONMENT    = "Qt";
        const QString MY_PROJECT_ENVIRONMENT_QT = "Qt";
        const QString MY_PROJECT_ENVIRONMENT_VS = "VS";
        const QString MY_PROJECT_UBUNTU         = "true";
        const QString MY_PROJECT_MAC            = "true";
        const QString MY_PROJECT_WINDOWS        = "true";
        const QString MY_PROJECT_ANDROID        = "false";
        const QString MY_PROJECT_WEB_ASSEMBLY   = "false";
        const QString MY_PROJECT_IOS            = "false";
        const QString MY_PROJECT_X64            = "true";
        const QString MY_PROJECT_X86            = "true";
        const QString MY_PROJECT_DEBUG          = "false";
        const QString MY_PROJECT_RELEASE        = "true";
        // TabUbuntu Ubuntu
        const QString MY_UBUNTU_QT_VERSION = "5.15.2";
        const QString MY_UBUNTU_VS_VERSION = "2019";
        const QString MY_UBUNTU_QTIF_VERSION = "4.1.1";
        const QString MY_UBUNTU_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_UBUNTU_PYTHON_VERSION = "3.8";
        const QString MY_UBUNTU_PYTHON_REQUIRED = "true";
        const QString MY_UBUNTU_MINGW32 = "";
        const QString MY_UBUNTU_MINGW64 = "";
        const QString MY_UBUNTU_MINGW32_TOOLS = "";
        const QString MY_UBUNTU_MINGW64_TOOLS = "";
        const QString MY_UBUNTU_VISUAL_STUIDIO = "";
        const QString MY_UBUNTU_UPGRADE_OS = "false";
        // TabMac Mac
        const QString MY_MAC_QT_VERSION = "5.15.2";
        const QString MY_MAC_VS_VERSION = "2019";
        const QString MY_MAC_QTIF_VERSION = "4.1.1";
        const QString MY_MAC_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_MAC_PYTHON_VERSION = "3.8";
        const QString MY_MAC_PYTHON_REQUIRED = "true";
        const QString MY_MAC_MINGW32 = "";
        const QString MY_MAC_MINGW64 = "";
        const QString MY_MAC_MINGW32_TOOLS = "";
        const QString MY_MAC_MINGW64_TOOLS = "";
        const QString MY_MAC_VISUAL_STUIDIO = "";
        const QString MY_MAC_UPGRADE_OS = "false";
        // TabAndroid Android
        const QString MY_ANDROID_QT_VERSION = "5.15.2";
        const QString MY_ANDROID_VS_VERSION = "2019";
        const QString MY_ANDROID_QTIF_VERSION = "4.1.1";
        const QString MY_ANDROID_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_ANDROID_PYTHON_VERSION = "3.8";
        const QString MY_ANDROID_PYTHON_REQUIRED = "true";
        const QString MY_ANDROID_MINGW32 = "";
        const QString MY_ANDROID_MINGW64 = "";
        const QString MY_ANDROID_MINGW32_TOOLS = "";
        const QString MY_ANDROID_MINGW64_TOOLS = "";
        const QString MY_ANDROID_VISUAL_STUIDIO = "";
        const QString MY_ANDROID_UPGRADE_OS = "false";
        // TabWebAssembly WEBASSEMBLY
        const QString MY_WEBASSEMBLY_QT_VERSION = "5.15.2";
        const QString MY_WEBASSEMBLY_VS_VERSION = "2019";
        const QString MY_WEBASSEMBLY_QTIF_VERSION = "4.1.1";
        const QString MY_WEBASSEMBLY_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_WEBASSEMBLY_PYTHON_VERSION = "3.8";
        const QString MY_WEBASSEMBLY_PYTHON_REQUIRED = "false";
        const QString MY_WEBASSEMBLY_MINGW32 = "";
        const QString MY_WEBASSEMBLY_MINGW64 = "";
        const QString MY_WEBASSEMBLY_MINGW32_TOOLS = "";
        const QString MY_WEBASSEMBLY_MINGW64_TOOLS = "";
        const QString MY_WEBASSEMBLY_VISUAL_STUIDIO = "";
        const QString MY_WEBASSEMBLY_UPGRADE_OS = "false";
        // TabIOS IOS
        const QString MY_IOS_QT_VERSION = "5.15.2";
        const QString MY_IOS_VS_VERSION = "2019";
        const QString MY_IOS_QTIF_VERSION = "4.1.1";
        const QString MY_IOS_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_IOS_PYTHON_VERSION = "3.8";
        const QString MY_IOS_PYTHON_REQUIRED = "false";
        const QString MY_IOS_MINGW32 = "";
        const QString MY_IOS_MINGW64 = "";
        const QString MY_IOS_MINGW32_TOOLS = "";
        const QString MY_IOS_MINGW64_TOOLS = "";
        const QString MY_IOS_VISUAL_STUIDIO = "";
        const QString MY_IOS_UPGRADE_OS = "false";
        // TabWindows Windows
        const QString MY_WINDOWS_QT_VERSION = "5.15.2";
        const QString MY_WINDOWS_VS_VERSION = "2019";
        const QString MY_WINDOWS_QTIF_VERSION = "4.1.1";
        const QString MY_WINDOWS_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_WINDOWS_PYTHON_VERSION = "3.8";
        const QString MY_WINDOWS_PYTHON_REQUIRED = "true";
        const QString MY_WINDOWS_MINGW32 = "mingw81_32";
        const QString MY_WINDOWS_MINGW64 = "mingw81_64";
        const QString MY_WINDOWS_MINGW32_TOOLS = "mingw810_32";
        const QString MY_WINDOWS_MINGW64_TOOLS = "mingw810_64";
        const QString MY_WINDOWS_VISUAL_STUIDIO = "Visual Studio 2019";
        const QString MY_WINDOWS_UPGRADE_OS = "false";
        // TabDefaults Defaults
        const QString MY_DEFAULTS_QT_VERSION = "5.15.2";
        const QString MY_DEFAULTS_VS_VERSION = "2019";
        const QString MY_DEFAULTS_QTIF_VERSION = "4.1.1";
        const QString MY_DEFAULTS_PACKAGE_FOLDER = "packages/com.appveyor.qtappveyor/data";
        const QString MY_DEFAULTS_PYTHON_VERSION = "3.8";
        const QString MY_DEFAULTS_PYTHON_REQUIRED = "true";
        const QString MY_DEFAULTS_MINGW32 = "mingw81_32";
        const QString MY_DEFAULTS_MINGW64 = "mingw81_64";
        const QString MY_DEFAULTS_MINGW32_TOOLS = "mingw810_32";
        const QString MY_DEFAULTS_MINGW64_TOOLS = "mingw810_64";
        const QString MY_DEFAULTS_VISUAL_STUIDIO = "Visual Studio 2019";
        const QString MY_DEFAULTS_UPGRADE_OS = "false";
        #endif
        // Constants
        const QString MY_INI_FILE         = "QtAppVeyor.ini";   //!< \c MY_INI_FILE      @brief Ini File Name
        const QString MY_INTERNET_URL     = "http://www.google.com"; //!< \c MY_INTERNET_URL @brief Default Internet URL for testing if Internet is up.
        const QString MY_SQL_DEFAULT      = "QSQLITE";          //!< \c SQL_DEFAULT     @brief Default SQL Driver QSQLITE
        const QString MY_SQL_COMBO_INDEX  = "SqlComboBoxIndex"; //!< \c SQL_COMBO_INDEX @brief Field Name for SQL ComboBox Index
        const QString MY_SQL_COMBO_VALUE  = "SqlComboBoxValue"; //!< \c SQL_COMBO_VALUE @brief Field Name for SQL ComboBox Value
        const QString MY_SQL_COMBO_STATE  = "SqlComboBoxState"; //!< \c SQL_COMBO_STATE @brief Field Name for SQL ComboBox State
        const QString MY_SQL_PROJECT_ID   = "ProjectID";        //!< \c SQL_PROJECT_ID  @brief Field Name for Project ID
        // SQL Ini Variable Names Field Names
        const QString MY_SQL_DB_NAME   = "SqlDatabaseName";  //!< \c MY_SQL_DB_NAME   @brief SQL Ini Storage Field Name
        const QString MY_SQL_DB_TYPE   = "SqlDatabaseType";  //!< \c MY_SQL_DB_TYPE   @brief SQL Ini Storage Field Name
        const QString MY_SQL_DB_HOST   = "SqlDatabaseHost";  //!< \c MY_SQL_DB_HOST   @brief SQL Ini Storage Field Name
        const QString MY_SQL_DB_USER   = "SqlDatabaseUser";  //!< \c MY_SQL_DB_USER   @brief SQL Ini Storage Field Name
        const QString MY_SQL_DB_PASS   = "SqlDatabasePass";  //!< \c MY_SQL_DB_PASS   @brief SQL Ini Storage Field Name
        // Used in tr
        const char *MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_1 = "Record not found in Database";
        const char *MY_ERROR_MESSAGE_DB_RECORD_NOT_FOUND_2 = "Record not found in Database for %1. Click Cancel to exit.";
        // Language
        const QString MY_DEFAULT_LANGUAGE_CODE  = "en";                //!< \c MY_DEFAULT_LANGUAGE_CODE @brief Default Langages Code
        const QString MY_TRANSLATION_PREFIX     = "QtAppVeyor";        //!< \c MY_TRANSLATION_PREFIX    @brief Translation Prefix
        //
        const QString MY_LAST_PROJECT_FOLDER = "LastProjectFolder"; //!< \c MY_QT_PROJECT_NAME  @brief Field Name for Last Project folder
        //
        const QString MY_OS_NAME_UBUNTU      = "Ubuntu";             //!< \c OS_NAME_UBUNTU      @brief OS Name for Ubuntu
        const QString MY_OS_NAME_MAC         = "Mac";                //!< \c OS_NAME_MAC         @brief OS Name for Mac
        const QString MY_OS_NAME_ANDROID     = "Android";            //!< \c OS_NAME_ANDROID     @brief OS Name for Android
        const QString MY_OS_NAME_WEBASSEMBLY = "WebAssembly";        //!< \c OS_NAME_WEBASSEMBLY @brief OS Name for WebAssembly
        const QString MY_OS_NAME_IOS         = "iOS";                //!< \c OS_NAME_IOS         @brief OS Name for iOS
        const QString MY_OS_NAME_WINDOWS     = "Windows";            //!< \c OS_NAME_Windows     @brief OS Name for Windows
        const QString MY_OS_NAME_DEFAULTS    = "Defaults";           //!< \c OS_NAME_DEFAULTS    @brief OS Name for Defaults
        const QString MY_IS_DEBUG_MESSAGE    = "IsDebugMessage";     //!< \c MY_IS_DEBUG_MESSAGE @brief Field Name for IsDebugMessage
        const QString MY_LOCALE_LANG_CODE    = "LocaleLanguageCode"; //!< \c MY_CURRENT_LANG_CODE    @brief Field Name for Current Language Code
        // My Org Settings Field Names
        const QString MY_APPLICATION_NAME   = "SettingsApplicationName"; //!< \c ConstSettingsApplicationName @brief QSettings Field Settings Application Name.
        const QString MY_ORG_NAME           = "SettingsOrgName";         //!< \c ConstSettingsOrgName         @brief QSettings Field Settings Org Name.
        const QString MY_ORG_DOMAIN         = "SettingsOrgDomain";       //!< \c ConstSettingsOrgDomain       @brief QSettings Field Settings Org Domain.
        const QString MY_GEOMETRY_POS       = "SettingsGeometryPos";     //!< \c ConstSettingsGeometryPos     @brief QSettings Field Settings Geometry Pos.
        const QString MY_GEOMETRY_SIZE      = "SettingsGeometrySize";    //!< \c ConstSettingsGeometrySize    @brief QSettings Field Settings Geometry Size.
        const QString MY_GEOMETRY_MAX       = "SettingsGeometryMax";     //!< \c ConstSettingsGeometryMax     @brief QSettings Field Settings Geometry Max.
        const QString MY_GEOMETRY_MIN       = "SettingsGeometryMin";     //!< \c ConstSettingsGeometryMin     @brief QSettings Field Settings Geometry Min.
        //
        const QString MY_APP_NAME_VALUE     = "QtAppVeyor";              //!< \c ConstDefaultAppName          @brief Default App Name.
        // Change this value if you fork this Project, just make sure it points to a valid Repository
        const QString MY_ORG_NAME_VALUE     = "Light-Wizzard";           //!< \c ConstDefaultOrgName          @brief Default Org Name.
        // This is the User Name and Project or GitHub URL, but does not have to be
        const QString MY_DEFAULT_DOMAIN     = "https://github.com";      //!< \c ConstDefaultDomain      @brief Default Domain, This can be any URL.
        // "https://github.com/Light-Wizzard/QtAppVeyor";
        const QString MY_DEFAULT_ORG_DOMAIN = MY_DEFAULT_DOMAIN + "/" + MY_ORG_NAME_VALUE + "/" + MY_APP_NAME_VALUE; //!< \c ConstDefaultOrgDomain @brief Default Org Domain.
};
#endif // MYCONSTANTS_H
/*** ************************* End of File ***********************************/
