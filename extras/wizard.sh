#!/bin/bash
#
# Copyleft and Written by Jeffrey Scott Flesher
# No Copyrights or Licenses
#
# shell?check -x .${TheWorkSpace}/wizard.sh
#
declare -x TheLastUpdate;       TheLastUpdate="31 July 2021 13:03";
declare -x TheScriptVersion;    TheScriptVersion="1.0.3.A";
declare -x TheWizardScriptName; TheWizardScriptName="wizard.sh";
declare -x TheWizardScriptName; TheWizardScriptName="Wizard Script";
#
declare -x ThisRoofFolder; ThisRoofFolder="${HOME}";
if [ ! -d "${ThisRoofFolder}" ]; then
    mkdir -p "${ThisRoofFolder}";    
fi
declare -x TheWorkSpace; TheWorkSpace="${ThisRoofFolder}/workspace/";    
# TheFullScriptPath
# Check to see if set
if [ -z ${TheFullScriptPath+x} ]; then declare -x TheFullScriptPath; TheFullScriptPath="$(dirname "$(readlink -f "${0}")")"; export TheFullScriptPath; fi
#
# TheWizardPath
# Check to see if set
if [ -z ${TheWizardPath+x} ]; then declare -x TheWizardPath; TheWizardPath="$TheFullScriptPath"; export TheWizardPath; fi
#
# Set to 1 the first time you start Hand Translating your Localization files so they do not get overwriten.
# TheLocalizedFilesSafe
# Check to see if set
if [ -z ${TheLocalizedFilesSafe+x} ]; then declare -ix TheLocalizedFilesSafe; TheLocalizedFilesSafe=0; export TheLocalizedFilesSafe; fi
#
# TheDebugging
# Check to see if set
if [ -z ${TheDebugging+x} ]; then declare -ix TheDebugging; TheDebugging=0; export TheDebugging; fi
#
# List all Distros you use here
#
# TheOsDistros
# Check to see if set
if [ -z ${TheOsDistros+x} ]; then declare -ax TheOsDistros; TheOsDistros=( "archlinux" ); export TheOsDistros; fi
#
# COPY_RSYNC
# Check to see if set
if [ -z ${COPY_RSYNC+x} ]; then declare -ix COPY_RSYNC; COPY_RSYNC=1 export COPY_RSYNC; fi
#
# SimulateThis
# Check to see if set
if [ -z ${SimulateThis+x} ]; then declare -ix SimulateThis; SimulateThis=0; export SimulateThis; fi
#
# ThisClearOk
# Check to see if set
if [ -z ${ThisClearOk+x} ]; then declare -ix ThisClearOk; ThisClearOk=0; export ThisClearOk; fi
#
# TestSshURL
# Check to see if set
if [ -z ${TestSshURL+x} ]; then declare -x TestSshURL; TestSshURL="localhost"; export TestSshURL; fi
# Test SSH Password
#
# TestSshUserPassword
# Check to see if set
if [ -z ${TestSshUserPassword+x} ]; then declare -x TestSshUserPassword; TestSshUserPassword="default"; export TestSshUserPassword; fi
# Test SSH Password
# TestSshRootPassword
# Check to see if set
if [ -z ${TestSshRootPassword+x} ]; then declare -x TestSshRootPassword; TestSshRootPassword="default"; export TestSshRootPassword; fi
#
# TestSshAppPath
# Check to see if set
if [ -z ${TestSshAppPath+x} ]; then declare -x TestSshAppPath; TestSshAppPath="default"; export TestSshAppPath; fi
#
# TestSshAppFolder
# Check to see if set
if [ -z ${TestSshAppFolder+x} ]; then declare -x TestSshAppFolder; TestSshAppFolder="default"; export TestSshAppFolder; fi
#
# TestSshUser
# Check to see if set
if [ -z ${TestSshUser+x} ]; then declare -x TestSshUser; TestSshUser="default"; export TestSshUser; fi
#
# TestSshIP
# Check to see if set
if [ -z ${TestSshIP+x} ]; then declare -x TestSshIP; TestSshIP="default"; export TestSshIP; fi
#
# TestSshPort
# Check to see if set
if [ -z ${TestSshPort+x} ]; then declare -x TestSshPort; TestSshPort="default"; export TestSshPort; fi
#
#
# ThisRunLocalizer
# Check to see if set
if [ -z ${ThisRunLocalizer+x} ]; then declare -ix ThisRunLocalizer; ThisRunLocalizer=0; export ThisRunLocalizer; fi
#
# TheDefaultLanguage
# Check to see if set
if [ -z ${TheDefaultLanguage+x} ]; then declare -x TheDefaultLanguage; TheDefaultLanguage="en"; export TheDefaultLanguage; fi
#
# ThisSimulateTrans
# Check to see if set
if [ -z ${ThisSimulateTrans+x} ]; then declare -ix ThisSimulateTrans; ThisSimulateTrans=0; export ThisSimulateTrans; fi
#
# ThisTabSpace
# Check to see if set
if [ -z ${ThisTabSpace+x} ]; then declare -x ThisTabSpace; ThisTabSpace="    "; export ThisTabSpace; fi
#
# ThisLocalizeAll
# Check to see if set
if [ -z ${ThisLocalizeAll+x} ]; then declare -ix ThisLocalizeAll; ThisLocalizeAll=1; export ThisLocalizeAll; fi # 1=True Localize all Files, this can get up to 8 Hours.
#
# UseFreeGoogleTrans
# Check to see if set
if [ -z ${UseFreeGoogleTrans+x} ]; then declare -ix UseFreeGoogleTrans; UseFreeGoogleTrans=1; export UseFreeGoogleTrans; fi  # 1=True Google Translation cost money
#
declare -a TheLocalizeLanguageList; TheLocalizeLanguageList=();                #
# TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="en";           # 1. Do not activate the default language
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="de";             # 2. German
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="fr";             # 3. French
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ja";             # 4. Japanese
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="zh-cn";          # 5. Chinese Simplified
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="zh-tw";          # 6. Chinese Traditional
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ar";             # 7. Arabic
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="es";             # 8. Spanish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ca";             # 9. Catalan
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="da";             # 10. Danish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="nl";             # 11. Dutch
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="tl";             # 12. Filipino
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="fi";             # 13. Finnish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="gl";             # 14. Galician
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="el";             # 15. Greek
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="haw";            # 16. Hawaiian
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="he";             # 17. Hebrew
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="hi";             # 18. Hindi
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="hu";             # 19. Hungarian
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="id";             # 20. Indonesian
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ga";             # 21. Irish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="it";             # 22. Italian
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ko";             # 23. Korean
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ku";             # 24. Kurdish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="pl";             # 25. Polish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="pt";             # 26. Portuguese
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="ru";             # 27. Russian
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="gd";             # 28. Scots Gaelic
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="sw";             # 29. Swahili
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="sv";             # 30. Swedish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="th";             # 31. Thai
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="tr";             # 32. Turkish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="vi";             # 33. Vietnamese
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="yi";             # 34. Yiddish
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="cy";             # 35. Welsh
TheLocalizeLanguageList[$((${#TheLocalizeLanguageList[@]}))]="zu";             # 36. Zulu
# if you want all of them, it will take a month to translate them for free
# TheLocalizeLanguageList=(af ak ar as ast be bg bn-bd bn-in br bs ca cs csb cy da de el en-gb en-us en-za eo es-ar es-cl es-es es-mx et eu fa ff fi fr fy-nl ga-ie gd gl gu-in he hi-in hr hu hy-am id is it ja kk km kn ko ku lg lij lt lv mai mk ml mr nb-no nl nn-no nso or pa-in pl pt-br pt-pt rm ro ru si sk sl son sq sr sv-se ta ta-lk te th tr uk vi zh-cn zh-tw zu);
#
#
declare -ax ThisProgress; ThisProgress=( "-" "\\" "|" "/" ); #
declare -i ThisProgression; ThisProgression=0;
#
# CREATE_LOCALIZER
# Check to see if set
if [ -z ${CREATE_LOCALIZER+x} ]; then declare -ix CREATE_LOCALIZER; CREATE_LOCALIZER=1; export CREATE_LOCALIZER; fi
#
# BashRc_Path
# Check to see if set
if [ -z ${BashRc_Path+x} ]; then declare -x BashRc_Path; BashRc_Path='/etc/bashrc'; export BashRc_Path; fi
#
# REFRESH_REPO
# Check to see if set
if [ -z ${REFRESH_REPO+x} ]; then declare -ix REFRESH_REPO; REFRESH_REPO=0; export REFRESH_REPO; fi
# Where the po.langage file goes -> Edit this line as needed for project
#
# TheLocalizedPath
# Check to see if set
if [ -z ${TheLocalizedPath+x} ]; then declare -x TheLocalizedPath; TheLocalizedPath="${TheFullScriptPath}/locale";  export TheLocalizedPath; fi
#
# Name to call the Langage File referanced above -> Edit this line as needed for project
if [ -z ${TheLocalizedFile+x} ]; then declare -ix TheLocalizedFile; TheLocalizedFile="wizard"; export TheLocalizedFile; fi
# Set to 1 the first time you start Hand Translating your Localization files so they do not get overwriten.
#
# TheLocalizedFilesSafe
# Check to see if set
if [ -z ${TheLocalizedFilesSafe+x} ]; then declare -ix TheLocalizedFilesSafe; TheLocalizedFilesSafe=0; export TheLocalizedFilesSafe; fi
# Change this to the Default Language that the Localized files are in
# TheDefaultLocalizedLanguage
# Check to see if set
if [ -z ${TheDefaultLocalizedLanguage+x} ]; then declare -x TheDefaultLocalizedLanguage; TheDefaultLocalizedLanguage='en'; export TheDefaultLocalizedLanguage; fi
# Localization of all script tags to support language
# TheRunLocalizer
# Check to see if set
if [ -z ${TheRunLocalizer+x} ]; then declare -ix TheRunLocalizer; TheRunLocalizer=0; export TheRunLocalizer; fi
# Create Help.html
#
# TheRunHelp
# Check to see if set
if [ -z ${TheRunHelp+x} ]; then declare -ix TheRunHelp; TheRunHelp=0; export TheRunHelp; fi
# 0=Disable, 1=Run, 2=Run Extended Test
#
# TheRunTest
# Check to see if set
if [ -z ${TheRunTest+x} ]; then declare -ix TheRunTest; TheRunTest=0; export TheRunTest; fi
# Automatically install from saved settings
# TheAutoMan
# Check to see if set
if [ -z ${TheAutoMan+x} ]; then declare -ix TheAutoMan; TheAutoMan=0; export TheAutoMan; fi
#
# 14-Jan-2013 @ 06:32:36 PM
#
# TheDateTime
# Check to see if set
if [ -z ${TheDateTime+x} ]; then declare -x TheDateTime; TheDateTime="$(date +"%d-%b-%Y @ %r")"; export TheDateTime; fi
# Day-Mon-YYYY-T-HH-MM: 14-Jan-2013-T-18-32
#
# TheLogDateTime
# Check to see if set
if [ -z ${TheLogDateTime+x} ]; then declare -x TheLogDateTime; TheLogDateTime="$(date +"%d-%b-%Y-T-%H-%M-%S")"; export TheLogDateTime; fi
#
# TheConfigName
# Check to see if set
if [ -z ${TheConfigName+x} ]; then declare -x TheConfigName; TheConfigName="wizzard"; export TheConfigName; fi
#
# TheLogPath
# Check to see if set
if [ -z ${TheLogPath+x} ]; then declare -x TheLogPath; TheLogPath="${TheFullScriptPath}/Support/Logs"; export TheLogPath; fi
#
# TheConfigPath
# Check to see if set
if [ -z ${TheConfigPath+x} ]; then declare -x TheConfigPath; TheConfigPath="${TheFullScriptPath}/Support/Config"; export TheConfigPath; fi
#
# TheErrorLog
# Check to see if set
if [ -z ${TheErrorLog+x} ]; then declare -x TheErrorLog; TheErrorLog="${TheLogPath}/0-${TheConfigName}-error.log"; export TheErrorLog; fi
#
# TheActivityLog
# Check to see if set
if [ -z ${TheActivityLog+x} ]; then declare -x TheActivityLog; TheActivityLog="${TheLogPath}/1-${TheConfigName}-activity.log"; export TheActivityLog; fi
#
# Install_Type_1
# Check to see if set
if [ -z ${Install_Type_1+x} ]; then declare -ix Install_Type_1; Install_Type_1=1; export Install_Type_1; fi
#
# ThisNetworkManager
# Check to see if set
if [ -z ${ThisNetworkManager+x} ]; then declare -x ThisNetworkManager; ThisNetworkManager="networkmanager"; export ThisNetworkManager; fi
#
# TheMountPoint
# Check to see if set
if [ -z ${TheMountPoint+x} ]; then declare -x TheMountPoint; TheMountPoint="/mnt/"; export TheMountPoint; fi
#
# TheDriveFormated
# Check to see if set
if [ -z ${TheDriveFormated+x} ]; then declare -ix TheDriveFormated; TheDriveFormated=1; export TheDriveFormated; fi
#
# YN_OPTION
# Check to see if set
if [ -z ${YN_OPTION+x} ]; then declare -x YN_OPTION; YN_OPTION=""; export YN_OPTION; fi
#
# TheAnswer 0=True and 1=False
# Check to see if set
if [ -z ${TheAnswer+x} ]; then declare -ix TheAnswer; TheAnswer=0; export TheAnswer; fi
# upvars
# if [ -f "${TheFullScriptPath}/upvars.sh" ]; then source "${TheFullScriptPath}/upvars.sh"; else echo "ERROR FILE NOT FOUND: - ${TheFullScriptPath}/upvars.sh"; exit 1; fi
#
# TODO
# Function names: mypackage::my_function() { ... } https://google.github.io/styleguide/shell.xml?showone=Function_Names#Function_Names
#
#
#-------------------------------------------------------------------------------
# This script will install Arch Linux,
# although it could be adapted to install any Linux distro that uses the same package names.
# This Script Assumes you wish GPT disk format, and gives you the choice to use UEFI, BIOS or no boot loader.
# The first time you use it, configure settings for Software and Configuration, you can use debugging help if needed, this will start the Wizard, follow instructions.
# You have the Option of Installing Software, this is just a list of Configuration files, and will save a series of files for later use.
# After reboot you have the option to run -i to install software; you can load the Software list if you already saved it; or create a new one.
# If after reboot you have no Internet access, run the Script with a -n and pick option 1 to setup network, then the option to ping.
#-------------------------------------------------------------------------------
# @FIX
# 1. Localization
# 2. Save all installed and removed into file for testing
# 3. Finish Menu load and save option.
# 4. Custom Install
# 5. Ask what drive to save log files to; only if live mode, case running from root, and want logs on flash drive.
#-------------------------------------------------------------------------------
# This Program is under the Free License. It is Free of any License or Laws Governing it.
# You are Free to apply what ever License you wish to it below this License.
# The Free License means that the End User has total Freedom while using the License,
# whereas all other License types fall short due to the Laws governing them,
# Free License is not covered by any Law, all programmers writing under the Free License,
# take an oath that the Software Contains No Malice: Viruses, Malware, or Spybots...
# and only does what it was intended to do, notifying End Users before doing it.
# All Programmers and End Users are Free to Distribute or Modify this script,
# as long as they list themselves as Programmers and Document Changes.
# Free License is also Free of any Liability or Legal Actions, Freedom starts with Free.
#-------------------------------------------------------------------------------
# Other LICENSES:
# 1. GNU
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Things to Fix
# Check for USERNAME in all Log functions and replace it with $SystemUserName
# Add function to ssh into account and get hostname; pull_hostname
#
shopt -s expand_aliases;
alias cls='printf "\033c"'; # Clear Terminal
#cls;
#
# Get current Device Script is Executing from
declare ScriptDevice;
declare ScriptDevice2;
if [ "$EUID" -eq 0 ]; then
    #ScriptDevice="$(df | grep -w "${TheFullScriptPath}" | awk {'print $1'})";
    # shellcheck disable=SC2034
    { read -r; read -r ScriptDevice ScriptDevice2;}< <(df .)
fi
#
declare -i ThisArrayIndex; ThisArrayIndex=0;
declare -x TheMenuPath;    TheMenuPath="${TheMenuPath:-"${TheFullScriptPath}/Support/Menu"}"
# Debugging
declare -ix Set_TheDebugging; Set_TheDebugging=0; # Used in set_debugging_mode
declare -ix TheSilentMode;    TheSilentMode=0;   # Used to Silence Logging and warnings
declare -ix E_BADARGS;
# shellcheck disable=SC2034
E_BADARGS=65;    # Return Bad Args
# Localization
#
# LocalizedID
# Check to see if set
if [ -z ${LocalizedID+x} ]; then declare -ax LocalizedID; LocalizedID=(); export LocalizedID; fi     # Localize ID for po file
#
# LocalizedMSG
# Check to see if set
if [ -z ${LocalizedMSG+x} ]; then declare -ax LocalizedMSG; LocalizedMSG=(); export LocalizedMSG; fi    # Localize MSG for po file
#
# LocalizedComment
# Check to see if set
if [ -z ${LocalizedComment+x} ]; then declare -ax LocalizedComment; LocalizedComment=(); export LocalizedComment; fi
#
# TEXT_SCRIPT_ID
# Check to see if set
if [ -z ${TEXT_SCRIPT_ID+x} ]; then declare -x TEXT_SCRIPT_ID; TEXT_SCRIPT_ID=""; export TEXT_SCRIPT_ID; fi
# Help
#
# HelpArray
# Check to see if set
if [ -z ${HelpArray+x} ]; then declare -ax HelpArray; HelpArray=(); export HelpArray; fi
# Helper Global Variables
declare -x MyString; MyString="";          # Used in Testing
# Network Detection
declare -x PingHost1; PingHost1="google.com";
declare -x PingHost2; PingHost2="wikipedia.org";
declare -x ActiveNetAdapter; ActiveNetAdapter="";  # Active Network Adapter Name: same as NIC
declare -a NIC; NIC=();            # Nic Name: eth0, eth1...
declare -a EthAddress; EthAddress=();     # Nic Address
declare -a EthReverseDNS; EthReverseDNS=();  # Nic Reverse DNS Address
# Note: Make sure to void these out on exit or reboot to clear them.
declare SystemUserName; SystemUserName="$(whoami)"; # User Name
declare USERPASSWD; USERPASSWD="";        # User Password
declare Root_Password; Root_Password="";     # Root Password
#
#declare BTICK; BTICK='`';            # Back Tick used in SQL
declare -x TICK; TICK="'";             # Tick used in Bash
#
declare -a USER_GROUPS; USER_GROUPS=();
# SSH
declare -x SSH_Keygen_Type; SSH_Keygen_Type="rsa";  # dsa
#
declare -ax LOCALE_ARRAY; LOCALE_ARRAY=( "" );
declare -ax LIST_DEVICES; LIST_DEVICES=( "" );
#
declare -ix INSTALL_NO_INTERNET; INSTALL_NO_INTERNET=0;
# FIXME
#
declare OPTION;              OPTION=" ";        # Options - Used in Input
declare -ax OPTIONS;         OPTIONS=();        # Array of Options - Used in Input
declare -ix INSTALL_WIZARD;  INSTALL_WIZARD=0;  # Install Wizard - Setup default list to execute; do it in code so recording Macros is not needed.
if [ -z ${TheAutoMan+x} ]; then declare -ix TheAutoMan; TheAutoMan=0; export TheAutoMan; fi
declare -ix BYPASS;          BYPASS=1;          # Allow Bypass in Input
declare -x MyReturn;         MyReturn="";       # Can be used to return data from functions
# Function Counters
declare -i HelpComplileCounter;     HelpComplileCounter=0;
declare -ix LocalizeComplileCounter; LocalizeComplileCounter=0;
declare -i TestCounter;             TestCounter=0;
# Formatting
declare -x SPACE;    SPACE="\x20";
declare -x HELP_TAB; HELP_TAB="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
# Editors
declare -x  EDITOR; EDITOR="nano";
declare -ax EDITORS; EDITORS=("nano" "emacs" "vi" "vim" "joe");
# AUTOMATICALLY DETECTS THE SYSTEM LANGUAGE
# automatically detects the system language based on your locale
declare -x TheLanguage; TheLanguage="$(locale | sed '1!d' | sed 's/LANG=//' | cut -c1-5)"; # en_US
declare -x LOCALE; LOCALE="$TheLanguage"; # en_US
declare -ax COUNTRIES; COUNTRIES=("Australia" "Belarus" "Belgium" "Brazil" "Bulgaria" "Canada" "Chile" "China" "Colombia" "Czech Republic" "Denmark" "Estonia" "Finland" "France" "Germany" "Greece" "Hungary" "India" "Ireland" "Israel" "Italy" "Japan" "Kazakhstan" "Korea" "Macedonia" "Netherlands" "New Caledonia" "New Zealand" "Norway" "Poland" "Portugal" "Romania" "Russian Federation" "Serbia" "Singapore" "Slovakia" "South Africa" "Spain" "Sri Lanka" "Sweden" "Switzerland" "Taiwan" "Ukraine" "United Kingdom" "United States" "Uzbekistan" "Viet Nam");
declare -ax TheCountryCodes;
# shellcheck disable=SC2034
TheCountryCodes=("AU" "BY" "BE" "BR" "BG" "CA" "CL" "CN" "CO" "CZ" "DK" "EE" "FI" "FR" "DE" "GR" "HU" "IN" "IE" "IL" "IT" "JP" "KZ" "KR" "MK" "NL" "NC" "NZ" "NO" "PL" "PT" "RO" "RU" "RS" "SG" "SK" "ZA" "ES" "LK" "SE" "CH" "TW" "UA" "GB" "US" "UZ" "VN");
declare -x COUNTRY_CODE;      COUNTRY_CODE=${LOCALE#*_}; # en_US = en-US = US
declare -x COUNTRY;           COUNTRY="United States";
declare -x LANGUAGE_LO;       LANGUAGE_LO="en-US";
declare -x LANGUAGE_HS;       LANGUAGE_HS="en";
declare -x LANGUAGE_AS;       LANGUAGE_AS="en";
declare -x LANGUAGE_KDE;      LANGUAGE_KDE="en_gb";
declare -x LANGUAGE_FF;       LANGUAGE_FF="en-us"; # af ak ar as ast be bg bn-bd bn-in br bs ca cs csb cy da de el en-gb en-us en-za eo es-ar es-cl es-es es-mx et eu fa ff fi fr fy-nl ga-ie gd gl gu-in he hi-in hr hu hy-am id is it ja kk km kn ko ku lg lij lt lv mai mk ml mr nb-no nl nn-no nso or pa-in pl pt-br pt-pt rm ro ru si sk sl son sq sr sv-se ta ta-lk te th tr uk vi zh-cn zh-tw zu
declare -x LANGUAGE_CALLIGRA; LANGUAGE_CALLIGRA="en";
declare -x KEYBOARD;          KEYBOARD="us"; # used to drill down into more specific layouts for some; not the same as KEYMAP necessarily
declare -x KEYMAP;            KEYMAP="us";
declare -x ZONE;              ZONE="America";
declare -x SUBZONE;           SUBZONE="Los_Angeles";
# OS Info
#
# My_OS
# Check to see if set
if [ -z ${My_OS+x} ]; then declare -x My_OS; My_OS=""; export My_OS; fi    # OS: Linux, FreeBSD, MAC, Windows
#
# My_DIST
# Check to see if set
if [ -z ${My_DIST+x} ]; then declare -x My_DIST; My_DIST=""; export My_DIST; fi    # CentOS, Arch Linux, Debian, Redhat
#
# My_PSUEDONAME
# Check to see if set
if [ -z ${My_PSUEDONAME+x} ]; then declare -x My_PSUEDONAME; My_PSUEDONAME=""; export My_PSUEDONAME; fi
#
# My_ARCH
# Check to see if set
if [ -z ${My_ARCH+x} ]; then declare -x My_ARCH; My_ARCH=""; export My_ARCH; fi
#
# My_Ver
# Check to see if set
if [ -z ${My_Ver+x} ]; then declare -x My_Ver; My_Ver="";  export My_Ver; fi
#
# My_Ver_Major
# Check to see if set
if [ -z ${My_Ver_Major+x} ]; then declare -x My_Ver_Major; My_Ver_Major=""; export My_Ver_Major; fi     # Major Version Number
#
# My_Ver_Minor
# Check to see if set
if [ -z ${My_Ver_Minor+x} ]; then declare -x My_Ver_Minor; My_Ver_Minor=""; export My_Ver_Minor; fi   # Major Version Number
#
# My_OS_Update
# Check to see if set
if [ -z ${My_OS_Update+x} ]; then declare -x My_OS_Update; My_OS_Update=""; export My_OS_Update; fi   # Patch Number
#
# My_OS_Package
# Check to see if set
if [ -z ${My_OS_Package+x} ]; then declare -x My_OS_Package; My_OS_Package="";  export My_OS_Package; fi
###############################################################################
# Wizard Development
# https://developer.android.com/studio/command-line/variables
declare -ix My_SOURCE_BASH_PROFILE; My_SOURCE_BASH_PROFILE=0; # If 0 it will not run My_APPEND_BASH_PROFILE
#
declare -x My_JAVA_JDK_HOME_DEFAULT;
declare -x My_STUDIO_JDK;
declare -x My_JAVA_JDK_DEFAULT;
declare -x My_JAVA_JRE_DEFAULT;
declare -x My_JAVA_VER;
declare -ix My_JAVA_VER_Rank;
#
declare -x My_GUI_EDITOR;
declare -x My_TERMINAL_EDITOR;
#
declare -x My_ANDROID_SDK_ROOT_DEFAULT;
declare -x My_ANDROID_NDK_ROOT_DEFAULT;
# My_ANDROID_NDK_VERSION=android-ndk-r20b
declare -x My_ANDROID_NDK_VERSION;
# Sets the path to the user-specific emulator configuration directory.
# The default location is $My_ANDROID_SDK_ROOT_DEFAULT/.android/.
declare -x My_ANDROID_EMULATOR_HOME;
# The default location is $ANDROID_EMULATOR_HOME/avd/.
# You might want to specify a new location if the default location is low on disk space.
declare -x My_ANDROID_AVD_HOME;
# Use this environment variable to set a default filter expression when you are running logcat from your development computer. For example
# set ANDROID_LOG_TAGS=ActivityManager:I MyApp:D *:.
declare -x My_ANDROID_LOG_TAGS;
# HTTP_PROXY
# ANDROID_VERBOSE
# ANDROID_EMULATOR_USE_SYSTEM_LIBS
# QEMU_AUDIO_DRV
# QEMU_AUDIO_OUT_DRV
# QEMU_AUDIO_IN_DRV
# ANDROID_SERIAL
#
# Set My_ANDROID_EABI to the EABI you want to use.
# You can find the list in ${My_ANDROID_NDK_ROOT}/toolchains.
# This value is always used.
# My_ANDROID_EABI="x86-4.6";
# My_ANDROID_EABI="arm-linux-androideabi-4.6";
# My_ANDROID_EABI="arm-linux-androideabi-4.8";
# My_ANDROID_EABI="arm-linux-androideabi-4.9";
# aarch64-linux-android-4.9
declare -x My_ANDROID_EABI;
# Set My_ANDROID_ARCH to the architecture you are building for.
# This value is always used.
# My_ANDROID_ARCH=arch-x86
declare -x My_ANDROID_ARCH;
# https://developer.android.com/ndk/guides/stable_apis
# Set My_ANDROID_API to the API you want to use.
# You should set it to one of:
# android-14, android-9, android-8, android-14, android-5 android-4, or android-3.
# You can't set it to the latest (for example, API-17) because the NDK does not supply the platform.
# At Android 5.0, there will likely be another platform added (android-22?).
# This value is always used:android-14, android-18, android-19, ...
declare -x My_ANDROID_API;
# https://developer.android.com/studio/releases/platforms
# Android 9 (API level 28)
#
# My_Dev_Folder="${HOME}\Dev";
declare -x My_Dev_Folder;
declare -ix My_USE_ENV_BASH_PROFILE; My_USE_ENV_BASH_PROFILE=0; # it either reads in your profile env=1 or skips it
declare -ix My_USE_FIPS;             My_USE_FIPS=0;
# FIXME NOW
#                                                            #
declare -x EDITOR;                  #EDITOR="";              #  Do not override
declare -x My_EDITOR;               My_EDITOR="";            #
#                                                            #
declare -ix INSTALL_JAVA;           INSTALL_JAVA=1;          #
#                                                            #
declare -x JAVA_HOME;               # JAVA_HOME="";          # Do not override
declare -x My_JAVA_HOME;            My_JAVA_HOME="";         #
#                                                            #
declare -x JAVA_JRE;                # JAVA_JRE="";           # Do not override
declare -x My_JAVA_JRE;             My_JAVA_JRE="";          #
#                                                            #
declare -x My_Current_Java;         My_Current_Java="";      #
#                                                            #
declare -x ANDROID_SDK_ROOT;        # ANDROID_SDK_ROOT="";   # Do not override
declare -x My_ANDROID_SDK_ROOT;     My_ANDROID_SDK_ROOT="";  #
#
# export ANDROID_NDK_ROOT=/Users/{YourUserName}/Library/Android/sdk
# export ANDROID_NDK=$ANDROID_NDK_ROOT/ndk-bundle
# https://developer.android.com/ndk/downloads
# android-ndk-r20b-linux-x86_64
#
#                                                            #
# Set ANDROID_NDK_ROOT to you NDK location.
# For example, /opt/android-ndk-r8e or /opt/android-ndk-r20b.
# If ANDROID_NDK_ROOT is not specified,
# the script will try to pick it up with the value of My_ANDROID_NDK_ROOT below.
# If ANDROID_NDK_ROOT is set, then the value is ignored.
declare -x ANDROID_NDK_ROOT;        # ANDROID_NDK_ROOT="";   # Do not override
declare -x My_ANDROID_NDK_ROOT;     My_ANDROID_NDK_ROOT="";  #
#                                                            #
declare -x ANDROID_TOOLCHAIN;       # ANDROID_TOOLCHAIN="";  # Do not override
declare -x My_ANDROID_TOOLCHAIN;    My_ANDROID_TOOLCHAIN=""; #
#                                                            #
declare -x ANDROID_SYSROOT;         # ANDROID_SYSROOT="";    # Do not override
declare -x My_ANDROID_SYSROOT;      My_ANDROID_SYSROOT="";   #
#                                                            #
declare -x ANDROID_EABI;            # ANDROID_EABI="";       # Do not override
declare -x My_ANDROID_EABI;         My_ANDROID_EABI="";      #
#                                                            #
declare -x FIPS_SIG;                # FIPS_SIG="";           # Do not override
declare -x My_FIPS_SIG;             My_FIPS_SIG="";          #
#                                                            #
# ############################################################ Menu Globals
declare -ix LAST_MENU_ITEM;         LAST_MENU_ITEM=0;        #
declare -x Breakable_Key;           Breakable_Key="";        #
#                                                            #
declare -i TputCols; TputCols=0; # Used in Printing to the Screen
#
declare -x prompt1; prompt1="$(gettext -s  "ENTER-OPTION")";
declare -x prompt2; prompt2="$(gettext -s  "ENTER-OPTIONS")";
declare -x StatusBar1; StatusBar1="$(gettext -s  "LOCALIZE_MAKE_CHOICE")";
declare -x StatusBar2; StatusBar2=" ";
# ############# COLORS ########################################################
# Themes
declare -ix TheThemeID; TheThemeID=${TheThemeID:-0};
# Menu Theme
#             Background      Foreground 1              Foreground 2              Foreground 3             Foreground Caution        Foreground Warn           Foreground Error          Test                      Separator
#             0               1                         2                         3                        4                         5                         6                         7                         8
# MenuTheme=("${T_Bg_Black}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Blue}${T_Bold}"   "${T_Fg_Red}${T_Bold}"    "${T_Fg_Green}${T_Bold}"  ")" ); # 0
#
declare -ax MenuTheme; MenuTheme=();
# *********************************# tput
# *********************************# tput Background
declare -x T_Bg_Black;             # 0: Black
# shellcheck disable=SC2034
# ugly T_Bg_Black="$(tput setab 0)";
T_Bg_Black="";
declare -x T_Bg_Red;               # 1: Red
# shellcheck disable=SC2034
T_Bg_Red="$(tput setab 1)";
declare -x T_Bg_Green;             # 2: Green
# shellcheck disable=SC2034
T_Bg_Green="$(tput setab 2)";
declare -x T_Bg_Yellow;            # 3: Yellow
# shellcheck disable=SC2034
T_Bg_Yellow="$(tput setab 3)";
declare -x T_Bg_Blue;              # 4: Blue
# shellcheck disable=SC2034
T_Bg_Blue="$(tput setab 4)";
declare -x T_Bg_Magenta;           # 5: Magenta
# shellcheck disable=SC2034
T_Bg_Magenta="$(tput setab 5)";
declare -x T_Bg_Cyan;              # 6: Cyan
# shellcheck disable=SC2034
T_Bg_Cyan="$(tput setab 6)";
declare -x T_Bg_White;             # 7: White
# shellcheck disable=SC2034
T_Bg_White="$(tput setab 7)";
declare -x T_Bg_default;           # 9: Default
# shellcheck disable=SC2034
T_Bg_default="$(tput setab 9)";
#
# ******************************** # tput Foreground
declare -x T_Fg_Black;             # 0: Black
# shellcheck disable=SC2034
T_Fg_Black="$(tput setaf 0)";
declare -x T_Fg_Red;               # 1: Red
# shellcheck disable=SC2034
T_Fg_Red="$(tput setaf 1)";
declare -x T_Fg_Light_Red;         # 161: Light Red
# shellcheck disable=SC2034
T_Fg_Light_Red="$(tput setaf 161)";
declare -x T_Fg_Green;             # 2: Green
# shellcheck disable=SC2034
T_Fg_Green="$(tput setaf 2)";
declare -x T_Fg_Light_Green;       # 19: Light Green
# shellcheck disable=SC2034
T_Fg_Light_Green="$(tput setaf 19)";
declare -x T_Fg_Yellow;            # 3: Yellow
# shellcheck disable=SC2034
T_Fg_Yellow="$(tput setaf 3)";
declare -x T_Fg_Light_Yellow;      # 11: Light Yellow
# shellcheck disable=SC2034
T_Fg_Light_Yellow=$(tput setaf 11);
declare -x T_Fg_Blue;              # 4: Blue
# shellcheck disable=SC2034
T_Fg_Blue="$(tput setaf 4)";
declare -x T_Fg_Light_Blue;        # 12: Light Blue
# shellcheck disable=SC2034
T_Fg_Light_Blue="$(tput setaf 12)";
declare -x T_Fg_Magenta;           # 5: Magenta
# shellcheck disable=SC2034
T_Fg_Magenta="$(tput setaf 5)";
declare -x T_Fg_Light_Magenta;     # 13: Light Magenta
# shellcheck disable=SC2034
T_Fg_Light_Magenta="$(tput setaf 13)";
declare -x T_Fg_Cyan;              # 6: Cyan
# shellcheck disable=SC2034
T_Fg_Cyan="$(tput setaf 6)";
declare -x T_Fg_Light_Cyan;        # 14: Light Cyan
# shellcheck disable=SC2034
T_Fg_Light_Cyan="$(tput setaf 14)";
declare -x T_Fg_White;             # 7: White
# shellcheck disable=SC2034
T_Fg_White="$(tput setaf 7)";
declare -x T_Fg_Light_White;       # 15: Light White
# shellcheck disable=SC2034
T_Fg_Light_White=$(tput setaf 15);
declare -x T_Fg_default;           # 9: Default
# shellcheck disable=SC2034
T_Fg_default="$(tput setaf 9)";
#
declare -x T_Reset;                # Reset
# shellcheck disable=SC2034
T_Reset="$(tput sgr0)";
declare -x T_Bold;                 # T_Bold
# shellcheck disable=SC2034
T_Bold="$(tput bold)";
declare -x T_Dim;                  # T_Dim
# shellcheck disable=SC2034
T_Dim="$(tput dim)";
declare -x T_Blink;                # T_Blink
# shellcheck disable=SC2034
T_Blink="$(tput blink)";
declare -x T_Begin_Underline;      # Begin Underline
# shellcheck disable=SC2034
T_Begin_Underline="$(tput smul)";
declare -x T_End_Underline;        # End Underline
# shellcheck disable=SC2034
T_End_Underline="$(tput rmul)";
declare -x T_Reverse;              # Reverse
# shellcheck disable=SC2034
T_Reverse="$(tput rev)";
declare -x T_Begin_Standout;       # Begin Standout
# shellcheck disable=SC2034
T_Begin_Standout="$(tput smso)";
declare -x T_End_Standout;         # End Standout
# shellcheck disable=SC2034
T_End_Standout="$(tput rmso)";


# *********************************# tput Background
declare -ax ColorsBG;
declare -ix ColorBgBlack;
declare -ix ColorBgRed;
declare -ix ColorBgGreen;
declare -ix ColorBgYellow;
declare -ix ColorBgBlue;
declare -ix ColorBgMagenta;
declare -ix ColorBgCyan;
declare -ix ColorBgWhite;
declare -ix ColorBgDefault;
#
# ******************************** # tput Foreground
declare -ax ColorsFG;
declare -ix ColorFgBlack;
declare -ix ColorFgRed;
declare -ix ColorFgLightRed;
declare -ix ColorFgGreen;
declare -ix ColorFgLightGreen;
declare -ix ColorFgYellow;
declare -ix ColorFgLightYellow;
declare -ix ColorFgBlue;
declare -ix ColorFgLightBlue;
declare -ix ColorFgMagenta;
declare -ix ColorFgLightMagenta;
declare -ix ColorFgCyan;
declare -ix ColorFgLightCyan;
declare -ix ColorFgWhite;
declare -ix ColorFgLightWhite;
declare -ix ColorFgDefault;
#

# tput civis # Hide Cursor
# tput cnorm # Display Cursor

declare -x T_Clear_EOL;            # Clear to End of Line
declare -x T_Clear_BOL;            # Clear to Beginning of Line
declare -x EXCLUDE_FILE_WARN;

# *************************************************************************** #
setVars()
{
    EXCLUDE_FILE_WARN=( "${TheConfigName}-1-taskmanager-name.db" "${TheConfigName}-1-taskmanager.db" "${TheConfigName}-0-packagemanager-name.db" "${TheConfigName}-0-packagemanager.db" "${TheConfigName}-2-packages.db" "${TheConfigName}-2-aur-packages.db" "${TheConfigName}-3-user-groups.db" "${TheConfigName}-4-software-config.db" );
    ColorsFG=();
    ColorFgBlack=0;
    ColorFgRed=1;
    ColorFgLightRed=161;
    ColorFgGreen=2;
    ColorFgLightGreen=19;
    ColorFgYellow=3;
    ColorFgLightYellow=11;
    ColorFgBlue=4;
    ColorFgLightBlue=12;
    ColorFgMagenta=5;
    ColorFgLightMagenta=13;
    ColorFgCyan=6;
    ColorFgLightCyan=14;
    ColorFgWhite=7;
    ColorFgLightWhite=15;
    ColorFgDefault=9;
    ColorsBG=();
    ColorBgBlack=0;
    ColorsBG["${ColorBgBlack}"]="$(tput setab 0)";         # 0: Black ${ColorsBG["${ColorBgBlack}"]}
    ColorBgRed=1;
    ColorsBG["${ColorBgRed}"]="$(tput setab 1)";           # 1: Red
    ColorBgGreen=2;
    ColorsBG["${ColorBgGreen}"]="$(tput setab 2)"          # 2: Green
    ColorBgYellow=3;
    ColorsBG["${ColorBgYellow}"]="$(tput setab 3)"         # 3: Yellow
    ColorBgBlue=4;
    ColorsBG["${ColorBgBlue}"]="$(tput setab 4)"           # 4: Blue
    ColorBgMagenta=5;
    ColorsBG["${ColorBgMagenta}"]="$(tput setab 5)"        # 5: Magenta
    ColorBgCyan=6;
    ColorsBG["${ColorBgCyan}"]="$(tput setab 6)"           # 6: Cyan
    ColorBgWhite=7;
    ColorsBG["${ColorBgWhite}"]="$(tput setab 7)"          # 7: White
    ColorBgDefault=9;
    ColorsBG["${ColorBgDefault}"]="$(tput setab 9)"        # 9: Default
    # shellcheck disable=SC2034
    T_Clear_EOL="$(tput el)";
    # shellcheck disable=SC2034
    T_Clear_BOL="$(tput el1)";
    ColorsFG["${ColorFgBlack}"]="$(tput setaf 0)";         # 0: Black ${ColorsFG["${ColorFgBlack}"]}
    ColorsFG["${ColorFgRed}"]="$(tput setaf 1)"            # 1: Red
    ColorsFG["${ColorFgLightRed}"]="$(tput setaf 161)"     # 161: Light Red
    ColorsFG["${ColorFgGreen}"]="$(tput setaf 2)"          # 2: Green
    ColorsFG["${ColorFgLightGreen}"]="$(tput setaf 19)"    # 19: Light Green
    ColorsFG["${ColorFgYellow}"]="$(tput setaf 3)"         # 3: Yellow
    ColorsFG["${ColorFgLightYellow}"]="$(tput setaf 11)"   # 11: Light Yellow
    ColorsFG["${ColorFgBlue}"]="$(tput setaf 4)"           # 4: Blue
    ColorsFG["${ColorFgLightBlue}"]="$(tput setaf 12)"     # 12: Light Blue
    ColorsFG["${ColorFgMagenta}"]="$(tput setaf 5)"        # 5: Magenta
    ColorsFG["${ColorFgLightMagenta}"]="$(tput setaf 13)"  # 13: Light Magenta
    ColorsFG["${ColorFgCyan}"]="$(tput setaf 6)"           # 6: Cyan
    ColorsFG["${ColorFgLightCyan}"]="$(tput setaf 14)"     # 14: Light Cyan
    ColorsFG["${ColorFgWhite}"]="$(tput setaf 7)"          # 7: White
    ColorsFG["${ColorFgLightWhite}"]="$(tput setaf 15)"    # 15: Light White
    ColorsFG["${ColorFgDefault}"]="$(tput setaf 9)"        # 9: Default
    exportVars;
    exportFunctions;
}
# *************************************************************************** #
exportVars()
{
    export EXCLUDE_FILE_WARN;
    export ColorsFG;
    export ColorFgBlack;
    export ColorFgRed;
    export ColorFgLightRed;
    export ColorFgGreen;
    export ColorFgLightGreen;
    export ColorFgYellow;
    export ColorFgLightYellow;
    export ColorFgBlue;
    export ColorFgLightBlue;
    export ColorFgMagenta;
    export ColorFgLightMagenta;
    export ColorFgCyan;
    export ColorFgLightCyan;
    export ColorFgWhite;
    export ColorFgLightWhite;
    export ColorFgDefault;
    export ColorsBG;
    export ColorBgBlack;
    export ColorBgRed;
    export ColorBgGreen;
    export ColorBgYellow;
    export ColorBgBlue;
    export ColorBgMagenta;
    export ColorBgCyan;
    export ColorBgWhite;
    export ColorBgDefault;
    export T_Clear_EOL;
    export T_Clear_BOL;
    export YN_OPTION;
    export TheFileCreatedDate;
    export TheFileModifiedDate;
}
# *************************************************************************** #
exportFunctions()
{
    export -f write_error;
    export -f trim;
    export -f ltrim;
    export -f rtrim;
    export -f string_len;
    export -f strip_leading_char;
    export -f strip_trailing_char;
    export -f add_trailing_char;
    export -f sub_string;
    export -f string_split;
    export -f string_replace;
    export -f load_2d_array;
    export -f localize_save;
    export -f clean_logs;
    export -f print_title;
    export -f print_info;
    export -f print_item;
    export -f print_list;
    export -f checkbox;
    export -f invalid_option;
    export -f invalid_options;
    export -f to_lower_case;
    export -f to_upper_case;
    export -f print_array;
    export -f assert;
    export -f os_info;
    export -f get_network_devices;
    export -f show_users;
    export -f device_list;
    export -f umount_partition;
    export -f read_input;
    export -f get_input_option;
    export -f clean_input;
    export -f read_input_options;
    export -f read_input_default;
    export -f read_input_data;
    export -f verify_input_default_data;
    export -f verify_input_data;
    export -f make_dir;
    export -f copy_file;
    export -f copy_files;
    export -f copy_dir;
    export -f remove_file;
    export -f remove_files;
    export -f remove_folder;
    export -f delete_line_in_file;
    export -f comment_file;
    export -f un_comment_file;
    export -f replace_option;
    export -f add_option;
    export -f make_file;
    export -f save_array;
    export -f load_array;
    export -f create_data_array;
    export -f add_menu_item;
    export -f restart_internet;
    export -f fix_network;
    export -f network_troubleshooting;
    export -f get_ip_from_url;
    export -f run_db_sql_file_ssh;
    export -f array_push;
    export -f remove_from_array;
    export -f get_index;
    export -f remove_array_duplicates;
    export -f date2stamp;
    export -f clear_logs;
    export -f add_user_group;
    export -f remove_user_group;
    export -f add_group;
    export -f add_user_2_group;
    export -f set_debugging_mode;
    export -f test_internet;
    export -f country_list;
    export -f get_country_codes;
    export -f get_country_code;
    export -f get_root_password;
    export -f get_user_name;
    export -f get_user_password;
    export -f get_locale;
    export -f yes_no;
    export -f select_create_user;
    export -f get_keyboard_layout;
    export -f configure_keymap;
    export -f get_editor;
    export -f configure_timezone;
    export -f db_backup;
    export -f create_database;
    export -f set_language;
    export -f create_ssh_user;
    export -f key_website;
    export -f random_password;
    export -f select_file;
    export -f password_safe;
    export -f install_package_with;
    export -f print_test_info;
    export -f print_themes;
    export -f is_installed;
    export -f is_ssh_keyed;
    export -f is_ssh_user;
    export -f is_os;
    export -f is_in_array;
    export -f is_string_in_file;
    export -f is_needle_in_haystack;
    export -f is_valid_email;
    export -f is_valid_path;
    export -f is_valid_domain;
    export -f is_valid_ip;
    export -f is_alphanumeric;
    export -f is_number;
    export -f is_wildcard_file;
    export -f is_internet;
    export -f is_online;
    export -f is_last_item;
    export -f is_user;
    export -f is_user_in_group;
    export -f is_group;
    export -f is_File_Smaller;
    export -f calculated_frame_rate;
    export -f is_frame_rate_min;
    export -f file_Size;
    export -f is_Alpha_String;
    export -f is_Valid_File_Name;
    export -f get_File_Inode;
    export -f is_root_user;
    export -f compare_versions;
    export -f get_FileName;
    export -f get_FilePath;
    export -f get_FileExtension;
    export -f rename_Space;
}
# END exportFunctions
# *************************************************************************** #
#
# Capname Description
# smcup   Save screen contents
# rmcup   Restore screen contents
# el1     Clear from the cursor to the beginning of the line
# ed      Clear from the cursor to the end of the screen
# clear   Clear the entire screen and home the cursor
# *************************************************************************** #
# *************************************************************************** #
# BEGIN run_Theme
update_Theme()
{
    # shellcheck disable=SC2034
    #MenuTheme=( "${NormalM}${BgBlackPm}${YellowPm}${BoldPm}m" "${NormalM}${BgBlackPm}${LightYellowPm}${BoldPm}m" "${NormalM}${BgBlackPm}${WhitePm}${BoldPm}m" ")" );
    # 0: Background
    # 1: Foreground 1
    # 2: Foreground 2
    # 3: Foreground 3
    # 4: Foreground Caution
    # 5: Foreground Warn
    # 6: Foreground Error
    # 7: Foreground Test
    # 8: Separator
    if [ "${TheThemeID}" -eq 0 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        #                 Background             Foreground 1                Foreground 2                Foreground 3         Foreground Caution        Foreground Warn            Foreground Error           Test                    Separator
        #           0                         1                         2                         3                        4                         5                         6                         7                         8
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Blue}${T_Bold}"   "${T_Fg_Red}${T_Bold}"    "${T_Fg_Green}${T_Bold}"  ")" ); # 0
    elif [ "${TheThemeID}" -eq 1 ]; then
        tput setab 7; # Set Background to White
        tput setaf 0; # Set Foreground to Black
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_White}"           "${T_Fg_Black}${T_Bold}" "${T_Fg_Black}"            "${T_Fg_Black}"          "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 1
    elif [ "${TheThemeID}" -eq 2 ]; then
        tput setab 4; # Set Background to Blue
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Blue}"            "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_White}${T_Bold}"  "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 2
    elif [ "${TheThemeID}" -eq 3 ]; then
        tput setab 6; # Set Background to Cyan
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Cyan}"            "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_White}${T_Bold}"   "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Red}"             "${T_Fg_Yellow}${T_Bold}" ")" ); # 3
    elif [ "${TheThemeID}" -eq 4 ]; then
        tput setab 2; # Set Background to Green
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Green}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Cyan}${T_Bold}"   "${T_Fg_Red}${T_Bold}"    "${T_Fg_Yellow}${T_Bold}" ")" ); # 4
    elif [ "${TheThemeID}" -eq 5 ]; then
        tput setab 3; # Set Background to Yellow
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Cyan}${T_Bold}"   "${T_Fg_Red}${T_Bold}"    "${T_Fg_Green}${T_Bold}"  ")" ); # 5
    elif [ "${TheThemeID}" -eq 6 ]; then
        tput setab 1; # Set Background to Red
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Red}"             "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Cyan}${T_Bold}"   "${T_Fg_Blue}${T_Bold}"   "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Green}${T_Bold}"  ")" ); # 6
    elif [ "${TheThemeID}" -eq 7 ]; then
        tput setab 5; # Set Background to Magenta
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Magenta}"         "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_White}${T_Bold}"  "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Cyan}${T_Bold}"   "${T_Fg_Green}${T_Bold}"  ")" ); # 7
    elif [ "${TheThemeID}" -eq 8 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 8
    elif [ "${TheThemeID}" -eq 9 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 9
    elif [ "${TheThemeID}" -eq 10 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 10
    elif [ "${TheThemeID}" -eq 11 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 11
    elif [ "${TheThemeID}" -eq 12 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 12
    elif [ "${TheThemeID}" -eq 13 ]; then
        tput setab 0; # Set Background to Black
        tput setaf 7; # Set Foreground to White
        if [ "$ThisClearOk" -eq 0 ]; then tput clear; fi
        # shellcheck disable=SC2034
        MenuTheme=( "${T_Bg_Black}"           "${T_Fg_Yellow}${T_Bold}" "${T_Fg_Yellow}${T_Bold}" "${T_Fg_White}${T_Bold}" "${T_Fg_Yellow}"          "${T_Fg_Magenta}"         "${T_Fg_Red}"             "${T_Fg_Green}"           ")" ); # 13
    fi
}
# END update_Theme
# *************************************************************************** #
# BEGIN print_themes
# HELPBUILDER print_themes
help_print_themes()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_THEMES_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_THEMES_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_THEMES_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# LOCALIZER print_themes
localize_print_themes()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_THEMES_USAGE" "print_this 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THEMES_DESC"  "Like print_info, without a blank line." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THEMES_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THEMES_MSG"   "print_themes Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_USE_THEME"   "Use Theme" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_themes()
{
    # Console width number
    TputCols="$(tput cols)";
    local -i total; total=13;
    local -i i;
    local OldThemeID;
    # shellcheck disable=SC2034
    OldThemeID=TheThemeID;
    for (( i=0; i<total; i++ )); do
        #tput sgr0;
        TheThemeID=${i};
        update_Theme;
        printf "${MenuTheme[0]}${MenuTheme[1]} %s : ${MenuTheme[2]} %s ${MenuTheme[3]} %s %s\n" "$(localize "${1}")" "${i}" "${2}" "${T_Clear_EOL}"; # | fold -sw $(( TputCols - 18 )) | sed 's/^/    /';
        print_this "LOCALIZE_USE_THEME" "${i}";
        #tput sgr0;
    done
    TheThemeID=OldThemeID;
}
# -------------------------------------
test_print_themes()
{
    ((TestCounter += 1));
    #print_themes  "LOCALIZE_PRINT_THEMES_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END print_themes
# *************************************************************************** #
# BEGIN print_this
# -------------------------------------
# HELPBUILDER print_this
help_print_this()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_THIS_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_THIS_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_THIS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="6 July 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_this
localize_print_this()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_THIS_USAGE" "print_this 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THIS_DESC"  "Like print_info, without a blank line." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THIS_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THIS_MSG"   "print_this Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_this()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_this()
{
    ((TestCounter += 1));
    print_this "LOCALIZE_PRINT_THIS_MSG" "PARM 2" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
export -f print_this;
# END print_this
# *************************************************************************** #
# BEGIN
# -------------------------------------
# HELPBUILDER print_that
help_print_that()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_THAT_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_THAT_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_THAT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_that
localize_print_that()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_THAT_USAGE" "print_that 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THAT_DESC"  "Like print_info, without a blank line and indented." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THAT_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_THAT_MSG"   "print_that Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_that()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "        %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_that()
{
    ((TestCounter += 1));
    print_that "LOCALIZE_PRINT_THAT_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
export -f print_that;
# END print_that
# *************************************************************************** #
# BEGIN print_caution
# -------------------------------------
# HELPBUILDER print_caution
help_print_caution()
{
    USAGE="$(localize "LOCALIZE_PRINT_CAUTION_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_CAUTION_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_CAUTION_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_caution
localize_print_caution()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_CAUTION_USAGE" "print_caution 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_CAUTION_DESC"  "Prints information on screen for end users to read, in a Column that is as wide as display will allow." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_CAUTION_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_CAUTION_MSG"   "print_caution Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# Same as Caution with no Return
print_read()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
print_caution()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_caution()
{
    ((TestCounter += 1));
    print_caution "LOCALIZE_PRINT_CAUTION_MSG" "TheThemeID=${TheThemeID}" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
}
export -f print_caution;
# END print_caution
# *************************************************************************** #
# BEGIN print_warning
# -------------------------------------
# HELPBUILDER print_warning
help_print_warning()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_WARNING_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_WARNING_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_WARNING_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_warning
localize_print_warning()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_WARNING_USAGE" "print_warning 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_WARNING_DESC"  "Print Warning" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_WARNING_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_WARNING_MSG"   "print_warning Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_warning()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[5]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[5]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_warning()
{
    ((TestCounter += 1));
    print_warning "LOCALIZE_PRINT_WARNING_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
export -f print_warning;
# END print_warning
# *************************************************************************** #
# BEGIN print_error
# -------------------------------------
# HELPBUILDER print_error
help_print_error()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_ERROR_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_ERROR_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_ERROR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_error
localize_print_error()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_ERROR_USAGE" "print_error 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ERROR_DESC"  "Print error" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ERROR_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ERROR_MSG"   "print_error Test" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> $(sub_string "${FUNCNAME[0]}" "localize_" 2)() : ${LINENO[0]}";
}
# -------------------------------------
print_error()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[6]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[6]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[5]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_error()
{
    ((TestCounter += 1));
    print_error "LOCALIZE_PRINT_ERROR_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
export -f print_error;
# END print_error
# *************************************************************************** #
# BEGIN print_test
# -------------------------------------
# HELPBUILDER print_test
help_print_test()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_TEST_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_TEST_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_TEST_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_test
localize_print_test()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_TEST_USAGE" "print_test 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_TEST_DESC"  "Print Test" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_TEST_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_TEST_MSG"   "print_test Print Test..." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_test()
{
    # Console width number
    TputCols="$(tput cols)";
    local thisLocalizedText; thisLocalizedText="$(localize "${1}")";
    # FINDME
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[7]}" "$thisLocalizedText" "${T_Reset}${MenuTheme[0]}${MenuTheme[7]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_test()
{
    ((TestCounter += 1));
    print_test "LOCALIZE_PRINT_TEST_MSG" "${FUNCNAME[0]} : ${LINENO[0]}";
}
export -f print_test;
# END print_test
# *************************************************************************** #
# BEGIN print_test_info
# LOCALIZER print_test_info
localize_print_test_info()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_TEST_PRINT_INFO_MSG" "Start wizard.sh Test" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_test_info()
{
    print_caution "LOCALIZE_TEST_PRINT_INFO_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END print_test_info
# *************************************************************************** #
# BEGIN print_title
# -------------------------------------
# HELPBUILDER print_title
help_print_title()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_TITLE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_TITLE_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_TITLE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_title
localize_print_title()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_TITLE_USAGE" "print_title 1->(Localized Text ID) 2->(Optional Text not Localized)" "Comment: print_title @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_TITLE_DESC"  "This will print a Header and clear the screen" "Comment: print_title @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_TITLE_NOTES" "Localized." "Comment: print_title @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_title()
{
    local TputCols; TputCols="$(tput cols)";
    #clear; # Does not help with Debugging or looking back at what you did
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    print_line;
    #                               1                2                                          3                    4                                          5           6                                          7           8
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[2]}" "${3:-" "}" "${T_Clear_EOL}" # | fold -sw $(( TputCols - 1 ));
    print_line;
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
}
# END print_title
# *************************************************************************** #
# BEGIN print_info
# -------------------------------------
# HELPBUILDER print_info
help_print_info()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_INFO_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_INFO_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_INFO_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_info
localize_print_info()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_INFO_USAGE" "print_info 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: print_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_INFO_DESC"  "Prints information on screen for end users to read, in a Column that is as wide as display will allow." "Comment: print_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_INFO_NOTES" "Localized." "Comment: print_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_INFO_TEST"  "Test print_info" "Comment: print_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_info()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    printf "%s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[2]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
}
# -------------------------------------
test_print_info()
{
    print_info "LOCALIZE_PRINT_INFO_TEST" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END print_info
# *************************************************************************** #
# BEGIN print_list
# -------------------------------------
# HELPBUILDER print_list
help_print_list()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_LIST_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_LIST_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_LIST_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_list
localize_print_list()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_LIST_USAGE" "print_list 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: print_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_LIST_DESC"  "Used to print Menu Descriptions, will change colors of text before and after a semi-colon" "Comment: print_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
    localize_info "LOCALIZE_PRINT_LIST_NOTES" "Localized." "Comment: print_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_list()
{
    #tput sgr0;
    local TputCols; TputCols="$(tput cols)";        # Console width number
    local thisString; thisString="$(localize "${1}")";
    local thisReturnStatus; thisReturnStatus="";
    if is_needle_in_haystack ": " "${thisString}" 4; then # 4=Middle
        if [ $# -eq 1 ]; then
            thisReturnStatus=$(sub_string "${thisString}" ":" 1);
            #echo "1=|${1}| --- thisString=${thisString} --- thisReturnStatus=|${thisReturnStatus}|";
            local Beginning="$thisReturnStatus";
            thisReturnStatus=$(sub_string "${thisString}" ":" 2);    # thisString was modified so use original;
            print_item "${Beginning}:" "${thisReturnStatus}";
        else
            thisReturnStatus=$(sub_string "${thisString}" ":" 1);
            local Beginning="$thisReturnStatus";
            thisReturnStatus=$(sub_string "$(localize "${1}")" ": " 2);    # thisString was modified so use original;
            print_item "${Beginning}:" "${thisReturnStatus}" "${2}";
        fi
    else
        if [ $# -eq 1 ]; then
            print_item "${thisString}";
        else
            print_item "${thisString}" "${2}";
        fi
    fi
    #echo ""; # This double spaces lines
    #tput sgr0;
}
# -------------------------------------
test_print_list()
{
    print_list "print_list Test: Description for Test.";
}
# END print_list
# *************************************************************************** #
# BEGIN print_item
# -------------------------------------
# HELPBUILDER print_item
help_print_item()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_ITEM_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_ITEM_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_ITEM_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_item
localize_print_item()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_ITEM_USAGE" "print_item 1->(Localized Text ID) 2->(Optional Not Localized Text)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ITEM_DESC"  "Used by print_list." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ITEM_NOTES" "Localized." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ITEM_MSG"   "print_item Test." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_item()
{
    # Console width number
    TputCols="$(tput cols)";
    printf "    %s%s%s %s%s %s%s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(localize "${1}")" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${2:-" "}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${3:-" "}" "${T_Clear_EOL}" | fold -sw $(( TputCols - 1 ));
}
# -------------------------------------
test_print_item()
{
    ((TestCounter += 1));
    print_item "LOCALIZE_PRINT_ITEM_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END print_item
# *************************************************************************** #
# BEGIN print_line
# -------------------------------------
# HELPBUILDER print_line
help_print_line()
{
    ((HelpComplileCounter += 1));
    USAGE="print_line";
    DESCRIPTION="$(gettext -s "PRINT-LINE-DESC")";
    NOTES="$(gettext -s "PRINT-LINE-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_line
localize_print_line()
{
    ((LocalizeComplileCounter += 1));
    localize_info "PRINT-LINE-DESC"  "Prints a line of dashes --- across the screen." "Comment: print_line @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "PRINT-LINE-NOTES" "None." "Comment: print_line @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_line()
{
    # Console width number
    TputCols="$(tput cols)";
    # shellcheck disable=SC2183
    printf "%s%*s%s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "${TputCols}" "${T_Clear_EOL}" | tr " " '-';
}
# -------------------------------------
test_print_line()
{
    print_line;
}
export -f print_line;
# END print_line
# *************************************************************************** #
# BEGIN pause_function
# -------------------------------------
# HELPBUILDER pause_function
help_pause_function()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "PAUSE_FUNCTION_USAGE")";        # pause_function 1->(Description) 2->(Debugging Information)
    DESCRIPTION="$(gettext -s "PAUSE_FUNCTION_DESC")";
    NOTES="$(gettext -s "PAUSE_FUNCTION_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER pause_function
localize_pause_function()
{
    ((LocalizeComplileCounter += 1));
    localize_info "PAUSE_FUNCTION_USAGE"   "pause_function 1->(Description Debugging Information)" "Comment: pause_function @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "PAUSE_FUNCTION_DESC"    "Pause function" "Comment: pause_function @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "PAUSE_FUNCTION_NOTES"   "Localized: Arguments passed in are not Localize, this is used for passing in Function names, that can not be localized; if required: localize before passing in." "Comment: pause_function @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "PRESS_ANY_KEY_CONTINUE" "Press any key to continue" "Comment: pause_function @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
pause_function()
{
    print_line;
    #tput sgr0;
    if [ $# -eq 1 ]; then
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE") [${1}]...";
    else
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE") [${1}] - [${2}]...";
    fi
    #tput sgr0;
}
export -f pause_function;
# END pause_function
# *************************************************************************** #
# BEGIN checkbox
# -------------------------------------
# HELPBUILDER checkbox
help_checkbox()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CHECK_BOX_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CHECK_BOX_DESC")";
    NOTES="$(localize "LOCALIZE_CHECK_BOX_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER checkbox
localize_checkbox()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CHECK_BOX_USAGE" "checkbox 1->(0={ }, 1={X}, 2={U})" "Comment: checkbox @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CHECK_BOX_DESC"  "Display {X} or { } or {U} in Menus." "Comment: checkbox @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CHECK_BOX_NOTES" "Used in Menu System." "Comment: checkbox @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
checkbox()
{
    if [ "${1}" -eq 0 ]; then
        echo -e "${MenuTheme[0]}${MenuTheme[1]}[ ]";
    elif [ "${1}" -eq 1 ]; then
        echo -e "${MenuTheme[0]}${MenuTheme[1]}[${MenuTheme[0]}${MenuTheme[2]}X${MenuTheme[0]}${MenuTheme[1]}]";
    elif [ "${1}" -eq 2 ]; then
        echo -e "${MenuTheme[0]}${MenuTheme[1]}[${MenuTheme[0]}${MenuTheme[2]}U${MenuTheme[0]}${MenuTheme[1]}]";
    fi
}
# END checkbox
# *************************************************************************** #
# BEGIN print_menu
# HELPBUILDER print_menu
help_print_menu()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_MENU_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_MENU_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_MENU_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_menu
localize_print_menu()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_MENU_USAGE" "${FUNCNAME[0]} 1->(MenuArray[@]) 2->(MenuInfoArray[@]) 3->(Letter to Exit)" "Comment: print_menu @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_MENU_DESC"  "Print Menu." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_MENU_NOTES" "Localized." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_MENU_MSG"   "$(sub_string "${FUNCNAME[0]}" "localize_" 2) Test." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_TEST_PRINT_MENU_1"   "Test Menu 1." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_2"   "Test Menu 2." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_3"   "Test Menu 3." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_4"   "Test Menu 4." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_TEST_PRINT_MENU_DESC_1"   "The Print Test Menu 1: Description." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_DESC_2"   "The Print Test Menu 2: Description." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_DESC_3"   "The Print Test Menu 3: Description." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_PRINT_MENU_DESC_4"   "The Print Test Menu 4: Description." "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "MENU-Q" "Quit" "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "MENU-B" "Back" "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "MENU-D" "Done" "Comment: ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# 1->(MenuArray[@])
# 2->(MenuInfoArray[@])
# 3->(Letter to Exit)
print_menu()
{
    [[ $# -ne 3 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    local -a arrayMenu=("${!1}");     # Array
    local -i total="${#arrayMenu[@]}";
    #
    local -a arrayInfo=("${!2}");     # Array
    local -i totalInfo="${#arrayInfo[@]}";
    #
    local -i index=0;
    TputCols="$(tput cols)";
    #tput sgr0;
    #
    # Line under Title
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    # Print Information Screen Above Menu
    for (( index=0; index<totalInfo; index++ )); do
        if [ "${totalInfo}" -le 8 ]; then
            if [ "${#arrayInfo[${index}]}" -gt 0 ]; then
                print_list "${SPACE}${arrayInfo[${index}]}";
            fi
        else
            if [ "${#arrayInfo[${index}]}" -gt 0 ]; then
                print_list "${arrayInfo[${index}]}";
            fi
        fi
    done
    # Print Menu
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    for (( index=0; index<total; index++ )); do
        if [ "${index}" -le 8 ]; then
            #echo -e "${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${arrayMenu[${index}]}"; #tput sgr0;
            printf "%s         %s%s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "${arrayMenu[${index}]}" "${T_Clear_EOL}";
        else
            #echo -e "${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${arrayMenu[${index}]}"; #tput sgr0;
            printf "%s        %s%s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "${arrayMenu[${index}]}" "${T_Clear_EOL}";
        fi
        ((LAST_MENU_ITEM++));
    done
    MY_ACTION=" ";
    if [ "${3}" == "Q" ]; then
        MY_ACTION="$(localize "MENU-Q")";
        Breakable_Key="Q";
    elif [ "${3}" == "B" ]; then
        MY_ACTION="$(localize "MENU-B")";
        Breakable_Key="B";
    elif [ "${3}" == "D" ]; then
        MY_ACTION="$(localize "MENU-D")";
        Breakable_Key="D";
    fi
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
    # Print Menu Breakable Key
    if [ "${index}" -le 8 ]; then
        echo -e "${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${3}) $MY_ACTION"; #tput sgr0;
    else
        echo -e "${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${3}) $MY_ACTION"; #tput sgr0;
    fi
    printf "%s%${TputCols}s\n" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "";
}
# -------------------------------------
test_print_menu()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n';
    #local -r MyMenuName="TestMenu";  # You must define Menu Name here
    #local -a TestMenuChecks=( $(load_array "${TheMenuPath}" "${MyMenuName}.db" 4 0 ) );
    # SC2034: TestMenuInfo appears unused. Verify it or export it.
    # shellcheck disable=SC2034
    # shellcheck disable=SC2207
    local -a TestMenuChecks=( $(create_data_array 4 0 ) );
    # SC2034: TestMenuInfo appears unused. Verify it or export it.
    # shellcheck disable=SC2034
    local -a TestMenuItems=();
    # SC2034: TestMenuInfo appears unused. Verify it or export it.
    # shellcheck disable=SC2034
    local -a TestMenuInfo=();
    print_this "LOCALIZE_PRINT_MENU_MSG" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #             1                2               3              4                       5  6  7                            8
    add_menu_item "TestMenuChecks" "TestMenuItems" "TestMenuInfo" "LOCALIZE_TEST_PRINT_MENU_1" "" "" "LOCALIZE_TEST_PRINT_MENU_DESC_1" "MenuTheme[@]";
    add_menu_item "TestMenuChecks" "TestMenuItems" "TestMenuInfo" "" "LOCALIZE_TEST_PRINT_MENU_2" "" "LOCALIZE_TEST_PRINT_MENU_DESC_2" "MenuTheme[@]";
    add_menu_item "TestMenuChecks" "TestMenuItems" "TestMenuInfo" "" "" "LOCALIZE_TEST_PRINT_MENU_3" "LOCALIZE_TEST_PRINT_MENU_DESC_3" "MenuTheme[@]";
    add_menu_item "TestMenuChecks" "TestMenuItems" "TestMenuInfo" "LOCALIZE_TEST_PRINT_MENU_4" "LOCALIZE_TEST_PRINT_MENU_1" "LOCALIZE_TEST_PRINT_MENU_2" "LOCALIZE_TEST_PRINT_MENU_DESC_4" "MenuTheme[@]";
    #
    print_menu "TestMenuItems[@]" "TestMenuInfo[@]" "Q";
    IFS="$ThisOldIFS";
}
export -f print_menu;
# END print_menu
# *************************************************************************** #
# BEGIN add_menu_item
# -------------------------------------
# HELPBUILDER add_menu_item
help_add_menu_item()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ADD_MENU_ITEM_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ADD_MENU_ITEM_DESC")";
    NOTES="$(localize "LOCALIZE_ADD_MENU_ITEM_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_menu_item
localize_add_menu_item()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_MENU_ITEM_USAGE" "add_menu_item 1->(Checkbox_List_Array) 2->(Menu_Array) 3->(Info_Array) 4->(Menu Description in White) 5->(In Yellow) 6->(In Red) 7->(Information Printed Above Menu) 8->(MenuTheme_Array[@])" "Comment: add_menu_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_MENU_ITEM_DESC"  "Add Menu Item." "Comment: add_menu_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_MENU_ITEM_NOTES" "Text should be Localize ID." "Comment: add_menu_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# total
# 1-> MenuChecks (Checkbox_List_Array)
# 2-> MenuItems (Menu_Array)
# 3-> MenuInfo (Info_Array)
# 4-> LocalWhite (Menu Description in White)
# 5-> LocalYellow (In Yellow)
# 6-> LocalRed (In Red)
# 7-> LocalInfo (Information Printed Above Menu)
# 8-> MenuTheme (MenuTheme_Array[@])
# -------------------------------------
add_menu_item()
{
    if [ $# -ne 8 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO"  "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local xIFS="${IFS}"; IFS=$'\n';
    #
    #get_stack "Here";
    #echo "${STACK}";
    #echo "${1}";
    #local -a MenuChecks=("${!1}");     # Array
    #local -i total="${#MenuChecks[@]}";
    #
    #local -a MenuItems=("${!2}");     # Array
    #local -i total="${#MenuItems[@]}";
    #
    #local -a MenuInfo=("${!3}");     # Array
    #local -i total="${#MenuInfo[@]}";

    #local LocalWhite=${4};
    #local LocalYellow=${5};
    #local LocalRed=${6};
    #local LocalInfo=${7};
#local MyMenuTheme=${8};

    #1 [[ -z ${MenuChecks} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuChecks"; pause_function " "; return 1; }
    #2 [[ -z ${MenuItems} ]]   && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuItems"; pause_function " "; return 1; }
    #3 [[ -z ${MenuInfo} ]]    && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuInfo"; pause_function " "; return 1; }
    #4 [[ -z ${LocalWhite} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalWhite"; pause_function " "; return 1; }
    #5 [[ -z ${LocalYellow} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalYellow"; pause_function " "; return 1; }
    #6 [[ -z ${LocalRed} ]]    && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalRed"; pause_function " "; return 1; }
    #7 [[ -z ${LocalInfo} ]]   && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalInfo"; pause_function " "; return 1; }
    #8 [[ -z ${MenuTheme} ]]   && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuTheme"; pause_function " "; return 1; }

    get_stack "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
    [[ -z ${1} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuChecks"; pause_function "${STACK}"; return 1; }
    [[ -z ${2} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuItems"; pause_function "${STACK}"; return 1; }
    [[ -z ${3} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuInfo"; pause_function "${STACK}"; return 1; }
    #[[ -z ${4} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalWhite"; pause_function "${STACK}"; return 1; }
    #[[ -z ${5} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalYellow"; pause_function "${STACK}"; return 1; }
    #[[ -z ${6} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalRed"; pause_function "${STACK}"; return 1; }
    [[ -z ${7} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): LocalInfo"; pause_function "${STACK}"; return 1; }
    [[ -z ${8} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MenuTheme"; pause_function "${STACK}"; return 1; }

    local -a arrayTheme=("${!8}");     # Theme Array
    local -i total_theme="${#arrayTheme[@]}";

    thisPrintDebug=0; # 0=No, 1=Yes
    thisSetDebug=0;   # 0=No, 1=Yes
    if [ ${thisSetDebug} -eq 1 ]; then set -x; fi # Turn On Debug mode
    if [ ${thisPrintDebug} -eq 1 ]; then
        echo "";
        echo "**********************************************";
        echo "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        echo "";
        #print_array "MenuChecks[@]" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        #local -i totalMenu=${#MenuChecks[@]};
        #echo "totalMenu=${totalMenu}";
        echo "";
        get_stack;
        echo "${STACK}";
        echo "**********************************************";
        echo "";
    fi
    # 1. Checkbox List Array -> 0 based Array
    # 2. Menu Array
    # 3. Info-Array
    # 4. Menu Description (In White)
    # 5. Menu Description (In Yellow)
    # 6. Menu Description (In Red)
    # 7. Informatin Printed Above Menu -> Build InfoArray
    # 8. Theme
    # @FIX pass in Checkbox-List-Array

    local -i total=0;
    #local -a checkbox_array=("${!1}")  # Checkbox List Array
    #echo "checkbox_array=${checkbox_array[@]}"
    eval "totalCheckbox=\${#$1[@]}"; # Checkbox_List_Array = 0 First Time
    if [ "${totalCheckbox}" -eq 0 ]; then
        array_push "${1}" "0"; # First Time we Create a Blank Checkbox Array; this means that a Save menu has not been Restored; so set it to 0
        totalCheckbox=1;
        LAST_MENU_ITEM=0;    # Reset this to 0, so we can count all menus and get total
    fi
    eval "total=\${#$2[@]}"; # MenuArray = 0 First Time; we push results into it
    #
    if [ "${total}" -ge "${totalCheckbox}" ]; then # First time total=0 and totalCheckbox=1, Second time total=1 and totalCheckbox=1, so we need to push a new chechbox, since we will push another menu item
        array_push "${1}" "0";
        ((totalCheckbox++));
    fi
    #
    eval "cba=\${$1[${total}]}"; # First time=0, Second time=1...
    #
    if [ -z ${cba+x} ]; then
        cba=0;
        if [ "${TheRunTest}" -eq 2 ]; then
            print_error "${FUNCNAME[0]}() checkbox null value is wrong! Menu Description: ${4} " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
        write_error "${FUNCNAME[0]}() checkbox null value is wrong! Menu Description: ${4} " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    if ! is_number "$cba" ; then
        if [ "${TheRunTest}" -eq 2 ]; then
            print_error "${FUNCNAME[0]}() checkbox value is wrong! total=${total} cba=$cba Menu Description: ${4} " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
        write_error "${FUNCNAME[0]}() checkbox value is wrong! total=${total} cba=$cba Menu Description: ${4} " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        cba=0;
    fi
    #
    if [ "${total_theme}" -ne 9 ]; then
        print_error "${FUNCNAME[0]}() MenuTheme wrong number arguments" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "${FUNCNAME[0]}() MenuTheme_Array should have 3 elements: total=${total} Menu Description: ${4} " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        arrayTheme[0]="${T_Bg_Black}";         # Background
        arrayTheme[1]="${T_Fg_Yellow}";        # Foreground 1
        arrayTheme[2]="${T_Fg_Light_Yellow}";  # Foreground 2
        arrayTheme[3]="${T_Fg_White}";         # Foreground 3
        arrayTheme[4]="${T_Fg_Yellow}";        # Caution
        arrayTheme[5]="${T_Fg_Magenta}";       # Warn
        arrayTheme[6]="${T_Fg_Red}";           # Error
        arrayTheme[7]="${T_Fg_Green}";         # Test
        arrayTheme[8]=")";                     # Seperater
    fi
    #
    array_push "${2}" "${arrayTheme[0]}${arrayTheme[1]}$(( total + 1 ))${arrayTheme[8]}${arrayTheme[3]} $(checkbox ${cba}) ${arrayTheme[4]}$(localize "${4}") ${arrayTheme[5]}$(localize "${5}") ${arrayTheme[6]}$(localize "${6}")";
    array_push "${3}" "$(localize "${7}")";
    IFS="${xIFS}";
    return 0;
}
# END add_menu_item
# *************************************************************************** #
# BEGIN get_stack
# *************************************************************************** #
# -------------------------------------
# HELPBUILDER get_stack
help_get_stack()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_GET_STACK_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_GET_STACK_DESC")";
    NOTES="$(localize "LOCALIZE_GET_STACK_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_stack
localize_get_stack()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_STACK_USAGE" "get_stack 1->(S{FUNCNAME}:S{LINENO[0]})" "Comment: print_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_STACK_DESC"  "Get Stack=S{STACK}" "Comment: print_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_STACK_NOTES" "Localized." "Comment: print_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_STACK_MSG"   "Get Stack is used for debugging." "Comment: print_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
function get_stack()
{
    if [ $# -ne 1 ]; then echo "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; fi
    STACK="";
    local message; message="${1:-""}"
    local stack_size; stack_size=${#FUNCNAME[@]};
    local func;
    local linen;
    local src;
    local i;
    # to avoid noise we start with 1 to skip the get_stack function
    # FIXME Replace all gone bad
    for (( i=1; i<stack_size; i++ )); do
        func="${FUNCNAME[$i]}"
        [ "$func" != "" ] && func=MAIN;
        linen="${BASH_LINENO[$(( i - 1 ))]}"
        src="${BASH_SOURCE[$i]}"
        [ "$src" != "" ] && src=non_file_source;
        STACK+=$'\n\t'"at: ${func} ${src} ${linen}"
    done
    STACK="${message}${STACK}";
}
# -------------------------------------
test_get_stack()
{
    ((TestCounter += 1));
    print_test "LOCALIZE_GET_STACK_MSG" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    get_stack "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    print_this "${STACK}";
}
export -f get_stack;
# END get_stack
# *************************************************************************** #
# BEGIN create_help
declare -i TheCreateHelp; TheCreateHelp=1;
# -------------------------------------
# HELPBUILDER create_help
help_create_help()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s  "LOCALIZE_CREATE_HELP_USAGE")";
    DESCRIPTION="$(gettext -s  "LOCALIZE_CREATE_HELP_DESC")";
    NOTES="$(gettext -s  "LOCALIZE_CREATE_HELP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="1 OCT 2012";
    REVISION="1 NOV 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER create_help
localize_create_help()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CREATE_HELP_USAGE"   "create_help 1->(NAME of Function.) 2->(USAGE) 3->(DESCRIPTION) 4->(NOTES) 5->(AUTHOR) 6->(VERSION) 7->(CREATED) 8->(REVISION) 9->(Source File and LINENO)" "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_HELP_DESC"    "Create an HTML Help File on the Fly" "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_HELP_NOTES"   "This Allows easy reading and Look up of all Functions in Program.<br />${HELP_TAB}This Function must be first Function all scripts see, so put it at the top of file.<br />${HELP_TAB}You can get as elaborate with help files as you want." "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_HELP_WORKING" "Create Help Working" "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
create_help()
{
    # shellcheck disable=SC2154
    if [ "${TheRunHelp}" -eq 0 ]; then
        return 0;
    elif [ "$TheCreateHelp" -eq 1 ]; then
        gettext -s "LOCALIZE_CREATE_HELP_WORKING";
        TheCreateHelp=0;
    fi
    echo -n ".";
    #echo "> ${1}";
    MY_HELP="<p class=\"function\" style=\"font-family:'Courier New'\"><span style=\"color:Crimson\">NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ${1}</span> <br /><span style=\"color:Blue\">USAGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ${2}  </span><br /><span style=\"color:DarkBlue\">DESCRIPTION: ${3}  </span><br /><span style=\"color:RoyalBlue\">NOTES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ${4}  </span><br /><span style=\"color:Red\">AUTHOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ${5}  </span><br /><span style=\"color:Cyan\">VERSION&nbsp;&nbsp;&nbsp;&nbsp;: ${6}  </span><br /><span style=\"color:DarkRed\">CREATED&nbsp;&nbsp;&nbsp;&nbsp;: ${7}  </span><br /><span style=\"color:FireBrick\">REVISION&nbsp;&nbsp;&nbsp;: ${8}  </span><br /><span style=\"color:Teal\">LINENO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ${9} </span></p>";
    HelpArray[$((${#HelpArray[@]}))]="$MY_HELP";
}
export -f create_help;
# END create_help
# *************************************************************************** #
# BEGIN debugger
help_debugger()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_DEBUGGER_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_DEBUGGER_DESC")";
    NOTES="$(gettext -s "LOCALIZE_DEBUGGER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
localize_debugger()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DEBUGGER_USAGE" "debugger 1->(1=On, x=Off)" "Comment: debugger @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DEBUGGER_DESC"  "Add Option: Ran from Task Manager." "Comment: debugger @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DEBUGGER_NOTES" "None." "Comment: debugger @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
debugger()
{
    if [ "${1}" -eq 1 ]; then set -v; set -x; else set +v; set +x; fi
}
export -f debugger;
# END debugger
# *************************************************************************** #
# BEGIN is_in_array
#
# IS IN ARRAY
# -------------------------------------
# HELPBUILDER is_in_array
help_is_in_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "IS-IN-ARRAY-USAGE")";      # is_in_array 1->(Array{@}) 2->(Search)
    DESCRIPTION="$(gettext -s "IS-IN-ARRAY-DESC")";
    NOTES="$(gettext -s "IS-IN-ARRAY-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_in_array
localize_is_in_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "IS-IN-ARRAY-USAGE" "is_in_array 1->(Array{@}) 2->(Search)"                                                                                                                                                                      "Comment: is_in_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS-IN-ARRAY-DESC"  "Is Search in Array{@}; return true (0) if found"                                                                                                                                                            "Comment: is_in_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS-IN-ARRAY-NOTES" "Use of Global ThisArrayIndex can be used in array index: if is_in_array Array{@} Search ; then MyArray{ThisArrayIndex}=1 ; fi; much like get_index; which bombs on not found; takes more code to write it." "Comment: is_in_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_in_array()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; return 1; }
    [[ -z ${2+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; return 1; }
    [[ -z ${3+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; return 1; }
    local -n thisArray=${1};
    local -i iMaxLen;       iMaxLen=${#thisArray[@]};
    local -i thisPrintTest; thisPrintTest="${3}";
    local -i index;         index=0;
    local -i returnStatus;  returnStatus=1;
    ThisArrayIndex=0;
    for index in "${!thisArray[@]}"; do
        if [ "${2}" == "${thisArray[${index}]}" ]; then
            ThisArrayIndex="${index}"; # used if you want to know what the index is
            returnStatus=0; # Return true
        fi
    done
    if [ "${thisPrintTest}" -eq 1 ]; then
        echo "is_in_array(${1}, ${2})";
        if [ "${iMaxLen}" -eq 0 ]; then
            print_caution "Empty Array"
        else
            for target in "${!thisArray[@]}"; do  echo "Array[${target}] = ${thisArray["${target}"]}";  done
        fi
    fi
    return "${returnStatus}"; # Return false
}
# -------------------------------------
test_is_in_array()
{
    ((TestCounter += 1));
    local -a MyArrayIsIn=( "1" "2" "3" );
    if is_in_array "MyArrayIsIn" "2" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "Looking for 2 and Found ${MyArrayIsIn[${ThisArrayIndex}]} $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_in_array
# *************************************************************************** #
# BEGIN remove_from_array
# -------------------------------------
# HELPBUILDER remove_from_array
help_remove_from_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_FROM_ARRAY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_FROM_ARRAY_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_FROM_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_from_array
localize_remove_from_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_FROM_ARRAY_USAGE" "remove_from_array 1->(array) 2->(Element)" "Comment: remove_from_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FROM_ARRAY_DESC"  "Remove Element from an Array." "Comment: remove_from_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FROM_ARRAY_NOTES" "Pass in Array by name 'array'." "Comment: remove_from_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_REMOVE_FROM_ARRAY_ERROR" "Wrong Parameters passed to remove_from_array" "Comment: remove_from_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_from_array()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local -n AlocalArray=${1};     # Array
    local -i iMaxStart=${#AlocalArray[@]};
    local -i iMaxEnd;
    local -i returnStatus; returnStatus=0;
    if is_in_array "${1}" "${2}" 0; then
        unset 'AlocalArray['"${ThisArrayIndex}"']';
        AlocalArray=("${AlocalArray[@]}");
        iMaxEnd=${#AlocalArray[@]};
        if [ "${iMaxEnd}" -eq "${iMaxStart}" ]; then
            returnStatus=1;
        fi
    fi
    return "${returnStatus}";
}
# -------------------------------------
test_remove_from_array()
{
    ((TestCounter += 1));
    local -a MyArrayRemove=( "1" "2" "3" );
    local -i iLenStart; iLenStart="${#MyArrayRemove[@]}";
    local -i iLenEnd; iLenEnd="${#MyArrayRemove[@]}";
    if is_in_array "MyArrayRemove" "2" 0; then
        remove_from_array "MyArrayRemove" "2";
        iLenEnd=${#MyArrayRemove[@]};
    fi
    if ! is_in_array "MyArrayRemove" "2" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "Had ${iLenStart} Elements Removed 1 now has ${iLenEnd} $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END remove_from_array
# *************************************************************************** #
# BEGIN print_help
# -------------------------------------
# HELPBUILDER print_help
help_print_help()
{
    ((HelpComplileCounter += 1));
    USAGE="print_help";
    DESCRIPTION="$(gettext -s "LOCALIZE_PRINT_HELP_DESC")";
    NOTES="$(gettext -s "LOCALIZE_PRINT_HELP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="1 OCT 2012";
    REVISION="1 NOV 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_help
localize_print_help()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_HELP_DESC"  "Print an HTML Help File on the Fly" "Comment: print_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_NOTES" "This Allows easy reading and Look up of all Functions in Program." "Comment: print_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_TITLE" "Arch Wizard Help File Generated on" "Comment: print_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_FUNCT" "Function" "Comment: print_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_ERROR" "Help Array Empty!" "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_MSG"   "Print Help for " "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_HELP_COMPLETE"   "Completed Print Help" "Comment: create_help @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_help()
{
    echo "";
    echo "Creating Help file: ${TheFullScriptPath}/help.html"
    print_caution "LOCALIZE_PRINT_HELP_MSG" "${HelpComplileCounter}";
    {
        echo "<!DOCTYPE html>";
        echo "<html>";
        echo "<body>";
        echo "$(gettext -s "LOCALIZE_PRINT_HELP_TITLE"): ${TheDateTime}";
        show_help 1;
        #if [ show_custom_help ] && show_custom_help >> "${TheFullScriptPath}/help.html"; # Must be defined in Custom Script
        echo "<hr />";
    } > "${TheFullScriptPath}/help.html";
    if [ "${#HelpArray[@]}" -ne 0 ]; then
        local -i index=0;
        for index in "${!HelpArray[@]}"; do
        {
            echo "$(gettext -s "LOCALIZE_PRINT_HELP_FUNCT") #${index}";
            echo "${HelpArray[${index}]}";
            echo "<hr />";
        }  >> "${TheFullScriptPath}/help.html"
        done
    else
        print_error "LOCALIZE_PRINT_HELP_ERROR";
    fi
    {
        echo "";
        echo "";
        echo "</body>";
        echo "</html>";
    } >> "${TheFullScriptPath}/help.html"
    echo "";
    echo "";
    print_info "LOCALIZE_PRINT_HELP_COMPLETE" "${TheFullScriptPath}/help.html";
}
export -f print_help;
# END print_help
# *************************************************************************** #
print_progress()
{
    echo -en "\b${ThisProgress[$((ThisProgression++))]}"; [[ ${ThisProgression} -ge 3 ]] && ThisProgression=0;
}
# *************************************************************************** #
# BEGIN localize_info
# -------------------------------------
# HELPBUILDER localize_info
help_localize_info()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_INFO_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_INFO_DESC")";
    NOTES="$(gettext -s "LOCALIZE_INFO_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER localize_info
localize_localize_info()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_INFO_DESC"  "Localize Info creates the &#36;{TheFullScriptPath}/Localize/en.po file used for Localization." "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INFO_NOTES" "Localized." "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INFO_USAGE" "localize_info 1->(Localize ID) 2->(Message to Localize) 3->(Comment)" "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "REMOVE_LOCALIZATION_FOLDER_WARNING" "Yes will Delete your Localization File, if you translate them by hand, you might not want to do this, back them up first if you want to keep them." "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# LOCALIZE INFO
# -------------------------------------
localize_info()
{
    if [ $# -ne 3 ]; then get_stack "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> ${STACK}"; exit 1; fi
    [[ -z ${1} ]] && { get_stack "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> ${STACK}"; exit 1; }
    [[ -z ${2+x} ]] && { get_stack "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> ${STACK}"; exit 1; }
    # localize_info 1->(Localize ID) 2->(Message to Localize) 3->(Comment)
    # shellcheck disable=SC2154
    [[ ${TheRunLocalizer} -eq 0 ]] && return 0;
    if [ "$CREATE_LOCALIZER" -eq 1 ]; then
        print_caution "Localizer Working..." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        CREATE_LOCALIZER=0;
    fi
    print_progress;
    #
    #echo ">: ${1}"
    # Check to see if its in Array
    #
    if [ "${#LocalizedID[@]}" -eq 0 ]; then
        LocalizedID[0]="${1}";
        LocalizedMSG[0]="${2}";
        LocalizedComment[0]="${3}";
    else
        if ! is_in_array "LocalizedID" "${1}" 0; then
            LocalizedID[${#LocalizedID[*]}]="${1}";
            LocalizedMSG[${#LocalizedMSG[*]}]="${2}";
            LocalizedComment[${#LocalizedComment[*]}]="${3}";
        else
                echo "Error ${1}"; exit 0;
        fi
    fi
    # if [ ${TheDebugging} -eq 1 ]; then echo "localize_info (ID = [${1}] - Message = [${2}] at line number: [${3}])"; fi
}
export -f localize_info;
# END localize_info
# *************************************************************************** #
# BEGIN localize
# -------------------------------------
# HELPBUILDER localize
help_localize()
{
    ((HelpComplileCounter += 1));
    USAGE="localize 1->(Localize ID) 2->(Optional: Print this with no Localization)";
    DESCRIPTION="$(gettext -s "LOCALIZE_DESC")";
    NOTES="$(gettext -s "LOCALIZE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER localize
localize_localize()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DESC"  "Localize Text, look up ID and return Localized string." "Comment: localize @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NOTES" "Localized. Used to Centralized the Localization Function, also to add more Functionality." "Comment: localize @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
localize()
{
    local -i thisPrintDebug;  thisPrintDebug=0;     # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;       # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi # Turn On Debug mode
    if [ ${thisPrintDebug} -eq 1 ]; then
        echo "";
        echo "********* localize() *************************";
        echo "${1}=$(gettext -s "${1}")";
        echo "**********************************************";
        echo "";
    fi
    # FINDME
    if [ $# -eq 1 ]; then echo -e "$(gettext -s "${1}")"; else echo -e "$(gettext -s "${1}") ${2}"; fi
    if [ ${thisSetDebug} -eq 1 ]; then set +x; fi # turn OFF debug mode
}
export -f localize;
# END localize
# *************************************************************************** #
# BEGIN localize_save
# -------------------------------------
# HELPBUILDER localize_save
help_localize_save()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_SAVE_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_SAVE_DESC")";
    NOTES="$(gettext -s "LOCALIZE_SAVE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sept 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER localize_save
localize_localize_save()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SAVE_USAGE" "localize 1->(Localize ID) 2->(Message to Localize) 3->(Print this with no Localization)" "Comment: localize_save @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SAVE_DESC"  "Localize ID and Message in &#36;{TheFullScriptPath}/Localize/en.po file."                 "Comment: localize_save @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SAVE_NOTES" "Localization Support, function will not overwrite msgids, delete all files if you want it to create new ones, else its only going to add new ones." "Comment: localize_save @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SAVE_MSG"   "Localizating" "Comment: localize_save @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZER_COMPLETED" "Localizer Completed." "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZER_REMOVING_FOLDER" "Localizer Removing Localize Folder." "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";

}
# -------------------------------------
localize_save()
{
    local -xi thisPrintDebug=0;        # 0=No, 1=Yes
    local -xi thisSetDebug=0;          # 0=No, 1=Yes
    if [ ${thisSetDebug} -eq 1 ]; then set -x; fi # Turn On Debug mode
    # http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/PO-Files.html
    #
    if [ "${TheRunLocalizer}" -eq 0 ]; then return 0; fi
    print_caution "LOCALIZE_SAVE_MSG" "${FUNCNAME[0]}()... ${LocalizeComplileCounter}" # No way to Localize this
    if [ "${TheLocalizedFilesSafe}" -eq 0 ]; then
        if [ -d "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}" ]; then
            ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
            read_input_yn "REMOVE_LOCALIZATION_FOLDER_WARNING" "Localization folder Removal" 0;
            BYPASS="$ThisOldByPass"; # Restore Bypass
            if [ "${YN_OPTION}" -eq 1 ]; then
                # FIXME Cannot delete folder that is in use, how to unload bash Localization to give up folder lock
                print_caution "LOCALIZER_REMOVING_FOLDER" "${FUNCNAME[0]}(): ${TheLocalizedPath} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                #remove_folder "${TheLocalizedPath}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        fi
    fi
    #
    make_dir "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/LC_MESSAGES/" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#    if [ -d "${TheLocalizedPath}" ]; then echo "TheLocalizedPath exist"; fi
#    if [ -d "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}" ]; then echo "TheLocalizedPath TheDefaultLocalizedLanguage exist"; fi
#    echo "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/${TheDefaultLocalizedLanguage}"
#    exit 1
    #
    echo "# Translation File"    >  "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/${TheDefaultLocalizedLanguage}.po"; # Overwrite
    echo ""                     >>  "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/${TheDefaultLocalizedLanguage}.po"; # Appends
    #
    local -i total="${#LocalizedID[@]}";
    local -i LanguagesIndex=0;
    echo "Localized total=${total}";
    #
    for LanguagesIndex in "${!LocalizedID[@]}"; do
        echo -en "\b${ThisProgress[$((ThisProgression++))]}"; [[ ${ThisProgression} -ge 3 ]] && ThisProgression=0;
        {
            echo "# ${LocalizedComment[$LanguagesIndex]} -> ${LocalizedMSG[$LanguagesIndex]}"
            echo "msgid \"${LocalizedID[$LanguagesIndex]}\""
            echo "msgstr \"${LocalizedMSG[$LanguagesIndex]}\""
            echo ""
        } >> "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/${TheDefaultLocalizedLanguage}.po";
    done
    #echo "Done 1";
    msgfmt -o "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/LC_MESSAGES/${TheLocalizedFile}.mo" "${TheLocalizedPath}/${TheDefaultLocalizedLanguage}/${TheDefaultLocalizedLanguage}.po";
    #
    ThisTranslator="simulate"; # moses google bing apertium
    local -a LanguagesTranslate=( "af" "ca" "de" "es" "fr" "ga" "gl" "hi" "it" "lt" "lv" "mt" "nl" "pl" "pt" "sq" );
    if [ "${ThisTranslator}" == "simulate" ]; then
        LanguagesTranslate=( "de" ); # Pick which ones you want to translate, see LanguagesTranslate
    #elif [ "${ThisTranslator}" == "google" ]; then
    #    LanguagesTranslate=( $(load_2d_array "${TheFullScriptPath}/Support/Source/gtranslate-cc.db" "1" ) ); # 1 is for Code
    #elif [ "${ThisTranslator}" == "bing" ]; then
    #    echo "Bing Translator";
        # Available for free up to 5,000 queries per month
        # curl 'http://api.apertium.org/json/translate?q=hello%20world&langpair=en%7Ces&callback=foo'
        #       http://api.apertium.org/json/translate?q=QUIT&langpair=en%7Csq
        # %7C = | (vertical bar)
    #elif [ "${ThisTranslator}" == "apertium" ]; then
    #    TRANSURL="http://api.apertium.org/json/translate";
    #    echo "set URL";
    #    LanguagesTranslate=( "af" "ca" "de" "es" "fr" "ga" "gl" "hi" "it" "lt" "lv" "mt" "nl" "pl" "pt" "sco" "sq" );
    #    API_Key="$API_KEY_APERTIUM"; # @FIX config add API key
    #elif [ "${ThisTranslator}" == "moses" ]; then
    #    LanguagesTranslate=( "af" "ca" "de" "es" "fr" "ga" "gl" "hi" "it" "lt" "lv" "mt" "nl" "pl" "pt" "sco" "sq" );
    fi
    #
    if [ ${thisPrintDebug} -eq 1 ]; then
        local -i transTotal="${#LanguagesTranslate[@]}";
        echo "transTotal=$transTotal";
    fi
    local LocalePath="";
    local RETURN_TRANS="";
    local -i index=0;
    for LanguagesIndex in "${!LanguagesTranslate[@]}"; do
        #echo "LanguagesIndex=$LanguagesIndex";
        LocalePath="${TheLocalizedPath}/${LanguagesTranslate[$LanguagesIndex]}/${LanguagesTranslate[$LanguagesIndex]}.po"; # [/script/locale]/lang/lang.po
        #echo "LocalePath=$LocalePath";
        make_dir "${TheLocalizedPath}/${LanguagesTranslate[$LanguagesIndex]}/LC_MESSAGES/" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        echo "";
        echo "${LanguagesTranslate[$LanguagesIndex]}";

        for index in "${!LocalizedID[@]}"; do
            echo -en "\b${ThisProgress[$((ThisProgression++))]}"; [[ ${ThisProgression} -ge 3 ]] && ThisProgression=0;
            if [ ! -f "$LocalePath" ]; then touch "$LocalePath"; fi # We do not want to overwrite it
            # This file may exist and may have hand translated entries, so to be safe; only create those entries that do not exist
            # Delete all files prior to calling this, if you want this function to create all new content.
            if ! is_string_in_file "$LocalePath" "msgid \"${LocalizedID[${index}]}\"" ; then
                if [ "${ThisTranslator}" == "simulate" ]; then
                    RETURN_TRANS="${LocalizedMSG[${index}]}";
                #elif [ "${ThisTranslator}" == "moses" ]; then
                    # $HOME
                    #~/mosesdecoder/bin/moses -f phrase-model/moses.ini < "${LocalizedMSG[${index}]}" > RESPONSE;
                    #~/mosesdecoder/bin/moses -f phrase-model/moses.ini < "Test" > RESPONSE;
                    #RETURN_TRANS="$(echo "$RESPONSE" | cut -d ':' -f 3 | cut -d '}' -f 1)";
                #elif [ "${ThisTranslator}" == "google" ]; then
                    #LANGPAIR="en%7C${LanguagesTranslate[$LanguagesIndex]}"; # "en|${LanguagesTranslate[$LanguagesIndex]}"
                    #echo "LANGPAIR=$LANGPAIR";
                    #PSTRING="$(echo "${LocalizedMSG[${index}]}" | tr " " '%20')"; # +
                    #PSTRING=${LocalizedMSG[${index}]// /%20};
                    #echo "PSTRING=$PSTRING";
                    # PSTRING=Invalid%Option
                    # Get translation
                    #echo "URL=${TRANSURL}?q=${PSTRING}&langpair=${LANGPAIR}&key=${API_Key}";
                    # URL=http://api.apertium.org/json/translate?q=Load%20Software:%20Will%20install%20Software%20Packages%20from%20above%20option.&langpair=en%7Ces&key=cwZdfGDhEkATSCydtSVYI7e3LI4
                    #RESPONSE="$(/usr/bin/env curl -s -A Mozilla ${TRANSURL}?q="${PSTRING}"&langpair="${LANGPAIR}"&key=${API_Key})"; # '&langpair='$LANGPAIR'&q='$PSTRING
                    # Parse and clean response, to show only translation.
                    #RETURN_TRANS="$(echo "$RESPONSE" | cut -d ':' -f 3 | cut -d '}' -f 1)";
                fi
                #
                {
                    echo "# ${LocalizedComment[${index}]} -> ${LocalizedMSG[${index}]}"
                    echo "msgid \"${LocalizedID[index]}\""
                    echo "msgstr \"${RETURN_TRANS}\""
                    echo ""
                }  >> "$LocalePath";
            fi
        done
        msgfmt -o "${TheLocalizedPath}/${LanguagesTranslate[$LanguagesIndex]}/LC_MESSAGES/${TheLocalizedFile}.mo" "${TheLocalizedPath}/${LanguagesTranslate[$LanguagesIndex]}/${LanguagesTranslate[$LanguagesIndex]}.po";
    done
    echo "";
    print_info "LOCALIZER_COMPLETED";
    if [ ${thisSetDebug} -eq 1 ]; then set +x; fi # turn OFF debug mode
}
# END localize_save
# *************************************************************************** #
# BEGIN is_string_in_file
# -------------------------------------
# HELPBUILDER is_string_in_file
help_is_string_in_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "IS_STRING_IN_FILE_USAGE")";      # is_string_in_file 1->(/full-path/file) 2->(search for string)
    DESCRIPTION="$(gettext -s "IS_STRING_IN_FILE_DESC")";
    NOTES="$(gettext -s "IS_STRING_IN_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_string_in_file
localize_is_string_in_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "IS_STRING_IN_FILE_USAGE" "is_string_in_file 1->(/full-path/file) 2->(search for string)" "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS_STRING_IN_FILE_DESC"  "Return true if string is in file." "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS_STRING_IN_FILE_NOTES" "Used to test files for Updates." "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS_STRING_IN_FILE_FNF"   "File Not Found" "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "IS_STRING_IN_FILE_MSG"   "Runnign Test is_string_in_file" "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# FIXME add escape filter
is_string_in_file()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${2} ]] && { return 1; }
    if [ -f "${1}" ]; then
        if is_file_user_read_access "${1}"; then
            if grep -q "${2}" "${1}"; then
                return 0;
            else
                return 1;
            fi
        else
            if sudo grep -q "${2}" "${1}"; then
                return 0;
            else
                return 1;
            fi
        fi
    else
        # Do not try this; re-cyclic - write_error "IS_STRING_IN_FILE_FNF" "(${1}) - (${2}) -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_error "IS_STRING_IN_FILE_FNF" "${FUNCNAME[0]}() (${1}) - (${2}) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        # shellcheck disable=SC2154
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
    fi
    return 1;
}
# END is_string_in_file
# -------------------------------------
test_is_string_in_file()
{
    ((TestCounter += 1));
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md"
    #print_test "IS_STRING_IN_FILE_MSG" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ -f "${ThisTestFile}" ]; then
        if is_string_in_file "${ThisTestFile}" "# FIND THIS LINE OF TEXT IN THIS FILE"; then # look for this static text
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_FILE_NOT_FOUND" "${FUNCNAME[0]} File not found: ${ThisTestFile} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    #
    print_caution "sudo required to run test" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    ThisTestFile="/etc/sudoers";
    if [ -f "${ThisTestFile}" ]; then
        if is_string_in_file "${ThisTestFile}" "## sudoers file."; then # look for this static text
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_FILE_NOT_FOUND" "${FUNCNAME[0]} File not found: ${ThisTestFile} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# *************************************************************************** #
# BEGIN write_error
# -------------------------------------
# HELPBUILDER write_error
help_write_error()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "WRITE_ERROR_USAGE")";
    DESCRIPTION="$(gettext -s "WRITE_ERROR_DESC")";
    NOTES="$(gettext -s "WRITE_ERROR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER write_error
localize_write_error()
{
    ((LocalizeComplileCounter += 1));
    localize_info "WRITE_ERROR_USAGE" "write_error 1->(Error) 2->(Debugging Information)" "Comment: write_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "WRITE_ERROR_DESC"  "Write Error to log." "Comment: write_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "WRITE_ERROR_NOTES" "Localized." "Comment: write_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
write_error()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    # shellcheck disable=SC2154
    if [ ! -f "${TheErrorLog}" ]; then
        print_test "Making TheErrorLog(${TheErrorLog}) in TheLogPath(${TheLogPath})" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        # shellcheck disable=SC2154
        [[ ! -d "${TheLogPath}" ]] && (mkdir -p "${TheLogPath}");
        touch "${TheErrorLog}";
    fi
    echo "$(gettext -s "${1}") (${2})" >> "${TheErrorLog}";
}
# -------------------------------------
test_write_error()
{
    ((TestCounter += 1));
    write_error "MY-ERROR-WRITE-ERROR" "write_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if is_string_in_file "${TheErrorLog}" "MY-ERROR-WRITE-ERROR" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END write_error
# *************************************************************************** #
# BEGIN trim
# -------------------------------------
# HELPBUILDER trim
help_trim()
{
    ((HelpComplileCounter += 1));
    USAGE="trim 1->( String to Trim )";
    DESCRIPTION="$(gettext -s "LOCALIZE_TRIM_DESC")";
    NOTES="$(gettext -s "LOCALIZE_TRIM_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="21 Dec 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER trim
localize_trim()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_TRIM_DESC"   "Remove space on Right and Left of string" "Comment: trim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TRIM_NOTES"  "MY_SPACE=' Left and Right '<br />${HELP_TAB}MY_SPACE=&#36;(trim &#34;&#36;MY_SPACE&#34;)<br />${HELP_TAB}echo &#34;|&#36;(trim &#34;&#36;MY_SPACE&#34;)|&#34;"   "Comment: trim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LLOC_TRIM_NOTES" "MY_SPACE=' Left and Right '<br />${HELP_TAB}MY_SPACE=&#36;(ltrim &#34;&#36;MY_SPACE&#34;)<br />${HELP_TAB}echo &#34;|&#36;(ltrim &#34;&#36;MY_SPACE&#34;)|&#34;" "Comment: trim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "RLOC_TRIM_NOTES" "MY_SPACE=' Left and Right '<br />${HELP_TAB}MY_SPACE=&#36;(rtrim &#34;&#36;MY_SPACE&#34;)<br />${HELP_TAB}echo &#34;|&#36;(rtrim &#34;&#36;MY_SPACE&#34;)|&#34;" "Comment: trim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
trim()
{
    # shellcheck disable=SC2005
    echo "$(rtrim "$(ltrim "${1}")")";
}
# END trim
# *************************************************************************** #
# BEGIN ltrim
# -------------------------------------
# HELPBUILDER ltrim
help_ltrim()
{
    ((HelpComplileCounter += 1));
    USAGE="ltrim 1->( String to Trim )";
    DESCRIPTION="$(gettext -s "LOCALIZE_LEFT_TRIM_DESC")";
    NOTES="$(gettext -s "LTRIM-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER ltrim
localize_ltrim()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_LEFT_TRIM_DESC"  "Remove space on Left of string" "Comment: ltrim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
ltrim()
{
    # Remove Left or Leading Space
    #
    #echo "${1}" | sed 's/^ *//g';
    #
    local old; old=$(shopt -p extglob);
    shopt -s extglob;
    echo "${1##*( )}";
    eval "$old";
}
# END ltrim
# *************************************************************************** #
# BEGIN rtrim
# -------------------------------------
# HELPBUILDER rtrim
help_rtrim()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_RIGHT_TRIM_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_RIGHT_TRIM_DESC")";
    NOTES="$(gettext -s "RTRIM-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER rtrim
localize_rtrim()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RIGHT_TRIM_USAGE" "rtrim 1->(' String to Trim ')" "Comment: rtrim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RIGHT_TRIM_DESC"  "Remove space on Right of string" "Comment: rtrim @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
rtrim()
{
    # Remove Right or Trailing Space
    [[ -z ${1} ]] && { echo ""; }
    #
    #echo "${1}" | sed 's/ *$//g';
    #
    local old; old=$(shopt -p extglob);
    shopt -s extglob;
    echo "${1%%*( )}";
    eval "$old";
}
# -------------------------------------
# Test All Trim Functions together
test_trim()
{
    ((TestCounter += 1));
    local MY_SPACE; MY_SPACE='  Left and Right  ';
    if [[ $(rtrim "$MY_SPACE") == '  Left and Right' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "rtrim @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "rtrim @  ${FUNCNAME[0]}() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    if [[ $(ltrim "$MY_SPACE") == 'Left and Right  ' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "ltrim @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "ltrim @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    if [[ $(trim "$MY_SPACE") == 'Left and Right' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "trim @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "trim @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END rtrim
# *************************************************************************** #
# BEGIN is_needle_in_haystack
# -------------------------------------
# HELPBUILDER is_needle_in_haystack
help_is_needle_in_haystack()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_DESC")";
    NOTES="$(gettext -s "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="22 Jan 2013";
    REVISION="22 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_needle_in_haystack
localize_is_needle_in_haystack()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_USAGE" "is_needle_in_haystack 1->(Needle to search in Haystack) 2->(Haystack to search in) 3->(Type of Search: 1=Exact, 2=Beginning, 3=End, 4=Middle, 5=Anywhere)" "Comment: is_needle_in_haystack @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_"  "Search for a Needle in the Haystack" "Comment: is_needle_in_haystack @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_NEEDLE_IN_HAYSTACK_NOTES" "None." "Comment: is_needle_in_haystack @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# is_needle_in_haystack 1->(Needle to search in Haystack) 2->(Haystack to search in) 3->(Type of Search: 1=Exact, 2=Beginning, 3=End, 4=Middle, 5=Anywhere, 6=Anywhere Exactly)
#
is_needle_in_haystack()
{
    if [[ "${1}" != *"${2}"* ]]; then
        if [[ "${2}" != *" "* ]]; then # Check to see if it has Spaces, then test it like an Array
            return 1;
        fi
    fi # If it not in the String return 1 for false
    local -i SearchResults=0;
    case ${2} in # Haystack
        "${1}") SearchResults=1 ;; # Match Exact Haystack String
       "${1}"*) SearchResults=2 ;; # Match Beginning of Haystack String
       *"${1}") SearchResults=3 ;; # Match End of Haystack String
      *"${1}"*) SearchResults=4 ;; # Needle String can be anywhere in the Haystack String
    esac
    if [ "$SearchResults" -eq "${3}" ]; then # SearchResults=0-4
        return 0;
    else
        if [ "${3}" -ge "5" ]; then                     # Anywhere in String
            if [ "$SearchResults" -ne "0" ] && [ "${3}" -ne "6" ]; then # SearchResults=0-4 - 0=No Found
                if [ "${TheRunTest}" -eq 3 ]; then echo "SearchResults=$SearchResults return at line ${LINENO[0]}"; fi
                return 0;
            else                                            # Check it like its an Array
                local -a MyNeedle=( "$("${1}")" );         # Create an Array from the Needle
                local -a Haystack=( "$("${2}")" );         # Create an Array from the Haystack
                local -i MyNeedleTotal="${#MyNeedle[@]}";   # 1 or Greater
                local -i index=0;                           # Index
                local -i HayStackIndex=0;                   # Index
                local -i H_Counter=0;                       # H_Counter how many times we find it
                local -a FoundIndex=();                     #
                trak=0
                if [ "${3}" -eq "5" ]; then                 # Anywhere Exactly in String: Haystack=1ABS 2ABS 1POS 2POS and Needle=ABS POS,
                    for HayStackIndex in "${!Haystack[@]}"; do
                        ((trak++));
                        for index in "${!MyNeedle[@]}"; do
                            local -i SearchResults=0;
                            case ${Haystack[$HayStackIndex]} in # Haystack Array
                                "${MyNeedle[${index}]}") SearchResults=1 ;; # Match Exact Haystack String
                               "${MyNeedle[${index}]}"*) SearchResults=2 ;; # Match Beginning of Haystack String
                               *"${MyNeedle[${index}]}") SearchResults=3 ;; # Match End of Haystack String
                              *"${MyNeedle[${index}]}"*) SearchResults=4 ;; # Needle String can be anywhere in the Haystack String
                            esac
                            if [ "$SearchResults" -ne "0" ]; then # SearchResults=0-4 - 0=No Found
                                if [ "${#FoundIndex[@]}" -eq 0 ]; then
                                    if [ "${TheRunTest}" -eq 3 ]; then echo "5. Needle=${MyNeedle[${index}]} | SearchResults=$SearchResults | index=${index}"; fi
                                    array_push "FoundIndex" "${index}";
                                    ((H_Counter++));
                                else
                                    if ! is_in_array "FoundIndex" "${index}" 0; then
                                        if [ "${TheRunTest}" -eq 3 ]; then echo "5. Needle=${MyNeedle[${index}]} | SearchResults=$SearchResults | index=${index}"; fi
                                        array_push "FoundIndex" "${index}";
                                        ((H_Counter++));
                                    fi
                                fi
                            fi
                        done
                    done
                    if [ "${TheRunTest}" -eq 3 ]; then echo "H_Counter=$H_Counter and MyNeedleTotal=$MyNeedleTotal"; fi
                    if [ "$H_Counter" -eq "$MyNeedleTotal" ]; then   # Keep in mind that we need another
                        return 0;
                    else
                        return 1;
                    fi
                else
                    for index in "${!MyNeedle[@]}"; do
                        if is_in_array "Haystack" "${MyNeedle[${index}]}" 0; then
                            if [ "${TheRunTest}" -eq 3 ]; then echo "Found ${MyNeedle[${index}]}"; fi
                            if [ "${3}" -eq "6" ]; then        # Anywhere Exactly in String: Haystack=12 13 and Needle=1 3,
                                if [ "${TheRunTest}" -eq 3 ]; then echo "6. Needle=${MyNeedle[${index}]} | SearchResults=$SearchResults | ThisArrayIndex=$ThisArrayIndex"; fi
                                ((H_Counter++));
                            fi
                        else
                            if [ "${TheRunTest}" -eq 3 ]; then echo "Not Found ${MyNeedle[${index}]}"; fi
                        fi
                    done
                    if [ "${TheRunTest}" -eq 3 ]; then echo "H_Counter=$H_Counter and MyNeedleTotal=$MyNeedleTotal"; fi
                    if [ "$H_Counter" -eq "$MyNeedleTotal" ]; then   # Keep in mind that we need another
                        return 0;
                    else
                        return 1;
                    fi
                fi
            fi
        else
            return 1;
        fi
    fi
    return 1; # We should never make it, but if we do, its an error
}
# END is_needle_in_haystack
# -----------------------------------------------------------------------------
test_is_needle_in_haystack()
{
    ((TestCounter += 1));
    HayStack="1 2 3 4 5";
    Needle="1 2 3 4 5"; # 1=Exact     : 1 2 3 4 5
    if is_needle_in_haystack "$Needle" "$HayStack" 1; then # 1=Exact
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    Needle="1";         # 2=Beginning : 1, 1 2 3 4, 1 2 3, 1 2
    if is_needle_in_haystack "$Needle" "$HayStack" 2; then # 2=Beginning
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    Needle="5";         # 3=End       : 5, 2 3 4 5, 3 4 5, 4 5
    if is_needle_in_haystack "$Needle" "$HayStack" 3; then # 3=End
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    Needle="3";         # 4=Middle    : 2 3, 2 3 4, 3 4, 3, 4
    if is_needle_in_haystack "$Needle" "$HayStack" 4; then # 4=Middle
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    HayStack="1ABS 2ABS 1POS 2POS";
    Needle="ABS POS";       # 5=Anywhere  : 1 5, 5 1, 1 2 3 5, 2 1 3 4 5, ...
    if is_needle_in_haystack "$Needle" "$HayStack" 5; then # 5=Anywhere
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    HayStack="1 4 5 12 3 15";
    Needle="1 3";       # 6=Anywhere Exactly  : Not found
    if is_needle_in_haystack "$Needle" "$HayStack" 6; then # 6=Anywhere Exactly
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# End test_is_needle_in_haystack
# *************************************************************************** #
# BEGIN string_len
# -------------------------------------
# HELPBUILDER string_len
help_string_len()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_STRING_LEN_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_STRING_LEN_DESC")";
    NOTES="$(gettext -s "LOCALIZE_STRING_LEN_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="25 Jan 2013";
    REVISION="25 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER string_len
localize_string_len()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_STRING_LEN_USAGE"   "string_len 1->('String')" "Comment: string_len @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_LEN_DESC"    "Given String, returns Length." "Comment: string_len @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_LEN_NOTES"   "Calls C function." "Comment: string_len @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
string_len()
{
    #echo "${#1}";
    #echo "$(expr "${1}" : '.*')"; # Use C Function
    # Fix in old code before removing
    #return $(expr "${1}" : '.*'); # Use C Function
    return "${#1}" # Uses Bash
}
# -------------------------------------
test_string_len()
{
    ((TestCounter += 1));
    MyString='A2B4C6';
    string_len "${MyString}";
    MyReturn=$?;
    if [ ${MyReturn} -eq 6 ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END string_len
# *************************************************************************** #
# BEGIN strip_leading_char
# -------------------------------------
# HELPBUILDER strip_leading_char
help_strip_leading_char()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_STRIP_LEADING_CHAR_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_STRIP_LEADING_CHAR_DESC")";
    NOTES="$(gettext -s "LOCALIZE_STRIP_LEADING_CHAR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="25 Jan 2013";
    REVISION="25 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER strip_leading_char
localize_strip_leading_char()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_STRIP_LEADING_CHAR_USAGE"   "strip_leading_char 1->('String') 2->(Character to remove)" "Comment: strip_leading_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRIP_LEADING_CHAR_DESC"   "Given String, returns with leading char removed if it existed." "Comment: strip_leading_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRIP_LEADING_CHAR_NOTES"   "Escape * i.e. (forwarslah)*" "Comment: strip_leading_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
strip_leading_char()
{
    echo "${1#${2}}";    #  The "1" refers to "${1}" which is string and "2" is Char to remove
}
# -------------------------------------
test_strip_leading_char()
{
    ((TestCounter += 1));
    MyString='/A2C4E6'; # Should pass without / in it also
    if [[ "$(strip_leading_char "${MyString}" "/")" == 'A2C4E6' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END strip_leading_char
# *************************************************************************** #
# BEGIN strip_trailing_char
# -------------------------------------
# HELPBUILDER strip_trailing_char
help_strip_trailing_char()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_STRIP_TRAILING_CHAR_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_STRIP_TRAILING_CHAR_DESC")";
    NOTES="$(gettext -s "LOCALIZE_STRIP_TRAILING_CHAR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="25 Jan 2013";
    REVISION="25 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER strip_trailing_char
localize_strip_trailing_char()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_STRIP_TRAILING_CHAR_USAGE"       "strip_trailing_char 1->('String') 2->(Character to remove)" "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRIP_TRAILING_CHAR_DESCRIPTION" "Given String, returns with trailing char removed if it existed." "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRIP_TRAILING_CHAR_NOTES"       "Escape * i.e. (forwardslash)*" "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
strip_trailing_char()
{
    echo "${1%${2}}";    #  The "1" refers to "${1}" which is string and "2" is Char to remove
}
# -------------------------------------
test_strip_trailing_char()
{
    ((TestCounter += 1));
    MyString='/A2C4E6/'; # Should pass without / in it also
    if [[ "$(strip_trailing_char "${MyString}" "/")" == '/A2C4E6' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END strip_trailing_char
# *************************************************************************** #
# BEGIN add_trailing_char
# -------------------------------------
# HELPBUILDER add_trailing_char
help_add_trailing_char()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_ADD_TRAILING_CHAR_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_ADD_TRAILING_CHAR_DESC")";
    NOTES="$(gettext -s "LOCALIZE_ADD_TRAILING_CHAR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="25 Jan 2013";
    REVISION="25 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_trailing_char
localize_add_trailing_char()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_TRAILING_CHAR_USAGE"       "strip_trailing_char 1->('String') 2->(Character to remove)" "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_TRAILING_CHAR_DESCRIPTION" "Given String, returns with trailing char removed if it existed." "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_TRAILING_CHAR_NOTES"       "Escape * i.e. (forwardslash)*" "Comment: strip_trailing_char @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
add_trailing_char()
{
    #  The "1" refers to "${1}" which is string and "2" is Char to remove
    if [[ "${1#${1%?}}" == "${2}" ]]; then
        echo "${1}";
    else
        echo "${1}${2}";
    fi
}
# -------------------------------------
test_add_trailing_char()
{
    ((TestCounter += 1));
    MyString='/A2C4E6'; # Should pass with / in it also
    if [[ "$(add_trailing_char "${MyString}" "/")" == '/A2C4E6/' ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# add_trailing_char
# *************************************************************************** #
# BEGIN sub_string
# -------------------------------------
# HELPBUILDER sub_string
help_sub_string()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_SUB_STRING_USAGE")";       # sub_string 1->('String') 2->(Search) 3->(1=Beginning, 2=End, 3=Remove)
    DESCRIPTION="$(gettext -s "LOCALIZE_SUB_STRING_DESC")";
    NOTES="$(gettext -s "LOCALIZE_SUB_STRING_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="25 Jan 2013";
    REVISION="25 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER sub_string
localize_sub_string()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SUB_STRING_USAGE"   "sub_string 1->('String') 2->(Search) 3->(1=Beginning, 2=End, 3=Remove) <- returns in var MyString" "Comment: sub_string @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SUB_STRING_DESC"    "Returns Sub Strings" "Comment: sub_string @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SUB_STRING_NOTES"   "See Run Test examples." "Comment: sub_string @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
sub_string()
{
    local MyStringOriginal; MyStringOriginal="${1}";  #
    local MySeperator;      MySeperator="${2}";       #
    local -i MyStartPoint;  MyStartPoint="${3}";      # 1=Beginning, 2=End, 3=Remove
    [[ -z ${MyStringOriginal} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyStringOriginal"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    [[ -z ${MySeperator} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MySeperator"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    local thisStringBeginning;
    local thisStringEnd;
    local -i thisPrintDebug; thisPrintDebug=0;        # 0=No, 1=Yes
    local -i thisSetDebug;   thisSetDebug=0;          # 0=No, 1=Yes
    if [ ${thisSetDebug} -eq 1 ]; then set -x; fi # Turn On Debug mode
    if [ ${thisPrintDebug} -eq 1 ]; then
        echo "";
        echo "**********************************************";
        get_stack "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "${STACK}";
        echo "**********************************************";
        echo "";
    fi

    if [[ "${MyStringOriginal}" == *"${MySeperator}"* ]]; then
        if [ "${MyStartPoint}" -eq 1 ]; then
            # Beginning
            thisStringBeginning="${MyStringOriginal%${MySeperator}*}"
            echo "${thisStringBeginning}";
            return 0;
        elif [ "${MyStartPoint}" -eq 2 ]; then
            thisStringEnd="${MyStringOriginal#*${MySeperator}}"
            echo "${thisStringEnd}";
            return 0;
        elif [ "${MyStartPoint}" -eq 3 ]; then
            thisStringBeginning="${MyStringOriginal%${MySeperator}*}"
            thisStringEnd="${MyStringOriginal#*${MySeperator}}"
            echo "${thisStringBeginning}${thisStringEnd}";
            return 0;
        elif [ "${MyStartPoint}" -eq 4 ]; then
            thisStringBeginning=${MyStringOriginal#*|}
            thisStringBeginning=${thisStringBeginning%|*}
            echo "${thisStringBeginning}";
            return 0;
        fi
    else
        echo "${MyStringOriginal}";
        return 1;
    fi
    if [ ${thisSetDebug} -eq 1 ]; then set +x; fi # turn OFF debug mode
    return 1;
}
# -------------------------------------
test_sub_string()
{
    ((TestCounter += 1));
    # 'MainItem 10: SubItem 10 and its description.'
    local thisSeperator;         thisSeperator=":";
    local thisStringBeginning;   thisStringBeginning="MainItem 10";
    local thisStringEnd;         thisStringEnd=" SubItem 10 and its description.";
    local thisStringOriginal;    thisStringOriginal="${thisStringBeginning}${thisSeperator}${thisStringEnd}";
    local thisReturnStatus;
    # 1=Beginning, 2=End, 3=Remove
    # 1. Beginning
    thisReturnStatus=$(sub_string "${thisStringOriginal}" "${thisSeperator}" 1);
    if [ "${thisReturnStatus}" == "${thisStringBeginning}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "1:Beginning @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "1:Beginning |${thisReturnStatus}| @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    # 2. End
    thisReturnStatus=$(sub_string "${thisStringOriginal}" "${thisSeperator}" 2);
    if [ "$thisReturnStatus" == "$thisStringEnd" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "2:End @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "2:End @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    # 3. Remove
    thisReturnStatus=$(sub_string "${thisStringOriginal}" "${thisSeperator}" 3);
    if [ "$thisReturnStatus" == "${thisStringBeginning}${thisStringEnd}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "3:Remove @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "3:Remove @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    # 4. Between
    thisStringOriginal="This is text with delimited text |Pass| and some like [Fail]";
    thisSeperator="|";
    thisReturnStatus=$(sub_string "${thisStringOriginal}" "${thisSeperator}" 4);
    if [ "$thisReturnStatus" == "Pass" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "4:Between @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "4:Between |${thisReturnStatus}| @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END sub_string
# *************************************************************************** #
# BEGIN string_split
# -------------------------------------
# HELPBUILDER string_split
help_string_split()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_STRING_SPLIT_USAGE")";     # string_split 1->('String') 2->(delimitor) 3->(section:1=First,2=Second...)
    DESCRIPTION="$(gettext -s "LOCALIZE_STRING_SPLIT_DESC")";
    NOTES="$(gettext -s "LOCALIZE_STRING_SPLIT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.1";
    CREATED="25 Jan 2013";
    REVISION="26 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER string_split
localize_string_split()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_STRING_SPLIT_USAGE"   "string_split 1->('String') 2->(delimiter) 3->(First_Half)" "Comment: string_split @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_SPLIT_DESC"    "Split String into half's, returns First Half if 1, if 0 second half." "Comment: string_split @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_SPLIT_NOTES"   "bla@some.com;john@doe.com | path:root" "Comment: string_split @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
string_split()
{
    local ThisOldIFS="${IFS}"; IFS=$"${2}"; # Very Important
    local -i Counter; Counter=0;
    local MySection;  MySection="";
    local -a MyArr;
    # shellcheck disable=SC2206
    MyArr=(${1}); # Automatically converts it to an Array removing the delimiters
    IFS=$" ";
    for MySection in "${MyArr[@]}" ; do
        ((Counter++));
        if [ "${Counter}" -eq "${3}" ]; then echo "${MySection}"; fi
    done
    IFS="$ThisOldIFS";
}
# -------------------------------------
test_string_split()
{
    ((TestCounter += 1));
    local thisString='section-1:section-2:section-3';
    if [[ "$(string_split "${thisString}" ":" 1):$(string_split "${thisString}" ":" 2):$(string_split "${thisString}" ":" 3)" == "${thisString}" ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END string_split
# *************************************************************************** #
# BEGIN string_replace
# -------------------------------------
# HELPBUILDER string_replace
help_string_replace()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_STRING_REPLACE_USAGE")";     # string_replace 1->('String') 2->(Replace) 3->(With this)
    DESCRIPTION="$(gettext -s "LOCALIZE_STRING_REPLACE_DESC")";
    NOTES="$(gettext -s "LOCALIZE_STRING_REPLACE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.1";
    CREATED="25 Jan 2013";
    REVISION="26 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER string_replace
localize_string_replace()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_STRING_REPLACE_USAGE"   "string_replace 1->('String') 2->(Replace) 3->(With this)" "Comment: $(sub_string "${FUNCNAME[0]}" "localize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_REPLACE_DESC"    "Replace String occurrence with something else."           "Comment: $(sub_string "${FUNCNAME[0]}" "localize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_STRING_REPLACE_NOTES"   "string_replace ' ' '_' "                                  "Comment: $(sub_string "${FUNCNAME[0]}" "localize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
string_replace()
{
    echo "${1//${2}/${3}}";
}
# -------------------------------------
test_string_replace()
{
    ((TestCounter += 1));
    local thisString="domain.com";
    if [[ "$(string_replace "${thisString}" "." "_")" == "domain_com" ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END string_replace
# *************************************************************************** #
# BEGIN load_2d_array
# -------------------------------------
# HELPBUILDER load_2d_array
help_load_2d_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(gettext -s "LOCALIZE_LOAD_2D_ARRAY_USAGE")";
    DESCRIPTION="$(gettext -s "LOCALIZE_LOAD_2D_ARRAY_DESC")";
    NOTES="$(gettext -s "LOCALIZE_LOAD_2D_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER load_2d_array
localize_load_2d_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_LOAD_2D_ARRAY_USAGE"   "Array=( &#36;(load_2d_array 1->(/Path/ArrayName.ext) 2->(0=First Array, 1=Second Array) ) )" "Comment: load_2d_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_LOAD_2D_ARRAY_DESC"    "Load a saved 2D Array from Disk"                                     "Comment: load_2d_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_LOAD_2D_ARRAY_NOTES"   "This Function Expects a file, bombs if not found."                   "Comment: load_2d_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_LOAD_2D_ARRAY_MISSING" "Missing File"                                                        "Comment: load_2d_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
load_2d_array()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -f "${1}" ]; then
        local lines=();
        local line="";
        local ThisOldIFS="$IFS";
        IFS=$" "; # You would think you need to use IFS=$'\n\t' since its a file, but what it needs to do is expand the spaces
        while read -r line; do
            # shellcheck disable=SC2206
            lines=($line); # Stored Data - Do not quote
            echo -e "${lines["${2}"]}";
        done < "${1}"; # Load Array from serialized disk file
        IFS="$ThisOldIFS";
    else
        print_error "LOCALIZE_LOAD_2D_ARRAY_MISSING" "${1}";
        write_error "LOCALIZE_LOAD_2D_ARRAY_MISSING" ": ${1} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        exit 1;
    fi
}
# -------------------------------------
test_load_2d_array()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n\t'; # Very Important when reading Arrays from files that end with a new line or tab
    # enclosure
    {
        echo "Afrikaans af"; echo "Albanian sq"; echo "Arabic ar"; echo "Azerbaijani az";
        echo "Basque eu"; echo "Bengali bn"; echo "Belarusian be"; echo "Bulgarian bg";
        echo "Catalan ca"; echo "Chinese-Simplified zh-CN"; echo "Chinese-Traditional zh-TW"; echo "Croatian hr"; echo "Czech cs";
        echo "Danish da"; echo "Dutch nl";
        echo "English en"; echo "Esperanto eo"; echo "Estonian et";
        echo "Filipino tl"; echo "Finnish fi"; echo "French fr";
        echo "Galician gl"; echo "Georgian ka"; echo "German de"; echo "Greek el"; echo "Gujarati gu";
        echo "Haitian Creole ht"; echo "Hebrew iw"; echo "Hindi hi"; echo "Hungarian hu";
        echo "Icelandic is"; echo "Indonesian id"; echo "Irish ga"; echo "Italian it";
        echo "Japanese ja";
        echo "Kannada kn"; echo "Korean ko";
        echo "Latin la"; echo "Latvian lv"; echo "Lithuanian lt";
        echo "Macedonian mk"; echo "Malay ms"; echo "Maltese mt";
        echo "Norwegian no";
        echo "Persian fa"; echo "Polish pl"; echo "Portuguese pt";
        echo "Romanian ro"; echo "Russian ru";
        echo "Serbian sr"; echo "Slovak sk"; echo "Slovenian sl"; echo "Spanish es"; echo "Swahili sw"; echo "Swedish sv";
        echo "Tamil ta"; echo "Telugu te"; echo "Thai th"; echo "Turkish tr";
        echo "Ukrainian uk"; echo "Urdu ur";
        echo "Vietnamese vi";
        echo "Welsh cy";
        echo "Yiddish yi";
    } >> "${TheFullScriptPath}/Support/Source/gtranslate-cc.db";
    local -a LanguagesTranslate;
    # shellcheck disable=SC2207
    LanguagesTranslate=( $(load_2d_array "${TheFullScriptPath}/Support/Source/gtranslate-cc.db" "0" ) ); # 1 is for Country
    if is_in_array "LanguagesTranslate" "English" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    # shellcheck disable=SC2207
    LanguagesTranslate=( $(load_2d_array "${TheFullScriptPath}/Support/Source/gtranslate-cc.db" "1" ) ); # 1 is for Country Code
    if is_in_array "LanguagesTranslate" "en" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    IFS="$ThisOldIFS";
}
# END load_2d_array
# *************************************************************************** #
# BEGIN clean_logs
# -------------------------------------
# HELPBUILDER clean_logs
help_clean_logs()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CLEAN_LOGS_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CLEAN_LOGS_DESC")";
    NOTES="$(localize "LOCALIZE_CLEAN_LOGS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER clean_logs
localize_clean_logs()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CLEAN_LOGS_USAGE" "clean_logs 1->(Log-Entry)" "Comment: clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAN_LOGS_DESC"  "Clean Log Entry of USERNAME and Passwords." "Comment: clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAN_LOGS_NOTES" "None." "Comment: clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CLEAN_LOGS_ARG"   "Wrong Number of Arguments passed to clean_logs!" "Comment: clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAN_LOGS_TEST"  "Test Log file with USERNAME" "Comment: clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
clean_logs()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO"  "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local LogString="${1}";
    #local ReplaceWith='USERNAME';
    #
    if [[ "$LogString" == *"$SystemUserName"* ]]; then
        LogString=${LogString/$SystemUserName/'USERPASSWD'};
    fi
    #
    if [[ "$LogString" == *"$USERPASSWD"* ]]; then
        #ReplaceWith='$USERPASSWD';
        LogString=${LogString/$USERPASSWD/'USERPASSWD'};
    fi
    #
    if [[ "$LogString" == *"$Root_Password"* ]]; then
        #ReplaceWith='$Root_Password';
        LogString=${LogString/$Root_Password/'ROOTPASSWD'};
    fi
    echo "$LogString";
}
# -------------------------------------
test_clean_logs()
{
    ((TestCounter += 1));
    if [ -z ${USERPASSWD+x} ]; then USERPASSWD="USER_SECRET_PW"; fi
    if [ -z ${Root_Password+x} ]; then Root_Password="ROOT_SECRET_PW"; fi
    local LogString; LogString="$(gettext -s "LOCALIZE_WRITE_LOG_TEST") $SystemUserName $USERPASSWD $Root_Password MY-TEST -> clean_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #echo "${LogString}";
    if [[ $(clean_logs "${LogString}")  != *"$SystemUserName"* ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END clean_logs
# *************************************************************************** #
# BEGIN write_log
# -------------------------------------
# HELPBUILDER write_log
help_write_log()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_WRITE_LOG_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_WRITE_LOG_DESC")";
    NOTES="$(localize "LOCALIZE_WRITE_LOG_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER write_log
localize_write_log()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_WRITE_LOG_USAGE" "write_log 1->(Log) 2->(Debugging Information)" "Comment: write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRITE_LOG_DESC"  "Write Log Entry." "Comment: write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRITE_LOG_NOTES" "Localized." "Comment: write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_WRITE_LOG_ARG"   "Wrong Number of Arguments passed to write_log!" "Comment: write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRITE_LOG_TEST"  "Test Log file with USERNAME" "Comment: write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
write_log()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ ! -f "${TheActivityLog}" ]; then
        print_test "making TheActivityLog(${TheActivityLog}) in TheLogPath(${TheLogPath})" "${FUNCNAME[0]}() : ${LINENO[0]}";
        [[ ! -d "${TheLogPath}" ]] && (mkdir -p "${TheLogPath}");
        touch "${TheActivityLog}";
    fi
    #{
    #    clean_logs $(gettext -s "${1}")
    #    echo ${2}
    #} >> "${TheActivityLog}";
    clean_logs "$(gettext -s "${1} ${2}")" >> "${TheActivityLog}";
}
# -------------------------------------
test_write_log()
{
    ((TestCounter += 1));
    write_log "LOCALIZE_WRITE_LOG_TEST" "MY-TEST $SystemUserName $USERPASSWD $Root_Password -> write_log @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if is_string_in_file "${TheActivityLog}" "MY-TEST" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END write_log
# *************************************************************************** #
# BEGIN contains_element
# -------------------------------------
# HELPBUILDER contains_element
help_contains_element()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CONTAINS_ELEMENT_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CONTAINS_ELEMENT_DESC")";
    NOTES="$(localize "LOCALIZE_CONTAINS_ELEMENT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER contains_element
localize_contains_element()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CONTAINS_ELEMENT_USAGE"  "contains_element 1->(Search) 2->(&#36;{array[@]})" "Comment: contains_element @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONTAINS_ELEMENT_DESC"  "Array Contains Element" "Comment: contains_element @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONTAINS_ELEMENT_NOTES" "Used to Search Options in Select Statement for Valid Selections." "Comment: contains_element @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
contains_element()
{
    # check if an element exist in a string
    for e in "${@:2}"; do [[ ${e} == "${1}" ]] && break; done;
}
# -------------------------------------
test_contains_element()
{
    ((TestCounter += 1));
    MyArray=( "1" "2" "3" );
    if contains_element "2" "${MyArray[@]}"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END contains_element
# *************************************************************************** #
# BEGIN invalid_option
# -------------------------------------
# HELPBUILDER invalid_option
help_invalid_option()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "INVALID-OPTION-DESC")";
    DESCRIPTION="$(localize "INVALID-OPTION-DESC")";
    NOTES="$(localize "INVALID-OPTION-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER invalid_option
localize_invalid_option()
{
    ((LocalizeComplileCounter += 1));
    localize_info "INVALID-OPTION-USAGE" "invalid_option 1->(Invalid Option) 2->(Debug Info)" "Comment: invalid_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "INVALID-OPTION-DESC"  "Invalid option" "Comment: invalid_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "INVALID-OPTION-NOTES" "None." "Comment: invalid_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "INVALID-OPTION-TEXT-1" "Invalid option" "Comment: invalid_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
invalid_option()
{
    print_line
    if [ $# -eq 0 ]; then
        print_this "INVALID-OPTION-TEXT-1";
    elif [ $# -eq 1 ]; then
        print_this "INVALID-OPTION-TEXT-1" ": ${1}";
    elif [ $# -eq 2 ]; then
        print_this "INVALID-OPTION-TEXT-1" ": ${1} : ${2}";
    else
        print_this "INVALID-OPTION-TEXT-1" ": ${1}";
    fi
    if [ "${INSTALL_WIZARD}" -eq 0 ] &&  [ "${TheAutoMan}" -eq 0 ]; then
        pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
}
# END invalid_option
# *************************************************************************** #
# BEGIN invalid_options
# -------------------------------------
# HELPBUILDER invalid_options
help_invalid_options()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_INVALID_OPTIONS_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_INVALID_OPTIONS_DESC")";
    NOTES="$(localize "LOCALIZE_INVALID_OPTIONS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER invalid_options
localize_invalid_options()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_INVALID_OPTIONS_USAGE" "invalid_options 1->(Invalid Options)" "Comment: invalid_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INVALID_OPTIONS_DESC"  "Invalid options" "Comment: invalid_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INVALID_OPTIONS_NOTES" "Idea was to show all valid options, still in work.." "Comment: invalid_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
invalid_options()
{
    print_line;
    if [ -z ${1+x} ]; then
        print_this "INVALID-OPTION-TEXT";
    else
        print_this "INVALID-OPTION-TEXT" ": ${1}";
    fi
}
# END invalid_options
# *************************************************************************** #
# BEGIN to_lower_case
# -------------------------------------
# HELPBUILDER to_lower_case
help_to_lower_case()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_TO_LOWER_CASE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_TO_LOWER_CASE_DESC")";
    NOTES="$(localize "LOCALIZE_TO_LOWER_CASE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER to_lower_case
localize_to_lower_case()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_TO_LOWER_CASE_USAGE" "to_lower_case 1->(Word)" "Comment: to_lower_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TO_LOWER_CASE_DESC"  "Make all Lower Case." "Comment: to_lower_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TO_LOWER_CASE_NOTES" "None." "Comment: to_lower_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
to_lower_case()
{
    echo "${1,,}";
    # echo ${1} | tr "[A-Z]" "[a-z]"; # Slow and unpredictable with Locale: tr "[:upper:]" "[:lower:]"
}
# -------------------------------------
test_to_lower_case()
{
    ((TestCounter += 1));
    if [[ $(to_lower_case "A") == "a" ]]; then # Only make changes once
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END to_lower_case
# *************************************************************************** #
# BEGIN to_upper_case
# -------------------------------------
# HELPBUILDER to_upper_case
help_to_upper_case()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_TO_UPPER_CASE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_TO_UPPER_CASE_DESC")";
    NOTES="$(localize "LOCALIZE_TO_UPPER_CASE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER to_upper_case
localize_to_upper_case()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_TO_UPPER_CASE_USAGE" "to_upper_case 1->(Word)" "Comment: to_upper_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TO_UPPER_CASE_DESC"  "Make all Upper Case." "Comment: to_upper_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TO_UPPER_CASE_NOTES" "None." "Comment: to_upper_case @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
to_upper_case()
{
    echo "${1^^}";
    # echo ${1} | tr "[a-z]" "[A-Z]";  # Slow and unpredictable with Locale: tr "[:upper:]" "[:lower:]"
}
# -------------------------------------
test_to_upper_case()
{
    ((TestCounter += 1));
    if [[ $(to_upper_case "a") == "A" ]]; then # Only make changes once
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END to_upper_case
# *************************************************************************** #
# BEGIN print_array
# -------------------------------------
# HELPBUILDER print_array
help_print_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PRINT_ARRAY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PRINT_ARRAY_DESC")";
    NOTES="$(localize "LOCALIZE_PRINT_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="21 Dec 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER print_array
localize_print_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PRINT_ARRAY_USAGE" "print_array 1->(array{@})" "Comment: print_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ARRAY_DESC"  "Print Array; normally for Troubleshooting; but could be used to print a list." "Comment: print_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ARRAY_NOTES" "None." "Comment: print_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PRINT_ARRAY_WARN"  "Passed in empty array from" "Comment: print_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
print_array()
{
    if [ -z ${1+x} ]; then print_warning "LOCALIZE_PRINT_ARRAY_WARN" ": ${2}"; exit 0; fi
    local ThisOldIFS="$IFS"; IFS=$" ";
    local -a myArray=("${!1}");     # Array
    local -i total="${#myArray[@]}";
    echo -e "    ---------------------------------";
    printf "    %s%stotal=%s %s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${total}" "${T_Clear_EOL}";
    for (( i=0; i<total; i++ )); do
        printf "    %s%s%s [%s]=|%s| %s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[3]}" "${1}" "${i}" "${myArray[$i]}" "${T_Clear_EOL}";
    done
    echo -e "    ---------------------------------";
    IFS="$ThisOldIFS";
}
# END print_array
# *************************************************************************** #
# BEGIN
# -------------------------------------
# HELPBUILDER assert
help_assert()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ASSERT_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ASSERT_DESC")";
    NOTES="$(localize "LOCALIZE_ASSERT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER assert
localize_assert()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ASSERT_USAGE" "assert 1->(Called from) 2->(Test] 1->(Debugging Information)" "Comment: assert @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ASSERT_DESC"  "assert for debugging variables" "Comment: assert @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ASSERT_NOTES" "None." "Comment: assert @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
assert()                  #  If condition false,
{                         #+ exit from script with error message.
    E_PARAM_ERR=98;
    E_ASSERT_FAILED=99;
    #
    if [ -z ${3+x} ]; then      # Not enough parameters passed.
        return $E_PARAM_ERR;   # No damage done.
    fi
    lineno=${3};
    if [ ! "${2}" ]; then
        echo "Assertion failed:  \"${2}\"";
        echo "File \"$0\", line $lineno";
        exit $E_ASSERT_FAILED;
    else
        if [ "${TheDebugging}" -eq 1 ]; then echo "assert (Passed in [${1}] - checking [${2}] at line number: [${3}])"; fi
        return 1; #  and continue executing script.
    fi
}
# END assert
# *************************************************************************** #
# My_JAVA_JDK_HOME_DEFAULT="/usr/lib/jvm/java-8-openjdk-amd64"
# My_JAVA_JRE_DEFAULT="/usr/lib/jvm/java-8-openjdk-amd64/jre"
# My_JAVA_JDK_DEFAULT="jdk1.8.0_201";
# My_JAVA_VER jdk1.8.0_201 = 18
getJava()
{
    local -i thisPrintDebug;  thisPrintDebug=0;      # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;        # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_test "Debugging Information for" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    # hash <the_command> # For regular commands. Or...
    # type <the_command> # To check built-ins and keywords
    if hash java 2>/dev/null; then
        # First get path to Java, by getting its type
        # type -p java > /usr/bin/java
        My_JAVA_JDK_HOME_DEFAULT="$(dirname "$(readlink -f "$(type -p java)")")";
        #java "$@"
    else
        My_JAVA_JDK_HOME_DEFAULT="";
    fi
    if [ "${thisPrintDebug}" -eq 1 ]; then
        if [ "${My_JAVA_JDK_HOME_DEFAULT}" != "" ]; then
            print_test "${FUNCNAME[0]}() My_JAVA_JDK_HOME_DEFAULT='${My_JAVA_JDK_HOME_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        else
            print_error "${FUNCNAME[0]}() Java not installed: My_JAVA_JDK_HOME_DEFAULT='${My_JAVA_JDK_HOME_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    fi
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
}
# *************************************************************************** #
getJDK()
{
    local ThisOldIFS; ThisOldIFS="${IFS}";
    local -i thisPrintDebug;  thisPrintDebug=0;      # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;        # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_test "Debugging Information for" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    # whereis java
    # readlink -f /usr/bin/java
    if hash jrunscript 2>/dev/null; then
        My_JAVA_JRE_DEFAULT="$(jrunscript -e 'java.lang.System.out.println(java.lang.System.getProperty("java.home"));')";
    elif hash javac 2>/dev/null; then
        My_JAVA_JRE_DEFAULT="$(type -p javac|xargs readlink -f|xargs dirname|xargs dirname)/jre";
    elif [ -d "${My_JAVA_JDK_HOME_DEFAULT}/jre" ]; then
        My_JAVA_JRE_DEFAULT="${My_JAVA_JDK_HOME_DEFAULT}/jre";
    else
        My_JAVA_JRE_DEFAULT=""
    fi
    if [ "${thisPrintDebug}" -eq 1 ]; then
        if [ "${My_JAVA_JRE_DEFAULT}" != "" ]; then
            if [ -d "${My_JAVA_JRE_DEFAULT}" ]; then
                print_test "${FUNCNAME[0]}() My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            else
                print_error "${FUNCNAME[0]}() Folder not found: My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "${FUNCNAME[0]}() Folder not found: My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    fi
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
}
# *************************************************************************** #
setJava()
{
    local ThisOldIFS; ThisOldIFS="${IFS}";
    local -i thisPrintDebug;  thisPrintDebug=0;      # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;        # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_test "Debugging Information for" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    # set My_JAVA_JDK_HOME_DEFAULT
    getJava;
    if [ "${My_JAVA_JDK_HOME_DEFAULT}" != "" ]; then
        if [ -d "${My_JAVA_JDK_HOME_DEFAULT}" ]; then
            # "1.8.0_232"
            My_JAVA_VER="$(java -version 2>&1 >/dev/null | grep 'version' | awk '{print $3}')";
            My_JAVA_VER="$(sed -e 's/^"//' -e 's/"$//' <<<"${My_JAVA_VER}")";
            #  18
            My_JAVA_VER_Rank=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;');
            if [ "${thisPrintDebug}" -eq 1 ]; then
                print_test "${FUNCNAME[0]}() My_JAVA_VER='${My_JAVA_VER}' My_JAVA_VER_Rank='${My_JAVA_VER_Rank}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
            #
            getJDK;
            if [ "${My_JAVA_JRE_DEFAULT}" != "" ]; then
                if [ -d "${My_JAVA_JRE_DEFAULT}" ]; then
                    IFS=$"/";
                    #export IFS=";"
                    local setIt; setIt=0;
                    My_JAVA_JRE_DEFAULT="";
                    for word in ${My_JAVA_JDK_HOME_DEFAULT}; do
                        if [ "${setIt}" -eq 1 ]; then
                            My_JAVA_JRE_DEFAULT="${word}";
                            break;
                        fi
                        if [ "${word}" == "jvm" ]; then
                            setIt=1;
                        fi
                    done
                    if [ "${thisPrintDebug}" -eq 1 ]; then
                        print_test "${FUNCNAME[0]}() My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}' My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    fi
                    IFS="$ThisOldIFS";
                else
                    if [ "${thisPrintDebug}" -eq 1 ]; then
                        print_error "${FUNCNAME[0]}() Folder not found: My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}' My_JAVA_JRE_DEFAULT='${My_JAVA_JRE_DEFAULT}'" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    fi
                fi
            fi
        fi
    fi
    # FIXME now
    # STUDIO_JDK JDK_HOME, and JAVA_HOME
    My_STUDIO_JDK="${My_JAVA_JDK_HOME_DEFAULT}";
    My_JAVA_HOME="${My_JAVA_JDK_HOME_DEFAULT}";
    My_JAVA_JRE="${My_JAVA_JRE_DEFAULT}";
    My_EDITOR="${My_GUI_EDITOR}";
    #
    if [ -z ${JAVA_HOME+x} ]; then
        if [ -f "${HOME}/.bash_profile" ] && [ "${My_SOURCE_BASH_PROFILE}" -eq 1 ]; then
            # must make sure to source your env to set Java and other path variables
            # shellcheck source=/dev/null
            source "${HOME}/.bash_profile";
        fi
        if [ -z ${JAVA_HOME+x} ]; then
            JAVA_HOME="${My_JAVA_HOME}";
        fi
    fi
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
}
# END setJava
# *************************************************************************** #
setEditor()
{
    My_GUI_EDITOR="$(type -p gedit)";     # GUI Editor
    My_TERMINAL_EDITOR="$(type -p nano)"; # Terminal Editor used by Terminal
}
# *************************************************************************** #
setAndroid()
{
    My_ANDROID_NDK_VERSION="android-ndk-r20b";          # Version or folder name
    My_ANDROID_API="android-20";                        #
    My_ANDROID_SDK_ROOT_DEFAULT="${My_Dev_Folder}/Android/Sdk"; # Manual Install of Andriod SDK alternative /opt/andriod-sdk
    My_ANDROID_NDK_ROOT_DEFAULT="${My_Dev_Folder}/Android/Ndk/${My_ANDROID_NDK_VERSION}"; # Base
    My_ANDROID_EABI="aarch64-linux-android-4.9";        # Not installed do not use
    My_ANDROID_ARCH="arch-x86";                         #

    My_ANDROID_EMULATOR_HOME="${HOME}/.android/";
    My_ANDROID_AVD_HOME="${My_ANDROID_EMULATOR_HOME}/avd/";

    My_ANDROID_SDK_ROOT="${My_ANDROID_SDK_ROOT_DEFAULT}";
    ANDROID_NDK_ROOT="${My_ANDROID_NDK_ROOT}/${My_ANDROID_NDK_VERSION}";
    #
    if [ -d "${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/toolchains" ]; then         # Does not exist, put it here as a FIXME because I think it should
        My_ANDROID_TOOLCHAIN="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/toolchains";
    elif [ -d "/opt/android-sdk" ]; then
        My_ANDROID_TOOLCHAIN="/opt/android-sdk/toolchains";
    else
        My_ANDROID_TOOLCHAIN="";
    fi
    if [ -z ${ANDROID_TOOLCHAIN+x} ]; then
        ANDROID_TOOLCHAIN="${My_ANDROID_TOOLCHAIN}";
    else
        if [ "${My_USE_ENV_BASH_PROFILE}" -eq 1 ]; then
            My_ANDROID_TOOLCHAIN="${ANDROID_TOOLCHAIN}";
        else
            if [ -d "${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/toolchains" ]; then
                My_ANDROID_TOOLCHAIN="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/toolchains";
            fi
        fi
    fi
    #
    if [ -d "${My_ANDROID_NDK_ROOT}/platforms/${My_ANDROID_API}/${My_ANDROID_ARCH}" ]; then       # Does not exist, put it here as a FIXME because I think it should
        My_ANDROID_SYSROOT="${My_ANDROID_NDK_ROOT}/platforms/${My_ANDROID_API}/${My_ANDROID_ARCH}";
    elif [ -d "/opt/android-sdk" ]; then
        My_ANDROID_SYSROOT="/opt/android-sdk/sysroot";
    else
        My_ANDROID_SYSROOT="";
    fi
    if [ -z ${ANDROID_SYSROOT+x} ]; then
        ANDROID_SYSROOT="${My_ANDROID_SYSROOT}";
    else
        if [ "${My_USE_ENV_BASH_PROFILE}" -eq 1 ]; then
            My_ANDROID_SYSROOT="${ANDROID_SYSROOT}";
        else
            if [ -d "${My_ANDROID_SDK_ROOT_DEFAULT}" ]; then
                My_ANDROID_SYSROOT="${My_ANDROID_NDK_ROOT}/platforms/${My_ANDROID_API}/${My_ANDROID_ARCH}";
            fi
        fi
    fi
    #
    if [ -d "${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/eabi" ]; then       # Does not exist, put it here as a FIXME because I think it should
        My_ANDROID_EABI="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/eabi";
    elif [ -d "/opt/android-eabi" ]; then         # I have no idea where this file is FIXME AUR removed it
        My_ANDROID_EABI="/opt/android-eabi";
    else
        My_ANDROID_EABI="";
    fi
    if [ -z ${ANDROID_EABI+x} ]; then
        ANDROID_EABI="${My_ANDROID_EABI}";
    else
        if [ "${My_USE_ENV_BASH_PROFILE}" -eq 1 ]; then
            My_ANDROID_EABI="${ANDROID_EABI}";
        else
            if [ -d "${My_ANDROID_SDK_ROOT_DEFAULT}" ]; then
                My_ANDROID_EABI="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/eabi";
            fi
        fi
    fi
    #
    if [ -d "${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/fips" ]; then       # Does not exist, put it here as a FIXME because I think it should
        My_FIPS_SIG="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/fips";
    elif [ -d "/opt/android-fips" ]; then       # I have no idea where this file is FIXME AUR removed it
        My_FIPS_SIG="/opt/android-fips";
    else
        My_FIPS_SIG="";
    fi
    if [ -z ${FIPS_SIG+x} ]; then
        FIPS_SIG="${My_FIPS_SIG}";
    else
        if [ "${My_USE_ENV_BASH_PROFILE}" -eq 1 ]; then
            My_FIPS_SIG="${FIPS_SIG}";
        else
            if [ -d "${My_ANDROID_SDK_ROOT_DEFAULT}" ]; then
                My_FIPS_SIG="${My_ANDROID_NDK_ROOT_DEFAULT}/${My_ANDROID_NDK_VERSION}/fips";
            fi
        fi
    fi
    #
}
# *************************************************************************** #
# BEGIN os_info
# -------------------------------------
# HELPBUILDER os_info
help_os_info()
{
    ((HelpComplileCounter += 1));
    USAGE="os_info";
    DESCRIPTION="$(localize "LOCALIZE_OS_INFO_DESC")";
    NOTES="$(localize "LOCALIZE_OS_INFO_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="10 Apr 2013";
    REVISION="10 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER os_info
localize_os_info()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_OS_INFO_DESC"  "OS Information." "Comment: os_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_OS_INFO_NOTES" "None." "Comment: os_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# os_info; My_DIST My_OS="mac"
os_info()
{
    local -i thisPrintDebug;  thisPrintDebug=0;      # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;        # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_test "Debugging Information for" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    My_OS="$(to_lower_case "$(uname -s)")";  # OS: Linux, FreeBSD, MAC, Windows
    My_OS="${My_OS// /}";                    # Remove all Spaces: Windows Nt becomes WindowsNt
    My_ARCH="$(uname -m)";                   # x86 or x86_64
    My_Ver="$(uname -r)";                    # OS Version
    #
    if [ "$My_OS" == "sunos" ]; then           # Sun OS
        case $(uname -r) in
            4*)  My_OS="sunbsd";    ;;
            5*)  My_OS="solaris";   ;;
             *)  My_OS="solaris";   ;;
        esac
        My_ARCH="$(uname -p)";
        My_DIST="$My_OS";
    elif [ "$My_OS" == "HP-UX" ]; then         # HP-UX
        My_OS="hp";
        My_DIST="hp";
    elif [ "$My_OS" == "IRIX" ]; then          # IRIX
        My_OS="sgi";
        My_DIST="sgi";
    elif [ "$My_OS" == "OSF1" ]; then          # OSF1
        My_OS="decosf";
        My_DIST="decosf";
    elif [ "$My_OS" == "IRIX" ]; then          # IRIX
        My_OS="sgi";
        My_DIST="sgi";
    elif [ "$My_OS" == "ULTRIX" ]; then        # ULTRIX
        My_OS="ultrix";
        My_DIST="ultrix";
    elif [ "$My_OS" == "aix" ]; then           # AIX
        My_Ver=$(oslevel -r);
        My_DIST="aix";
    elif [ "$My_OS" == "freebsd" ]; then       # Free BSD
        My_DIST="freebsd";
    elif [ "$My_OS" == "windowsnt" ]; then     # Windows NT
        My_DIST="windowsnt";
    elif [ "$My_OS" == "darwin" ]; then        # MAC
        My_OS="mac";
        My_DIST="mac";
        # shellcheck disable=SC2230
        if [ -n "$(which sw_vers 2>/dev/null)" ]; then
            My_PSUEDONAME="$(sw_vers -productName)";
            My_Ver="$(sw_vers -productVersion)";
            My_OS_Update="${My_Ver##*.}";
            My_Ver="${My_Ver%.*}";

            if [[ "$My_Ver" =~ 10.8 ]]; then
                My_PSUEDONAME="mountain lion";
            elif [[ "$My_Ver" =~ 10.7 ]]; then
                My_PSUEDONAME="lion";
            elif [[ "$My_Ver" =~ 10.6 ]]; then
                My_PSUEDONAME="snow leopard"
            elif [[ "$My_Ver" =~ 10.5 ]]; then
                My_PSUEDONAME="leopard";
            elif [[ "$My_Ver" =~ 10.4 ]]; then
                My_PSUEDONAME="tiger";
            elif [[ "$My_Ver" =~ 10.3 ]]; then
                My_PSUEDONAME="panther";
            elif [[ "$My_Ver" =~ 10.2 ]]; then
                My_PSUEDONAME="jaguar";
            elif [[ "$My_Ver" =~ 10.1 ]]; then
                My_PSUEDONAME="puma";
            elif [[ "$My_Ver" =~ 10.0 ]]; then
                My_PSUEDONAME="cheetah";
            else
                My_PSUEDONAME="unknown";
            fi
        fi
    elif [ "$My_OS" == "linux" ]; then                       # Linux
        # shellcheck disable=SC1123
        if [ -f /etc/centos-release ] ; then                                                         # CentOS
            My_DIST="redhat";
            My_PSUEDONAME="CentOS";
            My_Ver_Major="$(cut -d " " -f 3 /etc/redhat-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/redhat-release | cut -d '.' -f 2)";
            My_Ver="${My_Ver_Major}.${My_Ver_Minor}"; # $(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//);
            echo "My_Ver=$My_Ver";
            My_OS_Update="$(uname -r)";
        elif [ -f /etc/redhat-release ] ; then                                                         # Redhat
            My_DIST="redhat";
            My_PSUEDONAME="Redhat";
            My_Ver_Major="$(cut -d " " -f 3 /etc/redhat-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/redhat-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)";
        elif [ -f /etc/fedora-release ] ; then                                                         # Fedora
            My_DIST="fedora";
            My_PSUEDONAME="Fedora";
            My_Ver_Major="$(cut -d " " -f 3 /etc/fedora-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/fedora-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/fedora-release | sed s/.*release\ // | sed s/\ .*//)";
        elif [ -f /etc/SuSE-release ] ; then                                                            # SuSE
            My_DIST="suse";
            My_PSUEDONAME="SuSe";
            My_Ver_Major="$(cut -d " " -f 3 /etc/SuSE-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/SuSE-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/SuSE-release | tr "\n" " " | sed s/.*=\ //)";
        elif [ -f /etc/mandrake-release ] ; then                                                        # Mandrake
            My_DIST="mandrake";
            My_PSUEDONAME="Mandrake";
            My_Ver_Major=$(cut -d " " -f 3 /etc/mandrake-release | cut -d '.' -f 1);
            My_Ver_Minor=$(cut -d " " -f 3 /etc/mandrake-release | cut -d '.' -f 2);
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//)";
        elif [ -f /etc/debian_version ] ; then                                                          # Debian, Ubuntu, LMDE
            My_DIST="debian";
            if grep -Fxq "Debian" /etc/issue ; then
                My_PSUEDONAME="Debian";
            elif grep -Fxq "Ubuntu" /etc/issue ; then
                My_PSUEDONAME="Ubuntu";
            elif grep -Fxq "Linux Mint Debian Edition" /etc/issue ; then
                My_PSUEDONAME="LMDE";
            elif grep -Fq "LMDE" /etc/issue ; then
                My_PSUEDONAME="LMDE";
            else
                My_PSUEDONAME="Debian";
            fi
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{print $2}')";
        elif [ -f /etc/arch-release ] ; then                                                            # ArchLinux They may drop this like Manjaro did
            My_DIST="archlinux";
            My_PSUEDONAME="Archlinux";
            My_OS_Package="pacman";
            My_Ver="$( lsb_release -r -s )";                     # LMDE=1
            if [[ "${My_Ver}" == *.* ]]; then # 5=Anywhere
                My_Ver_Major="$(string_split "$My_Ver" "." 1)";  # 1=First Half
                My_Ver_Minor="$(string_split "$My_Ver" "." 2)";  # 2=Second Half
                My_OS_Update="${My_Ver##*.}";
            else
                My_Ver_Major="$My_Ver";
                My_Ver_Minor="0";
                My_OS_Update="0";
            fi
        elif [ -f /etc/os-release ] ; then                                                              # Manjaro - ArchLinux
            My_DIST="archlinux";
            My_PSUEDONAME="Manjaro";
            My_OS_Package="pacman";
            My_Ver="$( lsb_release -r -s )";                     # LMDE=1
            if is_needle_in_haystack "." "$My_Ver" 5; then # 5=Anywhere
                My_Ver_Major="$(string_split "$My_Ver" "." 1)";  # 1=First Half
                My_Ver_Minor="$(string_split "$My_Ver" "." 2)";  # 2=Second Half
            else
                My_Ver_Major="$My_Ver";
                My_Ver_Minor="0";
            fi
        elif [ -f /etc/UnitedLinux-release ] ; then                                                     # United Linux
            My_DIST="unitedlinux";
            My_PSUEDONAME="UnitedLinux";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/UnitedLinux-release | tr "\n" " " | sed s/VERSION.*//)";
        elif [ -f /etc/slackware-release ] || [ -f /etc/slackware-version ]; then                     # slackware
            My_DIST="slackware";
            My_PSUEDONAME="slackware";
            if [ -f /etc/slackware-release ]; then
                # shellcheck disable=SC2002
                My_Ver="$(cat /etc/slackware-release | tr "\n" " " | sed s/VERSION.*//)";
            else
                # shellcheck disable=SC2002
                My_Ver="$(cat /etc/slackware-version | tr "\n" " " | sed s/VERSION.*//)";
            fi
        elif [ -f /etc/yellowdog-release ]; then                                                            # Yellow dog
            My_DIST="yellowdog";
            My_PSUEDONAME="YellowDog";
            My_Ver_Major="$(cut -d " " -f 3 /etc/yellowdog-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/yellowdog-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/yellowdog-release | tr "\n" " " | sed s/.*=\ //)";
        elif [ -f /etc/sun-release ]; then                                                            # Sun JDS
            My_DIST="sun";
            My_PSUEDONAME="Sun";
            My_Ver_Major="$(cut -d " " -f 3 /etc/sun-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/sun-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/sun-release | tr "\n" " " | sed s/.*=\ //)";
        elif [ -f /etc/release ]; then                                                            # Solaris/Sparc
            My_DIST="solaris";
            My_PSUEDONAME="Sparc";
            My_Ver_Major="$(cut -d " " -f 3 /etc/release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/release | tr "\n" " " | sed s/.*=\ //)";
        elif [ -f /etc/gentoo-release ]; then                                                            # Gentoo
            My_DIST="gentoo";
            My_PSUEDONAME="Gentoo";
            My_Ver_Major="$(cut -d " " -f 3 /etc/gentoo-release | cut -d '.' -f 1)";
            My_Ver_Minor="$(cut -d " " -f 3 /etc/gentoo-release | cut -d '.' -f 2)";
            # shellcheck disable=SC2002
            My_Ver="$(cat /etc/gentoo-release | tr "\n" " " | sed s/.*=\ //)";
        elif [[ -x "$(type -p lsb_release 2>/dev/null)" ]]; then # shellcheck disable=SC2230
            # which replaced with type
            # Debian
            # /usr/bin/lsb_release
            #My_PSUEDONAME=$(  lsb_release -i -s);             # LinuxMint
            My_Ver="$( lsb_release -r -s )";                     # LMDE=1
            if is_needle_in_haystack "." "$My_Ver" 5; then # 5=Anywhere
                My_Ver_Major="$(string_split "$My_Ver" "." 1)";  # 1=First Half
                My_Ver_Minor="$(string_split "$My_Ver" "." 2)";  # 2=Second Half
            else
                My_Ver_Major="$My_Ver";
                My_Ver_Minor="0";
            fi
            My_DIST="$(lsb_release -c -s)";                      # debian
            My_OS_Package="rpm";
            if [[ "$My_PSUEDONAME" =~ Debian,Ubuntu ]]; then
                My_OS_Package="deb";
            elif [[ "SUSE LINUX" =~ $My_PSUEDONAME ]]; then
                if lsb_release -d -s | grep -q openSUSE; then
                    My_PSUEDONAME="openSUSE";
                fi
            elif [[ $My_PSUEDONAME =~ Red.*Hat ]]; then
                My_PSUEDONAME="Red Hat";
            fi
            if grep -Fxq "Debian" /etc/issue ; then
                My_PSUEDONAME="Debian";
                My_OS_Package="deb";
            elif grep -Fxq "Ubuntu" /etc/issue ; then
                My_PSUEDONAME="Ubuntu";
                My_OS_Package="deb";
            elif grep -Fxq "Linux Mint Debian Edition" /etc/issue ; then
                My_PSUEDONAME="LMDE";
                My_OS_Package="deb";
            elif grep -Fq "LMDE" /etc/issue ; then
                My_PSUEDONAME="LMDE";
                My_OS_Package="deb";
            else
                My_PSUEDONAME="Debian";
                My_OS_Package="deb";
            fi
        fi
    fi
    #
    My_Dev_Folder="${HOME}\Dev";
    #
    setEditor;
    #
    setAndroid;
    # Set Java Stuff
    setJava;
    #
}
# -------------------------------------
test_os_info()
{
    ((TestCounter += 1));
    os_info;
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_OS=$My_OS";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_ARCH=$My_ARCH";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_DIST=${My_DIST}";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_PSUEDONAME=$My_PSUEDONAME";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_Ver=$My_Ver";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_Ver_Major=$My_Ver_Major";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_Ver_Minor=$My_Ver_Minor";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_OS_Package=$My_OS_Package";
    print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} | My_OS_Update=$My_OS_Update";
}
# END os_info
# *************************************************************************** #
# BEGIN is_os
# -------------------------------------
# HELPBUILDER is_os
help_is_os()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_OS_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_OS_DESC")";
    NOTES="$(localize "NONE")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_os
localize_is_os()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_OS_USAGE" "is_os 1->(os-name)" "Comment: is_os @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_OS_DESC"  "Check to see if OS matches what you think it is" "Comment: is_os @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_os()
{
    if [ $# -ne 1 ]; then printLocalized "LOCALIZE_WRONG_ARGS_PASSED_TO" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { return 1; }
    if [ "${My_DIST}" == "" ]; then os_info; fi
    if [ "${My_DIST}" == "${1}" ]; then return 0; else return 1; fi
}
# -------------------------------------
test_is_os()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$" ";
    print_info "    TheOsDistros=${TheOsDistros[*]}";
    for Distro in "${TheOsDistros[@]}"; do
        if is_os "$Distro" ; then
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} |  $(sub_string "${FUNCNAME[0]}" "test_" 2)($Distro)";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} |  $(sub_string "${FUNCNAME[0]}" "test_" 2)($Distro)";
        fi
    done
    IFS="$ThisOldIFS";
}
# END is_os
# *************************************************************************** #
# BEGIN get_network_devices
# -------------------------------------
# HELPBUILDER get_network_devices
help_get_network_devices()
{
    ((HelpComplileCounter += 1));
    USAGE="get_network_devices";
    DESCRIPTION="$(localize "LOCALIZE_GET_NETWORK_DEVICE_DESC")";
    NOTES="$(localize "LOCALIZE_GET_NETWORK_DEVICE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_network_devices
localize_get_network_devices()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_NETWORK_DEVICE_DESC"  "Get Network Devices." "Comment: get_network_devices @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_NETWORK_DEVICE_NOTES" "Holds IP Address if its an Active connection; no test of Internet Access are done." "Comment: get_network_devices @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_NETWORK_DEVICE_TEST"  "You need root access to preform this Test." "Comment: get_network_devices @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_network_devices()
{
    # -----------------------------------
    function system_primary_ip
    {
        # returns the primary IP assigned to ethx
        # echo -n $(hostname  -i | cut -f1 -d" ");
        # 8.8.8.8 via 192.168.1.1 dev enp2s0 src 192.168.1.10
        ip route get 8.8.8.8 | awk '/src / {print $7}' | sed 's/\.$//';
    }
    # -----------------------------------
    function network_adapter_names
    {
        # returns the primary IP assigned to ethx
        local myNet; myNet=$(sudo lshw -class network | awk -F: '/logical name: / {print $2}' | awk '{print $1}');
        for myNetName in "${myNet[@]}"; do
            echo "$myNetName";
        done
    }
    # -----------------------------------
    function get_rdns
    {
        # calls host on an IP address and returns its reverse dns
        if host "${1}"; then
            host "${1}" | awk '/pointer/ {print $5}' | sed 's/\.$//';
        else
            # not working if Host 13.1.168.192.in-addr.arpa. not found: 3(NXDOMAIN)
            echo "FAIL";
        fi
    }
    # -----------------------------------
    # lspci | egrep -i --color 'network|ethernet'
    local ThisOldIFS="$IFS"; IFS=$" ";
    local MyEthAddress; MyEthAddress=$(hostname -i);
    EthAddress=("${MyEthAddress}");
    for MyIp in "${EthAddress[@]}"; do
        if host "$MyIp" >/dev/null ; then
            #echo "******************** HERE ******************";
            EthReverseDNS+=( "$(get_rdns "$MyIp")" );
        else
            EthReverseDNS+=("");
        fi
    done
    # shellcheck disable=3129
    ActiveNetAdapter=$(system_primary_ip);
    IFS=$'\n';
    NIC=( "$(network_adapter_names)" );
    IFS=$" ";
    IFS="$ThisOldIFS";
}
# -------------------------------------
test_get_network_devices()
{
    ((TestCounter += 1));
    print_caution "LOCALIZE_GET_NETWORK_DEVICE_TEST" "@ $(basename "${BASH_SOURCE[0]}") -> $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    get_network_devices;
    local -i total; total="${#EthAddress[@]}";
    local -i MyIndex=0;
    for (( MyIndex=0; MyIndex<total; MyIndex++ )); do
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "@ $(basename "${BASH_SOURCE[0]}") -> $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    done
}
# END get_network_devices
# *************************************************************************** #
# BEGIN show_users
# -------------------------------------
# HELPBUILDER show_users
help_show_users()
{
    ((HelpComplileCounter += 1));
    USAGE="show_users";
    DESCRIPTION="$(localize "LOCALIZE_SHOW_USERS_DESC")";
    NOTES="$(localize "LOCALIZE_SHOW_USERS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER show_users
localize_show_users()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SHOW_USERS_DESC"  "Show Users." "Comment: show_users @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SHOW_USERS_NOTES" "Shows users in /etc/passwd." "Comment: show_users @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SHOW_USERS_MSG"   "Testing show_users" "Comment: show_users @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
show_users()
{
   gawk -F: '{print $1}' /etc/passwd;
}
# END show_users
# *************************************************************************** #
# BEGIN device_list
# -------------------------------------
# HELPBUILDER device_list
help_device_list()
{
    ((HelpComplileCounter += 1));
    USAGE="device_list";
    DESCRIPTION="$(localize "LOCALIZE_DEVICE_LIST_DESC")";
    NOTES="$(localize "LOCALIZE_DEVICE_LIST_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER device_list
localize_device_list()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DEVICE_LIST_DESC"  "Get Device List." "Comment: device_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DEVICE_LIST_NOTES" "Used to get Hard Drive Letter, assumes you are running this from a Flash Drive." "Comment: device_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
device_list()
{
    local ThisOldIFS="$IFS";
    # Get all SD devices
    IFS=$'\n';
    local -a LIST_ALL_DEVICES=( "$( ls /dev/sd* )" );
    # List: /dev/sda /dev/sda1 /dev/sda2 /dev/sdb /dev/sdb1
    LIST_DEVICES=();
    IFS=$" ";
    for x in "${LIST_ALL_DEVICES[@]}"; do
        if [ "${#x[@]}" -eq 8 ]; then # @FIX /dev/sdx note it might be better to remove number, but then you have duplicates to deal with; what if you have more devices then z
            if [[ "$(cat /sys/block/"${x: -3}"/removable)" == "1" ]]; then
                if [ "${ScriptDevice}" == "${x: -4}" ]; then
                    LIST_DEVICES[$(${#LIST_DEVICES[@]})]="${x: -3} Removable Device Script is Executing.";
                    ScriptDevice="/dev/${x: -4}";
                else
                    LIST_DEVICES[$(${#LIST_DEVICES[@]})]="${x: -3} Removable";
                fi
            else
                if [ "${ScriptDevice}" == "${x: -4}" ]; then
                    LIST_DEVICES[$(${#LIST_DEVICES[@]})]="${x: -3} Device Script is Executing.";
                    ScriptDevice="/dev/${x: -4}";
                else
                    LIST_DEVICES[$(${#LIST_DEVICES[@]})]="${x: -3}";
                fi
            fi
        fi
    done
    IFS="$ThisOldIFS";
}
# END device_list
# *************************************************************************** #
# BEGIN umount_partition
# -------------------------------------
# HELPBUILDER umount_partition
help_umount_partition()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_UMOUNT_PARTITION_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_UMOUNT_PARTITION_DESC")";
    NOTES="$(localize "LOCALIZE_UMOUNT_PARTITION_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER umount_partition
localize_umount_partition()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_UMOUNT_PARTITION_USAGE" "umount_partition 1->(Device Name)" "Comment: umount_partition @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_UMOUNT_PARTITION_DESC"  "Umount partition." "Comment: umount_partition @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_UMOUNT_PARTITION_NOTES" "None." "Comment: umount_partition @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
umount_partition()
{
    swapon -s|grep "${1}" && swapoff "${1}"; # check if swap is on and umount
    mount|grep "${1}" && umount "${1}";      # check if partition is mounted and umount
}
# END umount_partition
# *************************************************************************** #
# BEGIN is_valid_email
# -------------------------------------
# HELPBUILDER is_valid_email
help_is_valid_email()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_VALID_EMAIL_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_VALID_EMAIL_DESC")";
    NOTES="$(localize "LOCALIZE_IS_VALID_EMAIL_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_valid_email
localize_is_valid_email()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_VALID_EMAIL_USAGE" "is_valid_email 1->(value)" "Comment: is_valid_email @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_EMAIL_DESC"  "Is Valid path." "Comment: is_valid_email @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_EMAIL_NOTES" "None." "Comment: is_valid_email @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_valid_email()
{
    local compressed; compressed="$(echo "${1}" | grep -P '^[A-Za-z0-9._&#37;+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')"
    if [ "$compressed" != "${1}" ] ; then
        return 1;
    else
        return 0;
    fi
}
# END is_valid_email
# *************************************************************************** #
# BEGIN is_valid_path
# -------------------------------------
# HELPBUILDER is_valid_path
help_is_valid_path()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_VALID_PATH_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_VALID_PATH_DESC")";
    NOTES="$(localize "LOCALIZE_IS_VALID_PATH_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_valid_path
localize_is_valid_path()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_VALID_PATH_USAGE" "is_valid_path 1->(value)" "Comment: is_valid_path @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_PATH_DESC"  "Is Valid path." "Comment: is_valid_path @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_PATH_NOTES" "A-Z 0-9 - / (Fix for Windows Drive Letter : and backslash.)" "Comment: is_valid_path @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_valid_path()
{
    local compressed; compressed="$(echo "${1}" | grep -P '/[-_A-Za-z0-9]+(/[-_A-Za-z0-9]*)*')"
    # @FIX what about Windows
    if [ "$compressed" != "${1}" ] ; then
        return 1;
    else
        return 0;
    fi
}
# END is_valid_path
# *************************************************************************** #
# BEGIN is_valid_domain
# -------------------------------------
# HELPBUILDER is_valid_domain
help_is_valid_domain()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_VALID_DOMAIN_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_VALID_DOMAIN_DESC")";
    NOTES="$(localize "LOCALIZE_IS_VALID_DOMAIN_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_valid_domain
localize_is_valid_domain()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_VALID_DOMAIN_USAGE" "is_valid_domain 1->(value)" "Comment: is_valid_domain @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_DOMAIN_DESC"  "Is Valid Domain Name." "Comment: is_valid_domain @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_DOMAIN_NOTES" "None." "Comment: is_valid_domain @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_valid_domain()
{
    local compressed; compressed="$(echo "${1}" | grep -P '(?=^.{5,254}$)(^(?:(?!\d+\.)[a-zA-Z0-9_\-]{1,63}\.?)+(?:[a-zA-Z]{2,})$)')"
    if [ "$compressed" != "${1}" ] ; then
        if [[ "${OPTION}" =~ ^[a-zA-Z0-9][-a-zA-Z0-9]{0,61}[a-zA-Z0-9]$ ]] ; then # it can be localhost or any name with the .tdl
            return 0;
        else
            return 1;
        fi
    else
        return 0;
    fi
}
# END is_valid_domain
# *************************************************************************** #
# BEGIN is_valid_ip
# -------------------------------------
# HELPBUILDER is_valid_ip
help_is_valid_ip()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_VALID_IP_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_VALID_IP_DESC")";
    NOTES="$(localize "LOCALIZE_IS_VALID_IP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_valid_ip
localize_is_valid_ip()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_VALID_IP_USAGE" "is_valid_ip 1->(value)" "Comment: is_valid_ip @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_IP_DESC"  "Is Valid IP Address." "Comment: is_valid_ip @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_VALID_IP_NOTES" "None." "Comment: is_valid_ip @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_valid_ip()
{
    local ip="${1}";
    local OIFS="${IFS}";
    if [[ "${ip}" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        IFS='.';
        # shellcheck disable=SC2206
        ip=(${ip});
        IFS="${OIFS}";
        [[ "${ip[0]}" -le 255 && "${ip[1]}" -le 255 && "${ip[2]}" -le 255 && "${ip[3]}" -le 255 ]]
    fi
    return "$?";
}
# END is_valid_ip
# *************************************************************************** #
# BEGIN is_alphanumeric
# -------------------------------------
# HELPBUILDER is_alphanumeric
help_is_alphanumeric()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_ALPHANUMERIC_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_ALPHANUMERIC_DESC")";
    NOTES="$(localize "LOCALIZE_IS_ALPHANUMERIC_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_alphanumeric
localize_is_alphanumeric()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_ALPHANUMERIC_USAGE" "is_alphanumeric 1->(value)" "Comment: is_alphanumeric @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_ALPHANUMERIC_DESC"  "Is Alphanumeric." "Comment: is_alphanumeric @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_ALPHANUMERIC_NOTES" "None." "Comment: is_alphanumeric @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_alphanumeric()
{
    if ! [[ "${1}" =~ [^a-zA-Z0-9\ ] ]]; then
        return 0;
    else
        return 1;
    fi
}
# -------------------------------------
test_is_alphanumeric()
{
    ((TestCounter += 1));
    if is_alphanumeric "1" && is_alphanumeric "A" && ! is_alphanumeric '!@#'; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_alphanumeric
# *************************************************************************** #
# BEGIN is_number
# -------------------------------------
# HELPBUILDER is_number
help_is_number()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_NUMBER_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_NUMBER_DESC")";
    NOTES="$(localize "LOCALIZE_IS_NUMBER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_number
localize_is_number()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_NUMBER_USAGE" "is_number 1->(value)" "Comment: is_number @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_NUMBER_DESC"  "Is Number." "Comment: is_number @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_NUMBER_NOTES" "None." "Comment: is_number @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_number()
{
    if [[ "${1}" =~ ^[0-9]+$ ]] ; then return 0; else return 1; fi
}
# -------------------------------------
test_is_number()
{
    ((TestCounter += 1));
    if is_number "1" && ! is_number "A"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_number
# *************************************************************************** #
# BEGIN read_input
# -------------------------------------
# HELPBUILDER read_input
help_read_input()
{
    ((HelpComplileCounter += 1));
    USAGE="read_input";
    DESCRIPTION="$(localize "LOCALIZE_READ_INPUT_DESC")";
    NOTES="$(localize "LOCALIZE_READ_INPUT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER read_input
localize_read_input()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_READ_INPUT_DESC"  "read keyboard input." "Comment: read_input @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_NOTES" "Sets Variable OPTION as return; do not us in TheAutoMan or INSTALL_WIZARD Mode." "Comment: read_input @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
read_input()
{
    printf "    %s%s%s %s" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "${prompt1}" "${T_Clear_EOL}";
    read -r -p "" OPTION;
}
# END read_input
# *************************************************************************** #
# BEGIN get_input_option
# -------------------------------------
# HELPBUILDER get_input_option
help_get_input_option()
{
    ((HelpComplileCounter += 1));
    USAGE="GET_INPUT_OPTION_USAGE";
    DESCRIPTION="$(localize "GET_INPUT_OPTION_DESC")";
    NOTES="$(localize "GET_INPUT_OPTION_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_input_option
localize_get_input_option()
{
    ((LocalizeComplileCounter += 1));
    localize_info "GET_INPUT_OPTION_USAGE"    "get_input_option 1->(array[@] of options) 2->(default) 3->(Base: 0 or 1) <- return value OPTION" "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "GET_INPUT_OPTION_DESC"     "Get Keyboard Input Options between two numbers." "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "GET_INPUT_OPTION_NOTES"    "None." "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "GET_INPUT_OPTION_CHOOSE-0" "Choose a number between 0 and" "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "GET_INPUT_OPTION_CHOOSE-1" "Choose a number between 1 and" "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "GET_INPUT_OPTION_DEFAULT"  "Default is" "Comment: get_input_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_input_option()
{
    # @FIX Make 0 based, or range based 3->(Base: 0 or 1)
    # Choose a number between x and
    if [ "${TheAutoMan}" -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then
        OPTION="${2}";
        return 0;
    fi
    local -i StartBased=0;
    if [ $# -eq "2" ]; then
        StartBased=1;
    elif [ $# -eq "3" ]; then
        StartBased="${3}";
    fi
    local -a array=("${!1}");
    local -i total="${#array[@]}";
    local -i index=0;
    local -i iPad=0;
    if   [ "${total}" -gt 9 ];   then iPad=3;
    elif [ "${total}" -gt 99 ];  then iPad=4;
    elif [ "${total}" -gt 999 ]; then iPad=5;
    fi
    echo "";
    for var in "${array[@]}"; do
        if [ "${StartBased}" -eq 0 ]; then
            printf "    %s%s%-${iPad}s %s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "$(( index++ ))" "${var}" "${T_Clear_EOL}";
        else
            printf "    %s%s%-${iPad}s %s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[4]}" "$(( ++index ))" "${var}" "${T_Clear_EOL}";
        fi
    done
    #
    if [ "${StartBased}" -eq 0 ]; then
        print_warning "GET_INPUT_OPTION_CHOOSE-0" "$((total-1))";
    else
        print_warning "GET_INPUT_OPTION_CHOOSE-1" "${total}";
    fi
    local -i DefaultValue="${2}";
    if [ "${StartBased}" -eq 0 ]; then
        print_this "GET_INPUT_OPTION_DEFAULT" ": ${2} (${array[$(( DefaultValue ))]})";
    else
        print_this "GET_INPUT_OPTION_DEFAULT" ": ${2} (${array[$(( DefaultValue - 1 ))]})";
    fi
    YN_OPTION=0;
    while [[ "${YN_OPTION}" -ne 1 ]]; do
        read_input;
        if [ -z ${OPTION+x} ]; then
            OPTION=${2};
            break;
        fi
        if ! [[ "${OPTION}" =~ ^[0-9]+$ ]] ; then
            invalid_options "${OPTION}";
        elif [ "${OPTION}" -le "${total}" ]; then
            if [ "${StartBased}" -eq 1 ] && [ "${OPTION}" -eq "0" ]; then
                invalid_options "${OPTION}";
            else
                break;
            fi
        else
            invalid_options "${OPTION}";
        fi
    done
    #if [ "$StartBased" -eq 0 ]; then OPTION=$((OPTION-1)); fi
    return 0;
}
# -------------------------------------
test_get_input_option()
{
    ((TestCounter += 1));
    local MyArray=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12");
    get_input_option "MyArray[@]" 1 1;
    #                                              1                2                                          3                                          4                                       5
    printf "    %s%s get_input_option 1 = %s %s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(gettext -s "LOCALIZE_TEST_FUNCTION_PASSED")" "${OPTION} (${MyArray[$((OPTION-1))]})" "${T_Clear_EOL}";
    get_input_option "MyArray[@]" 0 0;
    printf "    %s%s get_input_option 0 = %s %s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(gettext -s "LOCALIZE_TEST_FUNCTION_PASSED")" "${OPTION} (${MyArray[$((OPTION))]})" "${T_Clear_EOL}";
    read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
}
# END get_input_option
# *************************************************************************** #
# BEGIN clean_input
# -------------------------------------
# HELPBUILDER clean_input
help_clean_input()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CLEAN_INPUT_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CLEAN_INPUT_DESC")";
    NOTES="$(localize "LOCALIZE_CLEAN_INPUT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="26 Jan 2013";
    REVISION="26 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER clean_input
localize_clean_input()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CLEAN_INPUT_USAGE"   "clean_input 1->(Input String) <- return " "Comment: clean_input @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAN_INPUT_DESC"    "Clean Keyboard Input Options:  String of values: 1 2 3 or 1-3 or 1,2,3, replaces Commas with spaces, only allows Alphanumeric, - and space." "Comment: clean_input @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAN_INPUT_NOTES"   "Only Allows: Alphanumeric, 1 space between them, converts commas to spaces, converts all Alphas to lower case." "Comment: clean_input @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
clean_input()
{
    local CleanInput="${1}";                               # Assign
    CleanInput="$(trim "$CleanInput")";                  # Trim
    CleanInput="${CleanInput//,/ }";                     # Replace any Commas with space
    #CleanInput="$(echo -n "$CleanInput" | tr "," " ")"; # Replace any Commas with space using tr
    CleanInput="${CleanInput//[^a-zA-Z0-9 -]/}";         # Clean out anything thats not Alphanumeric, comma or a space
    CleanInput="$(to_lower_case "$CleanInput")";         # "$(echo -n $CleanInput | tr A-Z a-z)";   # Lowercase with TR: tr "[:upper:]" "[:lower:]"
    CleanInput="$(trim "$CleanInput")";                  # Trim
    echo "$CleanInput";
}
# -------------------------------------
test_clean_input()
{
    ((TestCounter += 1));
    local thisString; thisString="$(clean_input '1-3,4,5 6 A B C ^!@*')";
    if [ "${thisString}" == "1-3 4 5 6 a b c" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END clean_input
# *************************************************************************** #
# BEGIN read_input_options
# -------------------------------------
# HELPBUILDER read_input_options
help_read_input_options()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_READ_INPUT_OPTIONS_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_READ_INPUT_OPTIONS_DESC")";
    NOTES="$(localize "LOCALIZE_READ_INPUT_OPTIONS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER read_input_options
localize_read_input_options()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_USAGE"          "read_input_options 1->(options) 2->(Breakable Key) <- return Array Values in OPTIONS, expanded, duplicates removed and lower case." "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_DESC"           "Read Keyboard Input Options:  String of values: 1 2 3 or 1-3 or 1,2,3" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_NOTES"          "TheAutoMan, INSTALL_WIZARD and BYPASS to easily configure default values, hit 'r' to run Recommended Options." "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_OPTIONS"        "Use Options" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_IT_1"           "read_input_options Return Array" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_IT_2"           "read_input_options Removed Duplicates" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_VERIFY"         "Verify Input" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_INVALID-NUMBER" "Invalid Number Option: Legal values are" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_INVALID_ALPHA"  "Invalid Alpha Option: Legal values are" "Comment: read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_TITLE"   "Test Options Menu." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_1"       "Test Options." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_2"       "Option :" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_3"       "Testing Menu System with Options: " "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_4"       "Status of Option :" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_5"       "Menu System Test" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-1"    "Menu 1" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-1-I"         "Menu 1: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-1-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-1-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-1-SB"        "Status Bar Notice Test Menu Item 1" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-2"    "Menu 2" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-2-I"         "Menu 2: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-2-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-2-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-2-SB"        "Status Bar Notice Test Menu Item 2" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-3"    "Menu 3" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-3-I"         "Menu 3: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-3-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-3-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-3-SB"        "Status Bar Notice Test Menu Item 3" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-4"    "Menu 4" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-4-I"         "Menu 4: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-4-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-4-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-4-SB"        "Status Bar Notice Test Menu Item 4" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-5"    "Menu 5" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-5-I"         "Menu 5: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-5-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-5-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-5-SB"        "Status Bar Notice Test Menu Item 5" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-6"    "Menu 6" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-6-I"         "Menu 6: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-6-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-6-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-6-SB"        "Status Bar Notice Test Menu Item 6" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-7"    "Menu 7" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-7-I"         "Menu 7: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-7-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-7-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-7-SB"        "Status Bar Notice Test Menu Item 7" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-8"    "Menu 8" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-8-I"         "Menu 8: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-8-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-8-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-8-SB"        "Status Bar Notice Test Menu Item 8" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-9"    "Menu 9" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-9-I"         "Menu 9: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-9-C"         "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-9-W"         "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-9-SB"        "Status Bar Notice Test Menu Item 9" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-10"   "Menu 10" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-10-I"        "Menu 10: Information." "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-10-C"        "Caution" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-10-W"        "Warning" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_OPTIONS_MENU-10-SB"       "Status Bar Notice Test Menu Item 10" "Comment: test_read_input_options @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
read_input_options()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    # |1|
    # |1 2 3 4,5,6 7-9 Q D B R|
    #debugger 1
    local -i thisPrintDebug;  thisPrintDebug=0;   # 1=true or 0=false
    local -i thisSetDebug;    thisSetDebug=0;     # 1=true or 0=false
    local -a MyArray; MyArray=();
    local ThisOldIFS; ThisOldIFS="$IFS";
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi # Turn On Debug mode
    # EXPAND OPTIONS }}}
    # expand_options 1->(Array of Options MyArray=(1 2 3 4,5,6 7-9 Q D B) )
    # MyOptions=( expand_options "MyArray[@]" )
    expand_options()
    {
        local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$" ";
        local -a arrayOptions=("${!1}");     # Array
        local -i total="${#arrayOptions[@]}";
        local line="";
        local -a optionsArray=();
        # Fix any problems with input
        local -i total="${#arrayOptions[@]}";
        for (( i=0; i<total; i++ )); do
            if [ "${arrayOptions[$i]:0:1}" == "-" ]; then
                arrayOptions[$i]="${arrayOptions["${i}"]:1}";
            fi
        done
        #
        IFS=$" ";
        for line in "${arrayOptions[@]/,/ }"; do
            if [ "${line/-/}" != "$line" ]; then
                # @FIX not sure how to fix this: ((i={line%-*}; i<={line#*-}; i++)) or ((i=line%-*; i<=line#*-; i++))
                for ((i=${line%-*}; i<=${line#*-}; i++)); do
                    # Start at line with a - after it (%-*), 1-,
                    # then end with the - before it (#*-) -3,
                    # then count each item in between it, or expand it
                    [ -n "${i}" ] && optionsArray+=("${i}");
                done
            else
                # This is building an Array; bash you have to love it for allowing this type of declaration;
                # normally only works with strings in other languages;
                # normally in bash: array=($array "new") or array[${#array[*]}]="new"
                optionsArray+=("${line}")
            fi
        done
        #
        IFS=$'\n\t';
        optionsArray=( "$(remove_array_duplicates "optionsArray[@]")" );              # Remove Duplicates IFS=$'\n\t';
        #
        IFS=$" ";
        optionsArray=( "$(echo "${optionsArray[@]}" | tr "[:upper:]" "[:lower:]")" ); # Convert Alpha to Lower Case
        #
        for line in "${optionsArray[@]}"; do
            # If you use echo "" you will get a line feed so use IFS=$'\n\t', if you use -n you will not, so use IFS=$" "
            echo "$line";
        done
        IFS="$ThisOldIFS";
    }
    # *************************************************************************** #
    # CLEAN IT
    # MyArray=( $(clean_it 1->('1-3,4,5 6 A B C ^!@*') 2->('Defaults') 2->('Breakable-Key') ))
    clean_it()
    {
        local ThisOldIFS; ThisOldIFS="$IFS";
        # Pass in a string '1-3,4,5 6 A B C ^!@*', return trimmed string '1-3 4 5 6 a b c' of legal characters
        local MyOption; MyOption="$(clean_input "${1}")";
        local -a MyArray;
        IFS=$" ";
        if [ "$MyOption" == "r" ]; then  # Recommended Default Options
            if [ -z ${2+x} ]; then              # Use Breakable
                # This should not happen; you should always pass in the breakable key, how to fix it?
                # shellcheck disable=SC2207
                MyArray=( $( echo -n "${3}" ) );
            else
                # Not Empty
                # Use Defaults
                # shellcheck disable=SC2207
                MyArray=( $( echo -n "${2}" ) );
            fi
        else
            # shellcheck disable=SC2207
            MyArray=( $( echo -n "${MyOption}" ) );
        fi
        #
        IFS=$'\n\t';
        MyArray=( "$(expand_options "MyArray[@]")" ); # Expand Options: 1-3 returns 1 2 3
        for line in "${MyArray[@]}"; do
            echo "$line"; # If you use echo "" you will get a line feed so use IFS=$'\n\t', if you use -n you will not, so use IFS=$" "
        done
        IFS="$ThisOldIFS";
    }
    # *************************************************************************** #
    if [ "${TheAutoMan}" -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then
        IFS=$" ";
        if [ -z ${1+x} ]; then
            MyArray=( "$( clean_input "${2}" )" );             # @FIX this should not happen; you should always pass in the breakable key, how to fix it?
        else
            MyArray=( "$( clean_input "${1}" )" );
        fi
        IFS=$'\n\t';
        OPTIONS=( "$(expand_options "MyArray[@]")" ); # Expand Options: 1-3 returns 1 2 3
    else
        OPTION="";                                 # Clear: so we enter the loop
        while [[ -z ${OPTION} ]]; do
            OPTION="";                            # Clear: we have no idea whats in it after the first iteration
            read -r -p "        $prompt2" OPTION; # At this point its only going to be what the User types in
            # Now lets test Input
            if [ -n "${OPTION}" ]; then           # If not Empty
                IFS=$'\n\t';
                # Clean it, Trim, Replace Commas with Space, remove Illegal Characters.
                # shellcheck disable=SC2207
                OPTIONS=( $( clean_it "${OPTION}" "${1}" "${2}" ) );
                # Now test every option...
                local -i total="${#OPTIONS[@]}";
                for (( index=0; index<total; index++ )); do
                    if is_number "${OPTIONS["${index}"]}" ; then # If Number
                        if [ "${OPTIONS[${index}]}" -gt "$LAST_MENU_ITEM" ]; then
                            print_warning "LOCALIZE_READ_INPUT_OPTIONS_INVALID-NUMBER" ": 1-$LAST_MENU_ITEM, ${Breakable_Key}, r (${OPTIONS[${index}]})";
                            read_input_default "LOCALIZE_READ_INPUT_OPTIONS_VERIFY" "${OPTION}";
                            # shellcheck disable=SC2207
                            OPTIONS=( $(clean_it "${OPTION}" "${1}" "${2}" ) ); # Clean it, Trim, Replace Commas with Space, remove Illegal Characters.
                            break;
                        fi
                    else                                  # If Alpha it should = breakable, we tested for r above
                        if [[ "${OPTIONS["${index}"]}" != "$( to_lower_case "${Breakable_Key}" )" ]]; then
                            print_warning "LOCALIZE_READ_INPUT_OPTIONS_INVALID_ALPHA" ": 1-$LAST_MENU_ITEM, ${Breakable_Key}, r (${OPTIONS[${index}]})";
                            read_input_default "LOCALIZE_READ_INPUT_OPTIONS_VERIFY" "${OPTION}";
                            # shellcheck disable=SC2207
                            OPTIONS=( $(clean_it "${OPTION}" "${1}" "${2}" ) ); # Clean it, Trim, Replace Commas with Space, remove Illegal Characters.
                            break;
                        fi
                    fi
                done
            fi
        done
    fi
    if [ "${TheRunTest}" -eq 2 ]; then
        print_test "LOCALIZE_READ_INPUT_OPTIONS_OPTIONS" "${1}"; # Use Options Passed in as is
        print_test "LOCALIZE_READ_INPUT_OPTIONS_IT_1" ":";     # read_input_options Return Array
        print_array "OPTIONS[@]" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    IFS="${ThisOldIFS}";
    #debugger 0;
    write_log "read_input_options  ${OPTION}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
}
# -----------------------------------------------------------------------------
test_read_input_options()
{
    ((TestCounter += 1));
    #local -r menu_name="TestMenu";    # You must define Menu Name here
    local Breakable_Key="Q";           # Q=Quit, D=Done, B=Back
    local RecommendedOptions="1-3 4"; # Recommended Options to run in TheAutoMan or INSTALL_WIZARD Mode
    # SC2034: MenuChecks appears unused. Verify it or export it.
    # shellcheck disable=SC2034
    # shellcheck disable=SC2207
    MenuChecks=( $(create_data_array 0 0 ) );
    #
    if [ "${INSTALL_WIZARD}" -eq 1 ]; then
        RecommendedOptions="1,2,3 6 6";
    elif [ "${TheAutoMan}" -eq 1 ]; then
        RecommendedOptions="1 2 3 7 7";
    fi
    RecommendedOptions="${RecommendedOptions} ${Breakable_Key}";
    #
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n\t'; # Very Important when reading Arrays from files that end with a new line or tab
    IFS="$ThisOldIFS";
    #
    local StatusBar1="LOCALIZE_READ_INPUT_OPTIONS_TEST_1";
    local StatusBar2=": $RecommendedOptions";
    #
    while true; do
        #
        print_title "LOCALIZE_READ_INPUT_OPTIONS_TEST_TITLE";
        echo "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_line;
        print_info "LOCALIZE_READ_INPUT_OPTIONS_TEST_5";
        print_caution "${StatusBar1}" "${StatusBar2}";
        #
        local -a MenuItems;
        # SC2034: MenuChecks appears unused. Verify it or export it.
        # shellcheck disable=SC2034
        MenuItems=();
        local -a MenuInfo;
        # SC2034: MenuChecks appears unused. Verify it or export it.
        # shellcheck disable=SC2034
        MenuInfo=();
        #RESET_MENU=1; # Reset
        local -i ThisMenuItem=1;
        #             1            2           3          4                                           5                                             6                                             7                                  8
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-1-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-2-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-3-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-4-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-5-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-6-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-7-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-8-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-9-I"  "MenuTheme[@]"; ((ThisMenuItem++));
        add_menu_item "MenuChecks" "MenuItems" "MenuInfo" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-C" "LOCALIZE_READ_INPUT_OPTIONS_MENU-$ThisMenuItem-W" "LOCALIZE_READ_INPUT_OPTIONS_MENU-10-I" "MenuTheme[@]"; ((ThisMenuItem++));
        #
        print_menu "MenuItems[@]" "MenuInfo[@]" "${Breakable_Key}";
        #
        read_input_options "${RecommendedOptions}" "${Breakable_Key}";
        RecommendedOptions="" # Clear All previously entered Options so we do not repeat them
        #
        for S_OPT in "${OPTIONS[@]}"; do
            case "$S_OPT" in
                1)  # Option 1
                    MenuChecks["$((S_OPT - 1))"]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-${S_OPT-SB}");
                    StatusBar2="$S_OPT";
                    ;;
                2)  # Option 2
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                3)  # Option 3
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                4)  # Option 4
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                5)  # Option 5
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                6)  # Option 6
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                7)  # Option 7
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                8)  # Option 8
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                9)  # Option 9
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
               10)  # Option 10
                    # shellcheck disable=SC2034
                    MenuChecks[$((S_OPT - 1))]=1;
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    StatusBar1=$(localize "LOCALIZE_READ_INPUT_OPTIONS_MENU-$S_OPT-SB");
                    StatusBar2="$S_OPT";
                    ;;
                *)  # Not programmed key
                    print_warning "LOCALIZE_READ_INPUT_OPTIONS_TEST_2" "$S_OPT";
                    if [[ "$S_OPT" == $(to_lower_case "${Breakable_Key}") ]]; then
                        S_OPT="${Breakable_Key}";
                        break;
                    else
                        invalid_option "$S_OPT";
                    fi
                    ;;
            esac
        done
        if isBreakable "$S_OPT" "${Breakable_Key}"; then break; fi
    done
}
# END read_input_options
# *************************************************************************** #
# BEGIN read_input_yn
# -------------------------------------
# HELPBUILDER read_input_yn
help_read_input_yn()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_READ_INPUT_YN_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_READ_INPUT_YN_DESC")";
    NOTES="$(localize "LOCALIZE_READ_INPUT_YN_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="12 Dec 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER read_input_yn
localize_read_input_yn()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_READ_INPUT_YN_USAGE" "read_input_yn 1->(Question) 2->(None Localize) 3->(Default: 0=No, 1=Yes) <- return value YN_OPTION" "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_YN_DESC"  "Read Keyboard Input for Yes and No." "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_YN_NOTES" "Localized." "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_YN_TEST"  "Testing $(sub_string "${FUNCNAME[0]}" "localize_" 2)" "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_WRONG_KEY_YN" "Wrong Key, (Y)es or (n)o required." "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRONG_KEY_NY" "Wrong Key, (y)es or (N)o required." "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRONG_KEY_Q"  "Yes or No Question" "Comment: read_input_yn @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
read_input_yn()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> $(basename "${BASH_SOURCE[1]}") : ${FUNCNAME[1]}()"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WA_INFO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "LOCALIZE_WA_INFO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${3+x} ]] && { print_error "LOCALIZE_WA_INFO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    if [ "${TheAutoMan}" -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then YN_OPTION="${3}"; return 0; fi
    local -i thisOption; thisOption=0;
    # read_input_yn "Is this Correct" "This" 1
    # GET INPUT YN
    get_input_yn()
    {
        local OldIFS="$IFS"; IFS=$' ';
        echo "";
        if [ "${3}" == "1" ]; then
            print_read "${1}" "${2}" "[Y/n]:";
        else
            print_read "${1}" "${2}" "[y/N]:";
        fi
        #
        read -r -e -d '' -n1;
        echo "";
        IFS="$OldIFS";
        if [ "$REPLY" == "y" ] || [ "$REPLY" == "Y" ]; then
            TheAnswer=0;
            return 0;
        elif [ "$REPLY" == "n" ] || [ "$REPLY" == "N" ]; then
            TheAnswer=1;
            return 0;
        else
            return 1;
        fi
    }
    # *************************************************************************** #
    while [ "$thisOption" -ne 1 ]; do
        if get_input_yn "${1}" "${2}" "${3}"; then
            YN_OPTION="$TheAnswer";
            thisOption=1;
        else
            if [ "${3}" -eq 1 ]; then
                print_error "LOCALIZE_WRONG_KEY_YN" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            else
                print_error "LOCALIZE_WRONG_KEY_NY" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
            pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    done
    write_log "read_input_yn [${3}] answer ${YN_OPTION}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; # Left out data, it could be a password or user name.
}
# -------------------------------------
test_read_input_yn()
{
    ((TestCounter += 1));
    print_test "LOCALIZE_READ_INPUT_YN_TEST" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    read_input_yn "LOCALIZE_WRONG_KEY_Q" "" 1;
    print_caution "Return=${YN_OPTION}";
}
export -f read_input_yn;
# END read_input_yn
# *************************************************************************** #
# BEGIN read_input_default
# -------------------------------------
# HELPBUILDER read_input_default
help_read_input_default()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_READ_INPUT_DEFAULT_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_READ_INPUT_DEFAULT_DESC")";
    NOTES="$(localize "LOCALIZE_READ_INPUT_DEFAULT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="15 Jan 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER read_input_default
localize_read_input_default()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_READ_INPUT_DEFAULT_USAGE" "read_input_default 1->(Prompt) 2->(Default Value) <- returns string in OPTION" "Comment: read_input_default @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_DEFAULT_DESC"  "Read Keyboard Input and allow Edit of Default value." "Comment: read_input_default @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_DEFAULT_NOTES" "None." "Comment: read_input_default @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
read_input_default()
{
    # read_input_default "Enter Data" "Default-Date"
    if [ "${TheAutoMan}" -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then OPTION="${2}"; return 0; fi
    read -r -e -p "$(localize "${1}") >" -i "${2}" OPTION;
    echo "";
}
# END read_input_default
# *************************************************************************** #
# BEGIN read_input_data
# -------------------------------------
# HELPBUILDER read_input_data
help_read_input_data()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_READ_INPUT_DATA_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_READ_INPUT_DATA_DESC")";
    NOTES="$(localize "LOCALIZE_READ_INPUT_DATA_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER read_input_data
localize_read_input_data()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_READ_INPUT_DATA_USAGE" "read_input_data 1->(Localized Prompt) <- return value OPTION" "Comment: read_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_DATA_DESC"  "Read Data." "Comment: read_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_READ_INPUT_DATA_NOTES" "Return value in variable OPTION; not to be used in TheAutoMan or INSTALL_WIZARD Mode, since there is no default value." "Comment: read_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
read_input_data()
{
    read -r -p "$(localize "${1}") : " OPTION;
    write_log "read_input_data  ${1} = ${OPTION}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# FIXME test
# END read_input_data
# *************************************************************************** #
# BEGIN verify_input_default_data
# -------------------------------------
# HELPBUILDER verify_input_default_data
help_verify_input_default_data()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_DESC")";
    NOTES="$(localize "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER verify_input_default_data
localize_verify_input_default_data()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_USAGE"     "verify_input_default_data 1->(Prompt) 2->(Default-Value) 3->(Default 1=Yes or 0=No) 4->(Data Type: 0=Numeric, 1=Alphanumeric, 2=IP Address, 3=Domain Name, 4=Path, 5=Folder, 6=Email, 7=Special, 8=Password, 9=Alpha, 10=Variable) <- return value in OPTION" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_DESC"      "Verify Keyboard Input of Default Editable Value." "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_NOTES"     "None." "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST"      "Testing $(sub_string "${FUNCNAME[0]}" "localize_" 2)" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_ENTER"     "Enter" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_VERIFY"    "Verify" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_NOT-EMPTY" "Can not be empty" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_0"    "Numeric Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_1"    "Alphanumeric Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_2"    "IP Address Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_3"    "Domain Name Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_4"    "Full Path Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_5"    "Folder Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_6"    "Email Test Data" "Comment: verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
verify_input_default_data()
{
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ ${TheAutoMan} -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then
        write_log "${FUNCNAME[0]} ${1} = ${YN_OPTION}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; # Left out data, it could be a password or user name.
        OPTION="${2}";
        return 0;
    fi
    # READ VERIFY INPUT
    read_verify_input()
    {
        echo "";
        # @FIX using -n puts it all on the same line; when you use Arrows, it messes up the screen, deletes the line, and in general looks ugly.
        # if text is not at left side of screen, it jumps to that location
        #                        1                2                                          3                                                   4                    5
        printf "    %s%s%s %s: %s" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(localize "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_ENTER")" "$(localize "${1}")" "${T_Clear_EOL}";
        read -r -i "${2}" -e OPTION;
        echo "";
    }
    # *************************************************************************** #
    local -i Is_Valid=0;
    YN_OPTION=0;
    while [ "${YN_OPTION}" -ne 1 ]; do
        read_verify_input "${1}" "${2}";
        if [ "${4}" -eq 0 ]; then # Numeric
            if is_number "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 1 ]; then # Alphanumeric
            if is_alphanumeric "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 2 ]; then # IP Address
            if is_valid_ip "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 3 ]; then # Domain Name
            if is_valid_domain "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 4 ]; then # Path
            if is_valid_path "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 5 ]; then # Folder
            if is_valid_path "${OPTION}"; then
                Is_Valid=1;
            else
                if is_alphanumeric "${OPTION}"; then
                    Is_Valid=1;
                else
                    invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
                fi
            fi
        elif [ "${4}" -eq 6 ]; then # email
            if is_valid_email "${OPTION}"; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 7 ]; then # Special A-Z upper and lower, and -, but make sure the - is not leading or trailing
            if [[ "${OPTION}" =~ ^[a-zA-Z0-9][-a-zA-Z0-9]{0,61}[a-zA-Z0-9]$ ]] ; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 8 ]; then # Password - Replace * with |
            if [[ "${OPTION}" =~ ^[__A-Za-z0-9]+|$ ]] ; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 8 ]; then # Clean Var
            OPTION=${OPTION//[-+=.,]/_}

            if [[ "${OPTION}" =~ ^[__A-Za-z0-9]+$ ]] ; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi

        elif [ "${4}" -eq 9 ]; then # Alpha Only
            if [[ "${OPTION}" =~ ^[__A-Za-z]+$ ]] ; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        elif [ "${4}" -eq 10 ]; then # Variable A-Z upper and lower, and _, but make sure the _ is not trailing
            if [[ "${OPTION}" =~ ^[_a-zA-Z0-9][_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$ ]] ; then
                Is_Valid=1;
            else
                invalid_option "${OPTION} @ $(basename "${BASH_SOURCE[1]}") -> ${FUNCNAME[1]} : ${LINENO[1]} ";
            fi
        fi
        # --------------------------------
        if [ "$Is_Valid" -eq 1 ]; then #
            read_input_yn "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_VERIFY" "$(localize "${1}") : [${OPTION}]" "${3}";
            if [ -z ${YN_OPTION+x} ]; then
                echo "$(localize "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_NOT-EMPTY")!";
                YN_OPTION=0;
            fi
        fi
    done
    write_log "${FUNCNAME[0]} ${1} = ${YN_OPTION}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]} : ${LINENO[0]}"; # Left out data, it could be a password or user name.
    return 0;
}
# -------------------------------------
test_verify_input_default_data()
{
    print_test "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST" "$(sub_string "${FUNCNAME[0]}" "localize_" 2) : ${LINENO[0]}";
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_0" "2" 1 0; # 0 = Numeric
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Numeric";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Numeric";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_1" "A2" 1 1; # 1 = Alphanumeric
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Alphanumeric";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Alphanumeric";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_2" "0.0.0.0" 1 2; # 2 = IP Address
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Address";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} IP Address";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_3" "domainname.com" 1 3; # 3 = Domain Name
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Domain Name";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Domain Name";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_4" "/Full/Path" 1 4; # 4 = Path
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Path";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Path";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_5" "/Full/Path" 1 5; # 5 = Folder
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Folder";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Folder";
    fi
    verify_input_default_data "LOCALIZE_VERIFY_INPUT_DEFAULT_DATA_TEST_6" "name@domain.com" 1 6; #6 = Email
    if [ "${YN_OPTION}" -eq 1 ] ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]} Email";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]} Email";
    fi
    pause_function "verify_input_default_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END verify_input_default_data
# *************************************************************************** #
# BEGIN verify_input_data
# -------------------------------------
# HELPBUILDER verify_input_data
help_verify_input_data()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_VERIFY_INPUT_DATA_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_VERIFY_INPUT_DATA_DESC")";
    NOTES="$(localize "LOCALIZE_VERIFY_INPUT_DATA_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER verify_input_data
localize_verify_input_data()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_USAGE"  "verify_input_data 1->(Prompt) 2->(Data) <- return value OPTION" "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_DESC"   "verify input data." "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_NOTES"  "Localized." "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_ENTER"  "Enter" "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_VERIFY" "Verify" "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_VERIFY_INPUT_DATA_EMPTY"  "Can not be empty" "Comment: verify_input_data @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
verify_input_data()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ "${TheAutoMan}" -eq 1 ] || [ "${INSTALL_WIZARD}" -eq 1 ] && [ "${BYPASS}" -eq 1 ]; then
        OPTION="${2}";
        return 0;
    fi
    # READ VERIFY INPUT
    read_verify_input()
    {
        #                               1                2                                          3                                           4                    5
        printf "    %s%s%s %s%s\n" "${T_Clear_BOL}" "${T_Reset}${MenuTheme[0]}${MenuTheme[1]}" "$(localize "LOCALIZE_VERIFY_INPUT_DATA_ENTER")" "$(localize "${1}")" "${T_Clear_EOL}";
        read -r -p " : " OPTION;
    }
    # *************************************************************************** #
    YN_OPTION=0;
    while [[ "${YN_OPTION}" -ne 1 ]]; do
        read_verify_input "${1}"; # Returns OPTION
        read_input_yn "LOCALIZE_VERIFY_INPUT_DATA_VERIFY" "$(localize "${1}"): [${OPTION}]" "${2}"; # Returns YN_OPTION
        if [ -z ${OPTION+x} ]; then
            echo "$(localize "LOCALIZE_VERIFY_INPUT_DATA_EMPTY")!";
            YN_OPTION=0;
        fi
    done
    write_log "${FUNCNAME[0]} ${1} = ${YN_OPTION}" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; # Left out data, it could be a password or user name.
    return 0;
}
# END verify_input_data
# *************************************************************************** #
# BEGIN is_wildcard_file
# -------------------------------------
# HELPBUILDER is_wildcard_file
help_is_wildcard_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_WILDCARD_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_WILDCARD_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_IS_WILDCARD_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="12 Dec 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_wildcard_file
localize_is_wildcard_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_WILDCARD_FILE_USAGE" "is_wildcard_file 1->(/from/path/) 2->(filter)" "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_WILDCARD_FILE_DESC"  "Test for Files: is_wildcard_file '/from/path/' 'log' # if &lowast;.log exist." "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_WILDCARD_FILE_NOTES" "filter: if ' ' all, else use extension, do not pass 'Array' in &lowast; as wildcard. If looking for a '/path/.hidden' file, a /path/&lowast; fails, so use no wild card, i.e. /path/." "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_WILDCARD_FILE_TEST"  "Testing wildcard_file" "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_WILDCARD_FILE_MISSING_SRC" "Missing Source Folder Path" "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_WILDCARD_FILE_MISSING_F" "Missing Wildcard Filter: It can be a Space, but not empty." "Comment: is_wildcard_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_wildcard_file()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1} ]] && { print_error "LOCALIZE_IS_WILDCARD_FILE_MISSING_SRC" "${FUNCNAME[0]}():${LINENO[0]}"; pause_function " "; return 1; }
    [[ -z ${2} ]] && { print_error "LOCALIZE_IS_WILDCARD_FILE_MISSING_F" "${FUNCNAME[0]}():${LINENO[0]}"; pause_function " "; return 1; }
    # *************************************************************************** #
    findFilesWithExt()
    {
        local path; path="$1";
        local ext; ext="$2";
        # shellcheck disable=SC2034
        for f in "${path}"*."${ext}"; do
            return 1;
        done
        return 0;
    }
    # -----------------------------------------------------------
    if [ ! -d "${1}" ]; then
        if [ "${TheDebugging}" -eq 1 ]; then
            pause_function "[${1}] Directory Not Found  ${1}: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            get_stack "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
        return 1; # Path does not exist
    fi
    if [ "${2}" == " " ]; then
        if ls "${1}"* 1> /dev/null 2>&1; then
            return 0;  # NOT EMPTY
        else
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "[${1}] * Not Found : ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
            return 1;  # EMPTY
        fi
    else
        #if ls "${1}"*."${2}" 1> /dev/null 2>&1; then
        if findFilesWithExt "${1}" "${2}"; then
            #if [ "${TheDebugging}" -eq 1 ]; then pause_function "[${1}] *.${2} Not Found : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
            return 1;  # EMPTY
        else
            return 0; # NOT EMPTY
        fi
    fi
}
# -------------------------------------
test_is_wildcard_file()
{
    ((TestCounter += 1));
    if [ -f "${TheFullScriptPath}/Support/Test/Source/gtranslate-cc.db" ]; then
        if is_wildcard_file "${TheFullScriptPath}/Support/Test/Source/" "db" ; then # " " | "ext"
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
        fi
        #
        if is_wildcard_file "${TheFullScriptPath}/Support/Test/Source/" " " ; then # " " | "ext"
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
        fi
        #
        if is_wildcard_file "${TheFullScriptPath}/Support/Test/Source/" "badext" ; then
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
        else
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        fi
    fi # END if [ -f "${TheFullScriptPath}/Support/Test/Source/gtranslate-cc.db" ]; then
}
# END is_wildcard_file
# *************************************************************************** #
# BEGIN make_dir
# -------------------------------------
# HELPBUILDER make_dir
help_make_dir()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_MAKE_DIR_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_MAKE_DIR_DESC")";
    NOTES="$(localize "LOCALIZE_MAKE_DIR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER make_dir
localize_make_dir()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_MAKE_DIR_USAGE" "make_dir 1->(/Full/Path) 2->(Debugging Information)" "Comment: make_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_DIR_DESC"  "Make Directory." "Comment: make_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_DIR_NOTES" "return 0 if dir created." "Comment: make_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
make_dir()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -n "${1}" ]; then # Check for Empty
        [[ ! -d "${1}" ]] && mkdir -p "${1}";
        if [ -d "${1}" ]; then
            if [ "$TheSilentMode" -eq 0 ]; then
                write_log "make_dir ${1} from ${2} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
            return 0
        else
            write_error "make_dir ${1} failed to create directory from line ${2}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_error "make_dir ${1} failed to create directory from line ${2}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
            return 1;
        fi
    else
        write_error "Empty: make_dir [${1}] failed to create directory from line ${2}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_error "make_dir ${1} failed to create directory from line ${2}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_make_dir()
{
    ((TestCounter += 1));
    if make_dir "${TheFullScriptPath}/Support/Test/Target/MakeMe/" ": make_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END make_dir
# *************************************************************************** #
# BEGIN copy_file
# -------------------------------------
# HELPBUILDER copy_file
help_copy_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_COPY_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_COPY_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_COPY_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="24 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER copy_file
localize_copy_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_COPY_FILE_USAGE" "copy_file 1->(/full-path/from.ext) 2->(/full-path/to_must_end_with_a_slash/) 3->(Debugging Information)" "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILE_DESC"  "Copy File." "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILE_NOTES" "Creates Destination Folder if not exist. LINENO is for Logging and Debugging." "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_COPY_FILE_FNF"   "File Not Found" "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILE_PATH"  "Path Empty."    "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILE_ARG"   "Empty Argument" "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILE_FAIL"  "Copy Failed"    "Comment: copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
copy_file()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    #
    if [ ! -f "${1}" ]; then
        # SC2199: Arrays implicitly concatenate in [[ ]]. Use a loop (or explicit * instead of @).
        #if [[ "${EXCLUDE_FILE_WARN[@]}" != *"${1}"* ]]; then
        if [[ "${EXCLUDE_FILE_WARN[*]}" != *"${1}"* ]]; then
            print_error "LOCALIZE_COPY_FILE_FNF" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_COPY_FILE_FNF" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "copy_file ${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        fi
        return 1
    fi
    #
    if [ -z ${2+x} ]; then # Check for Empty
        print_error "LOCALIZE_COPY_FILE_PATH" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_COPY_FILE_PATH" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "copy_file ${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    local dir_to="${2%/*}";
    # local file_to="${2##*/}"
    if [ ! -d "$dir_to" ]; then # Check for Empty
        make_dir "$dir_to" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    #
    if [ -n "${1}" ] && [ -n "${2}" ]; then # Check for Empty
        do_copy "${1}" "${2}" "${3}";
        # -- means stop looking for arguments, in case the file name or folder starts with a dash, and gets interpreted as a command
#        if cp -f -- "${1}" "${2}"; then
#            write_log "copy_file ${1} to ${2} from ${3} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#        else
#            print_error "LOCALIZE_COPY_FILE_FAIL" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#            write_error "LOCALIZE_COPY_FILE_FAIL" "copy_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#            if [ "${TheDebugging}" -eq 1 ]; then pause_function "${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
#            return 1;
#        fi
    else
        print_error "LOCALIZE_COPY_FILE_ARG" "copy_file [${1}] to [${2}] failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_COPY_FILE_ARG" "copy_file [${1}] to [${2}] failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Empty: [${1}] to [${2}] from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_copy_file()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="README.md";
    copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}${thisFileName}" "copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ -f "${TargetFolder}${thisFileName}" ]; then # Only make changes once
        # FIXME delete_file
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END copy_file

# *************************************************************************** #
# BEGIN rename_file
# -------------------------------------
# HELPBUILDER rename_file
help_rename_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_RENAME_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_RENAME_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_RENAME_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="24 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER rename_file
localize_rename_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RENAME_FILE_USAGE" "rename_file 1->(/full-path/from.ext) 2->(/full-path/to_must_end_with_a_slash/) 3->(Debugging Information)" "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RENAME_FILE_DESC"  "Copy File." "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RENAME_FILE_NOTES" "Creates Destination Folder if not exist. LINENO is for Logging and Debugging." "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_RENAME_FILE_FNF"   "File Not Found" "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RENAME_FILE_PATH"  "Path Empty."    "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RENAME_FILE_ARG"   "Empty Argument" "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RENAME_FILE_FAIL"  "Copy Failed"    "Comment: rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
rename_file()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    #
    if [ ! -f "${1}" ]; then
        # SC2199: Arrays implicitly concatenate in [[ ]]. Use a loop (or explicit * instead of @).
        #if [[ "${EXCLUDE_FILE_WARN[@]}" != *"${1}"* ]]; then
        if [[ "${EXCLUDE_FILE_WARN[*]}" != *"${1}"* ]]; then
            print_error "LOCALIZE_RENAME_FILE_FNF" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_RENAME_FILE_FNF" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "rename_file ${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        fi
        return 1
    fi
    #
    if [ -z ${2+x} ]; then # Check for Empty
        print_error "LOCALIZE_RENAME_FILE_PATH" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_RENAME_FILE_PATH" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "rename_file ${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    local dir_to="${2%/*}";
    # local file_to="${2##*/}"
    if [ ! -d "$dir_to" ]; then # Check for Empty
        make_dir "$dir_to" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    #
    if [ -n "${1}" ] && [ -n "${2}" ]; then # Check for Empty
        do_copy "${1}" "${2}" "${3}";
        # -- means stop looking for arguments, in case the file name or folder starts with a dash, and gets interpreted as a command
#        if cp -f -- "${1}" "${2}"; then
#            write_log "rename_file ${1} to ${2} from ${3} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#        else
#            print_error "LOCALIZE_RENAME_FILE_FAIL" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#            write_error "LOCALIZE_RENAME_FILE_FAIL" "rename_file ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#            if [ "${TheDebugging}" -eq 1 ]; then pause_function "${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
#            return 1;
#        fi
    else
        print_error "LOCALIZE_RENAME_FILE_ARG" "rename_file [${1}] to [${2}] failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_RENAME_FILE_ARG" "rename_file [${1}] to [${2}] failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Empty: [${1}] to [${2}] from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_rename_file()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="README.md";
    rename_file "${SourceFolder}${thisFileName}" "${TargetFolder}${thisFileName}" "rename_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ -f "${TargetFolder}${thisFileName}" ]; then # Only make changes once
        # FIXME delete_file
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END rename_file


# *************************************************************************** #
# BEGIN do_copy
# -------------------------------------
# HELPBUILDER do_copy
help_do_copy()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_DO_COPY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_DO_COPY_DESC")";
    NOTES="$(localize "LOCALIZE_DO_COPY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="19 March 2021";
    REVISION="19 March 2021";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER do_copy
localize_do_copy()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DO_COPY_USAGE" "do_copy 1->(/full-path/from.ext) 2->(/full-path/to_must_end_with_a_slash/) 3->(Debugging Information)" "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_COPY_DESC"  "Copy File." "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_COPY_NOTES" "Creates Destination Folder if not exist. LINENO is for Logging and Debugging." "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_DO_COPY_FNF"   "File Not Found" "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_COPY_PATH"  "Path Empty."    "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_COPY_ARG"   "Empty Argument" "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_COPY_FAIL"  "Copy Failed"    "Comment: do_copy @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# Source File and Destination Folder or File
# do_copy "/full-path/from.ext" "/full-path/to_must_end_with_a_slash/" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#
declare ThisExcludeList; ThisExcludeList=".@__thumb"; export ThisExcludeList;
#
#
do_copy()
{
    if [ $# -ne 3 ] ; then
        echo "Source File and Destination Folder or File and Error Calling Function";
        exit 1;
    fi
    if [ ! -f "${1}" ]; then
        echo "Source File Not Found: ${1}";
        exit 1;
    fi
    if [ ! -f "${1}" ]; then
        if [ ! -d "${2}" ]; then
            echo "Destination Folder Not Found: ${2}";
            exit 1;
        fi
    fi
    # -ot (older than)
    # -nt (newer than) newer than or same age
    #if [ "${1}" -nt "${2}" ]; then
    #    echo "Coping file: ${1}";
    #    /usr/bin/cp -rf "${1}" "${2}";
    #else
    #    echo "Skip ${1}";
    #fi
    declare -i ReturnValue; ReturnValue=0;
    # FIXME 
    if [ "$COPY_RSYNC" -eq 1 ]; then
        if [ "${SimulateThis}" -eq 0 ]; then
            if ! rsync -av "${1}" "${2}" --exclude="${ThisExcludeList}"; then ReturnValue=1; fi
        else
            echo "SimulateThis: rsync -av ${1} ${2} --exclude=${ThisExcludeList}";
        fi
    else
        # -- means stop looking for arguments, in case the file name or folder starts with a dash, and gets interpreted as a command
        if ! /usr/bin/cp -f -- "${1}" "${2}"; then ReturnValue=1; fi
    fi
    if [ "${SimulateThis}" -eq 0 ]; then
        if [ "$ReturnValue" -eq 0 ]; then
            write_log "do_copy ${1} to ${2} from ${3} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        else
            print_error "LOCALIZE_DO_COPY_FAIL" "do_copy ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_DO_COPY_FAIL" "do_copy ${1} to ${2} failed to copy file from ${3} at ${TheDateTime}. @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "${1} to ${2} from ${3} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
            return 1;
        fi
    fi
    return 0;
}
# END do_copy
# *************************************************************************** #
# BEGIN copy_files
# -------------------------------------
# HELPBUILDER copy_files
help_copy_files()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_COPY_FILES_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_COPY_FILES_DESC")";
    NOTES="$(localize "LOCALIZE_COPY_FILES_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER copy_files
localize_copy_files()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_COPY_FILES_USAGE" "copy_files 1->(/full-path/must_end_with_a_slash/) 2->(ext or Blank for *) 3->(/full-path/must_end_with_a_slash/) 4->(Debugging Information)<br />${HELP_TAB}copy_files 1->(/full-path/) 2->( ) 3->(/full-path/to_must_end_with_a_slash/) 4->(Debugging Information)" "Comment: copy_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILES_DESC"  "Creates Destination Folder if not exist. LINENO is for Logging and Debugging." "Comment: copy_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_FILES_NOTES" "If looking for a '/path/.hidden' file, a /path/&lowast; fails, so use no wild card, i.e. /path/" "Comment: copy_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
copy_files()
{
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO"  "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -z ${1+x} ]; then
        write_error "Path Emtpy! copy_files |${1}| |${2}| to |${3}| failed to copy file from |${4}| at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Path Emtpy! |${1}| |${2}| to |${3}| from |${4}| (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    else
        if [ ! -d "${1}" ]; then
            write_error "Path Emtpy! copy_files |${1}| |${2}| to |${3}| failed to copy file from |${4}| at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "Path Emtpy! |${1}| |${2}| to |${3}| from |${4}| (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
            return 1;
        fi
    fi
    if [ -z ${3+x} ]; then # Check for Empty
        write_error "Path Emtpy! copy_files ${1} to ${3} failed to copy file from ${4} at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Path Emtpy! ${1} to ${3} from ${4} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    # Wildcard Copy
    if ! is_wildcard_file "${1}" "${2}" ; then # " " | "ext"
        if [ "${2}" == " " ]; then
            write_error "Files Not Found! copy_files->is_wildcard_file [${1}] to [${3}] failed to copy file from ${4} at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "Files Not Found! -rfv [${1}] to [${3}] from ${4} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        else
            write_error "Files Not Found! copy_files->is_wildcard_file [${1}*.${2}] to [${3}] failed to copy file from ${4} at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "Files Not Found! -fv [${1}*.${2}] to [${3}] from ${4} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        fi
        return 1;
    fi
    #
    local dir_from; dir_from="$(path_backslash_add "$1")";
    local dir_to;   dir_to="$(path_backslash_add "$3")";
    #
    if [ ! -d "$dir_to" ]; then  # Check for Empty
        make_dir "$dir_to" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    #
    # FIXME validate to name
    #
    if [ -n "${dir_from}" ] && [ -n "${dir_to}" ]; then  # Check for Empty
        # -- means stop looking for arguments, in case the file name or folder starts with a dash, and gets interpreted as a command
        if [ "${2}" == " " ]; then
            # Copy all recursively
            if is_file_user_read_access "${dir_from}"; then
                if cp -rf -- "${dir_from}." "${dir_to}"; then
                    write_log "copy_files -rf [${dir_from}.] to [${dir_to}] from ${4} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                else
                    print_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4} ${TheDateTime}." " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    write_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4}" " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    if [ "${TheDebugging}" -eq 1 ]; then pause_function "${dir_from}*.${2} to ${dir_to} from ${4} returned $TEMP (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
                    return 1
                fi
            else
                sudo_Required "${FUNCNAME[0]}";
                
                if do_copy "/full-path/from.ext" "/full-path/to_must_end_with_a_slash/" "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; then
                    write_log "copy_files -rf [${dir_from}.] to [${dir_to}] from ${4} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                else
                    print_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4} ${TheDateTime}." " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    write_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4}" " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    if [ "${TheDebugging}" -eq 1 ]; then pause_function "${dir_from}*.${2} to ${dir_to} from ${4} returned $TEMP (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
                    return 1
                fi
                
#                if sudo cp -rf -- "${1}." "${dir_to}"; then
#                    write_log "copy_files -rf [${dir_from}.] to [${dir_to}] from ${4} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#                else
#                    print_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4} ${TheDateTime}." " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#                    write_error "copy_files -rf [${dir_from}.] to [${dir_to}] failed to copy file from ${4}" " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#                    if [ "${TheDebugging}" -eq 1 ]; then pause_function "${dir_from}*.${2} to ${dir_to} from ${4} returned $TEMP (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
#                    return 1
#                fi
            fi
        else
            if is_file_user_read_access "$dir_from"; then
                if is_wildcard_file "${dir_from}" "${2}" ; then
                    if cp -rf -- "${dir_from}"*."${2}" "${dir_to}"; then
                        write_log "copy_files -rfv [${dir_from}*.${2}] to [${dir_to}] from ${4} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    else
                        print_error "copy_files Wildcard ${2} not found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        write_error "copy_files Wildcard ${2} not found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        if [ "${TheDebugging}" -eq 1 ]; then pause_function "${dir_from}*.${2} to ${dir_to} from ${4} returned $TEMP (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
                        return 1
                    fi
                fi
            else
                sudo_Required "${FUNCNAME[0]}";
                if is_wildcard_file "${dir_from}" "${2}" ; then
                    if sudo cp -rf -- "${dir_from}"*."${2}" "${dir_to}"; then
                        write_log "copy_files -rfv [${dir_from}*.${2}] to [${dir_to}] from ${4} at ${TheDateTime}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    else
                        print_error "copy_files Wildcard ${2} not found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        write_error "copy_files Wildcard ${2} not found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        if [ "${TheDebugging}" -eq 1 ]; then pause_function "${dir_from}*.${2} to ${dir_to} from ${4} returned $TEMP (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
                        return 1
                    fi
                fi
            fi
        fi
    else
        write_error "Empty: copy_files [${dir_from}*.${2}] to [${2}] failed to copy file from ${dir_to} at ${TheDateTime}." "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Empty: [${dir_from}*.${2}] to [${2}] from ${dir_to} (: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]})"; fi
        return 1;
    fi
    return 0;
}
# -----------------------------------------------------------------
# 1) /full-path/
# 2) ext or Blank for *
# 3) /full-path/to_must_end_with_a_slash/
# 4) Debugging Information
#
test_copy_files()
{
    ((TestCounter += 1));
    local SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local TargetPath="${TheFullScriptPath}/Support/Test/Target/";

    copy_files "${SourcePath}" "log" "${TargetPath}" "${FUNCNAME[0]}(): ${LINENO[0]}";

    local TestFilePath="${TheFullScriptPath}/Support/Test/Target/MyLogFile-1.log";
    if [ -f "${TestFilePath}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        remove_file "${TestFilePath}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    TargetPath="${TheFullScriptPath}/Support/Test/Target";
    copy_files "${SourcePath}" " " "${TargetPath}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ -f "${TestFilePath}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        remove_file "${TestFilePath}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END copy_files
# *************************************************************************** #
# BEGIN copy_dir
# -------------------------------------
# HELPBUILDER copy_dir
help_copy_dir()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_COPY_DIRECTORY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_COPY_DIRECTORY_DESC")";
    NOTES="$(localize "LOCALIZE_COPY_DIRECTORY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER copy_dir
localize_copy_dir()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_COPY_DIRECTORY_USAGE" "copy_dir 1->(/full-path/) 2->(/full-path/to_must_end_with_a_slash/) 3->(Debugging Information)" "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_DIRECTORY_DESC"  "Copy Directory." "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_DIRECTORY_NOTES" "None." "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_COPY_DIRECTORY_PATH"  "Empty Path." "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_DIRECTORY_COPY"  "Copied Directory" "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_DIRECTORY_ERROR" "Failed to copy Directory." "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COPY_DIRECTORY_MAKE"  "Failed to Make Directory." "Comment: copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
copy_dir()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    #
    if [ -z ${1+x} ]; then
        print_error "LOCALIZE_COPY_DIRECTORY_PATH" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_COPY_DIRECTORY_PATH" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    #
    if [ -z ${2+x} ]; then
        print_error "LOCALIZE_COPY_DIRECTORY_PATH" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_COPY_DIRECTORY_PATH" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    #
    local dir_to="${2%/*}";
    # local file_to="${2##*/}"
    if [ ! -d "$dir_to" ]; then
        if [ -n "$dir_to" ]; then
            if ! make_dir "$dir_to" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}" ; then
                print_error "LOCALIZE_COPY_DIRECTORY_MAKE" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                write_error "LOCALIZE_COPY_DIRECTORY_MAKE" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
            fi
        fi
    fi
    #
    # -- means stop looking for arguments, in case the file name or folder starts with a dash, and gets interpreted as a command
    if cp -rf -- "${1}" "${2}"; then
        # print_this "LOCALIZE_COPY_DIRECTORY_COPY" "[${1}] -> [${2}] : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_log  "LOCALIZE_COPY_DIRECTORY_COPY" "[${1}] -> [${2}] : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_COPY_DIRECTORY_ERROR" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_COPY_DIRECTORY_ERROR" "[${1}] -> [${2}] | ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        # @FIX if /etc resolv.conf needs its attributes changed
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_copy_dir()
{
    ((TestCounter += 1));
    local SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local TargetPath="${TheFullScriptPath}/Support/Test/Target/";
    if copy_dir "${SourcePath}" "${TargetPath}" ": copy_dir @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}" ; then
        # FIXME delete_files in Target
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END copy_dir
# *************************************************************************** #
# BEGIN remove_file
# -------------------------------------
# HELPBUILDER remove_file
help_remove_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_file
localize_remove_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_FILE_USAGE"     "remove_file 1->(/full-path/from.ext) 2->(Debugging Information)" "Comment: remove_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILE_DESC"      "Remove File if it exist." "Comment: remove_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILE_NOTES"     "if -f > rm -f." "Comment: remove_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILE_NOT-FOUND" "Not Found" "Comment: remove_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_file()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -f "${1}" ]; then
        if rm -f "${1}"; then
            # print_this "remove_file ${1}" " -> ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_log  "remove_file ${1}" " -> ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 0;
        else            
            print_error "LOCALIZE_REMOVE_FILE_NOT-FOUND" ": remove_file [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_REMOVE_FILE_NOT-FOUND" ": remove_file [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 1;
        fi
    else
        print_error "LOCALIZE_REMOVE_FILE_NOT-FOUND" ": remove_file [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_REMOVE_FILE_NOT-FOUND" ": remove_file [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        return 1;
    fi
}
# -------------------------------------
test_remove_file()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyArray.db";
    copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    remove_file "${TargetFolder}${thisFileName}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ -f "${TargetFolder}${thisFileName}" ]; then
        # FIXME remove_file "${TargetFolder}${thisFileName}" "${FUNCNAME[0]} ${TestthisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    fi
}
# END remove_file
# *************************************************************************** #
path_backslash_add()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    declare FilePath="$1";
    
    # [[ "${STR}" != */ ]] && STR="${STR}/"
    
    if [ ! -f "${FilePath}" ]; then
        length=${#FilePath};
        last_char=${FilePath:length-1:1};
        [[ $last_char != "/" ]] && FilePath="$FilePath/";
    fi
    echo "$FilePath"; #
}
# *************************************************************************** #
path_backslash_remove()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    declare FilePath="$1";
    
    # [[ "${STR}" == */ ]] && STR="${STR: : -1}"
    
    if [ ! -f "${FilePath}" ]; then
        length=${#FilePath};
        last_char=${FilePath:length-1:1};
        [[ $last_char == "/" ]] && FilePath=${FilePath:0:length-1};
    fi
    echo "$FilePath"; #
}
# *************************************************************************** #
# BEGIN remove_files
# -------------------------------------
# HELPBUILDER remove_files
help_remove_files()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_FILES_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_FILES_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_FILES_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_files
localize_remove_files()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_FILES_USAGE"      "remove_files 1->(/Full-Path/) 2->(ext or Blank for *) 3->(Debugging Information)" "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILES_DESC"       "Remove Files if it exist." "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILES_NOTES"      "if -f > rm -f." "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILES_NOT-FOUND"  "Not Found" "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILES_FNF"        "File Not Found Failed to remove files" "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FILES_FAIL"       "Failed to remove files" "Comment: remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_files()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    declare TheFilePath="${1}";
    TheFilePath="$(path_backslash_add "$TheFilePath")";
    if ! is_wildcard_file "${TheFilePath}" "${2}" ; then # " " | "ext"
        if [ "${2}" == " " ]; then
            write_error "LOCALIZE_REMOVE_FILES_FNF" "[${TheFilePath}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
            print_error "LOCALIZE_REMOVE_FILES_FNF" "[${TheFilePath}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "${FUNCNAME[0]} [${TheFilePath}] @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        else
            write_error "LOCALIZE_REMOVE_FILES_FNF" "[${TheFilePath}*.${2}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
            print_error "LOCALIZE_REMOVE_FILES_FNF" "[${TheFilePath}*.${2}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "${FUNCNAME[0]} [${TheFilePath}*.${2}] @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        fi
        return 1;
    fi
    #
    if [ "${2}" == " " ]; then
        # /path/* remove all files and folders recursively
        echo "rm -rf ${TheFilePath}*";
        if rm -rf "${TheFilePath}"*; then
            write_log "LOCALIZE_REMOVE_FILES_FAIL" " remove_file -rf [${TheFilePath}.]    -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
        else
            print_error "LOCALIZE_REMOVE_FILES_FNF" "[${TheFilePath}*.${2}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
        fi
    else
        # /path/*.ext remove only files with matching extensions
        if rm -rf "${TheFilePath}"*."${2}"; then
            write_log "LOCALIZE_REMOVE_FILES_FAIL" " remove_file -rf [${TheFilePath}*.${2}] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${3}";
        fi
    fi
}
# -------------------------------------
test_remove_files()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargeFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="*.log";
    copy_files "${SourceFolder}" " " "${TargeFolder}" "remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    remove_files "${TargeFolder}" "log" "remove_files @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ ! -f "${TargeFolder}${thisFileName}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END remove_files
# *************************************************************************** #
# BEGIN remove_folder
# -------------------------------------
# HELPBUILDER remove_folder
help_remove_folder()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_FOLDER_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_folder
localize_remove_folder()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_FOLDER_USAGE"   "remove_folder 1->(/Full-Path/) 2->(Debugging Information)" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_DESC"           "Remove Folder if it exist." "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_NOTES"          "if -d > rm -rf -- /Full-Path/" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_NOT_FOUND"      "Folder Not Found" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_FOUND"          "Error Removing Folder: Still exist because its in use by the script itself, exit and delete it manually if needed." "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "REMOVE_FOLDER"                   "Removed Folder" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_folder()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -d "${1}" ]; then
        # This path should not end in a slash
        if ! rm -rf "${1:?}"; then
            chmod -R 775 "${1}";
            rm -Rf "${1:?}/";
        fi
        if [ -d "${1}" ]; then
            write_error "LOCALIZE_REMOVE_FOUND" ": ${FUNCNAME[0]}(): [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_error "LOCALIZE_REMOVE_FOUND" ": ${FUNCNAME[0]}(): [${1}] @ ${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 1;
        else
            write_log  "REMOVE_FOLDER" "${1} -> ${2} -> ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_this "REMOVE_FOLDER" "${1} -> ${2} -> ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 0;
        fi
    else
        print_error "REMOVE-FOLDER-NOT-FOUND" ": ${FUNCNAME[0]}() [${1}] @ ${2} -> \n   @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "REMOVE-FOLDER-NOT-FOUND" ": ${FUNCNAME[0]}() [${1}] @ ${2} -> \n   @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        return 1;
    fi
}
# -------------------------------------
test_remove_folder()
{
    ((TestCounter += 1));
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local FolderName="RemoveMe";
    make_dir "${TargetFolder}${FolderName}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    remove_folder "${TargetFolder}${FolderName}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ ! -d "${TargetFolder}${FolderName}/" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END remove_folder
# *************************************************************************** #
# BEGIN delete_line_in_file
# -------------------------------------
# HELPBUILDER delete_line_in_file
help_delete_line_in_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_DELETE_LINE_IN_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_DELETE_LINE_IN_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_DELETE_LINE_IN_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER delete_line_in_file
localize_delete_line_in_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DELETE_LINE_IN_FILE_USAGE" "delete_line_in_file 1->(Text on line to Delete) 2->(/FullPath/FileName.ext)" "Comment: delete_line_in_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DELETE_LINE_IN_FILE_DESC"  "Given text of Line, Delete it in File" "Comment: delete_line_in_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DELETE_LINE_IN_FILE_NOTES" "This function is not ready to use, I forgot to finish it, so its just a stub that needs to be finished" "Comment: delete_line_in_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DELETE_LINE_IN_FILE_TF"    "Failed" "Comment: delete_line_in_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
delete_line_in_file()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    sed -i '/'"${1}"'/ d' "${2}";
    return "$?";
}
# -------------------------------------
test_delete_line_in_file()
{
    ((TestCounter += 1));
    print_test "LOCALIZE_TEST_FUNCTION_RUN" "$(basename "${BASH_SOURCE[0]}") : $(sub_string "${FUNCNAME[0]}" "test_" 2) : ${LINENO[0]} ";
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyTest.txt";
    copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if is_string_in_file "${TargetFolder}${thisFileName}" "Defaults timestamp_timeout" ; then
        if delete_line_in_file "Defaults timestamp_timeout" "${TargetFolder}${thisFileName}"; then
            if is_string_in_file "${TargetFolder}${thisFileName}" "Defaults timestamp_timeout" ; then
                print_error "LOCALIZE_DELETE_LINE_IN_FILE_TF" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "LOCALIZE_DELETE_LINE_IN_FILE_TF" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    fi
    # @FIXME; This function is not ready to use, I forgot to finish it, so its just a stub that needs to be finished
}
# END delete_line_in_file
# *************************************************************************** #
# BEGIN comment_file
# -------------------------------------
# HELPBUILDER comment_file
help_comment_file()
{
    ((HelpComplileCounter += 1));
    ((LocalizeComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_COMMENT_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_COMMENT_FILE_DESC")";
    NOTES="$(localize "NONE")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" " @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER comment_file
localize_comment_file()
{
    localize_info "LOCALIZE_COMMENT_FILE_USAGE" "comment_file 1->(Text to Comment) 2->(/FullPath/FileName.ext)" "Comment: comment_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COMMENT_FILE_DESC"  "Given text of Line, Comment it out in File" "Comment: comment_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_COMMENT_FILE_FNF"  "File not found" "Comment: comment_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
comment_file()
{
    # FIXME: Specify type of comment: <!-- HTML -->, # BASH, ; Config
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ ! -f "${2}" ]; then print_error "LOCALIZE_COMMENT_FILE_FNF" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; return 1; fi
    local -i thisReturnStatus=1;
    if is_string_in_file "${2}" "${1}" ; then
        sed -i 's/^'"${1}"'/#'"${1}"'/g' "${2}";
        thisReturnStatus="$?";
        if ! is_string_in_file "${2}" "#${1}" ; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            return 1;
        fi
    fi
    return "$thisReturnStatus";
}
# -------------------------------------
test_comment_file()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyTest.txt";
    copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if comment_file "Defaults:USERNAME" "${TargetFolder}${thisFileName}" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END comment_file
# *************************************************************************** #
# BEGIN
# -------------------------------------
# HELPBUILDER un_comment_file
help_un_comment_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_UN_LOC_COMMENT_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_UN_LOC_COMMENT_FILE_DESC")";
    NOTES="$(localize "NONE")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER un_comment_file
localize_un_comment_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_UN_LOC_COMMENT_FILE_USAGE" "un_comment_file 1->(Text) 2->(/FullPath/FileName.ext)" "Comment: un_comment_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_UN_LOC_COMMENT_FILE_DESC"  "Given text of Line, un-Comment it out in File" "Comment: un_comment_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
#
# 1) Text to Comment
# 2) FullPath to File to comment
#
un_comment_file()
{
    # FIXME: Specify type of comment: <!-- HTML -->, # BASH, ; Config
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ ! -f "${2}" ]; then print_error "LOCALIZE_COMMENT_FILE_FNF" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; return 1; fi
    local -i thisReturnStatus=1;
    #if [ $(egrep -ic "#${1}" "${2}") -gt 0 ]; then
    if is_string_in_file "${2}" "#${1}" ; then
        sed -i "/${1}/ s/# *//" "${2}";
        thisReturnStatus="$?";
        if [ "${TheRunTest}" -eq 1 ]; then
            if is_string_in_file "${2}" "#${1}" ; then
                print_error "LOCALIZE_TEST_FUNCTION_FAILED" "($thisReturnStatus) -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        fi
    fi
    return "$thisReturnStatus";
}
# -------------------------------------
test_un_comment_file()
{
    ((TestCounter += 1));
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyTest.txt";
    local String2Comment="Defaults:USERNAME";
    # This files was Commented the test before this
    if is_string_in_file "${TargetFolder}${thisFileName}" "#${String2Comment}" ; then
        if ! comment_file "${String2Comment}" "${TargetFolder}${thisFileName}" ; then
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
        fi
    fi
    if un_comment_file "${String2Comment}" "${TargetFolder}${thisFileName}" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END un_comment_file
# -----------------------------------------------------------------------------
# BEGIN replace_option
# -------------------------------------
# HELPBUILDER replace_option
help_replace_option()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REPLACE_OPTION_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REPLACE_OPTION_DESC")";
    NOTES="$(localize "LOCALIZE_REPLACE_OPTION_NOTES")";
    # http://www.grymoire.com/Unix/Quote.html
    # http://www.grymoire.com/Unix/Sed.html
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER replace_option
localize_replace_option()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REPLACE_OPTION_USAGE" "replace_option 1->(/Config/FullPath/FileName.ext) 2->(Option-String) 3->(Text to Replace) 4->(Package Name)" "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REPLACE_OPTION_DESC"  "Replace Option: Given File Name, Option and Text, add option to end of line in file." "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REPLACE_OPTION_NOTES" "If you have a string in a file: i.e. '[Option]=', you can append Text to add to it: i.e. '[Option]=Text Added'" "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REPLACE_OPTION_SF"    "Warning: String Exist:" "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REPLACE_OPTION_ERROR" "Error: String not Found:" "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REPLACE_OPTION_FNF"   "File Not Found:" "Comment: replace_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
replace_option()
{
    # replace_option "/usr/share/config/kdm/test-options.conf" "AllowClose=" "true" "APPEND-FILE-"
    # sed '/AllowClose=/ c\AllowClose=true' /home/UserName/Downloads/arch-git/archwiz/Test/Target/Source/test-options.conf
    # AllowClose=false to AllowClose=true
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO"  "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -f "${1}" ]; then
        if is_string_in_file "${1}" "${2}" ; then
            if ! is_string_in_file "${1}" "${2}${3}" ; then
                #debugger 1
                sed -i 's/^'"${2}"'.*$/'"${2}""${3}"'/' "${1}";
                #echo "sed returned: $?"
                #debugger 0
                return "$?";
            else
                print_warning "LOCALIZE_REPLACE_OPTION_SF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                write_error "LOCALIZE_REPLACE_OPTION_SF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "LOCALIZE_REPLACE_OPTION_ERROR";
            write_error "LOCALIZE_REPLACE_OPTION_ERROR" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_REPLACE_OPTION_FNF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_REPLACE_OPTION_FNF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
    fi
}
# -------------------------------------
test_replace_option()
{
    ((TestCounter += 1));
    #local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyTestConfig.txt";
    # Done above: copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    if is_string_in_file "${TargetFolder}${thisFileName}" "AllowClose=true" ; then
        replace_option "${TargetFolder}${thisFileName}" "AllowClose=" "false" "REPLACE_OPTION_TEST";
    fi
    replace_option "${TargetFolder}${thisFileName}" "AllowClose=" "true" "REPLACE_OPTION_TEST"
    if is_string_in_file "${TargetFolder}${thisFileName}" "AllowClose=true" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END replace_option
# *************************************************************************** #
# BEGIN add_option
# -------------------------------------
# HELPBUILDER add_option
help_add_option()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ADD_OPTION_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ADD_OPTION_DESC")";
    NOTES="$(localize "LOCALIZE_ADD_OPTION_NOTES")";
    # http://www.grymoire.com/Unix/Quote.html
    # http://www.grymoire.com/Unix/Sed.html
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_option
localize_add_option()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_OPTION_USAGE" "$(sub_string "${FUNCNAME[0]}" "localize_" 2) 1->(/Config/FullPath/FileName.ext) 2->(Option-String) 3->(Text to Add) 4->(Package Name)" "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_OPTION_DESC"  "Add Option: Given File Name, Option and Text, add option to end of line in file." "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_OPTION_NOTES" "If you have a string in a file: i.e. '[Option]=', you can append Text to add to it: i.e. '[Option]=Text Added'" "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_OPTION_SF"    "Warning: String Exist:" "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_OPTION_ERROR" "Error: String not Found:" "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_OPTION_FNF"   "File Not Found:" "Comment: add_option @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# 1->(/Config/FullPath/FileName.ext)
# 2->(Option-String)
# 3->(Text to Add)
# 4->(Package Name)
add_option()
{
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO"  "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -f "${1}" ]; then
        if is_string_in_file "${1}" "${2}" ; then
            if ! is_string_in_file "${1}" "${3}" ; then
                # removing '"${2}"' : "${2}" fails
                # SC2016: Expressions do not expand in single quotes, use double quotes for that.
                # shellcheck disable=SC2016
                sed -i '/'"${2}"'/ s_$_'"${3}"'_' "${1}";
                return "$?";
            else
                print_warning "LOCALIZE_ADD_OPTION_SF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                write_error "LOCALIZE_ADD_OPTION_SF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "LOCALIZE_ADD_OPTION_ERROR" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_ADD_OPTION_ERROR" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_ADD_OPTION_FNF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        write_error "LOCALIZE_ADD_OPTION_FNF" "${1} - ${2} - ${3} - Package: ${4} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
    fi
}
# -------------------------------------
# add_option "/usr/share/config/kdm/kdmrc" "SessionsDirs=" ",/usr/share/xsessions" "APPEND-FILE-"
# SessionsDirs=/usr/share/config/kdm/sessions,/usr/share/apps/kdm/sessions
test_add_option()
{
    ((TestCounter += 1));
    local SourceFolder="${TheFullScriptPath}/Support/Test/Source/";
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="MyTestConfig.txt";
    copy_file "${SourceFolder}${thisFileName}" "${TargetFolder}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #          1                            2               3                       4
    add_option "${TargetFolder}${thisFileName}" "SessionsDirs=" ",/usr/share/xsessions" "LOCALIZE_ADD_OPTION_KDM";
    if is_string_in_file "${TargetFolder}${thisFileName}" ",/usr/share/xsessions" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    remove_file "${TargetFolder}${thisFileName}" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# add_option
# *************************************************************************** #
# BEGIN make_file
# -------------------------------------
# HELPBUILDER make_file
help_make_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_MAKE_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_MAKE_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_MAKE_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER make_file
localize_make_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_MAKE_FILE_USAGE"  "make_file 1->(FileName.ext) 2->(Debugging Information)" "Comment: make_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_FILE_DESC"  "Make file." "Comment: make_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_FILE_NOTES" "None." "Comment: make_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_FILE_PASSED" "Make File created" "Comment: make_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_MAKE_FILE_FAILED" "Failed to create File" "Comment: make_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
make_file()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ -n "${1}" ] && [ -n "${2}" ]; then # Check for Empty
        [[ ! -f "${1}" ]] && touch "${1}";
        if [ -f "${1}" ]; then
            write_log "LOCALIZE_MAKE_FILE_PASSED" ": ${1} # ${2} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 0;
        else
            write_error "LOCALIZE_MAKE_FILE_FAILED" ": ${1} # ${2} : -f : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
            return 1;
        fi
    else
        write_error "LOCALIZE_MAKE_FILE_FAILED" "${1} # ${2} : -n : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_error "LOCALIZE_MAKE_FILE_FAILED" "${1} # ${2} : -n : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "Empty: [${1}] at ${3} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_make_file()
{
    ((TestCounter += 1));
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    local thisFileName="me.txt";
    if make_file "${TargetFolder}${thisFileName}" ": @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END make_file
# *************************************************************************** #
# BEGIN save_array
# -------------------------------------
# HELPBUILDER save_array
help_save_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE__SAVE_ARRAY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE__SAVE_ARRAY_DESC")";
    NOTES="$(localize "LOCALIZE__SAVE_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER save_array
localize__save_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE__SAVE_ARRAY_USAGE" "save_array 1->(Array(@)) 2->(/Path) 3->(MenuName.ext)" "Comment: save_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE__SAVE_ARRAY_DESC"  "Save Array." "Comment: save_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE__SAVE_ARRAY_NOTES" "None." "Comment: save_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE__SAVE_ARRAY_ERROR" "Error Saving Array." "Comment: save_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
}
# -------------------------------------
save_array()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    make_dir "${2}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    touch "${2}/${3}";
    local -a array=("${!1}");
    local -i total="${#array[@]}";
    for (( i=0; i<total; i++ )); do
        if [ "${i}" == 0 ]; then
            echo "${array[$i]}"  > "${2}/${3}"; # Overwrite
        else
            echo "${array[$i]}" >> "${2}/${3}"; # Append
        fi
    done
    if [ ! -f "${2}/${3}" ]; then
        write_error "LOCALIZE__SAVE_ARRAY_ERROR" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_error "LOCALIZE__SAVE_ARRAY_ERROR" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "${TheDebugging}" -eq 1 ]; then pause_function "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
        return 1;
    fi
    return 0;
}
# -------------------------------------
test_save_array()
{
    ((TestCounter += 1));
    local MyArray=( "1" "2" "3");
    local TargetFolder="${TheFullScriptPath}/Support/Test/Target/";
    if save_array "MyArray[@]" "${TargetFolder}" "MyArray.db" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END save_array
# *************************************************************************** #
# BEGIN load_array
# -------------------------------------
# HELPBUILDER load_array
help_load_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_LOAD_ARRAY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_LOAD_ARRAY_DESC")";
    NOTES="$(localize "LOCALIZE_LOAD_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER load_array
localize_load_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_LOAD_ARRAY_USAGE" "Array=( &#36;(load_array 1->(/Path/) 2->(ArrayName.ext) 3->(ArraySize) 4->(Default Data) ) )" "Comment: load_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_LOAD_ARRAY_DESC"  "Load a saved Array from Disk." "Comment: load_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_LOAD_ARRAY_NOTES" "If you have problems with this Function, make sure IFS=\$'\n', it has to expand, its not a real Array, but a newline delimited string." "Comment: load_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# 1) TheMenuPath
# 2) MyMenuName
# 3) totalElments
# 4) Default Value for all of them
# load_array "${TheMenuPath}" "${MyMenuName}.db" ${totalElments} 0;
load_array()
{
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local TheMenuPath="${1}";  #
    local MyMenuName="${2}";   #
    local totalElments="${3}"; #
    local DefaultData="${4}";  #
    [[ -z ${TheMenuPath} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED" "${FUNCNAME[0]}(): TheMenuPath"; pause_function " "; return 1; }
    [[ -z ${MyMenuName} ]]   && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyMenuName"; pause_function " "; return 1; }
    [[ -z ${totalElments} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): totalElments"; pause_function " "; return 1; }
    [[ -z ${DefaultData} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): DefaultData"; pause_function " "; return 1; }

    local MyFolderFile="${TheMenuPath}/${MyMenuName}";
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n';
    if [ -f "${MyFolderFile}" ]; then
        while read -r line; do
            echo "$line"; # Stored Data
        done < "${MyFolderFile}" # Load Array from serialized disk file
    else
        for (( i=0; i<totalElments; i++ )); do
            echo "${DefaultData}"; # Default Data
        done
        #save_array "NewMenuChecks[@]" "${1}" "${2}";
    fi
    IFS="$ThisOldIFS";
}
# -------------------------------------
test_Load_Array()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n\t'; # Very Important when reading Arrays from files that end with a new line or tab
    local TestFolderName="${TheFullScriptPath}/Support/Test/Source/";
    local TestFileName="MyArray.db";
    #local -i TableCount=6;
    ##MyArray=( $(load_array "${TestFileName}" 0 0 ) );
    #load_array "${TestFolderName}" "${TestFileName}" ${TableCount} 0;
    #local -a MyArray=(${NewMenuChecks[@]}); # Copy Global to Local
    #local -i total="${#MyArray[@]}";
    #if [ "${total}" -eq "${TableCount}" ]; then
    #            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    #else
    #            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    #fi

    MyArray=( "$(load_array "${TestFolderName}${TestFileName}" 0 0 )" );
    totalnArr="${#MyArray[@]}";
    if [ "${totalnArr}" -eq 3 ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    IFS="$ThisOldIFS";
}
# END load_array
# *************************************************************************** #
# BEGIN create_data_array
# -------------------------------------
# HELPBUILDER create_data_array
help_create_data_array()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CREATE_DATA_ARRAY_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CREATE_DATA_ARRAY_DESC")";
    NOTES="$(localize "LOCALIZE_CREATE_DATA_ARRAY_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER create_data_array
localize_create_data_array()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CREATE_DATA_ARRAY_USAGE" "create_data_array 1->(ArraySize) 2->(Default Data)" "Comment: create_data_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATA_ARRAY_DESC"  "Create Data Array." "Comment: create_data_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATA_ARRAY_NOTES" "None." "Comment: create_data_array @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
create_data_array()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}  -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ "${1}" -eq 0 ]] && return 0;
    MyTotal="${1}";
    for (( i=0; i<MyTotal; i++ )); do
        echo "${2}"; # Default Data
    done
}
# -------------------------------------
test_create_data_array()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n\t'; # Very Important when reading Arrays from files that end with a new line or tab
    # shellcheck disable=SC2207
    local MyArray=( $(create_data_array 3 0 ) );
    #echo "${MyArray[@]}"
    IFS="$ThisOldIFS";
    local totalnArr="${#MyArray[@]}";
    #echo "${totalnArr}";
    if [ "${totalnArr}" -eq 3 ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END create_data_array
# *************************************************************************** #
# BEGIN restart_internet
# -------------------------------------
# HELPBUILDER restart_internet
help_restart_internet()
{
    ((HelpComplileCounter += 1));
    USAGE="restart_internet";
    DESCRIPTION="$(localize "LOCALIZE_RESTART_INTERNET_DESC")";
    NOTES="$(localize "LOCALIZE_RESTART_INTERNET_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER restart_internet
localize_restart_internet()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RESTART_INTERNET_DESC"  "Restart Internet." "Comment: restart_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RESTART_INTERNET_NOTES" "Assumes system.d; uses systemctl restart; needs generic functions for other then Arch Linux calls." "Comment: restart_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
restart_internet()
{
    # FIXME make OS dependent
    if [ "$My_OS" == "solaris" ]; then
            network restart;
    elif [ "$My_OS" == "aix" ]; then
            network restart;
    elif [ "$My_OS" == "freebsd" ]; then
            network restart;
    elif [ "$My_OS" == "windowsnt" ]; then
            network restart;
    elif [ "$My_OS" == "mac" ]; then
            network restart;
    elif [ "$My_OS" == "linux" ]; then
        # if there is a need to know which Distro; i.e. CentOS for Redhat, or Ubuntu for Debian, then use My_PSUEDONAME
        # See wizard.sh os_info to see if OS test exist or works
        if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
            /etc/init.d/network restart;
        elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
            if [ "${ThisNetworkManager}" == "networkmanager" ]; then
                sudo systemctl restart NetworkManager.service;
            elif [ "${ThisNetworkManager}" == "wicd" ]; then
                sudo systemctl restart wicd.service;
                wicd-client;
            fi
        elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
             if [ "$My_PSUEDONAME" == "Ubuntu" ]; then
                service networking restart;
             else
                /etc/init.d/networking restart;
             fi
        elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
                network restart;
        elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
               network restart;
        elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
                network restart;
        elif [ "${My_DIST}" == "slackware" ]; then # -------------------------------- My_PSUEDONAME = Slackware Linux Distros
                /etc/rc.d/rc.inet1 restart;
        fi
    fi
}
# END restart_internet
# *************************************************************************** #
# BEGIN fix_network
# -------------------------------------
# HELPBUILDER fix_network
help_fix_network()
{
    ((HelpComplileCounter += 1));
    USAGE="fix_network";
    DESCRIPTION="$(localize "LOCALIZE_FIX_NETWORK_DESC")";
    NOTES="$(localize "LOCALIZE_FIX_NETWORK_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER fix_network
localize_fix_network()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_FIX_NETWORK_DESC"  "Fix Network." "Comment: fix_network @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_FIX_NETWORK_NOTES" "None." "Comment: fix_network @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_FIX_NETWORK_NETWORKMANAGER" "Restarting networkmanager via systemctl..." "Comment: fix_network @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_FIX_NETWORK_WICD"           "Restarting wicd via systemctl..." "Comment: fix_network @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_FIX_NETWORK_TRIED-TO-FIX"   "Tried to fix network connection; you may have to run this script again." "Comment: fix_network @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
fix_network()
{
        # FIXME make OS dependent
    if [ "$My_OS" == "solaris" ]; then
            network restart;
    elif [ "$My_OS" == "aix" ]; then
            network restart;
    elif [ "$My_OS" == "freebsd" ]; then
            network restart;
    elif [ "$My_OS" == "windowsnt" ]; then
            network restart;
    elif [ "$My_OS" == "mac" ]; then
            network restart;
    elif [ "$My_OS" == "linux" ]; then
        # if there is a need to know which Distro; i.e. CentOS for Redhat, or Ubuntu for Debian, then use My_PSUEDONAME
        # See wizard.sh os_info to see if OS test exist or works
        if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
            /etc/init.d/network restart;
        elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
            if [ "${ThisNetworkManager}" == "networkmanager" ]; then
                # networkmanager
                # Internet is down; no use trying to install software
                #if ! check_package networkmanager ; then
                #    if [ "$KDE_INSTALLED" -eq 1 ]; then
                #        package_install "networkmanager kdeplasma-applets-networkmanagement" "INSTALL-NETWORKMANAGER-KDE"
                #        if [ "$MATE_INSTALLED" -eq 1 ]; then
                #            package_install "network-manager-applet" "INSTALL-NETWORKMANAGER-MATE"
                #        fi
                #    else
                #        package_install "networkmanager network-manager-applet" "INSTALL-NETWORKMANAGER-OTHER"
                #    fi
                #    package_install "networkmanager-dispatcher-ntpd" "INSTALL-NETWORKMANAGER"
                #fi
                #add_group "networkmanager"
                #add_user_2_group "networkmanager"
                print_info "LOCALIZE_FIX_NETWORK_NETWORKMANAGER";
                sudo systemctl enable NetworkManager.service;
                sudo systemctl start NetworkManager.service;
            elif [ "${ThisNetworkManager}" == "wicd" ]; then
                #if ! check_package networkmanager ; then
                #    if [ "$KDE" -eq 1 ]; then
                #        do "that" "THIS"
                #    else
                #        package_install "wicd wicd-gtk" "INSTALL-NETWORKMANAGER-GTK"
                #    fi
                #fi
                print_info "LOCALIZE_FIX_NETWORK_WICD";
                sudo systemctl enable wicd.service;
                sudo systemctl start wicd.service;
                wicd-client;
            fi
        elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
             if [ "$My_PSUEDONAME" == "Ubuntu" ]; then
                service networking restart;
             else
                /etc/init.d/networking restart;
             fi
        elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
                network restart;
        elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
               network restart;
        elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
                network restart;
        elif [ "${My_DIST}" == "slackware" ]; then # -------------------------------- My_PSUEDONAME = Slackware Linux Distros
                /etc/rc.d/rc.inet1 restart;
        fi
    fi
    # @FIX More testing and repairing
    sleep 20;
    if [ "${INSTALL_NO_INTERNET}" -eq 0 ]; then
        if ! is_internet ; then
            sleep 10;
            if ! is_internet ; then
                print_error "LOCALIZE_FIX_NETWORK_TRIED-TO-FIX"; # if you see this; 20 seconds was not long enough, add another 10 for a full half minute
                return 1;
            fi
        fi
    fi
    return 0;
}
# END fix_network
# *************************************************************************** #
# BEGIN network_troubleshooting
# -------------------------------------
# HELPBUILDER network_troubleshooting
help_network_troubleshooting()
{
    ((HelpComplileCounter += 1));
    USAGE="network_troubleshooting";
    DESCRIPTION="$(localize "LOCALIZE_NETWORK_TROUBLESHOOTING_DESC")";
    NOTES="$(localize "LOCALIZE_NETWORK_TROUBLESHOOTING_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER network_troubleshooting
localize_network_troubleshooting()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_DESC"    "Network Troubleshooting." "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_NOTES"   "None." "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_TITLE"   "Network Troubleshooting" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_0"  "Network Debugging" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_1"  "1: Networkmanager: install and start, this is always the best way to start troubleshooting." "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_2"  "2: Disk Resolv: Edit/Review namerservers.txt on disk, then copy it to local disk." "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_3"  "3: Local Resolv:Edit/Review local /etc/resolv.conf" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_4"  "4: Identify which network interfaces" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_5"  "5: Link status: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_6"  "6: IP Address: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_7"  "7: Ping: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_8"  "8: Devices: Show all ethx that are active" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_9"  "9: Show Users: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_10" "10: Static IP: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_11" "11: Gateway: " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_12" "12: Quit" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_13" "Identify" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_14" "Link status" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_15" "Network Debugging" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_1"    "Enter IP address (192.168.1.2) " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_2"    "Enter IP Mask (255.255.255.0 = 24) " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_3"    "Enter IP address for Gateway (192.168.1.1) " "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_SELECT"  "Select an Option:" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_NETWORK_TROUBLESHOOTING_NIC"     "Select a NIC:" "Comment: network_troubleshooting @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
network_troubleshooting()
{
    get_network_devices;
    load_software;
    while true; do
        print_title "LOCALIZE_NETWORK_TROUBLESHOOTING_TITLE" " ";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_0";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_1";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_2";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_3";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_4";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_5";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_6";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_7";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_8";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_9";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_10";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_11";
        echo "";
        print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_12";
        #                   1              2              3             4          5         6         7          8         9         10           11        12
        NETWORK_TROUBLE=("Networkmanager" "Disk Resolv" "Local Resolv" "Identify" "Link" "IP address" "Ping"  "Devices" "Show Users" "Static IP" "Gateway" "Quit");
        PS3="$prompt1";
        print_this "LOCALIZE_NETWORK_TROUBLESHOOTING_SELECT";
        echo "";
        select OPT in "${NETWORK_TROUBLE[@]}"; do
            case "${REPLY}" in
                1)  # Networkmanager
                    fix_network;
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                2)  # Disk Resolv
                    custom_nameservers;
                    if [ "$My_OS" == "solaris" ]; then
                            cat /etc/resolv.conf ;
                    elif [ "$My_OS" == "aix" ]; then
                            cat /etc/resolv.conf ;
                    elif [ "$My_OS" == "freebsd" ]; then
                            cat /etc/resolv.conf ;
                    elif [ "$My_OS" == "windowsnt" ]; then
                            cat /etc/resolv.conf ;
                    elif [ "$My_OS" == "mac" ]; then
                            cat /etc/resolv.conf ;
                    elif [ "$My_OS" == "linux" ]; then
                        # if there is a need to know which Distro; i.e. CentOS for Redhat, or Ubuntu for Debian, then use My_PSUEDONAME
                        # See wizard.sh os_info to see if OS test exist or works
                        if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
                            cat /etc/resolv.conf ;
                        elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
                            cat /etc/resolv.conf ;
                        elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
                            cat /etc/resolv.conf ;
                        elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
                            cat /etc/resolv.conf ;
                        elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
                            cat /etc/resolv.conf ;
                        elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
                            cat /etc/resolv.conf ;
                        fi
                    fi
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                3)  # Local Resolv
                    if [ "$My_OS" == "solaris" ]; then
                            $EDITOR /etc/resolv.conf;
                    elif [ "$My_OS" == "aix" ]; then
                            $EDITOR /etc/resolv.conf;
                    elif [ "$My_OS" == "freebsd" ]; then
                            $EDITOR /etc/resolv.conf;
                    elif [ "$My_OS" == "windowsnt" ]; then
                            $EDITOR /etc/resolv.conf;
                    elif [ "$My_OS" == "mac" ]; then
                            $EDITOR /etc/resolv.conf;
                    elif [ "$My_OS" == "linux" ]; then
                        # if there is a need to know which Distro; i.e. CentOS for Redhat, or Ubuntu for Debian, then use My_PSUEDONAME
                        # See wizard.sh os_info to see if OS test exist or works
                        if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
                            $EDITOR /etc/resolv.conf;
                        elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
                            $EDITOR /etc/resolv.conf;
                        elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
                            $EDITOR /etc/resolv.conf;
                        elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
                            $EDITOR /etc/resolv.conf;
                        elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
                            $EDITOR /etc/resolv.conf;
                        elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
                            $EDITOR /etc/resolv.conf;
                        fi
                    fi
                    break;
                    ;;
                4)  # Identify
                    print_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_15" ": ip a ";
                    ip a;
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                5)  # Link
                    print_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_16" ": ip link show dev eth0";
                    for MyNIC in "${NIC[@]}"; do
                        ip link show dev "$MyNIC";
                    done
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                6)  # IP address
                    print_info "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_16" ": ip addr show dev eth0";
                    for MyNIC in "${NIC[@]}"; do
                        ip addr show dev "$MyNIC";
                    done
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                7)  # Ping
                    ping -c 3 "$PingHost1";
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                8)  # Devices
                    get_network_devices;
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
                9)  # Show Users
                    show_users;
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
               10)  # Add Static IP address
                    print_title "LOCALIZE_NETWORK_TROUBLESHOOTING_TITLE" " ";
                    print_info  "LOCALIZE_NETWORK_TROUBLESHOOTING_INFO_17";
                    # Add Static IP address
                    PS3="$prompt1";
                    print_this "LOCALIZE_NETWORK_TROUBLESHOOTING_NIC";
                    echo "";
                    select OPT in "${NIC[@]}"; do
                        case "${REPLY}" in
                            1)
                                # SC2128: Expanding an array without an index only gives the first element.
                                # shellcheck disable=SC2128
                                NIC_DEV="${NIC[0]}";
                                break;
                                ;;
                            2)
                                # SC2128: Expanding an array without an index only gives the first element.
                                # shellcheck disable=SC2128
                                NIC_DEV="${NIC[0]}";
                                break;
                                ;;
                            3)
                                # SC2128: Expanding an array without an index only gives the first element.
                                # shellcheck disable=SC2128
                                NIC_DEV="${NIC[0]}";
                                break;
                                ;;
                            *)
                                invalid_option "${REPLY}";
                                ;;
                        esac
                    done
                    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
                    read_input_data "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_1"; # Enter IP Address
                    IP_ADDRESS="${OPTION}";
                    read_input_data "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_2";
                    BYPASS="$ThisOldByPass"; # Restore Bypass
                    IP_MASK="${OPTION}";
                    ip addr add "${IP_ADDRESS}/${IP_MASK}" dev "$NIC_DEV";
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;

               11)  # Add Static Gateway
                    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
                    read_input_data "LOCALIZE_NETWORK_TROUBLESHOOTING_RD_3";
                    BYPASS="$ThisOldByPass"; # Restore Bypass
                    IP_ADDRESS="${OPTION}";
                    ip route add default via "$IP_ADDRESS";
                    pause_function "network_troubleshooting ${LINENO[0]}";
                    break;
                    ;;
               12)  # Quit
                    exit 1;
                    ;;
              "q")
                    break;
                    ;;
                *)
                    invalid_option "${REPLY}";
                    ;;
            esac
       done
       if isBreakable "${REPLY}" "q"; then break; fi
   done
}
# END network_troubleshooting
# *************************************************************************** #
# BEGIN
# -------------------------------------
# HELPBUILDER is_internet
help_is_internet()
{
    ((HelpComplileCounter += 1));
    USAGE="is_internet";
    DESCRIPTION="$(localize "LOCALIZE_IS_INTERNET_DESC")";
    NOTES="$(localize "LOCALIZE_IS_INTERNET_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_internet
localize_is_internet()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_INTERNET_DESC"  "Check if Internet is up by Pinging two Major DNS servers." "Comment: is_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_INTERNET_NOTES" "This pings google.com and wikipedia.org; they are good to ping to see if the Internet is up." "Comment: is_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_IS_INTERNET_INFO" "Checking for Internet Connection..." "Comment: is_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_internet()
{
    print_this "LOCALIZE_IS_INTERNET_INFO" "$PingHost1 or $PingHost2";
    if ! ping -w5 -c3 "$PingHost1" > /dev/null 2>&1; then
        if ! ping -w5 -c3 "$PingHost2" > /dev/null 2>&1; then
            return 1;
        fi
    fi
    return 0;
}
# -------------------------------------
test_is_internet()
{
    ((TestCounter += 1));
    if is_internet ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        fix_network;
        if is_internet ; then
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        fi
    fi
}
# END is_internet
# *************************************************************************** #
# BEGIN is_online
# -------------------------------------
# HELPBUILDER is_online
help_is_online()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_ONLINE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_ONLINE_DESC")";
    NOTES="$(localize "LOCALIZE_IS_ONLINE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_online
localize_is_online()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_ONLINE_USAGE" "is_online 1->(url)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_ONLINE_DESC"  "Check if URL can be Pinged through the Internet." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_ONLINE_NOTES" "This pings URL passed in." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_IS_ONLINE_INFO" "Checking URL for Internet Connection..." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_online()
{
    print_this "LOCALIZE_IS_ONLINE_INFO" "${1}";
    if ! ping -w5 -c3 "${1}" > /dev/null 2>&1; then
        sleep 3;
        if ! ping -w5 -c3 "${1}" > /dev/null 2>&1; then return 1; fi
    fi
    return 0;
}
# -------------------------------------
test_is_online()
{
    ((TestCounter += 1));
    if is_online "$PingHost1" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_online
# *************************************************************************** #
# BEGIN get_ip_from_url
# -------------------------------------
# HELPBUILDER get_ip_from_url
help_get_ip_from_url()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_GET_IP_FROM_URL_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_GET_IP_FROM_URL_DESC")";
    NOTES="$(localize "LOCALIZE_GET_IP_FROM_URL_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_ip_from_url
localize_get_ip_from_url()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_IP_FROM_URL_USAGE" "get_ip_from_url 1->(url)" "Comment: get_ip_from_url @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_IP_FROM_URL_DESC"  "Get IP Address from URL." "Comment: get_ip_from_url @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_IP_FROM_URL_NOTES" "Uses Host." "Comment: get_ip_from_url @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_ip_from_url()
{
    if ! is_installed "host" "dnsutils" 1 0; then
        print_error "install dnsutils" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        return 0;
        # FIXME install_this
    fi
    host "${1}" | awk '/^[[:alnum:].-]+ has address/ {print $4 ; exit }';
}
# -------------------------------------
test_get_ip_from_url()
{
    ((TestCounter += 1));
    if [ "${TestSshURL}" == "default" ]; then return; fi
    #
    if [[ "$(get_ip_from_url "${TestSshURL}")" == "${TestSshIP}" ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END get_ip_from_url
# *************************************************************************** #
# BEGIN run_db_sql_file_ssh
# -------------------------------------
# HELPBUILDER run_db_sql_file_ssh
help_run_db_sql_file_ssh()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_RUN_DB_SQL_FILE_SSH_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_RUN_DB_SQL_FILE_SSH_DESC")";
    NOTES="$(localize "LOCALIZE_RUN_DB_SQL_FILE_SSH_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="17 Jun 2013";
    REVISION="17 Jun 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER run_db_sql_file_ssh
localize_run_db_sql_file_ssh()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RUN_DB_SQL_FILE_SSH_USAGE" "run_db_sql_file_ssh 1->(IP or URL Address) 2->(User Name) 3->(/Full-Path/File-Name.sql or SQL Statement) 4->(DB User Name) 5->(DB Password) 6->(0=SQL File,1=SQL Statement) 7->(Database Type: 0=None,1=SQlite,2=PostgreSql,3=MySql)" "Comment: run_db_sql_file_ssh @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RUN_DB_SQL_FILE_SSH_DESC"  "Run Dabase Command." "Comment: run_db_sql_file_ssh @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RUN_DB_SQL_FILE_SSH_NOTES" "None." "Comment: run_db_sql_file_ssh @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
run_db_sql_file_ssh()
{
    if [ "${6}" -eq 0 ]; then     # SQL File
        if [ "${7}" -eq 3 ]; then # 0=None,1=SQlite,2=PostgreSql,3=MySql
            # Root Folder for User
            if scp "${3}" "${2}@${1}:"; then
                # SC2029: Note that, unescaped, this expands on the client side.
                # shellcheck disable=SC2029
                ssh "${2}@${1}" "mysql -u${4} -p${5} < ${3}";
            fi
        fi
    else                          # SQL Statement
        if [ "${7}" -eq 3 ]; then # 0=None,1=SQlite,2=PostgreSql,3=MySql
            # SC2029: Note that, unescaped, this expands on the client side.
            # shellcheck disable=SC2029
            ssh "${2}@${1}" "mysql -u${4} -p${5} -e \"${3}\"";
        fi
    fi
}
# END run_db_sql_file_ssh
# *************************************************************************** #
# BEGIN array_push
# -------------------------------------
# HELPBUILDER array_push
help_array_push()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ARRAY_PUSH_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ARRAY_PUSH_DESC")";
    NOTES="$(localize "LOCALIZE_ARRAY_PUSH_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER array_push
localize_array_push()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ARRAY_PUSH_USAGE" "array_push 1->(array) 2->(Element)" "Comment: array_push @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ARRAY_PUSH_DESC"  "Push Element into an Array." "Comment: array_push @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ARRAY_PUSH_NOTES" "None." "Comment: array_push @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
array_push()
{
    eval "shift; $1+=(\"\$@\")";
}
# -------------------------------------
test_array_push()
{
    ((TestCounter += 1));
    local -a MyArray=( "1" "2" );
    array_push "MyArray" "3";
    local -i totalnArr="${#MyArray[@]}";
    if [ "${totalnArr}" -eq 3 ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END array_push
# *************************************************************************** #
# BEGIN get_index
# -------------------------------------
# HELPBUILDER get_index
help_get_index()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_GET_INDEX_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_GET_INDEX_DESC")";
    NOTES="$(localize "LOCALIZE_GET_INDEX_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_index
localize_get_index()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_INDEX_USAGE" "get_index 1->(array[@]) 2->(Search)" "Comment: get_index @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_INDEX_DESC"  "Get Index into an Array." "Comment: get_index @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_INDEX_NOTES" "Bombs if not found; but finds errors in data; you could ask for data; but if its not in Array; this is a bug in Data not logic." "Comment: get_index @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_index()
{
    if [ $# -ne 2 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local -a i_array=("${!1}");
    local -i index=0;
    # Do not "${!i_array[@]}" it will not expand
    # shellcheck disable=SC2068
    for index in ${!i_array[@]}; do
        if [ "${i_array[${index}]}" == "${2}" ]; then
            echo -n "${index}";
            return 0;
        fi
    done
    write_error "FAILED:only use this if you know the record exist in get_index [${1}] [${2}]; check  " "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    pause_function "FAILED:only use this if you know the record exist in get_index [${1}] [${2}] at line ${LINENO[0]}";
    exit 1;
}
# -------------------------------------
test_get_index()
{
    ((TestCounter += 1));
    local -a MyArray; MyArray=( "1" "2" "3" );
    if [[ $(get_index "MyArray[@]" "2") -eq 1 ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END get_index
# *************************************************************************** #
# BEGIN remove_array_duplicates
declare -a RemovedIndexes; RemovedIndexes=();
# -------------------------------------
# HELPBUILDER remove_array_duplicates
help_remove_array_duplicates()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_ARRAY_DUPLICATES_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_ARRAY_DUPLICATES_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_ARRAY_DUPLICATES_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_array_duplicates
localize_remove_array_duplicates()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_ARRAY_DUPLICATES_USAGE" "MyArray=( \$( remove_array_duplicates '1->(Array[@])' ) )" "Comment: remove_array_duplicates @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_ARRAY_DUPLICATES_DESC"  "Removes Duplicates in Array." "Comment: remove_array_duplicates @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_ARRAY_DUPLICATES_NOTES" "set IFS=\$'\n\t'; before call" "Comment: remove_array_duplicates @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_array_duplicates()
{
    # Test Code
    # MY_ARR=("MY" "MY" "2" "2" "LIST" "LIST" "OK")
    # local -i total=${#MY_ARR[@]}
    # echo ${MY_ARR[@]} # Prints: MY MY 2 2 LIST LIST OK
    # MY_ARR=( $(remove_array_duplicates MY_ARR[@]) )
    # echo ${MY_ARR[@]} # Prints: MY 2 LIST OK    declare -a array=("${!1}")
    # for (( index=0; index<total; index++ )); do echo "ARRAY= ${MY_ARR[${index}]}"; done # to echo with new line
    local -a array=("${!1}");
    local -i total="${#array[@]}";
    local -a sarray=( "" );
    local -i i=0;
    local -i j=0;
    local -i y=0;
    for (( i=0; i<total; i++ )); do
        (( j = i + 1 ));
        while (( j < total )); do
            if [ "${array[$i]}" == "${array[$j]}" ]; then
                break;
            fi
            (( j = j + 1 ));
        done
        if [ "$j" == "${total}" ]; then
            sarray[$y]="${array[$i]}";
            (( y = y + 1 ));
        else
            RemovedIndexes[${#RemovedIndexes[@]}]="$i";
        fi
    done
    # Must echo to fill array
    # Do not "${sarray[*]}"; it will not expand
    for element in ${sarray[*]}; do
        echo -e "${element}";
    done
}
# -------------------------------------
test_remove_array_duplicates()
{
    ((TestCounter += 1));
    local ThisOldIFS; ThisOldIFS="$IFS"; IFS=$'\n\t'; # Very Important when reading Arrays from files that end with a new line or tab
    local -a MyArray=( "1" "2" "3" "4" "4" "5" "6-8" "6-8" );
    # shellcheck disable=SC2207
    local -a MyArray=( $( remove_array_duplicates "MyArray[@]") );
    IFS="$ThisOldIFS";
    local -i totalnArr="${#MyArray[@]}";
    if [ "${totalnArr}" -eq 6 ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END remove_array_duplicates
# *************************************************************************** #
# BEGIN is_last_item
# -------------------------------------
# HELPBUILDER is_last_item
help_is_last_item()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_LAST_ITEM_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_LAST_ITEM_DESC")";
    NOTES="$(localize "LOCALIZE_IS_LAST_ITEM_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_last_item
localize_is_last_item()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_LAST_ITEM_USAGE" "is_last_item 1->(array[@]) 2->(search)" "Comment: is_last_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_LAST_ITEM_DESC"  "is last item in array." "Comment: is_last_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_LAST_ITEM_NOTES" "None." "Comment: is_last_item @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_last_item()
{
    local -a i_array=("${!1}");
    local -i total="${#i_array[@]}";
    local -i index=0;
    local -i ci;
    for (( index=0; index<total; index++ )); do
        if [ "${i_array[${index}]}" == "${2}" ]; then
            ci=(index+1); # FIXME
            # SC2128: Expanding an array without an index only gives the first element.
            # shellcheck disable=SC2128
            if [ "${ci}" -eq "${#i_array[@]}" ]; then
                return 0; # True
            else
                return 1; # False
            fi
        fi
    done
    return 1;
}
# -------------------------------------
test_is_last_item()
{
    ((TestCounter += 1));
    local -a MyArray=( "1" "2" "3" "4" "5" "6" );
    if is_last_item "MyArray[@]" "6" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_last_item
# *************************************************************************** #
# BEGIN date2stamp
# -------------------------------------
# HELPBUILDER date2stamp
help_date2stamp()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_DATE2STAMP_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_DATE2STAMP_DESC")";
    NOTES="$(localize "LOCALIZE_DATE2STAMP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER date2stamp
localize_date2stamp()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DATE2STAMP_USAGE" "date2stamp 1->(date)" "Comment: date2stamp @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DATE2STAMP_DESC"  "Convert Date to Datetime stamp." "Comment: date2stamp @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DATE2STAMP_NOTES" "None." "Comment: date2stamp @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# Date
date2stamp()
{
    if [ $# -ne 1 ] ; then print_error "1->(date)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --utc --date "${1}" +%s;
}
# END date2stamp
# *************************************************************************** #
# 2021-03-22 year-month-day
# Date
is_valid_date()
{
    if [ $# -ne 1 ] ; then print_error "1->(date)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    #
    # Determine whether the given START_DATETIME is valid.
    if [[ "$My_OS" == "mac" ]]; then
        # Validate the date on a Mac (OSX), this is done by adding and subtracting one minute from the given date/time.
        # If the resulting date/time string is identical to the given date/time string, then the given date/time is valid.
        # If not, then the given date/time is invalid.
        TEST_DATETIME=$(date -v+1M -v-1M -jf "%F %T" "$1" +"%F %T" 2> /dev/null);
        if [[ "$TEST_DATETIME" != "$1" ]]; then return 1; fi
    else
        # Validate the date on a Linux machine (Redhat or Debian).  On Linux, this is
        # as easy as adding one minute and checking the return code.  If one minute
        # cannot be added, then the starting value is not a valid date/time.
        date -d "$1 UTC + 1 min" +"%F %T" &> /dev/null;
        test $? -eq 0 || return 1;
        #if [[ $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then if date -d "$1" >/dev/null; then return 0; else return 1; fi else return 1; fi
    fi
}
# -------------------------------------
test_is_valid_date()
{
    ((TestCounter += 1));
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md";
    local thisFileDate; thisFileDate="$(get_File_Created_Date "$ThisTestFile")";
    # thisFileDate=2021-03-22
    if is_valid_date "$thisFileDate" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
export -f is_valid_date;
# END is_valid_date
# *************************************************************************** #
date_add_days()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "+${2} days";
}
export -f date_add_days;
# END date_add_days
# *************************************************************************** #
date_add_days()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "+${2} days";
}
export -f date_add_days;
# END date_add_days
# *************************************************************************** #
date_add_hours()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "+${2} hour ago";
}
export -f date_add_hours;
# END date_add_hours
# *************************************************************************** #
date_add_minutes()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "+${2} minutes";
}
export -f date_add_minutes;
# END date_add_minutes
# *************************************************************************** #
date_add_seconds()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "+${2} seconds";
}
export -f date_add_seconds;
# END date_add_seconds
# *************************************************************************** #
date_subtract_days()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of days)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "-${2} days";
}
export -f date_subtract_days;
# END date_subtract_days
# *************************************************************************** #
date_subtract_hours()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of hour)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "-${2} hour ago";
}
export -f date_subtract_hours;
# END date_subtract_hours
# *************************************************************************** #
date_subtract_minutes()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of minutes)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "-${2} minutes";
}
export -f date_subtract_minutes;
# END date_subtract_minutes
# *************************************************************************** #
date_subtract_seconds()
{
    if [ $# -ne 2 ] ; then print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "1->(date) 2->(number of seconds)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    date --date "${1}" "-${2} seconds";
}
export -f date_subtract_seconds;
# END date_subtract_seconds
###############################################################################
declare -x TheFileCreatedDate;
declare -x TheFileModifiedDate;
# set_File_Dates "Full-Path-File-Name.Ext"
set_File_Dates()
{
    if [ $# -ne 1 ] ; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    if [ ! -f "$1" ]; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    # Set Global to ""
    TheFileCreatedDate=""; TheFileModifiedDate="";
    # this returns yyyy-mm-dd or ""
    TheFileModifiedDate="$(get_File_Modified_Date "$1")";
    #
    if ! is_valid_date "$TheFileModifiedDate"; then return 1; fi
    # get the date when the file was created and get the date when the file was last modified
    TheFileCreatedDate="$(stat -c '%w' "$1")";
    if [ "$TheFileCreatedDate" == "-" ]; then
        ## Subtract 13 seconds to the $TheFileModifiedDate to make it smaller than the $TheFileCreatedDate
        TheFileCreatedDate="$(date_subtract_seconds "$TheFileModifiedDate" 13)";
    fi
    if [ "$TheFileCreatedDate" == "" ]; then return 1; fi
    return 0;
}
# -------------------------------------
test_set_File_Dates()
{
    ((TestCounter += 1));
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md";
    #
    if set_File_Dates "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
export -f set_File_Dates;
# END set_File_Dates
###############################################################################
# get_File_Created_Date "Full-Path-File-Name.Ext"
# birth defaults to - and must be explicitly set
get_File_Created_Date()
{
    if [ $# -ne 1 ] ; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    if [ ! -f "$1" ]; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    # this returns yyyy-mm-dd or ""
    local thisFileModifiedDate; thisFileModifiedDate="$(get_File_Modified_Date "$1")";
    # get the date when the file was created and get the date when the file was last modified
    local thisFileCreatedDate; thisFileCreatedDate="$(stat -c '%w' "$1")";
    if [ "$thisFileCreatedDate" == "-" ]; then thisFileCreatedDate="$thisFileModifiedDate"; fi
    echo "$thisFileCreatedDate";
}
export -f get_File_Created_Date;
# END get_File_Created_Date
###############################################################################
# get_File_Modified_Date "File-Full-Path"
# this returns yyyy-mm-dd or ""
get_File_Modified_Date()
{
    if [ $# -ne 1 ] ; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; }
    if [ ! -f "$1" ]; then print_error "1->(Full-Path-File-Name.Ext)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    # stat -c %y /mnt/qnap-light-wizzard/Light-Wizzard-in-the-Flesh-Production/Scripts/Support/Test/Source/README.md
    # echo "2021-03-22 10:37:28.299198758 -0700" | cut -d' ' -f1
    local thisDate; thisDate="$(stat -c %y "$1" | cut -d' ' -f1)";
    if is_valid_date "$thisDate"; then return 0; else return 1; fi
}
export -f get_File_Modified_Date;
# END get_File_Modified_Date
# *************************************************************************** #
# BEGIN clear_logs
# -------------------------------------
# HELPBUILDER clear_logs
help_clear_logs()
{
    ((HelpComplileCounter += 1));
    USAGE="clear_logs";
    DESCRIPTION="$(localize "LOCALIZE_CLEAR_LOGS_DESC")";
    NOTES="$(localize "LOCALIZE_CLEAR_LOGS_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER clear_logs
localize_clear_logs()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CLEAR_LOGS_DESC"    "Clear all Log Entries." "Comment: clear_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAR_LOGS_NOTES"   "None." "Comment: clear_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAR_LOGS_CLEAR-1" "Clearing Log Files" "Comment: clear_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CLEAR_LOGS_CLEAR-2" "Created Log Folders" "Comment: clear_logs @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
clear_logs()
{
    print_this "LOCALIZE_CLEAR_LOGS_CLEAR-1" "..."
    make_dir "${TheLogPath}"    "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    make_dir "${TheMenuPath}"   "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    make_dir "${TheConfigPath}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    print_this "LOCALIZE_CLEAR_LOGS_CLEAR-2" "...";
    copy_file "${TheErrorLog}"    "${TheFullScriptPath}/Archive/${TheLogDateTime}.log" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    copy_file "${TheActivityLog}" "${TheFullScriptPath}/Archive/${TheLogDateTime}.log" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    echo "# Error Log: ${TheWizardScriptName} Version: ${TheScriptVersion} on ${TheDateTime}." > "${TheErrorLog}";
    echo "# Log: ${TheWizardScriptName} Version: ${TheScriptVersion} on ${TheDateTime}."       > "${TheActivityLog}";
}
# END clear_logs
# *************************************************************************** #
# BEGIN
# -------------------------------------
# HELPBUILDER is_user
help_is_user()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_USER_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_USER_DESC")";
    NOTES="$(localize "LOCALIZE_IS_USER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_user
localize_is_user()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_USER_USAGE"  "is_user 1->(USERNAME)" "Comment: is_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_USER_DESC"  "Checks if USERNAME exist." "Comment: is_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_USER_NOTES" "None." "Comment: is_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_user()
{
    #egrep -i "^${1}" /etc/passwd > /dev/null 2>&1;
    grep -E ^"${1}" "/etc/passwd" > /dev/null 2>&1;
    return "${?}";
}
# -------------------------------------
test_is_user()
{
    ((TestCounter += 1));
    if is_user "$(whoami)"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_user
# *************************************************************************** #
# BEGIN add_user_group
# -------------------------------------
# HELPBUILDER add_user_group
help_add_user_group()
{
    ((HelpComplileCounter += 1));
    USAGE="add_user_group 1->(Group Name)";
    DESCRIPTION="$(localize "LOCALIZE_ADD_USER_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_ADD_USER_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_user_group
localize_add_user_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_USER_GROUP_DESC"  "Add User group." "Comment: add_user_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_USER_GROUP_NOTES" "None." "Comment: add_user_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
add_user_group()
{
    USER_GROUPS[${#USER_GROUPS[*]}]="${1}";
    local ThisOldIFS="$IFS"; IFS=$'\n\t';
    USER_GROUPS=( "$( remove_array_duplicates "USER_GROUPS[@]")" );
    IFS=$"$ThisOldIFS";
}
# -------------------------------------
test_add_user_group()
{
    ((TestCounter += 1));
    add_user_group "TestMyAccount";
    if is_in_array "USER_GROUPS" "TestMyAccount" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END add_user_group
# *************************************************************************** #
# BEGIN remove_user_group
# -------------------------------------
# HELPBUILDER remove_user_group
help_remove_user_group()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_REMOVE_USER_GROUP_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_REMOVE_USER_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_REMOVE_USER_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER remove_user_group
localize_remove_user_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_REMOVE_USER_GROUP_USAGE" "remove_user_group 1->(Group Name)" "Comment: remove_user_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_USER_GROUP_DESC"  "Remove User group." "Comment: remove_user_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_REMOVE_USER_GROUP_NOTES" "None." "Comment: remove_user_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
remove_user_group()
{
    if is_in_array "USER_GROUPS" "${1}" 0; then
        remove_from_array "USER_GROUPS" "${1}";
    fi
}
# -------------------------------------
test_remove_user_group()
{
    ((TestCounter += 1));
    add_user_group "TestMyAccount2";
    remove_user_group "TestMyAccount2";
    if ! is_in_array "USER_GROUPS" "TestMyAccount2" 0; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END remove_user_group
# *************************************************************************** #
# BEGIN is_user_in_group
# -------------------------------------
# HELPBUILDER is_user_in_group
help_is_user_in_group()
{
    ((HelpComplileCounter += 1));
    USAGE="is_user_in_group 1->(GroupName)";
    DESCRIPTION="$(localize "LOCALIZE_IS_USER_IN_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_IS_USER_IN_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_user_in_group
localize_is_user_in_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_USER_IN_GROUP_DESC"  "is user in group." "Comment: is_user_in_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_USER_IN_GROUP_NOTES" "None." "Comment: is_user_in_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_user_in_group()
{
    groups "${SystemUserName}" | grep "${1}" > /dev/null 2>&1;
    return "$?";
}
# -------------------------------------
test_is_user_in_group()
{
    ((TestCounter += 1));
    if is_user_in_group "$(whoami)" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_user_in_group
# *************************************************************************** #
# BEGIN is_group
# -------------------------------------
# HELPBUILDER is_group
help_is_group()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_GROUP_USAGE")"
    DESCRIPTION="$(localize "LOCALIZE_IS_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_IS_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_group
localize_is_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_GROUP_USAGE"  "is_group 1->(GROUPNAME)" "Comment: is_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_GROUP_DESC"  "Is Group." "Comment: is_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_GROUP_NOTES" "None." "Comment: is_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_group()
{
    #egrep -i "^${1}" /etc/group > /dev/null 2>&1;
    grep -E "^${1}" /etc/group > /dev/null 2>&1;
    return "$?";
}
# -------------------------------------
test_is_group()
{
    ((TestCounter += 1));
    if is_group "users" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END is_group
# *************************************************************************** #
# BEGIN add_group
# -------------------------------------
# HELPBUILDER add_group
help_add_group()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ADD_GROUP_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ADD_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_ADD_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_group
localize_add_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_GROUP_USAGE" "add_group 1->(GroupName)" "Comment: add_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_GROUP_DESC"  "Add Group."               "Comment: add_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_GROUP_NOTES" "None."                    "Comment: add_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_GROUP_OK"    "Added Group"              "Comment: add_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_GROUP_FAIL"  "Failed to add Group"      "Comment: add_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
add_group()
{
    if ! is_group "${1}" ; then
        if sudo groupadd "${1}" ; then
            write_log "LOCALIZE_ADD_GROUP_OK" ": ${1} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 0;
        else
            print_error "LOCALIZE_ADD_GROUP_FAIL" ": ${1} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            write_error "LOCALIZE_ADD_GROUP_FAIL" ": ${1} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 1;
        fi
    fi
    return 0;
}
# -------------------------------------
# Requires login
test_add_group()
{
    ((TestCounter += 1));
    if add_group "testgroup" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    if is_group "testgroup" ; then
       if sudo groupdel "testgroup" ; then
            print_test "LOCALIZE_TEST_FUNCTION_REMOVE" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAIL_REMOVE" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
       fi
    fi
}
# END add_group
# *************************************************************************** #
# BEGIN add_user_2_group
# -------------------------------------
# HELPBUILDER add_user_2_group
help_add_user_2_group()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_ADD_USER_2_GROUP_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_ADD_USER_2_GROUP_DESC")";
    NOTES="$(localize "LOCALIZE_ADD_USER_2_GROUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER add_user_2_group
localize_add_user_2_group()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_ADD_USER_2_GROUP_USAGE" "add_user_2_group 1->(GroupName)" "Comment: add_user_2_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_USER_2_GROUP_DESC"  "Add User to Group." "Comment: add_user_2_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_ADD_USER_2_GROUP_NOTES" "None." "Comment: add_user_2_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_ADD_USER_2_GROUP_ERROR" "Error in adding User to group" "Comment: add_user_2_group @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
add_user_2_group()
{
    if ! is_group "testgroup" ; then
        if add_group "testgroup" ; then
            write_log "add_user_2_group ${1}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    fi
    if ! is_user_in_group "${1}" ; then
        if sudo gpasswd -a "${SystemUserName}" "${1}" ; then
            write_log "add_user_2_group ${1}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 0;
        else
            write_error "LOCALIZE_ADD_USER_2_GROUP_ERROR" ": gpasswd -a ${SystemUserName} ${1} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            return 1;
        fi
    fi
    return 0;
}
# -------------------------------------
test_add_user_2_group()
{
    ((TestCounter += 1));
    if add_user_2_group "testgroup" ; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
    # remove them
    if is_user_in_group "testgroup" ; then
        sudo gpasswd -d "${SystemUserName}" testgroup;
    fi
}
# END add_user_2_group
# *************************************************************************** #
# BEGIN set_debugging_mode
# -------------------------------------
# HELPBUILDER set_debugging_mode
help_set_debugging_mode()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_SET_DEBUGGING_MODE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_SET_DEBUGGING_MODE_DESC")";
    NOTES="$(localize "LOCALIZE_SET_DEBUGGING_MODE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER set_debugging_mode
localize_set_debugging_mode()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_USAGE" "set_debugging_mode" "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_DESC"  "Set Debugging Mode: also checks for Internet Connection." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_NOTES" "Fill try to Repair Internet Connection. Only sets Debugging switch if TheDebugging is set to 1." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_TITLE"         "Starting setup..." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_INTERNET-UP"   "Internet is Up!"   "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_TRIED-TO-FIX"  "I tried to fix Network, I will test it again, if it fails, first try to re-run this script over, if that fails, try Network Troubleshooting." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_TRY-AGAIN"     "trying again in 13 seconds..." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_INTERNET-DOWN" "Internet is Down: Internet is Down, this script requires an Internet Connection, fix and retry; try Network Troubleshooting; first try to rerun this script, I did try to fix this. Select Install with No Internet Connection option." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_NO-INTERNET"   "No Internet Install Set; if it fails; you must establish an Internet connection first; try Network Troubleshooting." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_WARN-1"        "Debug Mode will insert a Pause Function at critical functions and give you some information about how the script is running, it also may set other variables and run more test." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SET_DEBUGGING_MODE_WARN-2"        "Debugging is set on, if set -o nounset or set -u, you may get unbound errors that need to be fixed." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "BOOT-MODE-DETECTED"               "Boot Mode Detected." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LIVE-MODE-DETECTED"               "Live Mode Detected." "Comment: set_debugging_mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
set_debugging_mode()
{
    if [ "$Set_TheDebugging" -eq 0 ]; then
        Set_TheDebugging=1; # So we only run this once.
    else
        return 0; # True
    fi
    IsOK=0;  # True
    print_title "LOCALIZE_SET_DEBUGGING_MODE_TITLE";
    print_info "$TEXT_SCRIPT_ID";
    if is_internet ; then
        print_info "LOCALIZE_SET_DEBUGGING_MODE_INTERNET-UP";
    else
        fix_network;
        print_error "LOCALIZE_SET_DEBUGGING_MODE_TRIED-TO-FIX";
        print_this "LOCALIZE_SET_DEBUGGING_MODE_TRY-AGAIN";
        sleep 13;
        if ! is_internet ; then
            write_error "LOCALIZE_SET_DEBUGGING_MODE_INTERNET-DOWN" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_error "LOCALIZE_SET_DEBUGGING_MODE_INTERNET-DOWN" ;
            if [ "${INSTALL_NO_INTERNET}" -eq 0 ]; then
                INSTALL_NO_INTERNET=1;
                print_error "LOCALIZE_SET_DEBUGGING_MODE_NO-INTERNET";
            fi
            pause_function "set_debugging_mode : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            IsOK=0;
        fi
    fi
    if [ "${TheDebugging}" -eq 1 ]; then
        #set -u
        set -o nounset;
        print_error "LOCALIZE_SET_DEBUGGING_MODE_WARN-1";
        print_error "LOCALIZE_SET_DEBUGGING_MODE_WARN-2";
        pause_function "set_debugging_mode : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    return "$IsOK";
}
# END set_debugging_mode
# *************************************************************************** #
# BEGIN test_internet
# -------------------------------------
# HELPBUILDER test_internet
help_test_internet()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_TEST_INTERNET_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_TEST_INTERNET_DESC")";
    NOTES="$(localize "LOCALIZE_TEST_INTERNET_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER test_internet
localize_test_internet()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_TEST_INTERNET_USAGE" "test_internet" "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_DESC"  "Set Debugging Mode: also checks for Internet Connection." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_NOTES" "Fill try to Repair Internet Connection. Only sets Debugging switch if TheDebugging is set to 1." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_TEST_INTERNET_TITLE"         "Starting setup..." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_INTERNET-UP"   "Internet is Up!"   "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_TRIED-TO-FIX"  "I tried to fix Network, I will test it again, if it fails, first try to re-run this script over, if that fails, try Network Troubleshooting." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_TRY-AGAIN"     "trying again in 13 seconds..." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_INTERNET-DOWN" "Internet is Down: Internet is Down, this script requires an Internet Connection, fix and retry; try Network Troubleshooting; first try to rerun this script, I did try to fix this. Select Install with No Internet Connection option." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_NO-INTERNET"   "No Internet Install Set; if it fails; you must establish an Internet connection first; try Network Troubleshooting." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_WARN-1"        "Debug Mode will insert a Pause Function at critical functions and give you some information about how the script is running, it also may set other variables and run more test." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_INTERNET_WARN-2"        "Debugging is set on, if set -o nounset or set -u, you may get unbound errors that need to be fixed." "Comment: test_internet @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
test_internet()
{
    ((TestCounter += 1));
    if [ "$Set_TheDebugging" -eq 0 ]; then
        Set_TheDebugging=1; # So we only run this once.
    else
        return 0; # True
    fi
    IsOK=0;  # True
    print_title "LOCALIZE_TEST_INTERNET_TITLE";
    print_info "$TEXT_SCRIPT_ID";
    if is_internet ; then
        print_info "LOCALIZE_TEST_INTERNET_INTERNET-UP";
    else
        fix_network;
        print_error "LOCALIZE_TEST_INTERNET_TRIED-TO-FIX";
        print_this "LOCALIZE_TEST_INTERNET_TRY-AGAIN";
        sleep 13;
        if ! is_internet ; then
            write_error "LOCALIZE_TEST_INTERNET_INTERNET-DOWN" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_error "LOCALIZE_TEST_INTERNET_INTERNET-DOWN" ;
            if [ "$INSTALL_NO_INTERNET" -eq 0 ]; then
                INSTALL_NO_INTERNET=1;
                print_error "LOCALIZE_TEST_INTERNET_NO-INTERNET";
            fi
            pause_function "set_debugging_mode : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            IsOK=0;
        fi
    fi
    if [ "${TheDebugging}" -eq 1 ]; then
        #set -u
        set -o nounset;
        print_error "LOCALIZE_TEST_INTERNET_WARN-1";
        print_error "LOCALIZE_TEST_INTERNET_WARN-2";
        pause_function "set_debugging_mode : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    return "$IsOK";
}
# END test_internet
# *************************************************************************** #
# BEGIN country_list
# -------------------------------------
# HELPBUILDER country_list
help_country_list()
{
    ((HelpComplileCounter += 1));
    USAGE="country_list";
    DESCRIPTION="$(localize "LOCALIZE_COUNTRY_LIST_DESC")";
    NOTES="$(localize "LOCALIZE_COUNTRY_LIST_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER country_list
localize_country_list()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_COUNTRY_LIST_DESC"  "country list." "Comment: country_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_COUNTRY_LIST_NOTES" "Sets COUNTRY." "Comment: country_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_COUNTRY_LIST_SELECT" "Select your Country:" "Comment: country_list @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
country_list()
{
    #`reflector --list-countries | sed 's/[0-9]//g' | sed 's/^/"/g' | sed 's/,.*//g' | sed 's/ *$//g'  | sed 's/$/"/g' | sed -e :a -e '$!N; s/\n/ /; ta'`
    PS3="$prompt1";
    print_info "LOCALIZE_COUNTRY_LIST_SELECT";
    select COUNTRY in "${COUNTRIES[@]}"; do
        if contains_element "$COUNTRY" "${COUNTRIES[@]}"; then
          break;
        else
          invalid_option "${REPLY}";
        fi
    done
}
# END country_list
# *************************************************************************** #
# BEGIN get_country_codes
# -------------------------------------
# HELPBUILDER get_country_codes
help_get_country_codes()
{
    ((HelpComplileCounter += 1));
    USAGE="get_country_codes";
    DESCRIPTION="$(localize "LOCALIZE_GET_COUNTRY_CODES_DESC")";
    NOTES="$(localize "LOCALIZE_GET_COUNTRY_CODES_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_country_codes
localize_get_country_codes()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_COUNTRY_CODES_DESC"    "Get Country Code and set Counter." "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_NOTES"   "None." "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_COUNTRY_CODES_WARN"    "You must enter your Country correctly, no validation is done!" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INPUT"   "Country Code for Mirror List: (US) " "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_TITLE"   "Country Code for Mirror List" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_1"  "Australia     = AU | Belarus       = BY | Belgium       = BE" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_2"  "Brazil        = BR | Bulgaria      = BG | Canada        = CA" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_3"  "Chile         = CL | China         = CN | Colombia      = CO" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_4"  "Czech Repub   = CZ | Denmark       = DK | Estonia       = EE" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_5"  "Finland       = FI | France        = FR | Germany       = DE" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_6"  "Greece        = GR | Hungary       = HU | India         = IN" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_7"  "Ireland       = IE | Israel        = IL | Italy         = IT" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_8"  "Japan         = JP | Kazakhstan    = KZ | Korea         = KR" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_9"  "Macedonia     = MK | Netherlands   = NL | New Caledonia = NC" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_10" "New Zealand   = NZ | Norway        = NO | Poland        = PL" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_11" "Portugal      = PT | Romania       = RO | Russian Fed   = RU" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_12" "Serbia        = RS | Singapore     = SG | Slovakia      = SK" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_13" "South Africa  = ZA | Spain         = ES | Sri Lanka     = LK" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_14" "Sweden        = SE | Switzerland   = CH | Taiwan        = TW" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_15" "Ukraine       = UA | United King   = GB | United States = US" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODES_INFO_16" "Uzbekistan    = UZ | Viet Nam = VN" "Comment: get_country_codes @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_country_codes()
{
    # I pull the code from Locale, so it should always be right, so no need for a menu; default should work.
    print_title "LOCALIZE_GET_COUNTRY_CODES_TITLE" " - https://www.archlinux.org/mirrorlist/";
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_1";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_2";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_3";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_4";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_5";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_6";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_7";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_8";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_9";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_10";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_11";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_12";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_13";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_14";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_15";
    print_line;
    print_this  "LOCALIZE_GET_COUNTRY_CODES_INFO_16";
    print_line;
    print_error "LOCALIZE_GET_COUNTRY_CODES_WARN";
    #
    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    read_input_default "LOCALIZE_GET_COUNTRY_CODES_INPUT" "${LOCALE#*_}";
    BYPASS="$ThisOldByPass"; # Restore Bypass
    COUNTRY_CODE="$(to_upper_case "${OPTION}")"; # `echo "${OPTION}" | tr "[:lower:]" "[:upper:]"`;  # Upper case only
    COUNTRY="${COUNTRIES[$(get_index "TheCountryCodes[@]" "$COUNTRY_CODE")]}";
}
# END get_country_codes
# *************************************************************************** #
# BEGIN get_country_code
# -------------------------------------
# HELPBUILDER get_country_code
help_get_country_code()
{
    ((HelpComplileCounter += 1));
    USAGE="get_country_code";
    DESCRIPTION="$(localize "LOCALIZE_GET_COUNTRY_CODE_DESC")";
    NOTES="$(localize "LOCALIZE_GET_COUNTRY_CODE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_country_code
localize_get_country_code()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_COUNTRY_CODE_DESC"    "Get Country and Country Code." "Comment: get_country_code @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_COUNTRY_CODE_NOTES"   "Localized." "Comment: get_country_code @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_COUNTRY_CODE_CONFIRM" "Confirm Country Code" "Comment: get_country_code @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_country_code()
{
    YN_OPTION=0;
    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    while [[ ${YN_OPTION} -ne 1 ]]; do
        get_country_codes;
        read_input_yn "LOCALIZE_GET_COUNTRY_CODE_CONFIRM" "$COUNTRY_CODE" 1; # Returns YN_OPTION
    done
    BYPASS="$ThisOldByPass"; # Restore Bypass
    OPTION="$COUNTRY_CODE";
}
# END get_country_code
# *************************************************************************** #
# BEGIN get_root_password
# -------------------------------------
# HELPBUILDER get_root_password
help_get_root_password()
{
    ((HelpComplileCounter += 1));
    USAGE="get_root_password";
    DESCRIPTION="$(localize "LOCALIZE_GET_ROOT_PASSWORD_DESC")";
    NOTES="$(localize "LOCALIZE_GET_ROOT_PASSWORD_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_root_password
localize_get_root_password()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_DESC"   "Get root password." "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_NOTES"  "This shows the password on screen; not very secure, but its used so you can see the password, you do not want a mistake putting in Passwords." "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_TITLE"  "root" "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_INFO-1" "No Special Characters, until I figure out how to do this." "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_INFO-2" "Enter Root Password." "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_VD"     "root Password" "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_ROOT_PASSWORD_INFO-3" "Root Password is Set." "Comment: get_root_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_root_password()
{
    # @FIX Special Characters: How to embed ! $ into a variable, then to disk so a pipe can echo it; tried single tic '!' and escape \!, get error ! processes not found
    print_title "LOCALIZE_GET_ROOT_PASSWORD_TITLE";
    print_info  "LOCALIZE_GET_ROOT_PASSWORD_INFO-1";
    print_info  "LOCALIZE_GET_ROOT_PASSWORD_INFO-2";
    ThisOldByPass="${BYPASS}"; BYPASS=0;
    verify_input_data "LOCALIZE_GET_ROOT_PASSWORD_VD" 1;
    Root_Password="${OPTION}";
    BYPASS="$ThisOldByPass";
    print_title "LOCALIZE_GET_ROOT_PASSWORD_TITLE";
    print_info  "LOCALIZE_GET_ROOT_PASSWORD_INFO-3";
    # @FIX check for empty name
}
# END get_root_password
# *************************************************************************** #
# BEGIN get_user_name
# -------------------------------------
# HELPBUILDER get_user_name
help_get_user_name()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_GET_USER_NAME_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_GET_USER_NAME_DESC")";
    NOTES="$(localize "LOCALIZE_GET_USER_NAME_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_user_name
localize_get_user_name()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_USER_NAME_USAGE"  "get_user_name 1->(Optional Translated String for Title)"  "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_NAME_DESC"   "Get User Name."  "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_NAME_NOTES"  "Sets USERNAME." "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_USER_NAME_TITLE"  "User" "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_NAME_INFO-1" "No Special Characters, until I figure out how to do this." "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_NAME_INFO-2" "Enter User Name Alphanumeric only." "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_NAME_VD"     "User Name" "Comment: get_user_name @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_user_name()
{
    # @FIX Special Characters: How to embed ! $ into a variable, then to disk so a pipe can echo it; tried single tic '!' and escape \!, get error ! processes not found
    if [ -n "${1}" ] ; then
        print_title "LOCALIZE_GET_USER_NAME_TITLE" "${1}";
    else
        print_title "LOCALIZE_GET_USER_NAME_TITLE";
    fi
    print_info  "LOCALIZE_GET_USER_NAME_INFO-1";
    print_info  "LOCALIZE_GET_USER_NAME_INFO-2";
    ThisOldByPass="${BYPASS}"; BYPASS=0;
    verify_input_default_data "LOCALIZE_GET_USER_NAME_VD" "${USERNAME}" 1 1; # 1 = Alphanumeric
    USERNAME="${OPTION}";
    BYPASS="$ThisOldByPass";
    return 0;
}
# END get_user_name
# *************************************************************************** #
# BEGIN get_user_password
# -------------------------------------
# HELPBUILDER get_user_password
help_get_user_password()
{
    ((HelpComplileCounter += 1));
    USAGE="get_user_password";
    DESCRIPTION="$(localize "LOCALIZE_GET_USER_PASSWORD_DESC")";
    NOTES="$(localize "LOCALIZE_GET_USER_PASSWORD_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_user_password
localize_get_user_password()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_USER_PASSWORD_DESC"   "get user password." "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_PASSWORD_NOTES"  "Password in clear text." "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_USER_PASSWORD_TITLE"  "User Password" "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_PASSWORD_INFO-1" "16 Character Maximum on most Database Engines, Some Special Characters (Problem Storing them in text file) (use | instead of *)." "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_PASSWORD_INFO-2" "Enter User Password for" "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_PASSWORD_VD"     "User Password" "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_USER_PASSWORD_INFO-3" "User Name and Password is Set." "Comment: get_user_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_user_password()
{
    print_title "LOCALIZE_GET_USER_PASSWORD_TITLE" ": ${USERNAME}";
    print_info  "LOCALIZE_GET_USER_PASSWORD_INFO-1";
    print_info  "LOCALIZE_GET_USER_PASSWORD_INFO-2" ": ${USERNAME}";
    ThisOldByPass="${BYPASS}"; BYPASS=0;
    verify_input_default_data "LOCALIZE_GET_USER_PASSWORD_VD" "${USERPASSWD}" 1 8; # 8 = Password
    #verify_input_data "LOCALIZE_GET_USER_PASSWORD_VD" 1;
    USERPASSWD="${OPTION}";
    BYPASS="$ThisOldByPass";
    print_title "LOCALIZE_GET_USER_PASSWORD_TITLE";
    print_info  "LOCALIZE_GET_USER_PASSWORD_INFO-3";
    # @FIX check for empty name
}
# END get_user_password
# *************************************************************************** #
# BEGIN get_locale
# -------------------------------------
# HELPBUILDER get_locale
help_get_locale()
{
    ((HelpComplileCounter += 1));
    USAGE="get_locale";
    DESCRIPTION="$(localize "LOCALIZE_GET_LOCALE_DESC")";
    NOTES="$(localize "LOCALIZE_GET_LOCALE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER
localize_get_locale()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_LOCALE_DESC"     "Get Locale." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_NOTES"    "Used to get a Locale." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_LOCALE_TITLE"    "LOCALE" "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-1"   "Locales are used in Linux to define which language the user uses." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-2"   "As the locales define the character sets being used as well, setting up the correct locale is especially important if the language contains non-ASCII characters." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-3"   "We can only initialize those Locales that are Available, if not in list, Install Language and rerun script." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_SELECT"   "Select your Language Locale:" "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_TITLE-2"  "LANGUAGE/LOCALE" "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-4"   "Locales are used in Linux to define which language the user uses." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-5"   "As the locales define the character sets being used as well, setting up the correct locale is especially important if the language contains non-ASCII characters." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-6"   "We can only initialize those Locales that are Available, if not in list, Install Language and rerun script." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-7"   "First list shows all Available Languages, if yours is not in list choose No, then a full list will appear." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_INFO-8"   "Pick your Primary Language first, then you have an option to select as many languages as you wish." "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_CONFIRM"  "Confirm Language Locale" "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_DEFAULT"  "Use Default System Language"  "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_ADD-MORE" "Add more Locales" "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_LOCALE_EDIT"     "Edit system language (ex: en_US): " "Comment: get_locale @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_locale()
{
    # -------------------------------------
    # GET LOCALES LIST
    get_locales_list()
    {
        print_title "LOCALIZE_GET_LOCALE_TITLE" " - https://wiki.archlinux.org/index.php/Locale";
        print_info  "LOCALIZE_GET_LOCALE_INFO-1";
        print_info  "LOCALIZE_GET_LOCALE_INFO-2";
        print_info  "LOCALIZE_GET_LOCALE_INFO-3";
        # Another way to show all available, lots of work
        # @FIX create Localized po files for Localization
        # mkdir {af,sq,ar,eu,be,bs,bg,ca,hr,zh_CN,zh_TW,cs,da,en,et,fa,ph,fi,fr_FR,fr_CH,fr_BE,fr_CA,ga,gl,ka,de,el,gu,he,hi,hu,is,id,it,ja,kn,km,ko,lo,lt,lv,ml,ms,mi,mn,no,pl,pt_PT,pt_BR,ro,ru,mi,sr,sk,sl,so,es,sv,tl,ta,th,mi_NZ,tr,uk,vi}
        # @FIX do I need to localize Locale
        LOCALE_LANG=("Afrikaans" "Albanian" "Arabic" "Basque" "Belarusian" "Bosnian" "Bulgarian" "Catalan" "Croatian" "Chinese (Simplified)" "Chinese (Traditional)" "Czech" "Danish" "Dutch" "English" "Estonian" "Farsi" "Filipino" "Finnish" "French(FR)" "French (CH)" "French (BE)" "French (CA)" "Gaelic" "Gallego" "Georgian" "German" "Greek" "Gujarati" "Hebrew" "Hindi" "Hungarian" "Icelandic" "Indonesian" "Italian" "Japanese" "Kannada" "Khmer" "Korean" "Lao" "Lithuanian" "Latvian" "Malayalam" "Malaysian" "Maori" "Mongolian" "Norwegian" "Polish" "Portuguese" "Portuguese (Brazil)" "Romanian" "Russian" "Samoan" "Serbian" "Slovak" "Slovenian" "Somali" "Spanish" "Swedish" "Tagalog" "Tamil" "Thai" "Tongan" "Turkish" "Ukrainian" "Vietnamese");
        LOCALE_CODES=("af_ZA" "sq_AL" "ar_SA" "eu_ES" "be_BY" "bs_BA" "bg_BG" "ca_ES" "hr_HR" "zh_CN" "zh_TW" "cs_CZ" "da_DK" "nl_NL" "en_US" "et_EE" "fa_IR" "ph_PH" "fi_FI" "fr_FR" "fr_CH" "fr_BE" "fr_CA" "ga" "gl_ES" "ka_GE" "de_DE" "el_GR" "gu" "he_IL" "hi_IN" "hu" "is_IS" "id_ID" "it_IT" "ja_JP" "kn_IN" "km_KH" "ko_KR" "lo_LA" "lt_LT" "lv" "ml_IN" "ms_MY" "mi_NZ" "no_NO" "pl" "pt_PT." "pt_BR" "ro_RO" "ru_RU" "mi_NZ" "sr_CS" "sk_SK" "sl_SI" "so_SO" "es_ES" "sv_SE" "tl" "ta_IN" "th_TH" "mi_NZ" "tr_TR" "uk_UA" "vi_VN");
        LOCALE_LANG["${#LOCALE_LANG[@]}"]="Not-in-List"; # No Spaces
        PS3="$prompt1";
        echo "LOCALIZE_GET_LOCALE_SELECT";
        select LOCALE in "${LOCALE_LANG[@]}"; do
            if contains_element "$LOCALE" "${LOCALE_LANG[@]}"; then
                is_last_item "LOCALE_LANG[@]" "$LOCALE";
                if [ "$?" -ne 1 ]; then
                    LOCALE="${LOCALE_CODES[$(get_index "LOCALE_LANG[@]" "$LOCALE")]}";
                    return 0; # True
                else
                    return 1; # False
                fi
                break;
            else
                invalid_option "$LOCALE";
            fi
        done
    }
    # *************************************************************************** #
    # -------------------------------------
    #LANGUAGE SELECTOR
    language_selector()
    {
        #
        print_title "LOCALIZE_GET_LOCALE_TITLE-2" " - https://wiki.archlinux.org/index.php/Locale";
        print_info  "LOCALIZE_GET_LOCALE_INFO-4";
        print_info  "LOCALIZE_GET_LOCALE_INFO-5";
        print_info  "LOCALIZE_GET_LOCALE_INFO-6";
        print_info  "LOCALIZE_GET_LOCALE_INFO-7";
        print_info  "LOCALIZE_GET_LOCALE_INFO-8";
        #
        read_input_yn "LOCALIZE_GET_LOCALE_DEFAULT" "${TheLanguage}" 1; # Returns YN_OPTION
        if [ "${YN_OPTION}" -eq 1 ]; then
            LOCALE="$TheLanguage";
            set_language "$LOCALE";
        else
            get_locales_list;
            read_input_default "LOCALIZE_GET_LOCALE_EDIT" "$LOCALE";
            set_language "$LOCALE";
        fi
    }
    # *************************************************************************** #
    #
    LOCALE_ARRAY=( "" );
    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    #
    language_selector;
    #
    YN_OPTION=0;
    while [[ ${YN_OPTION} -ne 1 ]]; do
        if [ "${#LOCALE_ARRAY[@]}" -eq 0 ]; then
            LOCALE_ARRAY=( "$LOCALE" );
        else
            LOCALE_ARRAY=( "${LOCALE_ARRAY[@]}" "$LOCALE" );
        fi
        read_input_yn "LOCALIZE_GET_LOCALE_ADD-MORE" " " 0; # Returns YN_OPTION
        if [ "${YN_OPTION}" -eq 1 ]; then
            get_locales_list;
            read_input_default "LOCALIZE_GET_LOCALE_EDIT" "$LOCALE";
            read_input_yn "LOCALIZE_GET_LOCALE_CONFIRM" "$LOCALE" 1;
            if [ "${YN_OPTION}" -eq 0 ]; then
               LOCALE="NONE";
            fi
            YN_OPTION=0;
        else
            YN_OPTION=1;
            break;
        fi
    done
    BYPASS="$ThisOldByPass"; # Restore Bypass
}
# END get_locale
# *************************************************************************** #
# BEGIN yes_no
# -------------------------------------
# HELPBUILDER yes_no
help_yes_no()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_YES_NO_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_YES_NO_DESC")";
    NOTES="$(localize "LOCALIZE_YES_NO_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER yes_no
localize_yes_no()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_YES_NO_USAGE" "yes_no 1->(0=no, 1=yes)" "Comment: yes_no @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_YES_NO_DESC"  "Convert Digital to Analog." "Comment: yes_no @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_YES_NO_NOTES" "Localized. Used to Show simple settings." "Comment: yes_no @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "YES" "Yes" "Comment: yes_no @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "NO"  "No"  "Comment: yes_no @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
yes_no()
{
    if [ "${1}" -eq 1 ]; then
        localize "YES" "";
    else
        localize "NO" "";
    fi
}
# END yes_no
# *************************************************************************** #
# BEGIN select_create_user
# -------------------------------------
# HELPBUILDER select_create_user
help_select_create_user()
{
    ((HelpComplileCounter += 1));
    USAGE="select_create_user";
    DESCRIPTION="$(localize "LOCALIZE_SELECT_CREATE_USER_DESC")";
    NOTES="$(localize "LOCALIZE_SELECT_CREATE_USER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER select_create_user
localize_select_create_user()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SELECT_CREATE_USER_DESC"  "select user." "Comment: select_create_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_CREATE_USER_NOTES" "None." "Comment: select_create_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "SUDO-WARNING" "WARNING: THE SELECTED USER MUST HAVE SUDO PRIVILEGES" "Comment: select_create_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "Create-new-user" "Create new user" "Comment: select_create_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_CREATE_USER_AVAILABLE-USERS" "Available Users: " "Comment: select_create_user @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
select_create_user()
{
    print_title "SELECT/CREATE USER ACCOUNT - https://wiki.archlinux.org/index.php/Users_and_Groups";
    users=( "$(grep "/home" /etc/passwd | cut -d: -f1)" ); # FIXME Verify this works
    PS3="$prompt1";
    print_info "LOCALIZE_SELECT_CREATE_USER_AVAILABLE-USERS";
    if [[ "$(( ${#users[@]} ))" -gt 0 ]]; then
        print_error localize "SUDO-WARNING" "";
    else
        echo "";
    fi
    TEMP="$(localize "Create-new-user" "")";
    select OPT in "${users[@]}" "$TEMP"; do
        if [ "$OPT" == "$TEMP" ]; then
            create_new_user;
            break;
        elif contains_element "$OPT" "${users[@]}"; then
            USERNAME=$OPT;
            break;
        else
            invalid_option "$OPT";
        fi
    done
    [[ ! -f "/home/${USERNAME}/.bashrc" ]] && configure_user_account;
}
# END select_create_user
# *************************************************************************** #
# BEGIN get_keyboard_layout
# -------------------------------------
# HELPBUILDER get_keyboard_layout
help_get_keyboard_layout()
{
    ((HelpComplileCounter += 1));
    USAGE="get_keyboard_layout";
    DESCRIPTION="$(localize "LOCALIZE_GET_KEYBOARD_LAYOUT_DESC")";
    NOTES="$(localize "LOCALIZE_GET_KEYBOARD_LAYOUT_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_keyboard_layout
localize_get_keyboard_layout()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_KEYBOARD_LAYOUT_DESC"   "Get Keyboard Layout, makes changes for some variants." "Comment: get_keyboard_layout @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_KEYBOARD_LAYOUT_NOTES"  "None." "Comment: get_keyboard_layout @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_KEYBOARD_LAYOUT_TITLE"  "Keymap." "Comment: get_keyboard_layout @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_KEYBOARD_LAYOUT_SELECT" "Select keyboard layout:" "Comment: get_keyboard_layout @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_keyboard_layout()
{
    if [ "$TheLanguage" == "es_ES" ]; then
        print_title "LOCALIZE_GET_KEYBOARD_LAYOUT_TITLE" "https://wiki.archlinux.org/index.php/KEYMAP";
        KBLAYOUT=("es" "latam");
        PS3="$prompt1";
        print_info "LOCALIZE_GET_KEYBOARD_LAYOUT_SELECT";
        select KBRD in "${KBLAYOUT[@]}"; do
            KEYBOARD="$KBRD";
        done
    fi
}
# END get_keyboard_layout
# *************************************************************************** #
# BEGIN configure_keymap
# -------------------------------------
# HELPBUILDER configure_keymap
help_configure_keymap()
{
    ((HelpComplileCounter += 1));
    USAGE="configure_keymap";
    DESCRIPTION="$(localize "LOCALIZE_CONFIGURE_KEYMAP_DESC")";
    NOTES="$(localize "LOCALIZE_CONFIGURE_KEYMAP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER configure_keymap
localize_configure_keymap()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_DESC"    "Allows user to decide if they wish to change the Default Keymap." "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_NOTES"   "None." "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "Load-Keymap"              "Load Keymap" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "Confirm-Keymap"           "Confirm Keymap" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_TITLE"   "KEYMAP" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO"    "The KEYMAP variable is specified in the /etc/rc.conf file. It defines what keymap the keyboard is in the virtual consoles. Keytable files are provided by the kbd package." "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_DEFAULT" "If Default is ok, then no changes needed: " "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_LAYOUT"  "Keyboard Layout (ex: us-acentos): " "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_1"  "Belgian                = be-latin1    | Brazilian Portuguese = br-abnt2     | Canadian-French = cf" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_2"  "Canadian Multilingual  = ca_multi     | Colemak (US)         = colemak      | Croatian        = croat" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_3"  "Czech                  = cz-lat2      | Dvorak               = dvorak       | French          = fr-latin1" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_4"  "German                 = de-latin1 or de-latin1-nodeadkeys                  | Italian         = it" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_5"  "Lithuanian             = lt.baltic    | Norwegian            = no-latin1    | Polish          = pl" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_6"  "Portuguese             = pt-latin9    | Romanian             = ro_win       | Russian         = ru4" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_7"  "Singapore              = sg-latin1    | Slovene              = slovene      | Swedish         = sv-latin1" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_8"  "Swiss-French           = fr_CH-latin1 | Swiss-German         = de_CH-latin1 | Spanish         = es" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_9"  "Spanish Latinoamerican = la-latin1    | Turkish              = tr_q-latin5  | Ukrainian       = ua" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_KEYMAP_INFO_10" "United States          = us or us-acentos                                   | United Kingdom  = uk" "Comment: configure_keymap @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
configure_keymap()
{
    setkeymap()
    {
        # SC2012: Use find instead of ls to better handle non-alphanumeric filenames.
        # shellcheck disable=SC2012
        local keymaps=( "$(ls /usr/share/kbd/keymaps/i386/qwerty | sed 's/.map.gz//g')" );
        PS3="(shift+pgup/pgdown) $prompt1";
        echo "Select keymap:";
        select KEYMAP in "${keymaps[@]}" "more"; do
            if contains_element "$KEYMAP" "${keymaps[@]}"; then
                loadkeys "$KEYMAP";
                break;
            elif [[ "$KEYMAP" == more ]]; then
                # This might be a bug in spellcheck, it sees LOC_CONFIGURE_KEYMAP_LAYOUT as a global, -p is prompt, so its expecting text, not sure how this works, its localized? FIXME
                # shellcheck disable=SC2034
                read -r -p "LOCALIZE_CONFIGURE_KEYMAP_LAYOUT" KEYMAP;
                loadkeys "$KEYMAP";
                break;
            else
                invalid_option "$KEYMAP";
            fi
        done
    }
    print_title "LOCALIZE_CONFIGURE_KEYMAP_TITLE" " - https://wiki.archlinux.org/index.php/KEYMAP";
    print_this  "LOCALIZE_CONFIGURE_KEYMAP_INFO";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_1";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_2";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_3";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_4";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_5";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_6";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_7";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_8";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_9";
    print_line;
    print_this "LOCALIZE_CONFIGURE_KEYMAP_INFO_10";
    print_line;
    print_this  "LOCALIZE_CONFIGURE_KEYMAP_DEFAULT" " [$KEYMAP]";
    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    read_input_default "Keymap" "$KEYMAP";
    read_input_yn "Load-Keymap" "$KEYMAP" 0;
    if [ "${YN_OPTION}" -eq 1 ]; then
        while [[ ${YN_OPTION} -ne 1 ]]; do
            setkeymap;
            read_input_yn "Confirm-Keymap" "$KEYMAP" 1;
        done
    else
        KEYMAP="us";
    fi
    BYPASS="$ThisOldByPass"; # Restore Bypass
}
# END configure_keymap
# *************************************************************************** #
# BEGIN get_editor
# -------------------------------------
# HELPBUILDER get_editor
help_get_editor()
{
    ((HelpComplileCounter += 1));
    USAGE="get_editor";
    DESCRIPTION="$(localize "LOCALIZE_GET_EDITOR_DESC")";
    NOTES="$(localize "LOCALIZE_GET_EDITOR_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER get_editor
localize_get_editor()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_GET_EDITOR_DESC"  "This gets called from Boot mode and Live mode; it does not add software, only ask if you wish to change the default editor, called from the create_config function." "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_EDITOR_NOTES" "None." "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_GET_EDITOR_DEFAULT"   "Do you wish to change the Default Editor of " "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_EDITOR_TITLE"     "DEFAULT EDITOR" "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_EDITOR_INSTALLED" "Installed Editor(s): " "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_EDITOR_EDITORS"   "Editors" "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_GET_EDITOR_SELECT"    "Select default editor:" "Comment: get_editor @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
get_editor()
{
    print_title "LOCALIZE_GET_EDITOR_TITLE";
    if [ -f /usr/bin/vim ]; then
        print_info "LOCALIZE_GET_EDITOR_INSTALLED" "emacs";
    else
        print_info "LOCALIZE_GET_EDITOR_INSTALLED" "emacs & vim";
    fi
    print_this "LOCALIZE_GET_EDITOR_EDITORS" ": ${EDITORS[*]}";
    ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    read_input_yn "LOCALIZE_GET_EDITOR_DEFAULT" "$EDITOR" 0;
    BYPASS="$ThisOldByPass"; # Restore Bypass
    if [ "${YN_OPTION}" -eq 1 ]; then
        PS3="$prompt1";
        print_this "LOCALIZE_GET_EDITOR_SELECT";
        select OPT in "${EDITORS[@]}"; do
            case "${REPLY}" in
                1)
                    EDITOR="nano";
                    break;
                    ;;
                2)
                    EDITOR="emacs";
                    break;
                    ;;
                3)
                    EDITOR="vi";
                    break;
                    ;;
                4)
                    EDITOR="vim";
                    break;
                    ;;
                5)
                    EDITOR="joe";
                    break;
                    ;;
                *)
                    invalid_option "$OPT";
                    ;;
            esac
        done
    fi
}
# END get_editor
# *************************************************************************** #
# BEGIN configure_timezone
# -------------------------------------
# HELPBUILDER configure_timezone
help_configure_timezone()
{
    ((HelpComplileCounter += 1));
    USAGE="configure_timezone";
    DESCRIPTION="$(localize "LOCALIZE_CONFIGURE_TIMEZONE_DESC")";
    NOTES="$(localize "LOCALIZE_CONFIGURE_TIMEZONE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER configure_timezone
localize_configure_timezone()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_DESC"     "Configure Timezone." "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_NOTES"    "None." "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_DEFAULT"  "Is the Default Timezone Correct" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_CONFIRM"  "Confirm Timezone " "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_TITLE"    "TIMEZONE" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_INFO_1"   "In an operating system the time (clock) is determined by four parts: Time value, Time standard, Time Zone, and DST (Daylight Saving Time if applicable)." "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE"     "Select zone:" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_SUBZONE"  "Select subzone:" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_1"   "Africa" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_2"   "America" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_3"   "Antarctica" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_4"   "Arctic" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_5"   "Asia" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_6"   "Atlantic" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_7"   "Australia" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_8"   "Brazil" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_9"   "Canada" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_10"  "Chile" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_11"  "Europe" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_12"  "Indian" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_13"  "Mexico" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_14"  "Midest" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_15"  "Pacific" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_16"  "US" "Comment: configure_timezone @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
configure_timezone()
{
    settimezone()
    {
        # @FIX Localize?
        local zone=("$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_1")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_2")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_3")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_4")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_5")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_6")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_7")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_8")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_9")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_10")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_11")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_12")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_13")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_14")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_15")" "$(localize "LOCALIZE_CONFIGURE_TIMEZONE_ZONE_16")");
        PS3="$prompt1";
        echo "LOCALIZE_CONFIGURE_TIMEZONE_ZONE";
        select ZONE in "${zone[@]}"; do
            if contains_element "$ZONE" "${zone[@]}"; then
                local subzones=( "$(ls "/usr/share/zoneinfo/$ZONE/")" );
                PS3="$prompt1";
                echo "LOCALIZE_CONFIGURE_TIMEZONE_SUBZONE";
                select SUBZONE in "${subzones[@]}"; do
                    if contains_element "$SUBZONE" "${subzones[@]}"; then
                        add_packagemanager "remove_file \"/etc/localtime\" \"${LINENO[0]}\"; ln -s /usr/share/zoneinfo/${ZONE}/${SUBZONE} /etc/localtime" "RUN-TIMEZONE";
                        break;
                    else
                        invalid_option "$SUBZONE";
                    fi
                done
                break;
            else
                invalid_option "$ZONE"
            fi
        done
    }
    print_title "LOCALIZE_CONFIGURE_TIMEZONE_TITLE" " - https://wiki.archlinux.org/index.php/Timezone";
    print_info  "LOCALIZE_CONFIGURE_TIMEZONE_INFO_1";
    local ThisOldByPass="${BYPASS}"; BYPASS=0; # Do Not Allow Bypass
    read_input_yn "LOCALIZE_CONFIGURE_TIMEZONE_DEFAULT" "$ZONE/$SUBZONE" 1;
    while [[ ${YN_OPTION} -ne 1 ]]; do
        settimezone;
        read_input_yn "LOCALIZE_CONFIGURE_TIMEZONE_CONFIRM" "($ZONE/$SUBZONE)" 1;
    done
    BYPASS="$ThisOldByPass"; # Restore Bypass
    if [ "${RUNTIME_MODE}" -eq 2 ]; then # Live Mode
        if [ "${TheDriveFormated}" -eq 1 ]; then
            touch "${TheMountPoint}/etc/timezone";
            echo "${ZONE}/${SUBZONE}" > "${TheMountPoint}/etc/timezone";
            copy_file "${TheMountPoint}/etc/timezone" "${TheFullScriptPath}/etc/timezone" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        else
            echo "${ZONE}/${SUBZONE}" > "${TheFullScriptPath}/etc/timezone";
        fi
    else # Boot Mode
        echo "${ZONE}/${SUBZONE}" > "${TheFullScriptPath}/etc/timezone";
    fi
}
# END configure_timezone
# *************************************************************************** #
# BEGIN db_backup
# -------------------------------------
# HELPBUILDER db_backup
help_db_backup()
{
    ((HelpComplileCounter += 1));
    USAGE="MYSQL-BACKUP-USAGE";
    DESCRIPTION="$(localize "LOCALIZE_DB_BACKUP_DESC")";
    NOTES="$(localize "LOCALIZE_DB_BACKUP_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER db_backup
localize_db_backup()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_DB_BACKUP_USAGE"   "mysql_backup 1->(Database type: 0=None,1=SQlite,2=PostgreSql,3=MySql) 2->(User Name) 3->(IP Address) 4->(DB Name) 5->(Db User Name) 6->(Password) 7->(Base Destination Path) 8->(DB Full Path)" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DB_BACKUP_DESC"    "Backup Database" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DB_BACKUP_NOTES"   "" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_DB_BACKUP_TITLE"   "Start MySQL Backup..." "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DB_BACKUP_WORKING" "Working on" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DB_BACKUP_ERROR"   "Dump Failed" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DB_BACKUP_PING"    "Ping Failed" "Comment: mysql_backup @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
db_backup()
{
    print_this "LOCALIZE_DB_BACKUP_TITLE"
    #
    if is_online "${3}" ; then
        print_info "LOCALIZE_DB_BACKUP_WORKING" "${3}..."
        #mkdir -p "${1}/${DB_Full_Paths[$i]}/"
        if [ "${1}" -eq 0 ]; then   # None
            return 0;
        elif [ "${1}" -eq 1 ]; then # Sqlite
            print_warning "Not supported yet"
            return 0;
        elif [ "${1}" -eq 2 ]; then # PostgreSql
            print_warning "Not supported yet"
            return 0;
        elif [ "${1}" -eq 3 ]; then # My_SQL
            # shellcheck disable=SC2029
            ssh "${2}@${3}" "mysqldump --user=${5} --password=${6} ${5} |gzip -cq9" > "${7}/${8}/${5}.sql.gz";
        fi
        # shellcheck disable=SC2181
        if [ "$?" -ne 0 ]; then
            print_warning "LOCALIZE_DB_BACKUP_ERROR" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
            write_error   "LOCALIZE_DB_BACKUP_ERROR" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
            #read -r -e -sn 1 -p "PRESS_ANY_KEY_CONTINUE"
        fi
    else
        print_warning "LOCALIZE_DB_BACKUP_PING" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
        write_error   "LOCALIZE_DB_BACKUP_PING" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
    fi
}
# END db_backup
# -----------------------------------------------------------------------------
# BEGIN create_database
# -------------------------------------
# HELPBUILDER create_database
help_create_database()
{
    ((HelpComplileCounter += 1));
    USAGE="MYSQL-BACKUP-USAGE";
    DESCRIPTION="$(localize "LOCALIZE_CREATE_DATABASE_DESC")";
    NOTES="$(localize "LOCALIZE_CREATE_DATABASE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER create_database
localize_create_database()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CREATE_DATABASE_USAGE"   "create_database 1->(Database type: 0=None,1=SQlite,2=PostgreSql,3=MySql) 2->(User Name) 3->(IP Address) 4->(DB Name) 5->(Db User Name) 6->(DB Password) 7->(DB root Password)" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_DESC"    "Backup Database" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_NOTES"   "" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CREATE_DATABASE_TITLE"   "Start MySQL Backup..." "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_WORKING" "Working on" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_ERROR"   "Dump Failed" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_PING"    "Ping Failed" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_DATABASE_NI"      "Not Implemented" "Comment: create_database @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
create_database()
{
    if [ $# -ne 7 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} -> ${FUNCNAME[1]}()"; exit 1; fi
    if [ "${1}" -eq 0 ]; then return 0; fi # None
    if is_online "${3}" ; then
        if [ "${1}" -eq 1 ]; then   # SQlite
            print_this "LOCALIZE_CREATE_DATABASE_NI";
            return 0;
        elif [ "${1}" -eq 2 ]; then # PostgreSql
            print_this "LOCALIZE_CREATE_DATABASE_NI";
            return 0;
        elif [ "${1}" -eq 3 ]; then # MySql: which mysql
            # /usr/bin/mysql_secure_installation
            # /usr/bin/mysqladmin -u root password 'new-password'
            # /usr/bin/mysqladmin -u root -h vps-1135159-16955.manage.myhosting.com password 'new-password'
            # "UPDATE user SET password=PASSWORD("<YOUR_PASSWORD>") WHERE User="root";"

            # mysql --host=localhost --user=user --password=password << END
            # CREATE USER ${TICK}${5}${TICK}@${TICK}localhost${TICK} IDENTIFIED BY ${TICK}${6}${TICK};
            # CREATE DATABASE IF NOT EXISTS ${TICK}${4}${TICK} DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
            # GRANT ALL PRIVILEGES ON ${TICK}${4}${TICK} . * TO ${TICK}${5}${TICK}@${TICK}localhost${TICK};
            # END

            # @FIX I do not think we want to do this on Shared Host
            #ssh "root@${3}" "mysqladmin -u root password ${TICK}${7}${TICK}";
            #if [ "$?" -eq 1 ]; then  echo "Failed to set password"; fi

            # ${BTICK} or ${TICK}
            # "CREATE USER '$username'@'localhost' IDENTIFIED BY  '$password';"
            # "CREATE DATABASE \`$domainname\`;"
            # "GRANT ALL PRIVILEGES ON  \`$domainname\`.* TO $username@localhost WITH GRANT OPTION;"
            local SQL="CREATE USER ${TICK}${5}${TICK}@${TICK}localhost${TICK} IDENTIFIED BY ${TICK}${6}${TICK};CREATE DATABASE IF NOT EXISTS ${TICK}${4}${TICK} DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;GRANT ALL PRIVILEGES ON ${TICK}${4}${TICK}.* TO ${TICK}${5}${TICK}@${TICK}localhost${TICK} IDENTIFIED BY ${TICK}${6}${TICK};FLUSH PRIVILEGES;";
            #echo "mysql -uroot -p${7} -e \"$SQL\"";
            #ssh "${2}@${3}" "mysql -uroot -p${7} -e \"$SQL\"";
            # 1->(IP or URL Address) 2->(User Name) 3->(/Full-Path/File-Name.sql or SQL Statement) 4->(DB User Name) 5->(DB Password) 6->(0=SQL File,1=SQL Statement) 7->(Database Type: 0=None,1=SQlite,2=PostgreSql,3=MySql
            run_db_sql_file_ssh "${3}" "${2}" "$SQL" "root" "${7}" "1" "${1}";
            print_line;
            SQL="show databases;";
            print_line;
            run_db_sql_file_ssh "${3}" "${2}" "$SQL" "root" "${7}" "1" "${1}";
        fi
        # shellcheck disable=SC2181
        if [ "$?" -ne 0 ]; then
            print_warning "LOCALIZE_CREATE_DATABASE_ERROR" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
            write_error   "LOCALIZE_CREATE_DATABASE_ERROR" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
            #read -r -e -sn 1 -p "PRESS_ANY_KEY_CONTINUE"
        fi
    else
        print_warning "LOCALIZE_CREATE_DATABASE_PING" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
        write_error   "LOCALIZE_CREATE_DATABASE_PING" "${3} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"
    fi
}
# END create_database
# *************************************************************************** #
# BEGIN set_language
# -------------------------------------
# HELPBUILDER set_language
help_set_language()
{
    ((HelpComplileCounter += 1));
    USAGE="set_language";
    DESCRIPTION="$(localize "LOCALIZE_SET_LANGUAGE_DESC")";
    NOTES="$(localize "NONE")";
    # af ak ar as ast be bg bn-bd bn-in br bs ca cs csb cy da de el en-gb en-us en-za eo es-ar es-cl es-es es-mx et eu fa ff fi fr fy-nl ga-ie gd gl gu-in he hi-in hr hu hy-am id is it ja kk km kn ko ku lg lij lt lv mai mk ml mr nb-no nl nn-no nso or pa-in pl pt-br pt-pt rm ro ru si sk sl son sq sr sv-se ta ta-lk te th tr uk vi zh-cn zh-tw zu"
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="16 June 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER set_language
localize_set_language()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SET_LANGUAGE_DESC"  "Set Language: Used to set Languages for packages" "Comment: set_language @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
set_language()
{
    TheLanguage="${1}";
    # KDE #
    if [ "$TheLanguage" == pt_BR ] || [ "$TheLanguage" == en_GB ] || [ "$TheLanguage" == zh_CN ]; then
        LANGUAGE_KDE="$(to_lower_case "$TheLanguage")";
    elif [ "$TheLanguage" == en_US ]; then
        LANGUAGE_KDE="en_gb";
    else
        LANGUAGE_KDE="$(echo "$TheLanguage" | cut -d_ -f1)"; # -d\_ -f1)";
    fi
    # *************************************************************************** #
    # FIREFOX #
    if [ "$TheLanguage" == pt_BR ] || [ "$TheLanguage" == pt_PT ] || [ "$TheLanguage" == en_GB ] || [ "$TheLanguage" == es_AR ] || [ "$TheLanguage" == es_ES ] || [ "$TheLanguage" == zh_CN ]; then
        #LANGUAGE_FF="$(to_lower_case "$TheLanguage" | sed 's/_/-/')";
        LANGUAGE_FF="$(to_lower_case "${TheLanguage//_/-}")";
    elif [ "$TheLanguage" == en_US ]; then
        LANGUAGE_FF="en-us";
        #LANGUAGE_FF="en-gb";
    else
        LANGUAGE_FF="$(echo "$TheLanguage" | cut -d_ -f1)"; # -d\_ -f1)";
    fi
    # *************************************************************************** #
    # HUNSPELL #
    if [ "$TheLanguage" == pt_BR ]; then
        #LANGUAGE_HS="$(to_lower_case "$TheLanguage" | sed 's/_/-/')";
        LANGUAGE_HS="$(to_lower_case "${TheLanguage//_/-}")";
    elif [ "$TheLanguage" == pt_PT ]; then
        LANGUAGE_HS="pt_pt";
    else
        LANGUAGE_HS="$(echo "$TheLanguage" | cut -d_ -f1)"; # -d\_ -f1)";
    fi
    # *************************************************************************** #
    # ASPELL #
    LANGUAGE_AS="$(echo "$TheLanguage" | cut -d_ -f1)"; # -d\_ -f1)";
    # *************************************************************************** #
    # LIBREOFFICE #
    if [ "$TheLanguage" == pt_BR ] || [ "$TheLanguage" == en_GB ] || [ "$TheLanguage" == en_US ] || [ "$TheLanguage" == zh_CN ]; then
        # SC2001: See if you can use ${variable//search/replace} instead.
        #LANGUAGE_LO="$(echo "$TheLanguage" | sed 's/_/-/')";
        LANGUAGE_LO="${TheLanguage//_/-}";
    else
        LANGUAGE_LO="$(echo "$TheLanguage" | cut -d_ -f1)"; # -d\_ -f1)";
    fi
    # *************************************************************************** #
    # CALLIGRA #
    LANGUAGE_CALLIGRA="${TheLanguage:0:2}"
    if [ "$TheLanguage" == "pt_br" ]; then
        LANGUAGE_CALLIGRA="pt_br"; # Portugese
    else
        LANGUAGE_CALLIGRA="pt"; # Brazilian Portugese
    fi
    if [ "$TheLanguage" == "zh_cn" ]; then
        LANGUAGE_CALLIGRA="zh_cn";  # Simplified Chinese
    else
        LANGUAGE_CALLIGRA="zh_tw";  # Traditional Chinese
    fi
    if [ "${TheLanguage:0:2}" == "en" ]; then
        LANGUAGE_CALLIGRA="en_gb"; # British
    fi
    # *************************************************************************** #
}
# END set_language
# -----------------------------------------------------------------------------
# BEGIN is_ssh_keyed
# -------------------------------------
# HELPBUILDER is_ssh_keyed
help_is_ssh_keyed()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_SSH_KEYED_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_SSH_KEYED_DESC")";
    NOTES="$(localize "LOCALIZE_IS_SSH_KEYED_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="16 May 2013";
    REVISION="6 July 2017";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_ssh_keyed
localize_is_ssh_keyed()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_SSH_KEYED_USAGE" "is_ssh_keyed 1->(ssh User@URL_IP) 2->(Port: -p 22)" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_SSH_KEYED_DESC"  "Checks to see if ssh is keyed and can log in." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_SSH_KEYED_NOTES" "returns 1 for true, 0 false" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_ssh_keyed()
{
    [[ "$#" -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Counted $# Parameters - Usage: is_ssh_keyed UserName@IP_ADDRESS Port"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
   #if [[ $(ssh "${2}" -t -t -qo BatchMode=yes "${1}" echo "OK" | grep "OK" | wc -l) -eq 1 ]]; then
    if [[ $(ssh "${2}" -t -t -qo BatchMode=yes "${1}" echo "OK" | grep -c "OK") -eq 1 ]]; then
        return 0;
    else
        return 1;
    fi
}
# END is_ssh_keyed
# *************************************************************************** #
# BEGIN is_ssh_user
# -------------------------------------
# HELPBUILDER is_ssh_user
help_is_ssh_user()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_SSH_USER_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_SSH_USER_DESC")";
    NOTES="$(localize "LOCALIZE_IS_SSH_USER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="16 May 2013";
    REVISION="16 May 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_ssh_user
localize_is_ssh_user()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_SSH_USER_USAGE" "is_ssh_user 1->(ssh User) 2->(ssh URL)" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_SSH_USER_DESC"  "Checks to see if ssh User exist." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_SSH_USER_NOTES" "returns 0 for true, 1 false" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
is_ssh_user()
{
    # shellcheck disable=SC2140
    return "$( ssh "root@${2}" "egrep -i "^"${1}"" /etc/passwd > /dev/null 2>&1; echo \"\$?\";" )";
}
# END is_ssh_user
# *************************************************************************** #
# BEGIN create_ssh_user
# -------------------------------------
# HELPBUILDER create_ssh_user
help_create_ssh_user()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_CREATE_SSH_USER_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_CREATE_SSH_USER_DESC")";
    NOTES="$(localize "LOCALIZE_CREATE_SSH_USER_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="16 May 2013";
    REVISION="16 May 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER create_ssh_user
localize_create_ssh_user()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_CREATE_SSH_USER_USAGE"    "create_ssh_user 1->(ssh USERNAME) 2->(ssh URL or IP address) 3->(ssh User Password) 4->(ssh root Password) 5->(App_Path) 6->(App_Folder)" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_SSH_USER_DESC"     "Create SSH User." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_SSH_USER_NOTES"    "returns 0 for true, 1 false. You should not need root password, using Key which should be installed first." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_CREATE_SSH_USER_PASS"     "Created User" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_SSH_USER_FAIL"     "Failed to Create User" "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_SSH_USER_TYPE-1"   "Create folders for Type 1 Application install." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_CREATE_SSH_USER_TYPE-1-F" "Failed to Create folders for Type 1 Application install." "Comment: remove_module @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
create_ssh_user()
{
    # Note that, unescaped, this expands on the client side.
    # shellcheck disable=SC2029
    if [ "$( ssh "root@${2}" "egrep -i \"^${1}\" /etc/group > /dev/null 2>&1; echo \"\$?\";" )" -eq 1 ]; then
        # Note that, unescaped, this expands on the client side.
        # shellcheck disable=SC2029
        if [ "$( ssh "root@${2}" "groupadd ${1}; echo \"\$?\";" )" -eq 0 ]; then
            # Note that, unescaped, this expands on the client side.
            # shellcheck disable=SC2029
            if [ "$( ssh "root@${2}" "useradd -m -g ${1} -G ${1},users -s /bin/bash ${1}; echo \"\$?\";" )" -eq 0 ]; then
                # Note that, unescaped, this expands on the client side.
                # shellcheck disable=SC2029
                echo -e "${3}\n${3}\n" | ssh -t "root@${2}" "passwd ${1}";
                # Check exit code directly with e.g. 'if mycmd;', not indirectly with $?.
                #
                # shellcheck disable=SC2181
                if [ $? -eq 0 ]; then
                    print_this "LOCALIZE_CREATE_SSH_USER_PASS" "${1}";
                else
                    print_error "LOCALIZE_CREATE_SSH_USER_FAIL" "${1}";
                fi
            fi
        fi
    fi
    if [ "$((Install_Type_1))" -eq 0 ]; then
        print_this "LOCALIZE_CREATE_SSH_USER_TYPE-1" "${1} -> ${4}${5}";
        # "run" ]; -- SC2140: Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
        # shellcheck disable=SC2140
        if ssh "root@${2}" "mkdir -p Scripts;mkdir -p ${5};mkdir -p ${5}${6};mkdir -p ${5}run;chown -R ${1}:${1} ${5};chmod -R 770 ${5};chmod -R 755 ${5}${6}; if [ -d ""${5}"run" ]; then exit 0; else exit 1; fi"; then # you would have to keep track of each return to truly test for each error; this only shows the last; so I would make that a test
            print_error "LOCALIZE_CREATE_SSH_USER_TYPE-1-F" "${1}";
        fi
        pause_function "${LINENO[0]}"
    fi
}
# END create_ssh_user
# *************************************************************************** #
# BEGIN key_website
# -------------------------------------
# HELPBUILDER key_website
help_key_website()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_KEY_WEBSITE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_KEY_WEBSITE_DESC")";
    NOTES="$(localize "KEY-APP-NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="10 Apr 2013";
    REVISION="10 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER key_website
localize_key_website()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_KEY_WEBSITE_USAGE"     "key_website 1->(ssh USERNAME) 2->(ssh URL or IP address) 3->(ssh User Password) 4->(ssh root Password) 5->(App_Path) 6->(App_Folder) 7->(Create_User) 8->(Port: -p 22)" "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_DESC"      "Key Website will prompt you to create a new key, or use an existing one, then copy it to the site." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_NOTES"     "Install Key: ssh key." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_TEST"      "Testing Function key_website" "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_KEY"       "Warning about to Create Keys on this Computer; if you have keys, do not do this, or backup first, this will overwrite keys." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_USER"      "Warning about to Create User on this Computer." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_KEY_WEBSITE_LINE_1"    "Key Website for Automated SSH Access." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_LINE_2"    "You must create an SSH Key once, do not give it a password or phrase for automation, hit enter twice, or enter a password (not recommended), then copy it to account." "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_LINE_3"    "You might be required to type in password for server" "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_FAIL"      "ssh-copy failed" "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_PING"      "Can not ping"    "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_PASS"      "ssh Key Passed"  "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_EXIST"     "SSH Key Exist"   "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_COMMENT-P" "commented mesg y in /etc/bashrc."   "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_KEY_WEBSITE_COMMENT-F" "Error commenting mesg y in /etc/bashrc."   "Comment: do_app @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# 1. ssh-keygen -t rsa
# 2. ssh-copy-id -i ~/.ssh/id_rsa.pub USERNAME@remote_host
# 3. Enter ssh password when prompted; then try to log in using: ssh USERNAME@remote_host (it should not require password)
#
# 1->(ssh USERNAME)
# 2->(ssh URL or IP address)
# 3->(ssh User Password)
# 4->(ssh root Password)
# 5->(App_Path)
# 6->(App_Folder)
# 7->(Create_User)
# 8->(Port: -p 22)
key_website()
{
    [[ "$#" -ne 8 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Counted $# Parameters - Usage: key_website 1->(ssh USERNAME) 2->(ssh URL or IP address) 3->(ssh User Password) 4->(ssh root Password) 5->(App_Path) 6->(App_Folder) 7->(Create_User) 8->(Port: -p 22)"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    #echo "key_website start";
    #
    local -i Is_Ok; Is_Ok=0;
    # -------------------------
    # 1->(ssh URL or IP address) 2->(ssh root Password) 3->(Port: -p 22)
    fix_tty()
    {
        # shellcheck disable=SC2154
        if [ "${BashRc_Path}" != "" ]; then
            # No use looking for fail, press on if it fails
            sshpass -p "${2}" ssh -t -t "${3}" "root@${1}" "BashRc_Path=\"${BashRc_Path}\"; [[ -f \"\${BashRc_Path}\" ]] && [[ \$(egrep -ic 'mesg y' \"\${BashRc_Path}\") -gt 0 ]] && sed -i 's/^mesg/#mesg/g' \"\${BashRc_Path}\";"
        fi
    }
    # -------------------------
    # 1->(ssh USERNAME) 2->(ssh URL or IP address) 3->(ssh User Password) 4->(ssh root Password) 5->(App_Path) 6->(App_Folder) 7->(Create_User)
    create_ssh_account()
    {
        # Now test for user
        if is_ssh_user "${1}" "${2}"; then
            print_this "LOCALIZE_KEY_WEBSITE_PASS" "[${1}@${2}]";
        else
            # Create account
            if [ "${7}" -eq 1 ]; then
               create_ssh_user "${1}" "${2}" "${3}" "${4}" "${5}" "${6}";
            fi
        fi
    }
    # -------------------------
    # 1->(index)
    get_ssh_public_key()
    {
        if [ -f "${HOME}/.ssh/known_hosts" ]; then
            if ! is_string_in_file "${HOME}/.ssh/known_hosts" "${1}" ; then # look for the key
                ssh-keyscan -t "${SSH_Keygen_Type}" "${1}" > /dev/null 2>&1 >> "${HOME}/.ssh/known_hosts"
            fi
        else
            ssh-keyscan -t "${SSH_Keygen_Type}" "${1}" > /dev/null 2>&1 >> "${HOME}/.ssh/known_hosts"
        fi
    }
    # -------------------------
    if [ ! -f "$HOME/.ssh/id_${SSH_Keygen_Type}.pub" ] ; then # $HOME is /root if su
        print_error "LOCALIZE_KEY_WEBSITE_KEY" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "LOCALIZE_KEY_WEBSITE_LINE_1";
        print_this "LOCALIZE_KEY_WEBSITE_LINE_2";
        print_this "LOCALIZE_KEY_WEBSITE_LINE_3";
        pause_function "$(gettext -s "LOCALIZE_KEY_WEBSITE_LINE_1")" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        if [ "$SSH_Keygen_Type" == "rsa" ]; then
            ssh-keygen -t rsa;
        else
            ssh-keygen -t dsa;
        fi
        Is_Ok="$?";
    fi
    # 1->(ssh USERNAME) 2->(ssh URL or IP address) 3->(ssh User Password) 4->(ssh root Password) 5->(App_Path) 6->(App_Folder) 7->(Create_User) 8->(Port: -p 22)
    # "${TestSshUser}" "${TestSshIP}" "$TestSshUserPassword" "$TestSshRootPassword" "$TestSshAppPath" "$TestSshAppFolder" "1" "${TestSshPort}"
    if is_online "${2}" ; then
        # mkdir -p "${Destination_PATH}/${Destination[$i]}/"
        #echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${User_Names[$i]}@${Domain_Name}"
        # ssh-copy-id -i ~/.ssh/id_rsa.pub "${TestSshUser}@${TestSshIP}"
        # Could not figure out how to do this, so I did it manually
        #echo -e \"yes\n$Passwords\n$Passwords\" | ssh-copy-id -i ~/.ssh/id_rsa.pub "${User_Names[$i]}@${Domain_Name}"
        # expect script
        # Public key ~/.ssh/id_dsa.pub
        # Private key ~/.ssh/id_dsa
        # Install for user
        #
        # Install a root key first
        if is_ssh_keyed "root@${2}" "${8}"; then
            print_test "LOCALIZE_KEY_WEBSITE_PASS" "[root@${2}]";
        else
            print_caution "LOCALIZE_KEY_WEBSITE_FAIL" "root@${2} -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            print_this "LOCALIZE_KEY_WEBSITE_LINE_3" ": root@${2}";
            #
            get_ssh_public_key "${2}";
            # 2->(ssh URL or IP address) 4->(ssh root Password) 8->(Port: -p 22)
            fix_tty "${2}" "${4}" "${8}";
            #
            if sshpass -p "${4}" ssh-copy-id -i "${HOME}/.ssh/id_${SSH_Keygen_Type}.pub" "root@${2}"; then
                print_test "LOCALIZE_KEY_WEBSITE_PASS" "root@${2}";
                Is_Ok=0;
            else
                ssh-keygen -R "${2}";    # May have reinstalled VM
                get_ssh_public_key "${2}"; # Get new Key
                if sshpass -p "${4}" ssh-copy-id -i "${HOME}/.ssh/id_${SSH_Keygen_Type}.pub" "root@${2}"; then
                    Is_Ok=0;
                else
                    print_warning "LOCALIZE_KEY_WEBSITE_FAIL" "root@${2} [password = ${4}] [key = ${HOME}/.ssh/id_${SSH_Keygen_Type}.pub] -> @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    write_error "LOCALIZE_KEY_WEBSITE_FAIL" "root@${2} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    pause_function "root@${2} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    Is_Ok=1;
                fi
            fi
            #
            if [ "${Is_Ok}" -eq 0 ] && [ "${7}" -eq 1 ]; then
                print_error "LOCALIZE_KEY_WEBSITE_USER" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                pause_function "$(gettext -s "LOCALIZE_KEY_WEBSITE_USER")" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                create_ssh_account "${1}" "${2}" "${3}" "${4}" "${5}" "${6}" "${7}";
                echo "Here ************************************ @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} ";
            fi
        fi
        # Now Key User
        if is_ssh_keyed "${1}@${2}" "${8}"; then
            print_test "LOCALIZE_KEY_WEBSITE_PASS" "[${1}@${2}]";
        else
            #
            if [ "${7}" -eq 1 ]; then
                create_ssh_account "${1}" "${2}" "${3}" "${4}" "${5}" "${6}" "$7";
            fi
            print_caution "LOCALIZE_KEY_WEBSITE_FAIL" "${HOME}/.ssh/id_${SSH_Keygen_Type}.pub -> ${1}@${2}";
            print_this "LOCALIZE_KEY_WEBSITE_LINE_3" ": ${1}@${2}";
            if sshpass -p "${3}" ssh-copy-id -i "${HOME}/.ssh/id_${SSH_Keygen_Type}.pub" "${1}@${2}"; then
                print_this "LOCALIZE_KEY_WEBSITE_PASS" "${1}@${2}";
            else
                print_warning "LOCALIZE_KEY_WEBSITE_FAIL" "${1}@${2}";
                write_error "LOCALIZE_KEY_WEBSITE_FAIL" "${1}@${2} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                pause_function "${1}@${2} : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                Is_Ok=1;
            fi
        fi
    else
        print_warning "LOCALIZE_KEY_WEBSITE_PING" "${2}";
        write_error "LOCALIZE_KEY_WEBSITE_PING ${2}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        pause_function "key_website : @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        Is_Ok=1;
    fi
    #echo "key_website end";
    return "$Is_Ok";
}
# -------------------------------------
test_key_website()
{
    ((TestCounter += 1));
    #
    print_caution "LOCALIZE_KEY_WEBSITE_TEST" "$(basename "${BASH_SOURCE[0]}") @ $(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    if is_ssh_keyed "${TestSshUser}@${TestSshIP}" "${TestSshPort}"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        if key_website "${TestSshUser}" "${TestSshIP}" "$TestSshUserPassword" "$TestSshRootPassword" "$TestSshAppPath" "$TestSshAppFolder" "0" "${TestSshPort}"; then
            if is_ssh_keyed "${TestSshUser}@${TestSshIP}" "${TestSshPort}"; then
                print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
            else
                print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
                read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
            fi
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
            read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
        fi
    fi
}
# END key_website
# -----------------------------------------------------------------------------
# BEGIN random_password
# -------------------------------------
# HELPBUILDER random_password
help_random_password()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_RANDOM_PASSWORD_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_RANDOM_PASSWORD_DESC")";
    NOTES="$(localize "LOCALIZE_RANDOM_PASSWORD_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="17 Apr 2013";
    REVISION="18 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER random_password
localize_random_password()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RANDOM_PASSWORD_USAGE"  "random_password 1->(number of characters; defaults to 32) 2->(include special characters; 1 = yes, 0 = no; defaults to 1)" "Comment: random_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RANDOM_PASSWORD_DESC"   "Generate a Random Password" "Comment: random_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_RANDOM_PASSWORD_NOTES"  "Uses sha256sum" "Comment: random_password @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
random_password()
{
    #local CHAR;
    #[ "${2}" == "0" ] && CHAR="[:alnum:]" || CHAR="[:graph:]";
    #cat /dev/urandom | tr -cd "$CHAR" | head -c ${1:-32};
    #echo "";
    date +%s | sha256sum | base64 | head -c "${1}" ; echo; # no Special Characters
}
# END random_password
# *************************************************************************** #
# BEGIN is_installed
# -------------------------------------
# HELPBUILDER is_installed
help_is_installed()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_IS_INSTALLED_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_IS_INSTALLED_DESC")";
    NOTES="$(localize "LOCALIZE_IS_INSTALLED_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="17 Apr 2013";
    REVISION="18 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER is_installed
localize_is_installed()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_IS_INSTALLED_USAGE"  "IS_INSTALLED 1->(programm) 2->(program to install) 3->(0=no install, 1=install) 4->(alternet installer: 0=normal, 1=alternate)" "Comment: IS_INSTALLED @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_INSTALLED_DESC"   "$(sub_string "${FUNCNAME[0]}" "localize_" 2) AppName" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_INSTALLED_NOTES"  "Checks to see if Application is installed." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_IS_INSTALLED_TITLE"  "Is App Installed" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_IS_INSTALLED_INFO"   "Chechs if Application is installed." "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# Checks to see if program is installed
# 1) MyProgramName=dialog, ...
is_installed()
{
    if [ $# -ne 4 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} @ ${FUNCNAME[1]}"; exit 1; fi

    if hash "${1}" 2>/dev/null; then
        return 0;
    else
        if [ "${3}" -eq 1 ]; then
            install_package_with "${2}" 0 1 "${4}";
            if hash "${1}" 2>/dev/null; then
                return 0;
            else
                return 1;
            fi
        else
            return 1;
        fi
    fi
}
# FIXME test
# if is_installed "" "" 1 0; then
# END is_installed
# *************************************************************************** #
# BEGIN select_file
# -------------------------------------
# HELPBUILDER select_file
help_select_file()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_SELECT_FILE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_SELECT_FILE_DESC")";
    NOTES="$(localize "LOCALIZE_SELECT_FILE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="17 Apr 2013";
    REVISION="18 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER select_file
localize_select_file()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SELECT_FILE_USAGE"  "select_file 1->(Filter)" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_FILE_DESC"   "select_file" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_FILE_NOTES"  "" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    localize_info "LOCALIZE_SELECT_FILE_TITLE"  "Load From File" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_FILE_INFO"   "Please choose a From File" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_FILE_TP"     "select_file Passed" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SELECT_FILE_TF"     "select_file Failed" "Comment: select_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
select_file()
{
    if ! is_installed "dialog" "dialog" 1 0; then
        print_error "install dialog" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        return 0;
        # FIXME install_this
    fi
    if dialog --stdout --title "$(gettext -s "LOCALIZE_SELECT_FILE_INFO")" --fselect "${1}" 21 80; then
       return 0;
    else
       return 1;
    fi
}
# -------------------------------------
test_select_file()
{
    ((TestCounter += 1));
    if select_file "$(pwd)"; then
        print_test "LOCALIZE_SELECT_FILE_TP" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_SELECT_FILE_TF" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
}
# END select_file
# *************************************************************************** #
# BEGIN install_package_with
# -------------------------------------
# HELPBUILDER install_package_with
help_install_package_with()
{
    USAGE="$(localize "LOCALIZE_INSTALL_PACKAGE_WITH_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_INSTALL_PACKAGE_WITH_DESC")";
    NOTES="$(localize "NONE")";
    AUTHOR="Flesher";
    VERSION="1.0";
    CREATED="11 Sep 2012";
    REVISION="5 Dec 2012";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO}";
}
# -------------------------------------
# LOCALIZER install_package_with
localize_install_package_with()
{
    localize_info "LOCALIZE_INSTALL_PACKAGE_WITH_USAGE" "install_package_with 1->(Package) 2->(Confirm [1=no-confirm]) 3->(Force) 4->(alternet install)" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INSTALL_PACKAGE_WITH_DESC"  "Install Package with Parametters" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INSTALL_PACKAGE_WITH_INFO"  "Installing Package with" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED"  "Installing Package with" "Comment: @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
install_package_with()
{
    [[ $# -ne 4 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Counted $# Parameters - Usage: ${FUNCNAME[0]}() 1->(Package) 2->(Confirm) 3->(Force) 4->(alternet install)"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    if [[ -z ${My_DIST} ]]; then os_info; fi
    print_info "LOCALIZE_INSTALL_PACKAGE_WITH_INFO" "${1}" "My_DIST=${My_DIST}";
    if [ "$REFRESH_REPO" -eq 1 ]; then
        REFRESH_REPO=0;
        if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
            sudo yum update;
        elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
            sudo pacman -Syy && abs;
        elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
            sudo apt-get update;
        elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
            print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
        elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
            print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
            # urpmi "${1}"
        elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
            print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
        fi
    fi
    #
    if [ "${My_DIST}" == "redhat" ]; then # -------------------------------- Redhat, Centos, Fedora
        if [ "${2}" -eq 0 ] && [ "$3" -eq 0 ]; then    # Confirm
            sudo yum install "${1}";
        elif [ "${2}" -eq 0 ] && [ "$3" -eq 1 ]; then  # Confirm and Force
            rpm -e --nodeps PACKAGE
            # or rpm -e --justdb --nodeps PACKAGE
            sudo yum install "${1}";
        elif [ "${2}" -eq 1 ] && [ "$3" -eq 1 ]; then  # No Confirm and Force
            rpm -e --nodeps PACKAGE
            # or rpm -e --justdb --nodeps PACKAGE
            sudo yum install "${1}" -y;
        elif [ "${2}" -eq 1 ] && [ "$3" -eq 0 ]; then  # No Confirm
            sudo yum install "${1}" -y;
        else                                       # Default No Confirm
            sudo yum install "${1}" -y;
        fi
    elif [ "${My_DIST}" == "archlinux" ]; then # --------------------------- My_PSUEDONAME = Archlinux Distros
        if [ "${4}" -eq 0 ]; then    # Alternat Installer
            if [ "${2}" -eq 0 ] && [ "$3" -eq 0 ]; then    # Confirm
                sudo pacman --needed -S "${1}";
            elif [ "${2}" -eq 0 ] && [ "$3" -eq 1 ]; then  # Confirm and Force
                sudo pacman --needed -S "${1}";
            elif [ "${2}" -eq 1 ] && [ "$3" -eq 1 ]; then  # No Confirm and Force
                sudo pacman --needed --noconfirm -S "${1}";
            elif [ "${2}" -eq 1 ] && [ "$3" -eq 0 ]; then  # No Confirm
                sudo pacman --needed --noconfirm -S "${1}";
            else
                sudo pacman --noconfirm --needed -S "${1}";   # Default No Confirm
            fi
        else
            if [ "${2}" -eq 0 ] && [ "$3" -eq 0 ]; then    # Confirm
                yay --needed -S "${1}";
            elif [ "${2}" -eq 0 ] && [ "$3" -eq 1 ]; then  # Confirm and Force
                yay --needed -S "${1}";
            elif [ "${2}" -eq 1 ] && [ "$3" -eq 1 ]; then  # No Confirm and Force
                yay --needed --noconfirm -S "${1}";
            elif [ "${2}" -eq 1 ] && [ "$3" -eq 0 ]; then  # No Confirm
                yay --needed --noconfirm -S "${1}";
            else
                yay --noconfirm --needed -S "${1}";   # Default No Confirm
            fi
        fi
    elif [ "${My_DIST}" == "debian" ]; then # ------------------------------ Debian: My_PSUEDONAME = Ubuntu, LMDE - Distros
        if [ "${2}" -eq 0 ] && [ "$3" -eq 0 ]; then    # Confirm
            sudo apt-get install "${1}";
        elif [ "${2}" -eq 0 ] && [ "$3" -eq 1 ]; then  # Confirm and Force
            sudo apt-get -f install "${1}";
        elif [ "${2}" -eq 1 ] && [ "$3" -eq 1 ]; then  # No Confirm and Force
            sudo apt-get -f -y install "${1}";
        elif [ "${2}" -eq 1 ] && [ "$3" -eq 0 ]; then  # No Confirm
            sudo apt-get -y install "${1}";
        else
            sudo apt-get -y install "${1}";   # Default No Confirm
        fi
    elif [ "${My_DIST}" == "unitedlinux" ]; then # ------------------------- My_PSUEDONAME = unitedlinux Distros
        print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
    elif [ "${My_DIST}" == "mandrake" ]; then # ---------------------------- My_PSUEDONAME = Mandrake Distros
        print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
        # urpmi "${1}"
    elif [ "${My_DIST}" == "suse" ]; then # -------------------------------- My_PSUEDONAME = Suse Distros
        print_error "LOCALIZE_DO_INSTALL_PACKAGE_WITH_UNSUPPORTED";
    fi
}
# END install_package_with
# *************************************************************************** #
# BEGIN isBreakable
isBreakable()
{
    local -x -i thisSetDebug=0;          # 0=No, 1=Yes
    if [ ${thisSetDebug} -eq 1 ]; then set -x; fi # Turn On Debug mode
    local -x Option1; Option1="$(to_lower_case "${1}")";
    local -x Option2; Option2="$(to_lower_case "${2}")";
    if [ ${thisSetDebug} -eq 1 ]; then set +x; fi # turn OFF debug mode
    if [ "${Option1}" == "${Option2}" ]; then
        return 0;
    else
        return 1;
    fi
    return 1; # Should never get here
}
# END isBreakable
# *************************************************************************** #
# BEGIN password_safe
# -------------------------------------
# HELPBUILDER password_safe
help_password_safe()
{
    ((HelpComplileCounter += 1));
    USAGE="$(localize "LOCALIZE_PASSWORD_SAFE_USAGE")";
    DESCRIPTION="$(localize "LOCALIZE_PASSWORD_SAFE_DESC")";
    NOTES="$(localize "LOCALIZE_PASSWORD_SAFE_NOTES")";
    AUTHOR="Jeffrey Scott Flesher";
    VERSION="1.0";
    CREATED="17 Apr 2013";
    REVISION="18 Apr 2013";
    create_help "$(sub_string "${FUNCNAME[0]}" "help_" 2)" "$USAGE" "$DESCRIPTION" "$NOTES" "$AUTHOR" "$VERSION" "$CREATED" "$REVISION" "$(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
}
# -------------------------------------
# LOCALIZER password_safe
localize_password_safe()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_PASSWORD_SAFE_USAGE"  "password_safe 1->(Text) 2->(Password) 3->(encrypt or decrypt)" "Comment: password_safe @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PASSWORD_SAFE_DESC"   "Password Safe allows you to send in Text and Password and encrypt or decrypt text using openssl." "Comment: password_safe @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_PASSWORD_SAFE_NOTES"  "" "Comment: password_safe @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# -------------------------------------
# 1: String to Encrypt/Decrypt
# 2: Password
# 3: encrypt or decrypt
password_safe()
{
    #local result;

    if [ "${3}" == "encrypt" ]; then
        #result = encrypt_str "${1}";
        echo -e "${1}" | openssl enc -aes-128-cbc -a -salt -pass pass:"${2}";
    else
        echo -e "${1}" | openssl enc -aes-128-cbc -a -d -salt -pass pass:"${2}";
        #result = encrypt_str "${1}";
    fi
}
# -------------------------------------
test_password_safe()
{
    ((TestCounter += 1));
    # FIXME ! cannot be in String unless its slashed \!
    local thisString; thisString='Abc123456*@#$%^&d|Password';
    local -a thisReturnStatus; thisReturnStatus=$(password_safe "${thisString}" "MyPassword" "encrypt" );
    if [[ $(password_safe "$thisReturnStatus" "MyPassword" "decrypt" ) == "${thisString}" ]]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        read -r -e -sn 1 -p "$(gettext -s "PRESS_ANY_KEY_CONTINUE")";
    fi
}
# END test_password_safe
# *************************************************************************** #
# 1: MyCommentState: C=Comment | U=Uncomment
# 2: MyCommentThis: String to Comment
# 3: MyCommentFile: /path/file.ext
# 4: MyPadding: "    "
# setHtmlComment "$CommentState" "$CommentThis" "$MyPadding" "$CommentFile";
setHtmlComment()
{
    # Test Number of arguments else die
    [[ $# -ne 4 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'CommentState: C=Comment | U=Uncomment' 'CommentThis: string to comment' 'MyPadding: Spaces required' 'CommentFile: full path and file name'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    # Parametter check before assigning var because one echo sed
    [[ -z ${1} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): CommentState (C=Comment, U=Uncomment)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    [[ -z ${2} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): CommentThis  (string to Comment)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    [[ -z ${4} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): CommentFile (/path/filename.ext)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    local MyCommentState;  MyCommentState=${1};
    local MyCommentThis;
    #MyCommentThis=$(echo "${2}" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g; s/\./\\\./g'); # Escape / sed 's/\//\\\//g' sed -e 's/[\/&]/\\&/g'
    MyCommentThis=$(echo "${2}" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g; s/!/\\\!/g; s/\./\\\./g');
    # sed "s/KEYWORD/$(echo $2 | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/g"
    local MyCommentFindThis; MyCommentFindThis="${2}"; # Not Escaped
    local MyPadding;         MyPadding="${3}";         # Rightside padding in string
    local MyCommentFile;     MyCommentFile="${4}";     # File to check
    local -i returnStatus;   returnStatus=0;           # 0=No Errors, 1=Errors
    local -i thisPrintDebug; thisPrintDebug=0;         # 1=true or 0=false
    local -i thisSetDebug;   thisSetDebug=0;           # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi    # Turn On Debug mode
    #
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_this "";
        print_this "*************************************";
        print_this "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "";
        print_this "MyCommentState=|${MyCommentState}|";
        print_this "MyCommentThis=|${MyCommentThis}|";
        echo "MyCommentFile=|${MyCommentFile}|";
        print_this "MyPadding=|${MyPadding}|";
        print_this "";
        get_stack "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "${STACK}";
        print_this "*************************************";
        print_this "";
    fi
    # Check if file exist
    if [ -f "${MyCommentFile}" ]; then
        # check to see if its commented
        [[ ${thisPrintDebug} -eq 1 ]] && { print_info "setHtmlComment(${MyCommentState} |<!-- ${MyCommentFindThis} -->|" "${FUNCNAME[0]}() : ${LINENO[0]}"; }
        if grep -Fxq -- "${MyPadding}<!-- ${MyCommentFindThis} -->" "${MyCommentFile}"; then
            # Commented
           [[ ${thisPrintDebug} -eq 1 ]] && { print_info "Found Commented: ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
            if [ "$MyCommentState" == "U" ]; then
                [[ ${thisPrintDebug} -eq 1 ]] && { print_info "Uncomment ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if sed -i "s/${MyPadding}<!-- ${MyCommentThis} -->/${MyPadding}${MyCommentThis}/g" "${MyCommentFile}" >/dev/null 2>&1; then
                    if grep -Fq -- "${MyPadding}<!-- ${MyCommentFindThis} -->" "${MyCommentFile}"; then
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Uncomment Failed ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        returnStatus=1;
                    fi
                else
                    returnStatus=1;
                fi
            fi
        else
            # Not Commented
            if grep -Fxq -- "${MyPadding}${MyCommentFindThis}" "${MyCommentFile}"; then
                # Found Not Commented
                [[ ${thisPrintDebug} -eq 1 ]] && { print_info "Found Uncommented: ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if [ "$MyCommentState" == "C" ]; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_info "Comment ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    if sed -i "s/${MyPadding}${MyCommentThis}/${MyPadding}<!-- ${MyCommentThis} -->/g" "${MyCommentFile}" >/dev/null 2>&1; then
                        if ! grep -Fq -- "${MyPadding}<!-- ${MyCommentFindThis} -->" "${MyCommentFile}"; then
                            [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Comment Failed ${MyCommentThis}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                            returnStatus=1;
                        fi
                    else
                        returnStatus=1;
                    fi
                fi # END if [ "$MyCommentState" == "C" ]; then
            fi # END if grep -Fxq -- "${MyPadding}${MyCommentFindThis}" "${MyCommentFile}"; then
        fi # END if grep -Fxq -- "${MyPadding}<!-- ${MyCommentFindThis} -->" "${MyCommentFile}"; then
    else
        print_error "LOCALIZE_FILE_NOT_FOUND" "MyCommentState=|${MyCommentState}| MyCommentThis=|${MyCommentThis}| MyCommentFile=|${MyCommentFile}| -> ${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
    fi
    #
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
    return "${returnStatus}";
}
# END setHtmlComment
# -------------------------------------
test_setHtmlComment()
{
    ((TestCounter += 1));
    #
    local thisFileName="test.xhtml";
    local SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local TargetPath="${TheFullScriptPath}/Support/Test/Target/";
    local MySourceFile="${SourcePath}${thisFileName}";
    local MyTargetFile="${TargetPath}${thisFileName}";
    local thisPrintDebug; thisPrintDebug=0;      # 1=Yes, 0=No
    local MyErrors; MyErrors=0;
    local -a CommentArray; CommentArray=();
    local -a CommentArraySpace; CommentArraySpace=();
    #
    if ! copy_file "${MySourceFile}" "${MyTargetFile}" "copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "copy_file in setHtmlComment @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
    #
    CommentArray[$((${#CommentArray[@]}))]='<?xml version="1.0"?>';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="";
    CommentArray[$((${#CommentArray[@]}))]='<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xml:lang="en" lang="en">';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="";
    CommentArray[$((${#CommentArray[@]}))]='<!DOCTYPE html>';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="";
    CommentArray[$((${#CommentArray[@]}))]='<html lang="en">';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="";
    CommentArray[$((${#CommentArray[@]}))]='<reference type="cover" title="Cover" href="cover.xhtml"></reference>';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="    ";
    CommentArray[$((${#CommentArray[@]}))]='<script async="async" src="1doc2rule.min.js"></script>';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="    ";
    CommentArray[$((${#CommentArray[@]}))]='<meta charset="utf-8" />';
    CommentArraySpace[$((${#CommentArraySpace[@]}))]="    ";
    #
    if [ -f "${MyTargetFile}" ]; then
        if [ "${#CommentArray[@]}" -ne 0 ]; then
            local -i index=0;
            for index in "${!CommentArray[@]}"; do
                [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Working on: ${CommentArray[${index}]} Space=|${CommentArraySpace[${index}]}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if grep -Fxq -- "${CommentArraySpace[${index}]}${CommentArray[${index}]}" "${MyTargetFile}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found Uncommented: |${CommentArray[${index}]}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    # Comment
                    if ! setHtmlComment "C" "${CommentArray[${index}]}" "${CommentArraySpace[${index}]}" "${MyTargetFile}"; then
                        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "U ${CommentArray[${index}]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        MyErrors=1;
                    fi
                elif grep -Fxq -- "${CommentArraySpace[${index}]}<!-- ${CommentArray[${index}]} -->" "${MyTargetFile}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found Commented: |${CommentArray[${index}]}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    # UnComment
                    if ! setHtmlComment "U" "${CommentArray[${index}]}" "${CommentArraySpace[${index}]}" "${MyTargetFile}"; then
                        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "setHtmlComment(C ${CommentArray[${index}]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                        MyErrors=1;
                    fi
                else
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Not Found: |${CommentArray[${index}]}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                fi
            done
            if [ "${MyErrors}" -eq 0 ]; then
                print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
            else
                print_error "LOCALIZE_TEST_FUNCTION_FAILED" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END test_setHtmlComment
# *************************************************************************** #
# 1: MySedThis: String to Search for
# 2: MySedThat: String to Replace Search with
# 3: MyPath: '/path/fileNameNoExt' or single mode "/path/fileName.ext"
# 4: MyFileExt: xhtml, css, js, and a special case of 1=Single File Mode
# sedThis "SedThis" "SedThat" "/path/FileNameNoExt" "xhtml";
# sedThis "SedThis" "SedThat" "/path/fileName.ext" "1";
sedThis()
{
    # Test Number of arguments else die
    [[ $# -ne 4 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() '' ''"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    # Parametter check before assigning var because one echo sed
    [[ -z ${1} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MySedThis (search for)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    [[ -z ${3} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyPath (/path/)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    [[ -z ${4} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyFileExt (ext: xhtml, css, js)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    #
    # sed -i 's|This/That|g' *.xhtml
    #                                                           backslash \  slash /      ampersand &  bang !     period .
    local MySedThis;         MySedThis=$(echo "${1}" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g; s/!/\\\!/g; s/\./\\\./g'); # Escape / s/>/\\\>/g;   sed 's/\//\\\//g' sed -e 's/[\/&]/\\&/g'
    local MyFindThis;        MyFindThis="${1}";  # Not Escaped
    local MySedThat;         MySedThat="";       # Can be Empty
    [[ -n "${2}" ]]          && { MySedThat=$(echo "${2}" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g; s/!/\\\!/g; s/\./\\\./g'); } # Escape / sed 's/\//\\\//g' sed -e 's/[\/&]/\\&/g'
    local MyFindThat;        MyFindThat="${MySedThat}";  # Not Escaped
    local MyPath;            MyPath="${3}";      # File Path
    local MyFileExt;         MyFileExt="${4}";   # File Extension
    local thisFileName;                          # Full Path and File Name
    local -i returnStatus;   returnStatus=0;     # 0=No Errors, 1=Errors
    local -i thisPrintDebug; thisPrintDebug=0;   # 1=true or 0=false
    local -i thisSetDebug;   thisSetDebug=0;     # 1=true or 0=false
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_this "";
        print_this "*************************************";
        print_this "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "";
        print_this "MySedThis  =|${MySedThis}|";  # 1
        print_this "MyFindThis =|${MyFindThis}|"; # 1
        print_this "MySedThat  =|${MySedThat}|";  # 2
        print_this "MyFindThat =|${MyFindThat}|"; # 2
        print_this "MyPath     =|${MyPath}|";     # 3
        print_this "MyFileExt  =|${MyFileExt}|";  # 4
        print_this "";
        get_stack "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "${STACK}";
        print_this "*************************************";
        print_this "";
    fi
    # Special case of 1=Single File Mode
    if [ "${MyFileExt}" == "1" ]; then
        [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -- \"${MySedThis}\" \"${MyPath}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
        if grep -q -- "${MySedThis}" "${MyPath}"; then
            [[ ${thisPrintDebug} -eq 1 ]] && { print_this "sed -i \"s/${MySedThis}/${MySedThat}/g\" ${MyPath} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
            if ! sed -i "s/${MySedThis}/${MySedThat}/g" "${MyPath}"; then
                returnStatus=1;
                print_error "Error in sedThis" "replace failed ${MySedThis} replace ${MySedThat} in file ${MyPath##*/} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
            # Check
            if [ -z ${1+x} ]; then
                if grep -Pq -- "${MySedThis}" "${MyPath}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                else
                    print_error "Error in sedThis" "replace not found ${MySedThat} in file ${MyPath} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    returnStatus=1;
                fi
            else
                if grep -Pq -- "${MySedThat}" "${MyPath}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                else
                    print_error "Error in sedThis" "replace not found ${MySedThat} in file ${MyPath} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    returnStatus=1;
                fi
            fi # END if [[ -z ${1} ]]; then
        fi # END if grep -q -- "${MySedThis}" "${MyPath}"; then
    else
        for thisFileName in "${MyPath}"*."${MyFileExt}"; do
            if [[ "${MyFindThis}" == "    " ]]; then
                # shellcheck disable=SC2028
                [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -- $'    ' \"${thisFileName}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if grep -q -- $'    ' "${thisFileName}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_this "sed -i $'s/    /    /g' ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                       if ! sed -i $'s/    /    /g' "${thisFileName}"; then
                        returnStatus=1;
                        print_error "Error in sedThis" "replace failed ${MySedThis} replace ${MySedThat} in file ${thisFileName##*/} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    fi
                      if grep -Pq -- $'    ' "${thisFileName}"; then
                           print_error "Error in sedThis" "replaceing Tab ${MySedThat} in file ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                           returnStatus=1;
                       else
                           [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                       fi
                fi # END if grep -q -- "${MySedThis}" "${thisFileName}"; then
            elif [[ "${MyFindThis}" == "[     ]*$" ]]; then # Clean Space end of Line
                # shellcheck disable=SC2028
                [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -- '[[:blank:]]$' \"${thisFileName}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if grep -q -- '[[:blank:]]$' "${thisFileName}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_this "sed -i $'s/[     ]*$//g' ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                       if ! sed -i $'s/[     ]*$//g' "${thisFileName}"; then
                        returnStatus=1;
                        print_error "Error in sedThis" "replace failed ${MySedThis} replace ${MySedThat} in file ${thisFileName##*/} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                    fi
                    #
                      if grep -Pq -- $'    ' "${thisFileName}"; then
                           print_error "Error in sedThis" "replaceing Tab ${MySedThat} in file ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                           returnStatus=1;
                       else
                           [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                       fi
                fi # END if grep -q -- "${MySedThis}" "${thisFileName}"; then
            else
                [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -- \"${MySedThis}\" \"${thisFileName}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if grep -q -- "${MySedThis}" "${thisFileName}"; then
                    [[ ${thisPrintDebug} -eq 1 ]] && { print_this "sed -i \"s/${MySedThis}/${MySedThat}/g\" ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    if ! sed -i "s/${MySedThis}/${MySedThat}/g" "${thisFileName}"; then
                        returnStatus=1;
                        print_error "Error in sedThis" "replace failed ${MySedThis} replace ${MySedThat} in file ${thisFileName##*/} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                       fi
                    # Check
                    if [[ -z ${1} ]]; then
                        if grep -Pq -- "${MySedThis}" "${thisFileName}"; then
                            [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        else
                            print_error "Error in sedThis" "replace not found ${MySedThat} in file ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                            returnStatus=1;
                        fi
                    else
                        if grep -Pq -- "${MySedThat}" "${thisFileName}"; then
                            [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Passed sedThis(${MySedThis}/${MySedThat})" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        else
                            if grep -Fq -- "${MySedThat}" "${thisFileName}"; then
                                print_error "Error in sedThis" "replace not found ${MySedThat} in file ${thisFileName} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                                returnStatus=1;
                            fi
                        fi
                    fi # END if [[ -z ${1} ]]; then
                fi # END if grep -q -- "${MySedThis}" "${thisFileName}"; then
            fi # END if [[ "${MyFindThis}" == "    " ]]; then
        done # END for thisFileName in "${MyPath}"*."${MyFileExt}"; do
    fi # END if [ "${MyFileExt}" == "1" ]; then
    #
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
    [[ ${thisPrintDebug} -eq 1 ]] && { print_test "End: sedThis" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
    return "${returnStatus}";
}
# END sedThis
# -------------------------------------
test_sedThis()
{
    ((TestCounter += 1));
    #
    local thisFileName;     thisFileName="test";
    local thisFileExt;      thisFileExt="xhtml";
    local SourcePath;       SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local TargetPath;       TargetPath="${TheFullScriptPath}/Support/Test/Target/";
    local MySourceFile;     MySourceFile="${SourcePath}${thisFileName}.${thisFileExt}";
    local MyTargetFile;     MyTargetFile="${TargetPath}${thisFileName}.${thisFileExt}";
    local thisPrintDebug;   thisPrintDebug=0;      # 1=Yes, 0=No
    local MyErrors;         MyErrors=0;
    local -a SearchArray;   SearchArray=();
    local -a ReplaceArray;  ReplaceArray=();
    local searchFor;
    # ensure this runs first: test_setHtmlComment
    if [ ! -f "${MySourceFile}" ]; then
        if ! copy_file "${MySourceFile}" "${MyTargetFile}" "copy_file @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; then
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "Could not copy file ${MySourceFile} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi
    fi
    # Create Search and Replace Array
    SearchArray[$((${#SearchArray[@]}))]="&apos;";        # apos
    ReplaceArray[$((${#ReplaceArray[@]}))]="&#39;";       # hex value
    #
    SearchArray[$((${#SearchArray[@]}))]="&nbsp;";        # nb space
    ReplaceArray[$((${#ReplaceArray[@]}))]="&#160;";      # hex value
    #
    SearchArray[$((${#SearchArray[@]}))]="<!-- <!--";     # double comment
    ReplaceArray[$((${#ReplaceArray[@]}))]="<!--";        # double comment
    #
    SearchArray[$((${#SearchArray[@]}))]="--> -->";       # double comment
    ReplaceArray[$((${#ReplaceArray[@]}))]="-->";         # double comment
    #
    SearchArray[$((${#SearchArray[@]}))]="\t";            # Tab
    ReplaceArray[$((${#ReplaceArray[@]}))]="${ThisTabSpace}"; # Defines spaces
    #
    SearchArray[$((${#SearchArray[@]}))]="[ \t]*$";       # End of Line Spaces
    ReplaceArray[$((${#ReplaceArray[@]}))]="";            # No Space is hard coded
    #
    #SearchArray[$((${#SearchArray[@]}))]='<?xml version="1.0"?>';    # End of Line Spaces
    #ReplaceArray[$((${#ReplaceArray[@]}))]='<?xml version="1.0" encoding="UTF-8" ?>';  # No Space is hard coded
    #
    SearchArray[$((${#SearchArray[@]}))]='<!-- <?xml version="1.0"?> -->';    # End of Line Spaces
    ReplaceArray[$((${#ReplaceArray[@]}))]='<!-- <?xml version="1.0" encoding="UTF-8" ?> -->';  # No Space is hard coded
    #
    SearchArray[$((${#SearchArray[@]}))]='<?xml version="1.0"?>';    # End of Line Spaces
    ReplaceArray[$((${#ReplaceArray[@]}))]='<?xml version="1.0" encoding="UTF-8" ?>';  # No Space is hard coded
    #
    SearchArray[$((${#SearchArray[@]}))]='<h1 class="a_header">';    # End of Line Spaces
    ReplaceArray[$((${#ReplaceArray[@]}))]='<span class="bignboldncenter">';  # No Space is hard coded
    #
    SearchArray[$((${#SearchArray[@]}))]='</h1>';    # End of Line Spaces
    ReplaceArray[$((${#ReplaceArray[@]}))]='</span>';  # No Space is hard coded
    #
    if [ -f "${MyTargetFile}" ]; then
        # Single File Mode
        if grep -Pq -- "<p>" "${MyTargetFile}"; then
            [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
            # sedThis
            if ! sedThis "<p>" '<p class="text_indent">' "${MyTargetFile}" "1"; then
                print_error "LOCALIZE_TEST_FUNCTION_FAILED" "Signle File Mode @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                MyErrors=1;
            fi
        else
           [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Not Found: |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
        fi # END if grep -Pq -- "${searchFor}" "${MyTargetFile}"; then
        # Multiply File Mode
        if [ "${#SearchArray[@]}" -ne 0 ]; then
            local -i index=0;
            for index in "${!SearchArray[@]}"; do
                searchFor=$(echo "${SearchArray[${index}]}" | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g; s/!/\\\!/g; s/\./\\\./g'); # s/>/\\\>/g;
                [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -P -- \"${searchFor}\" \"${MyTargetFile}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                if [[ "${SearchArray[${index}]}" == "    " ]]; then
                    # shellcheck disable=SC2028
                    [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -P -- $'    ' \"${MyTargetFile}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    if grep -Pq -- $'    ' "${MyTargetFile}"; then
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        # sedThis
                        if ! sedThis "${SearchArray[${index}]}" "${ReplaceArray[${index}]}" "${TargetPath}" "${thisFileExt}"; then
                            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "${SearchArray[${index}]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                            MyErrors=1;
                        fi
                    else
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Tab Not Found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    fi
                elif [[ "${SearchArray[${index}]}" == "[     ]*$" ]]; then # Clean Space end of Line
                    # shellcheck disable=SC2028
                    [[ ${thisPrintDebug} -eq 1 ]] && { echo "grep -P -- $'[     ]*$' \"${MyTargetFile}\" @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    if grep -Pq -- $'[     ]*$' "${MyTargetFile}"; then
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        # sedThis
                        if ! sedThis "${SearchArray[${index}]}" "${ReplaceArray[${index}]}" "${TargetPath}" "${thisFileExt}"; then
                            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "${SearchArray[${index}]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                            MyErrors=1;
                        fi
                    else
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Tab Not Found" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    fi
                else
                    if grep -Pq -- "${searchFor}" "${MyTargetFile}"; then
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_test "Found |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                        # sedThis
                        if ! sedThis "${SearchArray[${index}]}" "${ReplaceArray[${index}]}" "${TargetPath}" "${thisFileExt}"; then
                            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "${SearchArray[${index}]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
                            MyErrors=1;
                        fi
                    else
                        [[ ${thisPrintDebug} -eq 1 ]] && { print_error "Not Found: |${searchFor}|" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; }
                    fi # END if grep -Pq -- "${searchFor}" "${MyTargetFile}"; then
                fi # if [[ "${SearchArray[${index}]}" == "?" ]]; then
            done # END for index in "${!SearchArray[@]}"; do
            if [ "${MyErrors}" -eq 0 ]; then
                print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
            else
                print_error "LOCALIZE_TEST_FUNCTION_FAILED" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
            fi
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "SearchArray Empty@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        fi # END if [ "${#SearchArray[@]}" -ne 0 ]; then
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "File not Found ${MyTargetFile} @ $(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi # END if [ -f "${MyTargetFile}" ]; then
}
# END test_sedThis
# *************************************************************************** #
# 1: Image Path:
# isPngAlpha "/path/images/file.png";
isPngAlpha()
{
    # Test Number of arguments else die
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() '/path/images/file.png'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    # Parametter check before assigning var because one echo sed
    [[ -z ${1} ]]  && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyFile (/path/images/file.png)"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; return 1; }
    #                                                           backslash \  slash /      ampersand &  bang !     period .
    local MyFile;            MyFile="${1}";          # File Path and File Name.png
    local -i returnStatus;   returnStatus=0;         # 0=No Errors, 1=Errors
    local -i thisPrintDebug; thisPrintDebug=0;       # 1=true or 0=false
    local -i thisSetDebug;   thisSetDebug=0;         # 1=true or 0=false
    local thisID;
    if [ "${thisSetDebug}" -eq 1 ]; then set -x; fi  # Turn On Debug mode
    if [ "${thisPrintDebug}" -eq 1 ]; then
        print_this "";
        print_this "*************************************";
        print_this "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "";
        print_this "MyFile=|${MyFile}|";
        print_this "";
        get_stack "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
        print_this "${STACK}";
        print_this "*************************************";
        print_this "";
    fi
    #
    if ! is_installed "identify" "imagemagick" 1 1; then print_error "Install imagemagick" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; fi
    # not alpha: srgb or gray
    # alpha: srgba, lineargraya, graya
    # FIXME || or && srgba srgb
    thisID="$(identify -format '%[channels]' "${MyFile}")";

    case "${thisID}" in
           "srgba") ;&
     "lineargraya") ;&
           "graya") ;;
                 *) return 1; ;;
    esac
#    if [ "${thisID}" != "srgb" ] && [ "$thisID" != "srgba" ] && [ "$thisID" != "gray" ]; then
#        returnStatus=1;
#    fi
    #
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
    return 0;
}
# END isPngAlpha
# -------------------------------------
test_isPngAlpha()
{
    ((TestCounter += 1));
    #
    local thisFileNameA;        thisFileNameA="imageAlpha.png";
    local thisFileNameNA;       thisFileNameNA="imageNoAlpha.png";
    local SourcePath;           SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local thisPrintDebug;       thisPrintDebug=0;      # 1=Yes, 0=No
    # Check Non-Alpha
    if isPngAlpha "${SourcePath}${thisFileNameNA}"; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "File is Not an Alpha ${SourcePath}${thisFileNameNA}: $(identify -format '%[channels]' "${SourcePath}${thisFileNameNA}") @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    fi
    # Check Alpha
    if ! isPngAlpha "${SourcePath}${thisFileNameA}"; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "File is an Alpha ${SourcePath}${thisFileNameA}: $(identify -format '%[channels]' "${SourcePath}${thisFileNameA}") @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    else
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)():${LINENO[0]}";
    fi
    # end
}
# END test_isPngAlpha
# *************************************************************************** #
# 1: Status
# 2: Progress
# printProgress "Running" "total" "myPercent";
# ---------------------------------------
declare -x TermScreenAfter; TermScreenAfter="\033[0J"; # Move to location
declare -x TermLineBefore;  TermLineBefore="\033[1K";  # Erase Current Line
#declare -x TermLineAfter;  TermLineAfter="\033[0K";   # Erase Current Line
declare -x TermUp;          TermUp="\033[1A";          # Move up 1 Line
declare -x TermUpCount;     TermUpCount=2;             #
declare -x TermMessages;    TermMessages="\n";         #
declare -x TermProgress;    TermProgress="";           #
declare -x TermSpace;       TermSpace="    ";            # Default: 1 Tab
#
printProgress()
{
    # Test Number of arguments else die
    [[ $# -ne 3 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Status' 'Progress'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    #
    local myMessage;            myMessage="${1}";         # First time must be the Message, after that its blank
    local -i myProgressTotal;   myProgressTotal="${2}";   # Total
    local -i myProgressPercent; myProgressPercent="${3}"; # Current Number
    #
    local thisStatus; thisStatus="[          ] 0%";
    local thisPercentage;
    local thisCalPercentage;
    # ---------------------------------------
    # 1: Command to echo
    # 2: Count
    termReset()
    {
        [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Count' 'Terminal Code UP'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
        local myCount; myCount="${2}"
        while (( myCount )); do
            echo -en "${1}";
            (( myCount-- ));
        done
    }
    # ---------------------------------------
    termUpdateStatus()
    {
        # Move Up Number of Lines
        termReset "${TermUp}" "${TermUpCount}";
        # Move to location, Erase Line, and back up
        echo -en "${T_Clear_BOL}${T_Reset}${MenuTheme[0]}${MenuTheme[7]}${TermLineBefore}" "${TermScreenAfter}" "\r";
        #echo -en "${T_Clear_BOL}${TermLineBefore}" "${TermScreenAfter}" "\r";
        # Print Message
        echo -en "${TermMessages}";
        # Print Progress
        echo -e "${T_Clear_BOL}${TermSpace}${TermProgress}${T_Clear_EOL}";
    }
    # ---------------------------------------
    # 1: Message
    termAddMessage()
    {
        [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Message'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
        TermMessages+="${TermSpace}${1}\n";
        (( TermUpCount++ ));
    }
    # ---------------------------------------
    # 1: Progress
    termSetProgress()
    {
        [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Progress'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
        TermProgress="${1}";
        termUpdateStatus;
    }
    # ---------------------------------------
    # If not empty add a message
    if [[ -n "${myMessage}" ]]; then
        TermUpCount=2;
        TermMessages="\n";
        TermProgress="";
        termAddMessage "${myMessage}";
        termReset "\n" ${TermUpCount};
    fi
    # Make sure you do not divide by 0
    if [ "${myProgressPercent}" -gt 0 ] && [ "${myProgressTotal}" -gt 0 ]; then
        thisCalPercentage="$(bc <<< "scale=1;(${myProgressPercent} / ${myProgressTotal}) * 100")";
        thisPercentage=${thisCalPercentage%.*}
    else
        thisPercentage=0;
    fi
    #
    if [ "${thisPercentage}" -gt 1 ] && [ "${thisPercentage}" -lt 11 ]; then   # 10%
        thisStatus="[#         ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 9 ] && [ "${thisPercentage}" -lt 21 ]; then # 20%
        thisStatus="[##        ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 19 ] && [ "${thisPercentage}" -lt 31 ]; then # 30%
        thisStatus="[###       ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 39 ] && [ "${thisPercentage}" -lt 41 ]; then # 40%
        thisStatus="[####      ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 49 ] && [ "${thisPercentage}" -lt 51 ]; then # 50%
        thisStatus="[#####     ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 59 ] && [ "${thisPercentage}" -lt 61 ]; then # 60%
        thisStatus="[######    ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 69 ] && [ "${thisPercentage}" -lt 71 ]; then # 70%
        thisStatus="[#######   ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 79 ] && [ "${thisPercentage}" -lt 81 ]; then # 80%
        thisStatus="[########  ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 89 ] && [ "${thisPercentage}" -lt 91 ]; then # 90%
        thisStatus="[######### ] ${thisPercentage}%";
    elif [ "${thisPercentage}" -gt 99 ] && [ "${thisPercentage}" -lt 101 ]; then # 100%
        thisStatus="[##########] ${thisPercentage}%";
    fi
    #
    termSetProgress "${thisStatus}";
    #
}
# END printProgress
# -------------------------------------
test_printProgress()
{
    ((TestCounter += 1));
    #
    print_test "test_printProgress 1 Start";

    local -i total;     total=10;
    local -i myPercent; myPercent=0;
    printProgress "Running" "${total}" "${myPercent}";
    for (( myPercent=0; myPercent<total; myPercent++ )); do
        printProgress "" "${total}" "${myPercent}";
        sleep 1;
    done
    printProgress "" "${total}" "${total}";

    print_test "test_printProgress 2 Start";

    printProgress "Running Test 2" "${total}" "${myPercent}";
    for (( myPercent=0; myPercent<total; myPercent++ )); do
        printProgress "" "${total}" "${myPercent}";
        sleep .01;
    done
    printProgress "" "${total}" "${total}";

    print_test "test_printProgress End";
}
# END test_printProgress
# *************************************************************************** #
# 1. MyPath ends in /
# imageCount "/path/";
declare -a ImageExtNames; ImageExtNames=();
ImageExtNames[$((${#ImageExtNames[@]}))]='png';
ImageExtNames[$((${#ImageExtNames[@]}))]='jpg';
ImageExtNames[$((${#ImageExtNames[@]}))]='tif';
ImageExtNames[$((${#ImageExtNames[@]}))]='tiff';
ImageExtNames[$((${#ImageExtNames[@]}))]='gif';
ImageExtNames[$((${#ImageExtNames[@]}))]='jpeg';
ImageExtNames[$((${#ImageExtNames[@]}))]='jif';
ImageExtNames[$((${#ImageExtNames[@]}))]='jfif';
ImageExtNames[$((${#ImageExtNames[@]}))]='jp2';
ImageExtNames[$((${#ImageExtNames[@]}))]='jpx';
ImageExtNames[$((${#ImageExtNames[@]}))]='j2k';
ImageExtNames[$((${#ImageExtNames[@]}))]='j2c';
ImageExtNames[$((${#ImageExtNames[@]}))]='fpx';
ImageExtNames[$((${#ImageExtNames[@]}))]='pcd';
ImageExtNames[$((${#ImageExtNames[@]}))]='pdf';
ImageExtNames[$((${#ImageExtNames[@]}))]='webp';
ImageExtNames[$((${#ImageExtNames[@]}))]='svg';
ImageExtNames[$((${#ImageExtNames[@]}))]='ai';
ImageExtNames[$((${#ImageExtNames[@]}))]='eps ';
#
imageCount()
{
    [[ $# -ne 1 ]]     && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() config_Menu switch @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    local MyPath; MyPath=${1};
    [[ -z ${MyPath} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyPath @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }

    local -i thisImageCount=0;
    local -i index;
    local thisFileName;
    #
    for index in "${!ImageExtNames[@]}"; do
        # shellcheck disable=SC2034
        for thisFileName in "${MyPath}"*."${ImageExtNames[${index}]}"; do ((thisImageCount++)); done
    done
    echo "${thisImageCount}";
}
# END imageCount
# -------------------------------------
test_imageCount()
{
    ((TestCounter += 1));
    #
    print_test "Image Count Test";
    local -i thisImageCount; thisImageCount=0;
    local SourcePath="${TheFullScriptPath}/Support/Test/Source/";
    local -i index;
    thisImageCount="$(imageCount "${SourcePath}")";
    if [ "${thisImageCount}" -gt 0 ]; then
        print_test "imageCount  returns ${thisImageCount} image files in this folder";
    else
        print_error "imageCount  returns ${thisImageCount} image files in this folder";
    fi
    ls "${SourcePath}";
}
# END test_imageCount

# #############################################################################
#
getImageWidth()
{
    [[ $# -ne 1 ]]      && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    local MyImage; MyImage="${1}";   # Image Link
    [[ -z ${MyImage} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    #
    if [ -f "${MyImage}" ]; then
        #echo "$(identify -ping -format '%w' "${MyImage}")";
        identify -ping -format '%w' "${MyImage}"
    else
        print_error "File Not Found ${MyImage}"
    fi
}
#
getImageHeight()
{
    [[ $# -ne 1 ]]      && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    local MyImage; MyImage="${1}";   # Image Link
    [[ -z ${MyImage} ]] && { print_error "LOCALIZE_NAME_NOT_SPECIFIED"  "${FUNCNAME[0]}(): MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    # MyImage="${TheWorkSpace}/Support/Test/Source/imageNoAlpha.png"
    if [ -f "${MyImage}" ]; then
        #echo "$(identify -ping -format '%h' "${MyImage}")";
        identify -ping -format '%h' "${MyImage}"
    else
        print_error "File Not Found ${MyImage}"
    fi
}
# -------------------------------------
test_imageWidthHeight()
{
    ((TestCounter += 1));
    #
    print_test "Image Width and Height Test";
    local SourcePath; SourcePath="${TheFullScriptPath}/Support/Test/Source/imageNoAlpha.png"; # imageAlpha.png
    local MyWidth;  MyWidth="$(getImageWidth   "${SourcePath}")";
    local MyHeight; MyHeight="$(getImageHeight "${SourcePath}")";
    # MyWidth 333
    if [ -z ${MyWidth+x} ]; then
        print_error "getImageWidth Null"
    elif [ "${MyWidth}" -eq 0 ]; then
        print_error "getImageWidth returns ${MyWidth}";
    elif [ "${MyWidth}" -eq 333 ]; then
        print_test "getImageWidth returns ${MyWidth} expected 333";
    fi
    # MyHeight 333
    if [ -z ${MyHeight+x} ]; then
        print_error "getImageHeight Null"
    elif [ "${MyHeight}" -eq 0 ]; then
        print_error "getImageHeight returns ${MyHeight}";
    elif [ "${MyHeight}" -eq 333 ]; then
        print_test "getImageHeight returns ${MyHeight} expected 333";
    fi
}
# END test_imageWidthHeight
# -------------------------------------
#
declare -x SqliteDb;
declare -x SqliteDbPath;
declare -x SqlStatement;
declare -x SqlReturnRecord;
declare -x SqlRecordCount;
#
#
test_Sqlite()
{
    ((TestCounter += 1));
    #
    print_test "Test SQLite Database" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    #
    local dbPath; dbPath="${TheFullScriptPath}/Support/Test/Target/";
    # Database needs a full Path and File Name
    local db; db="test.db";
    #
    # Setup a Bash SQLite Function Library
    local tableName; tableName="Users";
    # Setter for SqliteDb, Source Path and Table Name make SqliteDb, its set internally: SqliteDb="${db}";
    sqlDb "${dbPath}" "${db}";
    #
    # Data Storage types in SQLite
    # NULL, INTEGER, REAL, TEXT, BLOB
    # FirstName, LastName, email
    #
    SqlStatementBuilder ""; # Empty it first
    SqlStatementBuilder "[ID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,";
    SqlStatementBuilder "[FirstName] TEXT NOT NULL,";
    SqlStatementBuilder "[LastName] TEXT NOT NULL,";
    SqlStatementBuilder "[email] TEXT NOT NULL UNIQUE";
    # Table Name, SQL Statment and 1 to delete database before adding table, use carefully
    sqlCreateDb "${tableName}" "${SqlStatement}" 1;
    if [ "${SqlReturnRecord}" == "" ]; then print_test "Passed sqlCreateDb" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlCreateDb" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
    if [ -f "${SqliteDbPath}${SqliteDb}" ]; then
        print_test "Database Created" "@ $(basename "${BASH_SOURCE[0]}") ${FUNCNAME[0]}() : ${LINENO[0]}";
        SqlStatementBuilder ""; # Empty it first
        if [[ -n "${SqlStatement}" ]]; then
            print_error "SqlStatement=|${SqlStatement}|";
        fi
        SqlStatementBuilder "";
        SqlStatementBuilder "INSERT INTO ${tableName} (";
        SqlStatementBuilder "FirstName,";
        SqlStatementBuilder "LastName,";
        SqlStatementBuilder "email";
        SqlStatementBuilder ") VALUES (";
        SqlStatementBuilder "'John',";
        SqlStatementBuilder "'Doe',";
        SqlStatementBuilder "'john.doe@lost.org'";
        SqlStatementBuilder ");";
        sqlInsert "${SqlStatement}";
        if [ "${SqlReturnRecord}" == "" ]; then print_test "Passed sqlInsert" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlInsert" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
        #
        SqlStatementBuilder "";
        SqlStatementBuilder "INSERT INTO ${tableName} (";
        SqlStatementBuilder "FirstName,";
        SqlStatementBuilder "LastName,";
        SqlStatementBuilder "email";
        SqlStatementBuilder ") VALUES (";
        SqlStatementBuilder "'Jane',";
        SqlStatementBuilder "'Dough',";
        SqlStatementBuilder "'jane.doe@lost.org'";
        SqlStatementBuilder ");";
        sqlInsert "${SqlStatement}";
        if [ "${SqlReturnRecord}" == "" ]; then print_test "Passed sqlInsert" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlInsert" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
        #
        sqlSelect "SELECT * FROM  ${tableName}";
        if [ "${SqlRecordCount}" -eq 2 ]; then print_test "Passed sqlSelect: Count expect: 2: got: ${SqlRecordCount}" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlUpdate" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
        sqlUpdate "UPDATE ${tableName} SET LastName = 'Doe' WHERE ID = 2;"
        if [ "${SqlReturnRecord}" == "" ]; then print_test "Passed sqlUpdate" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlUpdate" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
        sqlSelect "SELECT * FROM  ${tableName}";

        sqlDelete "DELETE FROM ${tableName} WHERE ID = 1;"
        if [ "${SqlReturnRecord}" == "" ]; then print_test "Passed sqlDelete" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlDelete" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
        sqlSelect "SELECT * FROM  ${tableName}";
        if [ "${SqlRecordCount}" -eq 1 ]; then print_test "Passed sqlSelect: Count expect: 1: got: ${SqlRecordCount}" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; else print_error "Fail sqlUpdate" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}"; fi
    else
        print_error "Database Not Found" "@ $(basename "${BASH_SOURCE[0]}") ${FUNCNAME[0]}() : ${LINENO[0]}";
    fi
}
# END test_Sqlite
# FIXME Test
# *************************************************************************** #
# Returns 0=True this Variable is either unset=0, set and empty=1, and 1 if set and not empty=2
declare -ix ThisVarState; ThisVarState=0;
# if ! checkIsEmpty "${UserBashFile-}"; then echo "Not Empty: State=${ThisVarState}"; fi
checkIsEmpty()
{
    if [ -n "${1-}" ]; then
        ThisVarState=2;
        # echo 'set and not empty'
        return 1;
    elif [ "${1+defined}" = defined ]; then
        ThisVarState=1;
        # echo 'set and empty'
        return 0;
    else
        ThisVarState=0;
        # echo 'unset'
        return 0;
    fi
}
# FIXME Test
# *************************************************************************** #
getValueLastDot()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    echo "${1##*.}";
}
# FIXME Test
# *************************************************************************** #
version_clean()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    #
    local thisNum;
    if [ -n "$1" ]; then
        if [[ "$1" != *"."* ]]; then
            thisNum="$(trim "$1")";
            thisNum="${thisNum//[!0-9]/}";
            thisNum="${thisNum##+(0)}";
            thisNum="$((10#${thisNum}))";
            thisNum="$((thisNum+0))";
            echo "$thisNum";
            return 0;
        fi

    fi
    #
    #
    local old_IFS; old_IFS="$IFS";
    local thisVersion; thisVersion="";
    local -i isFirst; isFirst=0;
    export IFS=".";
    for word in $1; do
        if [ -n "$word" ]; then
            thisNum="$(trim "$word")";
            thisNum="${thisNum//[!0-9]/}";
            thisNum="${thisNum##+(0)}";
            thisNum="$((10#${thisNum}))";
            thisNum="$((thisNum+0))";
            if [ "$isFirst" -eq 0 ]; then
                isFirst=1;
                thisVersion="$thisNum";
            else
                thisVersion="${thisVersion}.$thisNum";
            fi
        else
                thisVersion="${thisVersion}.0";
        fi
    done
    #
    IFS="$old_IFS";
    local thisDot; thisDot="${thisVersion//[^.]}";
    thisDot="${#thisDot}"
    #
    for (( i=0; i<thisDot; i++ )); do
        # 1.0.0
        if [ "$(getValueLastDot $thisVersion)" == "0" ]; then
            thisVersion="${thisVersion%.*}";
        fi
    done
    #
    echo "${thisVersion}";
}
# FIXME Test
# *************************************************************************** #
version_gt()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";
}
# *************************************************************************** #
version_e()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" == "$1";
}
# *************************************************************************** #
compare_versions()
{
    [[ $# -ne 3 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() MyImage @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}"; pause_function "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]} "; exit 1; }

    local firstVersion;   firstVersion="$(version_clean "$1")";
    local secondVersion; secondVersion="$(version_clean "$2")";
    # Equal
    if [ "$3" == "=" ] || [ "$3" == "eq" ]; then
        if version_e  "${firstVersion}" "${secondVersion}"; then return 0; fi
    fi
    # Greater than
    if [ "$3" == ">" ] || [ "$3" == "gt" ]; then
        if version_gt "${firstVersion}" "${secondVersion}"; then return 0; fi
    fi
    # Less than
    if [ "$3" == "<" ] || [ "$3" == "lt" ]; then
        if version_gt "${secondVersion}" "${firstVersion}"; then return 0; fi
    fi
    # Less than or =
    if [ "$3" == "<=" ] || [ "$3" == "le" ]; then
        if version_gt "${secondVersion}" "${firstVersion}"; then
            if version_e  "${firstVersion}" "${secondVersion}"; then return 0; fi
        fi
    fi
    # Greater than or =
    if [ "$3" == ">=" ] || [ "$3" == "ge" ]; then
        if version_gt "${firstVersion}" "${secondVersion}"; then
            if version_e  "${firstVersion}" "${secondVersion}"; then return 0; fi
        fi
    fi
    #
    return 1;
}
# *************************************************************************** #
#
testcompare_versions()
{
    print_test "Compare Versions: [$1=$(version_clean "$1")] ($3) [$2=$(version_clean "$2")]" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    if compare_versions "$1" "$2" "$3"; then
        print_test "Pass: $1 $3 $2" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "FAIL: Expected $3, Actual op, Arg1 $1, Arg2 $2" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END compare_versions
# -------------------------------------
test_compare_versions()
{
    ((TestCounter += 1));
    #
    print_test "The following tests should pass" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    local -a sourceComp; sourceComp=("1" "2.1" "3.0.4.10" "4.08"    "3.2.1.9.8144" "3.2"           "1.2" "2.1" "5.6.7" "1.01.1" "1.1.1"  "1"   "1.0" "1.0.2.0" "1..0" "1.0");
    local -a targetComp; targetComp=("1" "2.2" "3.0.4.2"  "4.08.01" "3.2"          "3.2.1.9.8144"  "2.1" "1.2" "5.6.7" "1.1.1"  "1.01.1" "1.0" "1"   "1.0.2"   "1.0"  "1..0");
    local -a compOp;         compOp=("=" "<"   ">"        "<"       ">"            "<"             "<"   ">"   "="     "="      "="      "="   "="   "="       "="    "=");
    local i;
    for ((i=0; i<${#sourceComp[@]}; i++)); do
        testcompare_versions "${sourceComp["$i"]}" "${targetComp["$i"]}" "${compOp["$i"]}";
    done
}
# END test_compare_versions
###############################################################################
#
# ls -i "${TheWorkSpace}/Support/Test/Source/README.md" | cut -d " " -f1;
get_File_Inode()
{
    if [ $# -ne 1 ] ; then print_error "1->(Full-Path)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local thisFile; thisFile="$1";
    # shellcheck disable=SC2012
    ls -i "$thisFile" | cut -d " " -f1;
}
# -------------------------------------
test_get_File_Inode()
{
    ((TestCounter += 1));
    #
    if [ -z ${TheWizardPath+x} ]; then
        TheWizardPath="${TheFullScriptPath}";
        echo "TheWizardPath=$TheWizardPath";
    fi
    ThisTestFile="${TheWizardPath}/Support/Test/Source/README.md";
    if [ "$(get_File_Inode "$ThisTestFile")" -eq "619315907" ]; then # Fill in value of known file above
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# #############################################################################
# BEGIN dobeep
# The Speaker Beep is on the motherboard and not really used nowadays
do_Beep()
{
    if type aplay; then
        aplay "${TheFullScriptPath}/beep-02.wav";
    fi
}
# -------------------------------------
test_do_Beep()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest="";
    if do_Beep "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME Test
# END dobeep
###############################################################################
get_FileName()
{
    if [ $# -ne 1 ] ; then print_error "The Files full Path and Name.Ext" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local thisFile; thisFile=$(basename "${1}"); # File Name.Extenion
    thisFile=${thisFile%.*};             # File Name
    echo "$thisFile";
}
# -------------------------------------
test_get_FileName()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md"
    local thisTest; thisTest="";
    if get_FileName "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
export -f get_FileName;
# FIXME Test
###############################################################################
get_FilePath()
{
    if [ $# -ne 1 ] ; then print_error "The Files full Path and Name.Ext" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    dirname "${1}";
}
# -------------------------------------
test_get_FilePath()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md"
    local thisTest; thisTest="";
    if get_FilePath "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME Test
###############################################################################
get_FileExtension()
{
    if [ $# -ne 1 ] ; then print_error "The Files full Path and Name.Ext" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    echo "${1##*.}";
}
# -------------------------------------
test_get_FileExtension()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md"
    local thisTest; thisTest="md";
    if [ "$(get_FileExtension "$ThisTestFile")" == "$thisTest" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME Test
# #############################################################################
# getHorizontalLineType (0=Text, 1=HTML)
declare TheLine; TheLine="*******************************************************************************";
declare TheLineHR; TheLineHR="<hr />";
get_Horizontal_LineType()
{
    if [ "$1" -eq 0 ]; then echo "$TheLine"; else echo "$TheLineHR"; fi
}
# -------------------------------------
test_get_Horizontal_LineType()
{
    ((TestCounter += 1));
    #
    if [ "$(get_Horizontal_LineType 0)" == "$TheLineHR" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    #
    if [ "$(get_Horizontal_LineType 1)" == "$TheLine" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME Test
# #############################################################################
declare TheHtmlStartTage; TheHtmlStartTage="<p>";
declare TheHtmlEndTage;   TheHtmlEndTage="</p>";
# fixLineType (0=text, 1=HTML) "Text"
fix_LineType()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    local pStart;
    local pEnd;
    if [ "$1" -eq 0 ]; then pStart=""; pEnd=""; else pStart="${TheHtmlStartTage}"; pEnd="${TheHtmlEndTage}"; fi
    printf "%s%s%s\n" "${pStart}" "${2}" "${pEnd}";
}
# -------------------------------------
test_fix_LineType()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest="This";
    if [ "$(fix_LineType "$thisTest" 0)" == "$thisTest" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    #
    if [ "$(fix_LineType "$thisTest" 1)" == "${TheHtmlStartTage}${thisTest}${TheHtmlEndTage}" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME Test
# #############################################################################
declare ThisTestFileFolder; ThisTestFileFolder="Test.video-265";
#
# Make a Test folder to test remove spaces
# make_Rename_Test RootFolder
make_Rename_Test()
{
    if [ $# -ne 1 ] ; then print_error "Root Path to Foler to use for Test" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local RootFolder; RootFolder="${1}";
    find "${RootFolder}/${ThisTestFileFolder}" -mindepth 1 -name "*" -print0 | xargs -0 rm -rf;
    if [ ! -d "${RootFolder}/${ThisTestFileFolder}" ]; then mkdir -p "${RootFolder}/${ThisTestFileFolder}"; fi
    if [ "${PWD}" != "${RootFolder}/${ThisTestFileFolder}" ]; then
        if ! cd "${RootFolder}/"; then echo "failed to cd"; exit 1; fi # FIXME
        if ! cd cd "${RootFolder}/${ThisTestFileFolder}/"; then echo "failed to cd"; exit 1; fi # FIXME
    fi
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/FileNoSpace.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    mkdir -p "${RootFolder}/${ThisTestFileFolder}/DirNoSpace";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/DirNoSpace/FileNoSpace.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/DirNoSpace/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    mkdir -p "${RootFolder}/${ThisTestFileFolder}/Dir With Space";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Dir With Space/FileNoSpace.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Dir With Space/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME

    mkdir -p "${RootFolder}/${ThisTestFileFolder}/Depth-1";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Depth-1/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    mkdir -p "${RootFolder}/${ThisTestFileFolder}/Depth-1/Depth-2";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Depth-1/Depth-2/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    mkdir -p "${RootFolder}/${ThisTestFileFolder}/Depth-1/Depth-2/Depth-3";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Depth-1/Depth-2/Depth-3/File With Space.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    #
    mkdir -p "${RootFolder}/${ThisTestFileFolder}/Test-RenameThis";
    if ! cp "${RootFolder}/Test.Support/Circle.illusion.mp4" "${RootFolder}/${ThisTestFileFolder}/Test-RenameThis/Test-RenameThis.mp4"; then echo "failed to cp"; exit 1; fi # FIXME
    return 0;
}
# -------------------------------------
test_make_Rename_Test()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Target/RenameTest/";
    if make_Rename_Test "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# FIXME test
# END make_Rename_Test
# #############################################################################
# rename_this 1->(Folder) 2->(this to rename) 3->(rename to this)
rename_this()
{
    if [ $# -ne 3 ] ; then print_error "rename_this 1->(Folder) 2->(this to rename) 3->(rename to this)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
#    local thisFolder; thisFolder="$1";
#    local thisRename; thisRename="$2";
#    local thatRename; thatRename="$3";
    local thisIFS; thisIFS="$IFS";

    # FIXME
#    for i in $(find "$thisFolder" -iname "${thisRename}*") ; 
#        # shellcheck disable=SC2001
#        do mv "$i" "$(echo "$i" | sed -e "s/${thisRename}//${thatRename}")"; 
#    done

#    while IFS= read -r -d '' file; do
#        # shellcheck disable=SC2001
#        do mv "$i" "$(echo "$i" | sed -e "s/${thisRename}//${thatRename}")"; 
#    done <   <(find "$thisFolder"  -iname "${thisRename}*" -print0)

#    find "$thisFolder" ! -name "$(printf "*\n*")" -name "*${thisRename}*" > thisTmpFile;
#    while IFS= read -r file; do
#        # shellcheck disable=SC2001
#        do mv "$file" "$(echo "$i" | sed -e "s/${thisRename}//${thatRename}")"; 
#    done < thisTmpFile
#    rm thisTmpFile;

    IFS="$thisIFS";
    return 0;
}
# -------------------------------------
test_rename_this()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Target/RenameTest/"
    #
    if make_Rename_Test "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    
    #
    if rename_this "${RootFolder}/${ThisTestFileFolder}/Test-RenameThis/" "RenameThis" "RenameThat"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    #
    if [ ! -f "${RootFolder}/${ThisTestFileFolder}/Test-RenameThat/Test-RenameThat.mp4" ]; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END rename_this
# #############################################################################
#
# Rename all files that have spaces to a variable
# Replace illegal or unwanted characters
#
rename_Space()
{
    if [ $# -ne 1 ] ; then print_error "String to Rename without Space" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if is_installed "detox" "detox" 1 0; then detox -rv "${1}"; fi
    #
}
# -------------------------------------
test_rename_Space()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Target/RenameTest/"
    local thisTest; thisTest="";
    if make_Rename_Test "$ThisTestFile"; then
        if rename_Space "$ThisTestFile"; then
            print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        else
            print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        fi
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END rename_Space
# FIXME Test
# #############################################################################
#
# Returns File Size
# if (( $(fileSize "${BaseFileName}") != $(fileSize "${Output_Folder}/${FileName}") )); then
file_Size()
{
    if [ $# -ne 1 ] ; then print_error "File to Check Size" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local optChar='c' fmtString='%s';
    [[ $(uname) =~ Darwin|BSD ]] && { optChar='f'; fmtString='%z'; }
    stat -${optChar} "${fmtString}" "$@";
}
# -------------------------------------
# stat -c "%s" "/mnt/qnap-light-wizzard/Light-Wizzard-in-the-Flesh-Production/Scripts/Support/Test/Source/README.md";
test_file_Size()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/README.md"
    local thisTest; thisTest="218";
    if [ "$(file_Size "$ThisTestFile")" -eq "$thisTest" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END fileSize
# #############################################################################
is_File_Smaller()
{
    if [ $# -ne 2 ] ; then print_error "Source and Target Files" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    if [ ! -f "$1" ]; then echo "File Not Found $1"; return 1; fi
    if [ ! -f "$2" ]; then echo "File Not Found $2"; return 1; fi
    local File1; File1="$(file_Size "$1")";
    local File2; File2="$(file_Size "$2")";
    if [ "$File1" -le "$File2" ]; then return 0; else return 1; fi
}
# -------------------------------------
test_is_File_Smaller()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest="${TheFullScriptPath}/Support/Test/Source/Circle.illusion.mp4"; # 932.2 KB
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/Zenith-Test-Pattern-HD-1080.mp4"  # 175.8 MB
    if is_File_Smaller "$thisTest" "$ThisTestFile"; then
        print_test "Pass: $thisTest $ThisTestFile" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "FAIL: $thisTest $ThisTestFile" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END is_File_Smaller
# #############################################################################
#
# Returns File Size
# $(calculated_bitrate "${BaseFileName}")
# FIXME bitrate? file_size_bytes?
calculated_bitrate()
{
    if [ $# -ne 1 ] ; then print_error "File Name to Calculate Bit Rate" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    myfilesize="$(fileSize "$@")";
    myfilesize="$((myfilesize*8192))";
    echo "${myfilesize}k";
}
# -------------------------------------
test_calculated_bitrate()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest="932.2";
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/Circle.illusion.mp4"
    if [ "$(calculated_bitrate "$ThisTestFile")" == "$thisTest" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END calculated_bitrate
# FIXME Test
# ##########################################################################################################################################################
# calculated_frame_rate
calculated_frame_rate()
{
    if [ $# -ne 1 ] ; then print_error "frame rate" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    Iterator=0;
    local -a FrameRateParts;
    local -i PartA;
    local -i PartB;
    # This should not change the global IFS
    local OldIFS="$IFS";
    IFS='/' read -ra FrameRateParts <<< "$1";
    IFS="$OldIFS";
    for i in "${FrameRateParts[@]}"; do
        # process "$i"
        Iterator=$((Iterator+1));
        if [ "$Iterator" -eq 1 ]; then
            PartA="$i";
        else
            PartB="$i";
        fi
    done
    FrameRate=$((PartA / PartB));
    echo "${FrameRate%\.*}";
}
# -------------------------------------
# 13978/583  = 23.9759862779
# 24000/1001 = 23.976023976
test_calculated_frame_rate()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest="23";
    ThisTestFile="24000/1001"
    if [ "$(calculated_frame_rate "$ThisTestFile")" == "$thisTest" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END calculated_frame_rate
# ##########################################################################################################################################################
# is_frame_rate_min "FileName" "Min Frame Rate: 30, 24..."
is_frame_rate_min()
{
    if [ $# -ne 2 ] ; then print_error "Input file name required and min frame rate" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local frame_rate; frame_rate="$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 "${1}")";
    # 13978/583  = 23.9759862779
    # 24000/1001 = 23.976023976
    # 25/1       = 25
    #
    # 24
    # 23.98 23.976
    # 29.97
    # 30
    # 50
    # 54.94
    # 60
    #
    #
    #
    # 119.5
    #
    #
    #
    frame_rate=$(calculated_frame_rate "$frame_rate");
    #
    if (("${frame_rate%\.*}" <= "${2%\.*}")); then return 0; else return 1; fi
}
# -------------------------------------
test_is_frame_rate_min()
{
    ((TestCounter += 1));
    #
    ThisTestFile="${TheFullScriptPath}/Support/Test/Source/Circle.illusion.mp4"
    local thisTest; thisTest="30";
    if is_frame_rate_min "$ThisTestFile" "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END is_frame_rate_min
# *************************************************************************** #
is_Alpha_String()
{
    if [ $# -ne 1 ] ; then print_error "Input file name required and min frame rate" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local thisString2Validate; thisString2Validate="$1";
    #  Only a-zA-Z characters are allowed
    #if [[ "$thisString2Validate" =~ [^a-zA-Z] ]]; then return 0; else return 1; fi
    if [[ "$thisString2Validate" =~ ^[a-zA-Z]+$ ]]; then return 0; else return 1; fi
}
# -------------------------------------
test_is_Alpha_String()
{
    ((TestCounter += 1));
    #
    local thisTest;
    thisTest="AaBbCcDcEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    if is_Alpha_String "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    thisTest="0123456789AaBbCcDcEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    if ! is_Alpha_String "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# *************************************************************************** #
# isValidFileName "FileName.Ext"
# Valid characters: Aa-Zz 0-9 . - _
is_Valid_File_Name()
{
    if [ $# -ne 1 ] ; then print_error "Input file name required and min frame rate" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    local thisString2Validate; thisString2Validate="$1";
    # Valid range is 1 to 255
    if [ "${#thisString2Validate}" -lt 1 ] || [ "${#thisString2Validate}" -gt 255 ]; then return 1; fi
    if [[ $thisString2Validate == "" ]]; then return 1; fi
    # "." and ".." are added automatically and always exist, so you can't have a
    # file named . or .. // https://askubuntu.com/a/416508/660555
    if [[ $thisString2Validate == "." ]] || [[ $thisString2Validate == ".." ]]; then return 1; fi
    # Checks whether valid characters exist: Aa-Zz 0-9 . - _
    if ! [[ "$thisString2Validate" =~ ^[0-9a-zA-Z._-]+$ ]]; then return 1; fi
    _thisString2Validate="$(echo "$thisString2Validate" | cut -c1-1)";
    # Checks the first character to ensure it starts with an AlphaNumberic or a dot indicating a Hidden File
    if ! [[ "$_thisString2Validate" =~ ^[0-9a-zA-Z.]+$ ]]; then return 1; fi
    return 0;
}
# -------------------------------------
test_is_Valid_File_Name()
{
    ((TestCounter += 1));
    #
    local thisTest; thisTest=".READ_ME-1.md";
    if is_Valid_File_Name "$thisTest"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# *************************************************************************** #
is_root_user()
{
    if [ "$(whoami)" == "root" ]; then return 0; else return 1; fi
}
# -------------------------------------
test_is_root_user()
{
    ((TestCounter += 1));
    #
    if ! is_root_user; then
        print_test "Pass: ! is_root_user" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "FAIL: is_root_user" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# #############################################################################
sudo_Required()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; fi
    [[ -z ${1} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    #
    print_test "sudo required, you must login to use function ${1}" "${FUNCNAME[0]} : ${LINENO[0]}";
    #
    if ! sudo -v; then
        print_error "Must run sudo with root permission to use function ${1}" "${FUNCNAME[0]} : ${LINENO[0]}"; exit 1;
    fi
}
export -f sudo_Required;
# END sudo_Required
###############################################################################
cleanText()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; fi
    [[ -z ${1} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local cleanThis; cleanThis="${1}";
    # &apos; &#39; &#x27;
    # html    | numeric | hex
    # &lsquo; | &#145;  | &#x91; // for the left/beginning single-quote and
    # &rsquo; | &#146;  | &#x92; // for the right/ending single-quote
    # &#8217; for apostrophe and right single quote
    # &#8216; for left single quote.
    #   < &lt;
    #   > &gt;
    #   " &quot;
    #   & &amp;
    #   ' &#39;

    # cleanThis="<It&#39;s>";
    #
    # cleanThis="${cleanThis/\&#39;/\'}"; # messes up editor
    # shellcheck disable=SC2001
    cleanThis="$( echo "${cleanThis}" | sed "s/\&#39;/'/g" )"; # Fix Apostrophe '
    # shellcheck disable=SC2001
    cleanThis="$( echo "${cleanThis}" | sed 's/\"//g' )"; # Remove quotes
    echo "${cleanThis}";
}
export -f cleanText;
# END cleanText
###############################################################################
uncleanText()
{
    if [ $# -ne 1 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; fi
    [[ -z ${1} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local cleanThis; cleanThis="${1}";

    # shellcheck disable=SC2001
    cleanThis="$( echo "${cleanThis}" | sed "s/'/\&#39;/g" )"; # Fix Apostrophe '
    echo "${cleanThis}";
}
export uncleanText;
# END uncleanText
###############################################################################
declare -i ThisTotalCharacters; ThisTotalCharacters=0;
declare -i ThisTotalWords;      ThisTotalWords=0;
setCharacterWordCount()
{
    # Test Number of arguments else die
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Status' 'Progress'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    local myTextString;      myTextString="${1}";
    local ThisOldIFS;        ThisOldIFS="$IFS";
    local -a thisWordsCount; thisWordsCount=();
    local -i thisWC;         thisWC=0;

    if [ -n "${myTextString-}" ]; then
        if [ "${thisWC}" -eq 1 ]; then
            ThisTotalWords+=$( echo "${myTextString}" | wc -w );
        else
            #
            IFS=$" ";
            # shellcheck disable=SC2206
            thisWordsCount=( ${myTextString} );
            ThisTotalWords+=${#thisWordsCount[@]};
        fi
        #
        ThisTotalCharacters+=${#myTextString};
    fi
    #
    IFS="$ThisOldIFS";
}
export -f setCharacterWordCount;
# END setCharacterWordCount
###############################################################################
# 1: myPrintThis: 1 = Print this to screen
#
setLocalizeSizes()
{
    # Test Number of arguments else die
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "Usage: ${FUNCNAME[0]}() 'Status' 'Progress'"; pause_function "$(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]} > ${FUNCNAME[1]}()"; return 1; }
    local -i myPrintThis; myPrintThis="${1}";
    local thisPOfile;
    local myLine;
    local ThisOldIFS;     ThisOldIFS="$IFS";
    local -i thisLocalStringIndex; thisLocalStringIndex=0;
    local thisLocalString;
    #
    thisPOfile="${TheLocalizedPath}${TheDefaultLanguage}/${TheDefaultLanguage}.po";
    if [ "${myPrintThis}" -eq 1 ]; then
        printInColor "Working on ${TheDefaultLanguage}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
        printInColor "${thisPOfile}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
        if [ -f "${thisPOfile}" ]; then
            while IFS='' read -r line || [[ -n "${line}" ]]; do
                if [ "${myPrintThis}" -eq 1 ]; then
                   echo -en "\b${ThisProgress[$((ThisProgression++))]}"; [[ ${ThisProgression} -ge 3 ]] && ThisProgression=0;
                fi
                if [[ -n "${line}" ]] && [[ "${line:0:1}" != "#" ]]; then
                    if [ "${line:0:5}" == "msgid" ]; then
                        myLine="$( cleanText "${line:6}" )";
                        #echo "msgid: |${myLine}|"
                        LocalizedID[$((${#LocalizedID[@]}))]="${myLine}";
                    elif [ "${line:0:6}" == "msgstr" ]; then
                        myLine="$( cleanText "${line:7}" )";
                        #echo "msgid: |${myLine}|"
                        LocalizedMSG[$((${#LocalizedMSG[@]}))]="${myLine}";
                        setCharacterWordCount "${myLine}";
                    fi
                fi # END if [[ -n "${line}" ]] && [[ "${line:0:1}" != "#" ]]; then
            done < "${thisPOfile}"
        fi # END if [ -f "${thisPOfile}" ]; then
        for thisLocalStringIndex in "${!LocalizedID[@]}"; do
            #echo "${LocalizedMSG[${thisLocalStringIndex}]}"
            gettext -s "${LocalizedID[${thisLocalStringIndex}]}"
        done # END for thisLocalStringIndex in "${!LocalizedID[@]}"; do
        printInColor "" "${ColorBgBlack}" "${ColorFgWhite}" 1;
        printInColor "Total Number of Words: ${ThisTotalWords}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
        printInColor "Total Number of Characters: ${ThisTotalCharacters}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
    else
        ThisTotalWords=0;
        ThisTotalCharacters=0;
        for thisLocalString in "${LocalizedMSG[@]}"; do
            setCharacterWordCount "${thisLocalString}";
        done # END for thisLocalString in "${LocalizedID[@]}"; do
    fi
    #
    #
    IFS="$ThisOldIFS";
}
export -f setLocalizeSizes;
# END setLocalizeSizes
###############################################################################
#
# printInColor "Text to Print to Screen" "${ColorBgBlack}" "${ColorFgWhite}"
#
printInColor()
{
    [[ $# -ne 4 ]] && { echo "LOCALIZE_WRONG_ARGS_PASSED_TO Usage: ${FUNCNAME[0]}() 'Text' 'Background Color' 'Foreground Color' $(basename "${BASH_SOURCE[0]}") Line # ${LINENO[0]}"; get_stack "${LINENO[0]}"; echo "${STACK}"; return 1; }
    local myText;       myText="${1}";    #
    local -i myBgColor; myBgColor="${2}"; #
    local -i myFgColor; myFgColor="${3}"; #
    local -i myNewLine; myNewLine="${4}"; #
    #
    if [ "${myNewLine}" -eq 1 ]; then
        echo -e "${T_Clear_BOL}${T_Reset}${ColorsBG[${myBgColor}]}${ColorsFG[${myFgColor}]}${ThisTabSpace}${T_Bold}${myText}${T_Clear_EOL}";
    else
        echo -ne "${T_Clear_BOL}${T_Reset}${ColorsBG[${myBgColor}]}${ColorsFG[${myFgColor}]}${ThisTabSpace}${T_Bold}${myText}${T_Clear_EOL}";
    fi
}
export -f printInColor;
# END
###############################################################################
# 1. Time in Seconds
sleepFor()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    local -i mySleepTotal;     mySleepTotal="${1}";
    local -i thisSleepPercent; thisSleepPercent=0;
    printProgress "Sleeping for ${1} seconds..." "${mySleepTotal}" "${thisSleepPercent}";
    for (( thisSleepPercent=0; thisSleepPercent<mySleepTotal; thisSleepPercent++ )); do
        printProgress "" "${mySleepTotal}" "${thisSleepPercent}";
        sleep 1;
    done
    printProgress "" "${mySleepTotal}" "${mySleepTotal}";
    printInColor "Waking up..." "${ColorBgBlack}" "${ColorFgGreen}" 1;
}
export -f sleepFor;
# END sleepFor
###############################################################################
# use -no-auto to disable autocorrect
localizeIt()
{
    [[ ${ThisRunLocalizer} -eq 0 ]] || [[ "${TheRunTest}" -eq 1 ]] || [ "${TheRunHelp}" -eq 1 ] && return 0;
    #
    local -i thisSetDebug;         thisSetDebug=0; # 0=No, 1=Yes
    local -i totalLocalized;       totalLocalized="${#LocalizedID[@]}";
    local -i totalLanguages;       totalLanguages="${#TheLocalizeLanguageList[@]}";
    local -i thisLanguagesIndex;   thisLanguagesIndex=0;
    local -i thisLocalStringIndex; thisLocalStringIndex=0;
    local -i toggleThis;           toggleThis=0;
    local -i sleepTime;            sleepTime=0;
    local -i perLineSleep;         perLineSleep=0;
    local -i perFileSleep;         perFileSleep=0;
    local thisPOfile;              thisPOfile="po";
    local thisMOfile;              thisMOfile="mo";
    local thisTrans;               thisTrans="mo-po";
    local -i doTrans;              doTrans=1;
    #
    if [ "${ThisSimulateTrans}" -eq 0 ]; then
        if [ "${UseFreeGoogleTrans}" -eq 1 ]; then
#            perLineSleep=66;   # 60 is 1 Minute, for Free they might cut you off if you make more request then that in 10 Minutes
#            perFileSleep=3666; # 3600 is 1 Hour, for Free this is a very limited amount of characters per hour
            perLineSleep=33;   # 60 is 1 Minute, for Free they might cut you off if you make more request then that in 10 Minutes
            perFileSleep=333; # 3600 is 1 Hour, for Free, this is a very limited amount of characters per hour
        else
            perLineSleep=1; # No delay means Hammer on the Server
            perFileSleep=6;
        fi
    else
        perLineSleep=1;
        perFileSleep=1;
    fi
    if [ ${thisSetDebug} -eq 1 ]; then set -x; fi # Turn On Debug mode
    # http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/PO-Files.html
    #
    #
    mkdir -p "${TheLocalizedPath}${TheDefaultLanguage}/LC_MESSAGES/";
    #
    echo "# Trinary Galactic Table Translation File"    >  "${TheLocalizedPath}${TheDefaultLanguage}/${TheDefaultLanguage}.po"; # Overwrite
    echo ""                     >>  "${TheLocalizedPath}${TheDefaultLanguage}/${TheDefaultLanguage}.po"; # Appends
    #
    printInColor "Localized total=${totalLocalized}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
    #
    #
    for thisLanguagesIndex in "${!LocalizedID[@]}"; do
        #echo -en "\b${ThisProgress[$((ThisProgression++))]}"; [[ ${ThisProgression} -ge 3 ]] && ThisProgression=0;
        {
            echo "# msgcomment: ${LocalizedComment[$thisLanguagesIndex]}"
            echo "msgid \"${LocalizedID[$thisLanguagesIndex]}\""
            echo "msgstr \"${LocalizedMSG[$thisLanguagesIndex]}\""
            echo ""
        } >> "${TheLocalizedPath}${TheDefaultLanguage}/${TheDefaultLanguage}.po";
    done
    # make mo file
    msgfmt -o "${TheLocalizedPath}${TheDefaultLanguage}/LC_MESSAGES/${TheLocalizedFile}.mo" "${TheLocalizedPath}${TheDefaultLanguage}/${TheDefaultLanguage}.po";
    #
    setLocalizeSizes 0; # set Character and Word Count if we need it
    printInColor "Total Number of Words: ${ThisTotalWords}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
    printInColor "Total Number of Characters: ${ThisTotalCharacters}" "${ColorBgBlack}" "${ColorFgWhite}" 1;
    #
    if [ "${ThisLocalizeAll}" -eq 1 ]; then
        if hash "trans" 2>/dev/null; then
            #
            for thisLanguagesIndex in "${!TheLocalizeLanguageList[@]}"; do
                doTrans=1;
                thisPOfile="${TheLocalizedPath}${TheLocalizeLanguageList[${thisLanguagesIndex}]}/${TheLocalizeLanguageList[${thisLanguagesIndex}]}.po";
                thisMOfile="${TheLocalizedPath}${TheLocalizeLanguageList[${thisLanguagesIndex}]}/LC_MESSAGES/${TheLocalizedFile}.mo";
                if [ "${TheLocalizedFilesSafe}" -eq 1 ]; then
                    if [ -f "${thisPOfile}" ]; then
                        if [ -f "${thisMOfile}" ]; then
                            doTrans=0;
                        fi
                    fi
                fi # END if [ "${TheLocalizedFilesSafe}" -eq 1 ]; then
                #
                if [ "${doTrans}" -eq 1 ]; then
                    mkdir -p "${TheLocalizedPath}${TheLocalizeLanguageList[${thisLanguagesIndex}]}";
                    mkdir -p "${TheLocalizedPath}${TheLocalizeLanguageList[${thisLanguagesIndex}]}/LC_MESSAGES/";
                    echo "# Trinary Galactic Table Translation File" >  "${thisPOfile}"; # Overwrite
                    echo ""                  >>  "${thisPOfile}"; # Appends
                    for thisLocalStringIndex in "${!LocalizedID[@]}"; do
                        printInColor "Working on ${thisLanguagesIndex} of ${totalLanguages}:  Localizating ${TheLocalizeLanguageList[${thisLanguagesIndex}]}: ${thisLocalStringIndex} of ${totalLocalized}: ${LocalizedID[${thisLocalStringIndex}]}" "${ColorBgBlack}" "${ColorFgBlue}" 1;
                        if [ "${ThisSimulateTrans}" -eq 0 ]; then
                            thisTrans="$( trans -no-autocorrect -no-warn -b -s en -t "${TheLocalizeLanguageList[${thisLanguagesIndex}]}" \""${LocalizedMSG[$thisLocalStringIndex]}"\" )";
                        else
                            thisTrans="${TheLocalizeLanguageList[${thisLanguagesIndex}]}: Simulation of trans";
                        fi
                        thisTrans="$(echo "${thisTrans}" | tr -d '\"' )"; # Remove all quotes, sometimes end quotes is missing or odd number
                        # we do not want to count quotes as not empty
                        if [ "${#thisTrans}" -eq 0 ]; then
                            thisTrans="\"${LocalizedMSG[$thisLocalStringIndex]}\""; # Must be in Quotes
                        else
                            thisTrans="\"${thisTrans}\"";                       # Now add them back, this makes sure the quotes are right
                        fi
                        #
                        printInColor "Trans=|${thisTrans}|" "${ColorBgBlack}" "${ColorFgYellow}" 1;
                        # enclosure for writing files
                        {
                            echo "# msgcomment: ${LocalizedComment[${thisLocalStringIndex}]}"
                            echo "msgid \"${LocalizedID[$thisLocalStringIndex]}\""
                            echo "msgstr ${thisTrans}"
                            echo ""
                        } >> "${thisPOfile}";
                        #
                        if [ "${UseFreeGoogleTrans}" -eq 1 ]; then
                            # I do not want to pound on the Server to translate this, they have kick me off; not sure how long to wait, work in progress...
                            # I have 118 lines so far, so how long do you want to wait, this is per Language,
                            # I have 36 Languages selected; that is 4248 * how many seconds you chose,
                            # at 6 x 4248 = 25,488 seconds / 60 = 424.8 Minutes, / 60 = 7.08 Hours
                            # Google is now Paid only, but you can get a few Free ones,
                            # at over 1 per minute, I have about 118 of them, so that is 118 minutes or almost 2 Hours per file
                            # so adding 2 hours x 118 files = 236 Hours or 9 day
                            # plus the fact we are only getting 1 file with a 1-hour wait so its more like 9 days and 8 hours to get if for free
                            # so I need to make a Progress Bar that reflects this
                            if [ "${ThisSimulateTrans}" -eq 0 ]; then
                                if [ "${toggleThis}" -eq 0 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 1 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 2 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 3 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 4 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 5 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 6 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 7 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 8 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 9 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 10 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 11 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 12 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                elif [ "${toggleThis}" -eq 13 ]; then
                                    sleepTime=$(( perLineSleep + toggleThis ));
                                    toggleThis=0;
                                fi
                            fi # END if [ "${ThisSimulateTrans}" -eq 0 ]; then
                            sleepFor "${sleepTime}";
                            (( toggleThis++ ))
                        fi # END if [ "${UseFreeGoogleTrans}" -eq 1 ]; then
                    done # END for thisLocalStringIndex in "${!LocalizedID[@]}"; do
                    #
                    if [ "${ThisSimulateTrans}" -eq 0 ]; then
                        msgfmt -o "${thisMOfile}" "${thisPOfile}";
                    fi
                    #
                    if [ "${UseFreeGoogleTrans}" -eq 1 ]; then
                        sleepFor "${perFileSleep}"; # 3666 seconds (over an hour per file supported) is an eternity for a Computer, but they limit you per hour, no fails required
                        # this will take 36 x 3,666 = 131,976 or 36.66 Hours to complete, try to push it and you will have trans rejections or untrans strings
                    fi # END if [ "${useFreeGoogleTrans}" -eq 1 ]; then
                fi # END if [ "${doTrans}" -eq 1 ]; then
            done # END for thisLanguagesIndex in "${!TheLocalizeLanguageList[@]}"; do
        else # if hash "trans" 2>/dev/null; then
            printInColor "trans not installed" "${ColorBgBlack}" "${ColorFgRed}" 1;
            printInColor "This Bash Script is not only Localized," "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "it is self Localizing, it will look up the Translation for every Language you chose," "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "and create the File for you." "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "https://github.com/soimort/translate-shell" "${ColorBgBlack}" "${ColorFgYellow}" 1;
            printInColor "You must copy file to Path, you cannot access it from inside another script otherwise." "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "This downloads the latest file from git" "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "wget git.io/trans" "${ColorBgBlack}" "${ColorFgYellow}" 1;
            printInColor "this changes Permissions so you can execute it" "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "chmod +x ./trans" "${ColorBgBlack}" "${ColorFgYellow}" 1;
            printInColor "You can move it to any Folder in your Path, I just use bin, because its the right place to put it." "${ColorBgBlack}" "${ColorFgBlue}" 1;
            printInColor "sudo mv trans /usr/bin/" "${ColorBgBlack}" "${ColorFgYellow}" 1;
        fi # END if hash "trans" 2>/dev/null; then
    fi # END if [ "${ThisLocalizeAll}" -eq 1 ]; then
    if [ "${thisSetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
}
export -f localizeIt;
# END localizeIt
###############################################################################
#
# setLocalized "ID" "Text" "Comment";
setLocalized()
{
    if [ $# -ne 3 ]; then print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    [[ -z ${3+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    # FIXME
    local thisID;       thisID="${1}";
    local thisText;     thisText="${2}";
    local thisComment;  thisComment="${3}";
    [[ -z ${thisID} ]]      && { echo "LOCALIZE_WRONG_ARGS_NULL thisID"; return 1; }
    [[ -z ${thisText} ]]    && { echo "LOCALIZE_WRONG_ARGS_NULL thisText"; return 1; }
    [[ -z ${thisComment} ]] && { echo "LOCALIZE_WRONG_ARGS_NULL thisComment"; get_stack "${FUNCNAME[0]}"; echo "${STACK}" return 1; }
    #
    ThisTextIDArray[$((${#ThisTextIDArray[@]}))]="${thisID}";
    ThisTextArray[$((${#ThisTextArray[@]}))]="${thisText}";
    LocalizedID[${#LocalizedID[*]}]="${thisID}";
    LocalizedMSG[${#LocalizedMSG[*]}]="${thisText}";
    LocalizedComment[${#LocalizedComment[*]}]="${thisComment}";
}
export -f setLocalized;
# END
###############################################################################
# mkvinfo --ui-language en_US "$thisFile" | grep -i compress
is_Video_Mkv_Compresed()
{
    if [ $# -ne 1 ] ; then print_error "1->(File)" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; exit 1; fi
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local thisFile; thisFile="$1";
    local isCommpessed; isCommpessed="$(mkvinfo --ui-language en_US "$thisFile" | grep -i compress)";
    if [[ -n "${isCommpessed}" ]]; then
        #echo "File is compressed";
        return 0;
    fi
    return 1;
}
# END is_Video_Mkv_Compresed
export -f is_Video_Mkv_Compresed;
# #############################################################################
# pushClipboard "This" 1=newline,0=no-line-return
pushClipboard()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    [[ -z ${2+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    if [ "$2" -eq 0 ]; then
        echo -n "$1" | setclip;
    else
        echo "$1" | setclip;
    fi
}
# END pushClipboard
export -f pushClipboard;
# #############################################################################
popClipboard()
{
    getclip;
}
# END popClipboard
export -f popClipboard;
# #############################################################################
is_variable_set()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    declare -p "$1" &>/dev/null;
}
# -------------------------------------
test_is_variable_set()
{
    ((TestCounter += 1));
    #
    if ! is_variable_set "THIS_VAR_NOT_EXIST"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    # shellcheck disable=SC2034
    declare THIS_VAR_NOT_EXIST;
    if is_variable_set "THIS_VAR_NOT_EXIST"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    # shellcheck disable=SC2034
    THIS_VAR_NOT_EXIST="This";
    if is_variable_set "THIS_VAR_NOT_EXIST"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi

}
# END is_variable_set
export -f is_variable_set;
# *************************************************************************** #
get_last_character()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local -i thisLength; thisLength=${#1};
    if [ "$thisLength" -eq 0 ]; then echo ""; else echo "${1: -1}"; fi
}
# -------------------------------------
test_get_last_character()
{
    ((TestCounter += 1));
    #
    local thisStringTest; 
    local thisLastChar;
    #
    thisStringTest="";
    thisLastChar="$(get_last_character "${thisStringTest}")";
    #
    if [ "${thisLastChar}" == "" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    #
    thisStringTest="/this/path/";
    thisLastChar="$(get_last_character "${thisStringTest}")";
    #
    if [ "${thisLastChar}" == "/" ]; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END get_last_character
export -f get_last_character;
# *************************************************************************** #
is_file_folder_readable() 
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local thisString; thisString="$(get_last_character "$1")";
    if [ "$thisString" == "/" ]; then
        # Check if folder exists
        # Check if folder permissions allow execution for read        
        if [[ -d "$1" && -x "$1" ]]; then return 0; else return 1; fi
    else
        # Check if file exists
        # Check if file permissions allow reading
        if [[ -e "$1" && -r "$1" ]]; then return 0; else return 1; fi
    fi
}
# -------------------------------------
test_is_file_folder_readable()
{
    ((TestCounter += 1));
    # Test File
    ThisTestFile="/etc/shadow";     
    #
    if ! is_file_folder_readable "${ThisTestFile}"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        exit 1;
    fi
    #
    # Test Folder
    ThisTestFile="/etc/multipath";
    if ! is_file_folder_readable "${ThisTestFile}"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
        exit 1;
    fi
}
# END is_file_folder_readable
export -f is_file_folder_readable;
# *************************************************************************** #
# if is_file_user_read_access "FileFullPath"; then echo "yes"; fi
# isUserAccess rename
# This first checks to see if the files is readable, then checks if the path is
is_file_user_read_access()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    local thisFileFolder; thisFileFolder="$1";
    # /var/lib/libvirt/images/
    # /var/lib/libvirt/images/Windoze10.qcow2
    if ! is_file_folder_readable "${thisFileFolder}"; then return 1; fi
    
    local thisPath; thisPath=""; # FIXME
    local thisPart; thisPart="";
    # Handle non-absolute paths, does not start with a slash
    if ! [[ "${thisFileFolder}" == /* ]] ; then thisPath="/$1"; fi
    #
    dirname "${thisFileFolder}" | tr '/' $'\n' | while read -r thisPart ; do
        thisPath="${thisPath}/${thisPart}";
        # Check for execute permissions
        if ! [[ -x "${thisPath}" ]] ; then
            #echo "'$thisPath' is blocking access.";
            return 1;
        fi
    done
    #
    if ! [[ -r "${thisFileFolder}" ]] ; then
        #echo "'$thisFileFolder' is not readable.";
        return 1;
    fi
    #
    local thisLastChar; thisLastChar="$(get_last_character "${thisFileFolder}")";
    #
    if [ "${thisLastChar}" == "/" ]; then
        local thisFile;
        for thisFile in "${thisFileFolder}"*; do 
            if ! is_file_folder_readable "${thisFile}"; then return 1; fi
        done
    fi

    if [ "$1" == "/var/lib/libvirt/images/" ]; then
        echo "HERE"; exit 0;
    fi
    return 0;
}
# -------------------------------------
test_is_file_user_read_access()
{
    ((TestCounter += 1));
    #
    ThisTestFile="/etc/sudoers";
    # check if
    if is_file_user_read_access "$ThisTestFile"; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    # check not if
    if ! is_file_user_read_access "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    # shadow
    ThisTestFile="/etc/shadow";
    # check if
    if is_file_user_read_access "$ThisTestFile"; then
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    # check not if
    if ! is_file_user_read_access "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END is_file_user_read_access
export -f is_file_user_read_access;
# *************************************************************************** #
# isUserExecute rename
is_file_user_execute_access()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    [[ -z ${1+x} ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") : Line # ${LINENO[0]}"; exit 1; }
    #
    if [ "$(stat -c %A "$1" | sed 's/...\(.\).\+/\1/')" == "x" ]; then
        # echo "Owner has execute permission!"
        return 0;
    else
        return 1;
    fi
}
# -------------------------------------
test_is_file_user_execute_access()
{
    ((TestCounter += 1));
    #
    ThisTestFile="/etc/sudoers";
    if ! is_file_user_execute_access "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
    #
    ThisTestFile="/etc/shadow";
    if ! is_file_user_execute_access "$ThisTestFile"; then
        print_test "LOCALIZE_TEST_FUNCTION_PASSED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    else
        print_error "LOCALIZE_TEST_FUNCTION_FAILED" "$(sub_string "${FUNCNAME[0]}" "test_" 2)() : ${LINENO[0]}";
    fi
}
# END is_file_user_execute_access
export -f is_file_user_execute_access;
# *************************************************************************** #
# *************************************************************************** #
# is_valid_email();
# is_valid_path();
# is_valid_domain();
# is_valid_ip();
# is_alphanumeric();
# is_number();

# is_os();
# is_installed();
# is_ssh_keyed();
# is_ssh_user();
# is_internet();
# is_online();
# is_last_item();
# is_user();
# is_user_in_group();
# is_group();

# is_in_array();
# is_string_in_file();
# is_needle_in_haystack();
# is_wildcard_file();
# *************************************************************************** #
# BEGIN GLOBAL
# -----------------------------------------------------------------------------
# *************************************************************************** #
# BEGIN localize_globals
#
setVars;
#
# #############################################################################
localize_common()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_RUNTIME" "Total runtime (Days:Hours:Minutes:Seconds)" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WA_READ_INPUT" "Wrong arguments: 1->(Question) 2->(Example) 3->(Default Value)" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WK_READ_INPUT" "Wrong Key" "Wrong Key in Read Input";
    localize_info "LOCALIZE_WA_PRINT_LOCALIZED" "Wrong Number Arugments: 1->(ID) 2->(MSG) 2->(Comment)" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
#    localize_info "" "" "";
#    localize_info "" "" "";
#    localize_info "" "" "";
}
# END
export -f localize_common;
# #############################################################################
localize_globals()
{
    ((LocalizeComplileCounter += 1));
    localize_info "LOCALIZE_SCRIPT_ID1" "Script" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SCRIPT_ID2" "Versions" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_SCRIPT_ID3" "Last updated" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # Menu
    localize_info "LOCALIZE_MAKE_CHOICE" "Make a Choice:" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # PROMPT
    localize_info "ENTER_OPTION"  "Enter your Option:" "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "ENTER_OPTIONS" "Enter n° of options (ex: 1 2 3 or 1-3 or 1,2,3 d b q r): "  "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # Press any Key
    localize_info "LOCALIZE_PRESS_ANY_KEY_2_CONTINUE" "Press Any Key to Continue, well not any, just Enter or Space, or what every you Want"  "Comment: $(sub_string "${FUNCNAME[0]}" "loclize_" 2) @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # *************************************************************************** #
    localize_info "NOT_FOUND"         "Not Found" "Comment: write_error @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # -----------------------------------------------------------------------------
    #
    localize_info "LOCALIZE_WRONG_ARGS_PASSED_TO" "Wrong Number of Arguments passed to " "Comment: localize_info @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    # -----------------------------------------------------------------------------
    # Troubleshooting Functions
    localize_info "LOCALIZE_TEST_FUNCTION_LOADED_FILE" "Loaded File"               "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_PASSED"      "Test Passed"               "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_FAILED"      "Test Failed"               "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_RUN"         "Running Test"              "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_FNF"         "File Not Found"            "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_REMOVE"      "Test Removed"              "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_FUNCTION_FAIL_REMOVE" "Test Failed to Removed"    "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_WRONG_NUMBER_OF_ARGUMENTS" "Wrong Number of Arguments" "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INSTALL_MENU_RECOMMENDED"  "Recommended Menu Options"  "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_INSTALL_MENU_COMPLETED"    "Completed."                "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "LOCALIZE_TEST_RAN"                  "Test Ran:"                 "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    localize_info "WIZ_BYE"             "Finished running ${TheWizardScriptName} Wizard" "Comment: Troubleshooting-Functions @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
}
# END localize_globals
TEXT_SCRIPT_ID="$(localize "LOCALIZE_SCRIPT_ID1"): ${TheWizardScriptName} $(localize "LOCALIZE_SCRIPT_ID2"): ${TheScriptVersion} $(localize "LOCALIZE_SCRIPT_ID3"): $TheLastUpdate";
# *************************************************************************** #
update_Theme;
if [ "${TheRunTest}" -eq 1 ] || [ "${TheRunTest}" -eq 2 ] || [ "${TheRunTest}" -eq 3 ] || [ "${TheRunTest}" -eq 4 ] || [ "${TheRunTest}" -eq 5 ] || [ "${TheRunTest}" -eq 6 ] || [ "${TheRunTest}" -eq 7 ] || [ "${TheRunTest}" -eq 8 ] || [ "${TheRunTest}" -eq 9 ] || [ "${TheRunTest}" -eq 10 ]; then
    print_test_info;
fi
# *************************************************************************** #
#
if [ -z "$My_DIST" ] || [ "$My_DIST" == "" ]; then os_info; fi
# *************************************************************************** #
# Run Test down here to avoid function calls before they are defined.
if [ "${TheRunTest}" -eq 1 ]; then
    test_is_file_folder_readable;
    test_get_last_character;
    test_is_file_user_read_access;
    test_is_file_user_execute_access;
    test_is_variable_set;
    test_is_valid_date;
    test_is_File_Smaller;
    test_isPngAlpha;
    test_is_string_in_file;
    test_is_os;
    test_is_alphanumeric;
    test_is_number;
    test_is_wildcard_file;
    test_is_last_item;
    test_is_user;
    test_is_frame_rate_min;
    test_is_Alpha_String;
    test_is_Valid_File_Name;
    test_is_root_user;
    test_is_in_array;
    test_create_data_array;
    test_remove_from_array;
    test_get_File_Inode;
    test_calculated_frame_rate;
    test_file_Size;
    test_compare_versions;
    test_print_themes;
    test_print_this;
    test_print_that;
    test_print_caution;
    test_print_warning;
    test_print_error;
    test_print_info;
    test_print_test;
    test_print_item;
    test_print_list;
    test_print_menu;
    test_print_line;
    test_get_stack;
    test_write_error;
    test_trim;
    test_string_len;
    test_strip_leading_char
    test_strip_trailing_char;
    test_add_trailing_char
    test_sub_string;
    test_string_split;
    test_string_replace;
    test_load_2d_array;
    test_clean_logs;
    test_write_log;
    test_contains_element;
    test_to_lower_case;
    test_to_upper_case;
    test_os_info;
    test_clean_input;
    test_copy_files;
    test_copy_file;
    test_copy_dir;
    test_remove_file;
    test_remove_files;
    test_remove_folder;
    test_comment_file;
    test_un_comment_file;
    test_add_option;
    test_make_file;
    test_save_array;
    test_array_push;
    test_make_dir;
    test_delete_line_in_file;
    test_get_index;
    test_remove_array_duplicates;
    test_setHtmlComment;
    test_sedThis;
    test_printProgress;
    test_imageCount;
    test_imageWidthHeight;
    print_caution "LOCALIZE_TEST_RAN" "${TestCounter}";
fi
# END   TheRunTest = 1
# BEGIN TheRunTest = 2
if [ "${TheRunTest}" -eq 2 ]; then
    # FIXME make better groups
    test_is_internet;
    test_is_online;
    test_is_user_in_group;
    test_is_group;
    test_password_safe;
    test_get_ip_from_url
    test_add_user_group;
    test_remove_user_group;
fi
# END   TheRunTest = 2
# BEGIN TheRunTest = 3
if [ "${TheRunTest}" -eq 3 ]; then
    test_read_input_yn;
    test_verify_input_default_data;
fi
# END   TheRunTest = 3
# BEGIN TheRunTest = 4
if [ "${TheRunTest}" -eq 4 ]; then
    test_select_file;
fi
# END   TheRunTest = 4
# BEGIN TheRunTest = 5
if [ "${TheRunTest}" -eq 5 ]; then
    test_get_input_option;
fi
# END   TheRunTest = 5
# BEGIN TheRunTest = 6
if [ "${TheRunTest}" -eq 6 ]; then
    test_get_network_devices;
    test_add_group;
    test_add_user_2_group;
    test_key_website;
fi
# END   TheRunTest = 6
# BEGIN TheRunTest = 7
if [ "${TheRunTest}" -eq 7 ]; then
    test_Sqlite;
fi
# END   TheRunTest = 7
# BEGIN TheRunTest = 10 or 3
if [ "${TheRunTest}" -eq 9 ] || [ "${TheRunTest}" -eq 3 ]; then
   #
    TheAutoMan=1;
    INSTALL_WIZARD=0;
    print_this "LOCALIZE_READ_INPUT_OPTIONS_TEST_3" "TheAutoMan=$TheAutoMan and INSTALL_WIZARD=${INSTALL_WIZARD}";
    test_read_input_options;
    #
    TheAutoMan=0;
    INSTALL_WIZARD=1;
    print_this "LOCALIZE_READ_INPUT_OPTIONS_TEST_3" "TheAutoMan=$TheAutoMan and INSTALL_WIZARD=${INSTALL_WIZARD}";
    test_read_input_options;
    #
    TheAutoMan=0;
    INSTALL_WIZARD=0;
    print_this "LOCALIZE_READ_INPUT_OPTIONS_TEST_3" "TheAutoMan=$TheAutoMan and INSTALL_WIZARD=${INSTALL_WIZARD}";
    test_read_input_options;
fi
# END   TheRunTest = 10 or 3
# BEGIN TheRunLocalizer = 1
if [ "${TheRunLocalizer}" -eq 1 ]; then
    echo "Localizing beginning..."
    localize_get_stack;
    localize_common; # must be define in external file
    localize_debugger;
    localize_create_help;
    localize_print_warning;
    localize_print_test;
    localize_print_this;
    localize_print_that;
    localize_print_caution;
    localize_print_error;
    localize_print_menu;
    localize_print_help;
    localize_print_line;
    localize_print_title;
    localize_print_info;
    localize_print_item;
    localize_print_list;
    localize_print_test_info;
    localize_print_themes;
    localize_print_array;
    localize_localize_info;
    localize_localize;
    localize_pause_function;
    localize_write_error;
    localize_trim;
    localize_ltrim;
    localize_rtrim;
    localize_string_len;
    localize_strip_leading_char;
    localize_strip_trailing_char;
    localize_add_trailing_char;
    localize_sub_string;
    localize_string_split;
    localize_string_replace;
    localize_load_2d_array;
    localize_localize_save;
    localize_clean_logs;
    localize_checkbox;
    localize_to_lower_case;
    localize_to_upper_case;
    localize_assert;
    localize_os_info;
    localize_get_network_devices;
    localize_show_users;
    localize_device_list;
    localize_umount_partition;
    localize_read_input;
    localize_get_input_option;
    localize_clean_input;
    localize_read_input_options;
    localize_read_input_yn;
    localize_read_input_default;
    localize_read_input_data;
    localize_verify_input_default_data;
    localize_verify_input_data;
    localize_make_dir;
    localize_copy_file;
    localize_copy_files;
    localize_copy_dir;
    localize_remove_file;
    localize_remove_files;
    localize_remove_folder;
    localize_delete_line_in_file;
    localize_comment_file;
    localize_un_comment_file;
    localize_replace_option;
    localize_add_option;
    localize_make_file;
    localize__save_array;
    localize_load_array;
    localize_create_data_array;
    localize_add_menu_item;
    localize_restart_internet;
    localize_fix_network;
    localize_network_troubleshooting;
    localize_get_ip_from_url;
    localize_run_db_sql_file_ssh;
    localize_array_push;
    localize_remove_from_array;
    localize_get_index;
    localize_remove_array_duplicates;
    localize_date2stamp;
    localize_clear_logs;
    localize_add_user_group;
    localize_remove_user_group;
    localize_add_group;
    localize_add_user_2_group;
    localize_set_debugging_mode;
    localize_test_internet;
    localize_country_list;
    localize_get_country_codes;
    localize_get_country_code;
    localize_get_root_password;
    localize_get_user_name;
    localize_get_user_password;
    localize_get_locale;
    localize_yes_no;
    localize_select_create_user;
    localize_get_keyboard_layout;
    localize_configure_keymap;
    localize_get_editor;
    localize_configure_timezone;
    localize_db_backup;
    localize_create_database;
    localize_set_language;
    localize_create_ssh_user;
    localize_key_website;
    localize_random_password;
    localize_select_file;
    localize_password_safe;
    localize_install_package_with;
    localize_invalid_option;
    localize_invalid_options;
    localize_is_installed;
    localize_is_ssh_keyed;
    localize_is_ssh_user;
    localize_is_os;
    localize_is_in_array;
    localize_is_string_in_file;
    localize_is_needle_in_haystack;
    localize_is_valid_email;
    localize_is_valid_path;
    localize_is_valid_domain;
    localize_is_valid_ip;
    localize_is_alphanumeric;
    localize_is_number;
    localize_is_wildcard_file;
    localize_is_internet;
    localize_is_online;
    localize_is_last_item;
    localize_is_user;
    localize_is_user_in_group;
    localize_is_group;
    localize_globals;
    localize_save;
fi
# END   TheRunLocalizer = 1
# BEGIN TheRunHelp = 1
if [ "${TheRunHelp}" -eq 1 ]; then
    help_get_stack;
    help_debugger
    help_create_help;
    help_print_test;
    help_print_warning;
    help_print_this;
    help_print_that;
    help_print_caution;
    help_print_error;
    help_print_menu;
    help_print_help;
    help_print_line;
    help_print_title;
    help_print_info;
    help_print_list;
    help_localize_info;
    help_localize;
    help_pause_function;
    help_write_error;help_trim
    help_trim;
    help_ltrim;
    help_rtrim;
    help_string_len;
    help_strip_leading_char;
    help_strip_trailing_char;
    help_add_trailing_char;
    help_sub_string;
    help_string_split;
    help_string_replace;
    help_load_2d_array;
    help_localize_save;
    help_clean_logs;
    help_checkbox;
    help_invalid_option;
    help_invalid_options;
    help_to_lower_case;
    help_to_upper_case;
    help_print_array;
    help_assert;
    help_os_info;
    help_get_network_devices;
    help_show_users;
    help_umount_partition;
    help_device_list;
    help_read_input;
    help_get_input_option;
    help_clean_input;
    help_read_input_options;
    help_read_input_yn;
    help_read_input_default;
    help_read_input_data;
    help_verify_input_default_data;
    help_verify_input_data;
    help_make_dir;
    help_copy_file;
    help_copy_files;
    help_copy_dir;
    help_remove_file;
    help_remove_files;
    help_remove_folder;
    help_delete_line_in_file;
    help_comment_file;
    help_un_comment_file;
    help_replace_option;
    help_add_option;
    help_make_file;
    help_save_array;
    help_load_array;
    help_create_data_array;
    help_add_menu_item;
    help_restart_internet;
    help_fix_network;
    help_network_troubleshooting;
    help_get_ip_from_url;
    help_run_db_sql_file_ssh;
    help_array_push;
    help_remove_from_array;
    help_get_index;
    help_remove_array_duplicates;
    help_date2stamp;
    help_clear_logs;
    help_add_user_group;
    help_remove_user_group;
    help_add_group;
    help_add_user_2_group;
    help_set_debugging_mode;
    help_test_internet;
    help_country_list;
    help_get_country_codes;
    help_get_country_code;
    help_get_root_password;
    help_get_user_name;
    help_get_user_password;
    help_get_locale;
    help_yes_no;
    help_select_create_user;
    help_get_keyboard_layout;
    help_configure_keymap;
    help_get_editor;
    help_configure_timezone;
    help_db_backup;
    help_create_database;
    help_set_language;
    help_create_ssh_user;
    help_key_website;
    help_random_password;
    help_select_file;
    help_password_safe;
    help_install_package_with;
    help_is_internet;
    help_is_online;
    help_is_last_item;
    help_is_user;
    help_is_user_in_group;
    help_is_group;
    help_is_ssh_keyed;
    help_is_ssh_user;
    help_is_os;
    help_is_in_array;
    help_is_string_in_file;
    help_is_needle_in_haystack;
    help_is_valid_email;
    help_is_valid_path;
    help_is_valid_domain;
    help_is_valid_ip;
    help_is_alphanumeric;
    help_is_number;
    help_is_wildcard_file;
    help_is_installed;
    print_help;
fi
# END TheRunHelp
#
# ************************************* END OF SCRIPT *************************
