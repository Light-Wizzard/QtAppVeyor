#!/bin/bash
#
# Copyleft and Written by Jeffrey Scott Flesher
# No Copyrights or Licenses
#
# Install Script for Archlinux Clone: Manjaro
#
stat /dev/ttyS0;
declare DateManager="30 July 2021";
declare VersionManager="1.0";
declare -x TheScriptName; TheScriptName="install-manjaro";
# #############################################################################
# Table of Content Index
# checkArgs
# #############################################################################
declare -x ThisRoofFolder; ThisRoofFolder="${HOME}";
if [ ! -d "${ThisRoofFolder}" ]; then
    mkdir -p "${ThisRoofFolder}";    
fi
declare -x TheWorkSpace; TheWorkSpace="${ThisRoofFolder}/workspace/";    
declare TheSambaPublicFolder; TheSambaPublicFolder="${ThisRoofFolder}/samba/public";
declare TheWindowsFolder; TheWindowsFolder="${ThisRoofFolder}/Windows";
declare -x TheWizardPath; TheWizardPath="${HOME}/Scripts"; export TheWizardPath;
declare ThisUnrealEngineGitFolder;         ThisUnrealEngineGitFolder="${ThisRoofFolder}/workspace/UnrealEngine";
declare ThisUnrealEngineLauncherGitFolder; ThisUnrealEngineLauncherGitFolder="${ThisRoofFolder}/workspace/UE4Launcher";

declare TheCOW; TheCOW="${TheWindowsFolder}/COW" 
declare -i ThisComputerNvidia; # FIXME command line
ThisComputerNvidia=1; # 1 = yes
#declare ThisOwner; ThisOwner="$(whoami)";
declare -ix ThisClearOk; ThisClearOk=1; export ThisClearOk;
# KVM
declare TheKvmImageFolder; TheKvmImageFolder="/var/lib/libvirt/images";
declare -i ThisCowBackUp; ThisCowBackUp=0;
# #############################################################################
#
# Rename Folders and Files with Space with a dot
# Runs encoder to optimize videos
#
# 3D to 2D
# ffmpeg -i './a3dmovie.mp4'  -vf "crop=w=iw/2:h=ih:x=0:y=0,scale=w=2*iw:h=ih,setdar=2" -y ./a2dmovie.mp4
#
# For Test:
# cd "${HOME}/Downloads/Test.install-home/"
# cd /mnt/BaseFolder
# chmod +x "${HOME}"/Scripts/install-manjaro.sh
# dos2unix "${HOME}"/Scripts/install-manjaro.sh
# clear; echo "Shell Check..."; shell?check "${HOME}"/Scripts/install-manjaro.sh
# shell?check -x .${TheWorkSpace}/install-manjaro.sh
# shell?check -x ".${TheWorkSpace}/install-manjaro.sh && { shell?check -x ".${TheWorkSpace}/wizard.sh"; }  && { shell?check -x ".${TheWorkSpace}/wizard-common.sh"; }

# "${HOME}"/Scripts/install-manjaro.sh -w "${TheWorkSpace}/workspace/"
# KVM Backup
# "${HOME}"/Scripts/install-manjaro.sh -w "${TheWorkSpace}/workspace/" -k
# "${HOME}"/Scripts/install-manjaro.sh -w "${TheWorkSpace}/workspace/" -m 2
# #############################################################################
#
declare ThisRunPacmanFast; ThisRunPacmanFast=0;
#
set -u; # same as  set -o nounset, error if variable is not set
# nocaseglob: If set, Bash matches filenames in a case-insensitive fashion when performing filename expansion.
# dotglob: If set, Bash includes filenames beginning with a `.' in the results of filename expansion.
# -s   Enable (set) each optname
shopt -s nullglob dotglob;
IFS=$' '; # IFS=$'\n\t'; IFS=$'\n';
# User's file creation mask. umask sets an environment variable which automatically sets file permissions on newly created files.
#   i.e. it will set the shell process's file creation mask to mode.
umask 022;
unalias -a; # -a   Remove All aliases; so cp is not cp -i
# -f The names refer to shell Functions, and the function definition is removed.
#   Readonly variables and functions may not be unset
unset -f "$(declare -F | sed "s/^declare -f //")";
#
#trap "echo Exited!; exit;" SIGINT SIGTERM;
trap "echo install-home Control Break; exit;"     SIGINT;
trap "echo install-home SIGTERM-d; exit;"         SIGTERM;
trap "echo install-home Exited with Error; exit;" EXIT;
trap "echo install-home Finished normally; exit;" 0;
#
#
# all Public Variables
declare TheFullScriptPath; TheFullScriptPath="$(dirname "$(readlink -f "${0}")")"; export TheFullScriptPath; # No Ending /
declare -i SimulateThis;   SimulateThis=0; export SimulateThis;      # 1=true or 0=false, Simulate rename
declare -i PrintDebug;     PrintDebug=0;   export PrintDebug;        # 1=true or 0=false
declare -i SetDebug;       SetDebug=0;     export SetDebug;          # 1=true or 0=false
#
declare -ix TheDebugging; TheDebugging=0;  export TheDebugging;
#
#
###############################################################################
# Where do I put these files in Misc
declare TheLocalizedPathFolderName;  TheLocalizedPathFolderName="locale"; export TheLocalizedPathFolderName;      # No slash at end
declare -x TheLocalizedPath;        TheLocalizedPath="${TheFullScriptPath}/${TheLocalizedPathFolderName}"; export TheLocalizedPath;
declare -x TheDefaultLanguage;          TheDefaultLanguage="en";                  # I wrote this in English so this is a constant
# Where the po.langage file goes -> Edit this line as needed for project
# Name to call the Langage File referanced above -> Edit this line as needed for project
declare -x TheLocalizedFile; TheLocalizedFile="$TheScriptName";
# Set to 1 the first time you start Hand Translating your Localization files so they do not get overwriten.
declare -ix TheLocalizedFilesSafe; TheLocalizedFilesSafe=1; export TheLocalizedFilesSafe;
# Change this to the Default Language that the Localized files are in
declare -x TheDefaultLocalizedLanguage; TheDefaultLocalizedLanguage='en'; export TheDefaultLocalizedLanguage;
#
# Localization of all script tags to support language
declare -ix TheRunLocalizer; TheRunLocalizer=0; export TheRunLocalizer;
# Multilingual Langage File Path -> from above: declare -r TheLocalizedPath="${TheFullScriptPath}/locale"
TEXTDOMAINDIR="${TheLocalizedPath}";
export TEXTDOMAINDIR;
# Multilingual Langage File Name -> from above: declare TheLocalizedFile
TEXTDOMAIN="${TheLocalizedFile}";
export TEXTDOMAIN;
# Create Help.html
declare -ix TheRunHelp; TheRunHelp=0; export TheRunHelp;
# 0=Disable, 1=Run, 2=Run Extended Test
declare -ix TheRunTest; TheRunTest=0; export TheRunTest;
# Automatically install from saved settings
declare -ix TheAutoMan; TheAutoMan=0; export TheAutoMan;
# 14-Jan-2013 @ 06:32:36 PM
# shellcheck disable=SC2034
declare -x TheDateTime; TheDateTime="$(date +"%d-%b-%Y @ %r")"; export TheDateTime;
# Day-Mon-YYYY-T-HH-MM: 14-Jan-2013-T-18-32-36
# shellcheck disable=SC2034
declare -x TheLogDateTime; TheLogDateTime=$(date +"%d-%b-%Y-T-%H-%M-%S"); export TheLogDateTime;
#
###############################################################################
#
###############################################################################
# change to project needs
declare -x TheConfigName;  TheConfigName="install-home";                                   export TheConfigName;
declare -x TheLogPath;     TheLogPath="${TheFullScriptPath}/Support/Logs";                 export TheLogPath;
declare -x TheConfigPath;  TheConfigPath="${TheFullScriptPath}/Support/Config";            export TheConfigPath;
declare -x TheErrorLog;    TheErrorLog="${TheLogPath}/0-${TheConfigName}-error.log";       export TheErrorLog;
declare -x TheActivityLog; TheActivityLog="${TheLogPath}/1-${TheConfigName}-activity.log"; export TheActivityLog;
# #############################################################################
# show_help (0=Text, 1=HTML)
show_help()
{
    [[ $# -ne 1 ]] && { echo "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    getHorizontalLineType "$1";
    fixLineType "$1" "Help";
    fixLineType "$1" "";
    fixLineType "$1" "Expected Argument Switches:";
    fixLineType "$1" "-h or --help";
    fixLineType "$1" "-l or --localize";
    fixLineType "$1" "-p or --printdebug";
    fixLineType "$1" "-s or --simulate";
    fixLineType "$1" "-t or --test";
    fixLineType "$1" "-v or --version";
    fixLineType "$1" "";
    fixLineType "$1" "Tests";
    fixLineType "$1" "Test 1: all common functions";
    fixLineType "$1" "Test 2: Internet and user account functions";
    fixLineType "$1" "Test 3: Keyboard Input functions";
    fixLineType "$1" "Test 4: Select File function";
    fixLineType "$1" "Test 6: Network and Group functions 5: Keyboard Input Options";
    fixLineType "$1" "Test 7: SQLite";
    fixLineType "$1" "";
}
# END show_help
# #############################################################################
#
declare -i IsBeeper;          IsBeeper=0;          # Beep after each encoding
declare -i TheRunCheck;       TheRunCheck=0;
declare -i TheRunFixNPM;      TheRunFixNPM=0;
declare -i TheRunFirst;       TheRunFirst=0;
declare -i TheRunFixSTO;      TheRunFixSTO=0;
declare -i TheRunSetXclip;    TheRunSetXclip=0;
declare -i TheRunScan;        TheRunScan=0;
declare -i TheScanLevelAV;    TheScanLevelAV=0;
declare -i TheKvmFixBackup;   TheKvmFixBackup=0;
# #############################################################################
declare -i DoNotRun; DoNotRun=0;
#
declare -i RUN_OPTIONS; RUN_OPTIONS=0;
declare -x PROGNAME;    PROGNAME="${0##*/}";     #
#                                  b d e g i j q u r x z 
declare -x SHORTOPTS;   SHORTOPTS="v,h,p,t:,s:,b,l,w:,a,c,n,f,o,x,m:,y,k";
declare -x LONGOPTS;    LONGOPTS="version,help,printdebug,test,simulate,beep,localize,workspace,annotation,check,npmfix,first,outtimer,xclip,malavscan,yelp,kvmfixbackup";
declare -x ARGS;        ARGS=$(getopt -s bash --options "${SHORTOPTS}" --longoptions "${LONGOPTS}" --name "${PROGNAME}" -- "$@");
eval set -- "$ARGS";
# #############################################################################
# checkArgs "$@"
checkArgs()
{
    #
	while true; do
	    case $1 in
	        -v|--version)
	            echo "Script Date: ${DateManager} Version: ${VersionManager}";
	            exit 0;
	            ;;
	        -h|--help)
	            usage;
	            ;;
	        -a|--annotation)
	            TheRunHelp=1;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "TheRunHelp"; fi
	            ;;            
	        -p|--printdebug)
	            PrintDebug=1;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "printdebug"; fi
	            ;;
	        -t|--test)
	            shift;
	            TheRunTest=$((${1} + 0));
	            [ ${TheRunTest} -lt 1 ] || [ ${TheRunTest} -gt 10 ] && usage;
	            echo "Run Test: ${1}";
	            ;;
	        -s|--simulate)
	            shift;
	            SimulateThis="${1}"; # 0=False, 1=True
	            if [ "${PrintDebug}" -eq 1 ]; then echo "simulate=${1}"; fi
	            ;;
	        -b|--beep)
	            IsBeeper=1;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "IsBeeper"; fi
	            ;;
	        -l|--localize)
	            TheRunLocalizer=1;
	            if [ ! -d "$TheLocalizedPath" ]; then mkdir -p "$TheLocalizedPath"; fi
	            if [ "${PrintDebug}" -eq 1 ]; then echo "localize"; fi
	            ;;
	        -w|--workspace)
	            shift;
	            TheWorkSpace="${1}"; # 
                #
                if [[ "$TheWorkSpace" != */ ]]; then TheWorkSpace="${TheWorkSpace}/"; fi # Make sure it ends with a /
                #
	            if [ "${PrintDebug}" -eq 1 ]; then echo "workspace=${1}"; fi
	            ;;
	        -c|--check)
	            TheRunCheck=1;
	            pacmanFast;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "check"; fi
	            ;;
	        -n|--npmfix)
	            TheRunFixNPM=1;
	            fixNpm;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "npmfix"; fi
	            ;;
	        -f|--first)
	            TheRunFirst=1;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "first"; fi
	            ;;
	        -o|--outtimer)
	            TheRunFixSTO=1;
                fixSudoTimeOut;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "outtimer"; fi
	            ;;
	        -x|--xclip)
	            TheRunSetXclip=1;
                setXclip;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "xclip"; fi
	            ;;
	        -m|--malavscan)
	            shift;
	            TheRunScan=1;
	            TheScanLevelAV=$((${1} + 0));
	            [ ${TheScanLevelAV} -lt 1 ] || [ ${TheScanLevelAV} -gt 10 ] && usage;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "malavscan"; fi
	            ;;
	        -y|--yelp)
	            echo "sudo required to run timeshift restore, this will reset the the OS back in time.";
	            read_input_yn_c "Run timeshift restore" "" 1;
                if [ "${YN_OPTION}" -eq 1 ]; then
    	            sudo timeshift --restore; sudo reboot;
    	        fi
    	        #
	            if [ "${PrintDebug}" -eq 1 ]; then echo "yelp"; fi
	            ;;
	        -k|--kvmfixbackup)
	            TheKvmFixBackup=1;
	            if [ "${PrintDebug}" -eq 1 ]; then echo "kvmfixbackup"; fi
	            ;;
	        --) shift; break; ;;
	         *) shift; break; ;;
	    esac; shift;
	done
    #
    if [ "$TheWorkSpace" == "" ]; then
        echo;
        echo "TheWorkSpace=$TheWorkSpace";
        echo;
        usage;
    else
        RUN_OPTIONS=1;
    fi
    #
    [[ "$TheKvmFixBackup" -eq 1 ]] && DoNotRun=1; 
    [[ "$TheRunFirst" -eq 1 ]] && DoNotRun=1; 
    [[ "$TheRunTest" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunLocalizer" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunHelp" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunCheck" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunFixNPM" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunFixSTO" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunSetXclip" -eq 1 ]] && DoNotRun=1;
    [[ "$TheRunScan" -eq 1 ]] && DoNotRun=1;
    #
    if [ "$DoNotRun" -eq 1 ]; then
        printDoNotRun "TheKvmFixBackup" "$TheKvmFixBackup";
        printDoNotRun "TheRunFirst" "$TheRunFirst";
        printDoNotRun "TheRunTest" "$TheRunTest";
        printDoNotRun "TheRunLocalizer" "$TheRunLocalizer";
        printDoNotRun "TheRunCheck" "$TheRunCheck";
        printDoNotRun "TheRunFixNPM" "$TheRunFixNPM";
        printDoNotRun "TheRunFixSTO" "$TheRunFixSTO";
        printDoNotRun "TheRunSetXclip" "$TheRunSetXclip";
        printDoNotRun "TheRunScan" "$TheRunScan";        
    fi
    #
}
# END checkArgs
# #############################################################################
# https://wiki.archlinux.org/index.php/SELinux
SELinux()
{
    print_caution "SELinux" "SELinux" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    pacmanFast;
    #
#    # 1.
#    yay --noconfirm --needed -S libsepol libselinux checkpolicy secilc setools libsemanage semodule-utils policycoreutils;
#    # 2. 
#    yay --noconfirm --needed -S pambase-selinux pam-selinux;
#    # 3. Test to make sure you can still login FIXME 
#    
#    # 4.
#    yay --noconfirm --needed -S coreutils-selinux findutils-selinux iproute2-selinux logrotate-selinux openssh-selinux psmisc-selinux shadow-selinux cronie-selinux;
#    # 5. 
#    sudoSELinux;
#    # 6.
#    yay --noconfirm --needed -S systemd-selinux systemd-libs-selinux util-linux-selinux util-linux-libs-selinux;
#    yay --noconfirm -Si systemd-selinux;
#    # 7.
#    yay --noconfirm --needed -S dbus-selinux;
#    yay --noconfirm --needed -S selinux-alpm-hook;
#    #
#    yay --noconfirm --needed -S selinux-refpolicy-arch;
#    # or
#    # yay --noconfirm --needed -S selinux-refpolicy-git;
#    #
#    yay --noconfirm --needed -S mcstrans restorecond
#    yay --noconfirm --needed -S selinux-dbus-config selinux-gui selinux-python selinux-python2 selinux-sandbox
#    yay --noconfirm --needed -S selinux-refpolicy-src
    if [ -d "${TheWorkSpace}" ]; then
        if cd "${TheWorkSpace}"; then
            git clone https://github.com/archlinuxhardened/selinux;
            if cd selinux; then
                ./recv_gpg_keys.sh;
                ./build_and_install_all.sh;
            fi
        fi
    fi
}
# #############################################################################
# https://wiki.archlinux.org/index.php/SELinux
#   
sudoSELinux()
{
    # backup your /etc/sudoers
    if [ -f /etc/sudoers ]; then
        if [ ! -f /etc/sudoers.bak ]; then
            sudo cp /etc/sudoers /etc/sudoers.bak;
        fi 
    fi
    #
    yay --noconfirm --needed -S sudo-selinux;
    #
    # it is overridden when sudo-selinux package is installed as a replacement of sudo
    if [ -f /etc/sudoers.bak ]; then
        if sudo /usr/bin/cp -f /etc/sudoers.bak /etc/sudoers; then
            sudo /usr/bin/rm -f /etc/sudoers.bak;
        fi 
    fi 
}
# #############################################################################
# useage
usage() { show_help 0; exit 1; }
# #############################################################################
# printDoNotRun "Var-Name" "Value";
printDoNotRun()
{
    if [ "${2}" -eq 1 ]; then
        echo "${1}=${2}";
    fi
}
# END printDoNotRun
# #############################################################################
pacmanFast()
{
    print_caution "Software Updates" "pacman setting coutry" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman-mirrors --country United_States;
    print_caution "Software Updates" "fast-track before updates" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman-mirrors --fasttrack 6;
    print_caution "Software Updates" "pacman updates" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman --noconfirm --needed -Syyu;
    print_caution "Software Updates" "yay updates" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    yay --noconfirm --needed -Suyya;
    #sudo pacman --noconfirm --needed -Suy;
    #
    ThisRunPacmanFast=1;
}
# END pacmanFast
# #############################################################################
# I tried to make this AMD or Nvidia, AMD will ignore modprobe
installGraphicCard()
{
    # Install NVIDIA Drivers
    inxi -G
    if ! sudo mhwd -a pci nonfree 0300; then
       sudo mhwd-kernal -r linux59; 
        if ! sudo mhwd -a pci nonfree 0300; then
            echo "Graphic Card did not install.";
            exit 1;
        fi
    fi
    mhwd -li

    #sudo gedit /etc/mkinitcpio.conf 
    # delete the word nouveau from the following line:
    #MODULES=" nouveau" 
    #MODULES="" 
    #sudo mkinitcpio -p [linux kernel version]
    #sudo mkinitcpio -p linux310

    if [ "$ThisComputerNvidia" == "Xeon" ]; then
        #sudo chown ${USER}:${USER} ~/.xinitrc
        # Hit the 'Save to X Configuration File' button and save to /etc/X11/mhwd.d/nvidia.conf
        #sudo mhwd-gpu --setmod nvidia --setxorg /etc/X11/mhwd.d/nvidia.conf
        #sudo gedit ~/.xinitrc
        #nvidia-settings --load-config-only
        #exec $(get_session)
        #sudo nvidia-settings
        # Remove the NVIDIA driver
        #sudo mhwd -r pci video-nvidia 
        #sudo mhwd -r pci video-nvidia 
        print_caution "Software Updates" "nvidia-modprobe" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
        nvidia-modprobe;
    fi
}
# #############################################################################
# FIXME
setXclip()
{
    print_caution "Set xclip alias" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    if [ ! -f ~/.bash_aliases ]; then
        touch ~/.bash_aliase;
        echo '#!/bin/bash' > ~/.bash_aliase;
        echo 'alias setclip="xclip -selection c";' > ~/.bash_aliase;
        echo 'alias getclip="xclip -selection c -o";' >> ~/.bash_aliase;
    fi
    alias setclip="xclip -selection c";
    alias getclip="xclip -selection c -o";
}
# END setXclip
# #############################################################################
runFirst()
{
    if [ "$ThisRunPacmanFast" -eq 0 ]; then pacmanFast; fi
    print_caution "Run First" "Set up fail2ban" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman --noconfirm --needed -S pacman-contrib yay wget rsync nano glibc libc++ libgit2-glib gucharmap clang fail2ban ed cppcheck tidy npm testdisk;
    installGedit;
    sudo pacman --noconfirm --needed -S imagewriter vlc gtk-engines git git-lfs nfs-utils xclip ntfs-3g;
    sudo npm update; sudo npm install -g npm;

    if [ ! -f /etc/fail2ban/jail.local ]; then
        sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local;
        if ! sudoAppend "bantime = 3666h\n maxretry = 3\nignoreip = 127.0.0.1/8 192.168.1.13 192.168.0.13" /etc/fail2ban/jail.local; then
            echo "Error updating jail";
        fi
        sudo gedit /etc/fail2ban/jail.local;
    fi
    #
    sudo systemctl start fail2ban || sudo systemctl restart fail2ban;
    sudo systemctl status fail2ban;
    sudo systemctl enable fail2ban;
    # sudo systemctl stop fail2ban
    #
    sudo pacman --noconfirm --needed -S mlocate appstream;
    sudo updatedb;
    echo "Finished runFirst";
    makeHome;
}
# END runFirst
# #############################################################################
updateFonts()
{
    print_caution "Update Fonts" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    fc-list;
    fc-cache;
    fc-match;
}
# END updateFonts
# #############################################################################
installFonts()
{
    print_caution "Install Fonts" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    # Fonts
    sudo pacman --noconfirm --needed -S xorg-font-util xorg-fonts-75dpi xorg-fonts-encodings xorg-fonts-misc xorg-fonts-misc xorg-fonts-type1 xorg-fonts-cyrillic xorg-fonts-alias;
    sudo pacman --noconfirm --needed -S fontconfig xorg-xlsfonts awesome-terminal-fonts;
    sudo pacman --noconfirm --needed -S ttf-liberation ttf-ubuntu-font-family noto-fonts ttf-roboto ttf-droid ttf-dejavu ttf-croscore ttf-bitstream-vera font-bh-ttf;
    sudo pacman --noconfirm --needed -S ttf-anonymous-pro ttf-cascadia-code ttf-fira-mono gnu-free-fonts ttf-linux-libertine;
    sudo pacman --noconfirm --needed -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts;
    sudo pacman --noconfirm --needed -S xorg-fonts-type1 font-mathematica;
    sudo pacman --noconfirm --needed -S dina-font tamsyn-font terminus-font bdf-unifont terminus-font-otb ttf-fantasque-sans-mono;
    #yay --noconfirm --needed -S cairo-infinality fontconfig-infinality freetype2-infinality;
    yay --noconfirm --needed -S ttf-ms-fonts;
    #
    yay --noconfirm --needed -S ttf-tahoma all-repository-fonts;
    yay --noconfirm --needed -S ttf-vista-fonts;
    updateFonts;
}
# END installFonts
# #############################################################################
#
installSagemath()
{
    print_caution "Install sagemath" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman --noconfirm --needed -S sagemath;
    sudo pacman --noconfirm --needed -S octave;
    sudo pacman-key --recv-keys AE5A7FB608A0221C;
    yay --noconfirm --needed -S scilab;
}
# END installSagemath
# #############################################################################
#
installQuartus()
{
    print_caution "Install Quartus" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    yay --noconfirm --needed -S tcllib ncurses5-compat-libs lib32-ncurses5-compat-libs quartus-free-quartus;
}
# END installQuartus
# #############################################################################
# Adding user '$USER' to user-group 'sambashare'
installSamba()
{
    print_caution "Install Samba" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman --noconfirm --needed -S samba smbclient manjaro-settings-samba gvfs-smb nemo-share;
    configSamba;
}
# END installSamba
# #############################################################################
# 10.0.2.4 by default
# Samba name server XEOFF is now a local master browser for workgroup WORKGROUP on subnet 192.168.122.1
# Samba name server XEOFF is now a local master browser for workgroup WORKGROUP on subnet 192.168.1.13
# 192.168.122.1 255.255.255.0
# <range start="192.168.122.2" end="192.168.122.254"/>
configSamba()
{
    print_caution "Configure Samba" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    # Samba
    sudo mkdir -p "${TheSambaPublicFolder}";
    sudo chown -R nobody:nobody "${TheSambaPublicFolder}";

    #sudo chmod -R 0775 "${TheSambaPublicFolder}";


    #change the owner to sambausers
    sudo chown -R root:sambausers "${TheSambaPublicFolder}";

    #Give permission of the share
    sudo chmod 1770 "${TheSambaPublicFolder}";

    ###
    pushClipboard "[Public]\npath = ${TheSambaPublicFolder}\nbrowsable =yes\nwritable = yes\nguest ok = yes\nread only = no\nforce user = nobody\ncreate mask = 0700\ndirectory mask = 0700" 1;
    sudo gedit /etc/samba/smb.conf;
    ###
    # Create a new group called sambausers
    add_group sambausers; # Checks to see if it exists first

    sudo ufw allow CIFS;
    # Add "${USER}" to the sambausers group
    sudo passwd sambausers -a "${USER}";

    # create new password for user "${USER}";
    sudo smbpasswd -a "${USER}";


    pushClipboard "[Samba]\ntitle=LanManager-like file and printer server for Unix\ndescription=The Samba software suite is a collection of programs that implements the SMB/CIFS protocol for unix systems, allowing you to serve files and printers to Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred to as the LanManager or NetBIOS protocol.\nports=137,138/udp|139,445/tcp" 1;
    #[Samba]
    #title=LanManager-like file and printer server for Unix
    #description=The Samba software suite is a collection of programs that implements the SMB/CIFS protocol for unix systems, allowing you to serve files and printers to Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred to as the LanManager or NetBIOS protocol.
    #ports=137,138/udp|139,445/tcp
    sudo gedit /etc/ufw/applications.d/samba;

    sudo ufw app update Samba;
    sudo ufw allow Samba;
    restart_Samba;

    #/usr/bin/qemu-kvm -m 1024 -name f15 -drive file=/images/f15.img,if=virtio
    #-fsdev local,security_model=passthrough,id=fsdev0,path=/tmp/share -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare


    #    mount -t 9p -o trans=virtio,version=9p2000.L hostshare /tmp/host_files

    # on Windows
    #notepad C:\\Windows\System32\drivers\etc\hosts
    #192.168.1.13	Xeon.localhost	Xeon
}
# END configSamba
# #############################################################################
restart_Samba()
{
    print_caution "Start or Restart Samba" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    #
    sudo systemctl start smb.service || sudo systemctl restart smb.service;
    sudo systemctl enable smb.service;
    sudo systemctl status smb.service;
    #
    sudo systemctl start nmb.service || sudo systemctl restart nmb.service;
    sudo systemctl enable nmb.service;
    sudo systemctl status nmb.service;
    #
    sudo systemctl start smb.service || sudo systemctl restart smb.service;
    
    sudo systemctl status smb.service; sudo systemctl status nmb.service;
}
# END restart_Samba
# #############################################################################
launchBrowser()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    local thisURL;  thisURL="$1";
    local thisPath; thisPath="$(which xdg-open || which gnome-open)";
    if [ -x "${BROWSER}" ]; then thisPath="${BROWSER}"; fi
    if [ -x "${thisPath}" ]; then
        "${thisPath}" "${thisURL}"; return "$?";
    fi
    echo "Can't find browser";
    return 1;
}
# END launchBrowser
# #############################################################################
kvmTest()
{
    echo "";echo "KVM Test Started";echo "";
    # CPU is 64, 32 or other
    CPU_ARCH=$(uname -m);
    # Check for AMD and Intel support
    CPU_TYPE="";
    if grep -n -e 'model name' /proc/cpuinfo | head -1 | grep -iq intel; then CPU_TYPE="Intel"; else CPU_TYPE="AMD"; fi

    echo "CPU: ${CPU_TYPE}:${CPU_ARCH}";

    # Check for UEFI and set var for display
    UEFI_INSTALL="";
    if [ -d /sys/firmware/efi/ ]; then UEFI_INSTALL="/UEFI"; fi
    # kvm-ok check
    if ! command -v kvm-ok &> /dev/null; then yay --noconfirm --needed -S cpu-checker-bzr; fi
    # check kvm-ok output if found: INFO: /dev/kvm exists\nKVM acceleration can be used
    KVM_OK="";
    if kvm-ok | grep "INFO: /dev/kvm exists" &> /dev/null; then echo "KVM Enabled"; KVM_OK="KVM Enabled"; else echo "KVM \033[33;5;7mDisabled\033[0m"; KVM_OK="KVM Disabled"; fi
    KVM_INSTALLED="";
    if systool -m kvm_amd -v &> /dev/null; then
        echo "AMD-V is enabled in the BIOS${UEFI_INSTALL}."
        KVM_INSTALLED="AMD-V Enabled and AMD IOMMU Disabled";    
        if compgen -G "/sys/kernel/iommu_groups/*/devices/*" > /dev/null; then echo "AMD IOMMU is enabled in the BIOS${UEFI_INSTALL}"; KVM_INSTALLED="AMD-V and AMD IOMMU Enabled"; fi
    elif systool -m kvm_intel -v &> /dev/null ; then
        echo "Intel VT-X is enabled in the BIOS${UEFI_INSTALL}."
        KVM_INSTALLED="Intel VT-X Enabled and VT-D Disabled";    
        if compgen -G "/sys/kernel/iommu_groups/*/devices/*" > /dev/null; then echo "Intel VT-D is enabled in the BIOS${UEFI_INSTALL}"; KVM_INSTALLED="Intel VT-X and Intel VT-D Enabled"; fi
    else
        if sudo dmesg | grep DMAR &> /dev/null; then echo "DMAR"; else echo "No DMAR"; fi
    fi
    # List IOMMU Groups
    if [ "$(ls -A /sys/kernel/iommu_groups)" ]; then 
        echo "ERROR";
        shopt -s nullglob;
        for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
            echo "IOMMU Group ${g##*/}:"
            for d in "$g/devices"/*; do
                echo -e "\t$(lspci -nns "${d##*/}")"
            done;
        done;
    fi
    echo ""; echo "KVM Test Finished: ${CPU_TYPE}:${CPU_ARCH} - ${KVM_OK} - ${KVM_INSTALLED} "; echo "";
}
# #############################################################################
# if [ "$TheKvmFixBackup" -eq 1 ]; then kvmFixBackup; fi
kvmFixBackup()
{
    print_caution "Running kvmFixBackup..." "Backup Cow=${ThisCowBackUp} and using KVM Image Folder ${TheKvmImageFolder}" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    kvmTest;
    # sudo chown -R root:kvm /var/lib/libvirt/images
    if [ -d "${TheKvmImageFolder}" ]; then
        sudo chown -R "${USER}":kvm "${TheKvmImageFolder}"; # set folder permissions
        sudo chmod a+x "${TheKvmImageFolder}";              #
        sudo chmod -R a+x "${TheKvmImageFolder}";
    fi
    #
    if [ -d "${TheWindowsFolder}" ]; then
        sudo chmod a+x "${TheWindowsFolder}";
        sudo chmod -R a+x "${TheWindowsFolder}";
        sudo chown -R "${USER}":kvm "${TheWindowsFolder}";
    fi
    # spice-guest-tools-latest.exe
    if [ -d "$TheWindowsFolder" ]; then
        if [ "$ThisCowBackUp" -eq 1 ]; then
            mkdir -p "${TheCOW}";
            #        
            print_caution "KVM Virtual Machine Manager Permission Fix and COW back up" "This can take a while..." "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
            local thisFile;
            for thisFile in "${TheKvmImageFolder}"*; do 
                if copy_files "${thisFile}/" " " "${TheCOW}" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}"; then
                    echo "Backed up COW to ${TheCOW}";
                else
                    echo "Failed to back up COW to ${TheCOW}";
                fi
            done
        fi
    fi
    sudo libguestfs-test-tool;
    # This is to make a share between Linux and Windows
    #sudo chown -R "${USER}":kvm /run/media/"${USER}"
    #sudo chmod -R a+x /run/media/"${USER}"
}    
# #############################################################################
doSuperMinPatch()
{
    print_caution "Do supermin Patch" "This will cause a pacman update for this same app" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    if ! sudo libguestfs-test-tool; then 
        if cd "${TheWorkSpace}"; then
            git clone https://github.com/jeonsi/arch_supermin_patch.git;
            # 
            if cd "${TheWorkSpace}arch_supermin_patch"; then
                sudo pacman --noconfirm -Syu patch pkg-config;
                makepkg -si;
            fi
            if ! sudo libguestfs-test-tool; then echo "Failed libguestfs-test-tool"; fi
        fi
    fi
}    
# END doSuperMinPatch
# #############################################################################
modifyKVM()
{
    ########
    # https://github.com/vanities/GPU-Passthrough-Arch-Linux-to-Windows10
    # Windows 10 installation iso https://www.microsoft.com/en-us/software-download/windows10ISO
    # Direct Download: here https://software-download.microsoft.com/pr/Win10_1809Oct_English_x64.iso?t=673fe9a0-8692-49ba-b0e0-e8ca7d314fdc&e=1544486586&h=9bb1b05b0fe6d83b41a5e8780a406244
    # virtio* drivers for windows10 https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.160-1/
    # Direct Download: here         https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.160-1/virtio-win-0.1.160.iso
    # 
    kvmTest;
    #GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
    echo "Edit line GRUB_CMDLINE_LINUX_DEFAULT=quiet intel_iommu=on";
    pushClipboard "intel_iommu=on" 0;
    sudo gedit /etc/default/grub;
    sudo grub-mkconfig -o /boot/grub/grub.cfg;
    echo "Reboot to take effect";
    # 
    ###
    # https://cockpit-project.org/running#archlinux
    # https://dausruddin.com/how-to-enable-clipboard-and-folder-sharing-in-qemu-kvm-on-windows-guest/
    # https://www.spice-space.org/download/windows/spice-webdavd/
    # https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi
    sudo systemctl enable --now cockpit.socket;
    #
    # Add Hardware
    # org.spice-space.webdav.0
    pushClipboard "org.spice-space.webdav.0" 0;
    launchBrowser "http://localhost:9090";
    ###
    #
    if ! sudo libguestfs-test-tool; then thisPatch=1; fi
    if [ "$thisPatch" -eq 1 ]; then echo "supermin Patch required"; fi
    if [ "$thisPatch" -eq 1 ]; then doSuperMinPatch; fi
    # fails virshpatcher
    mkdir -p ~/.config/libvirt;
    if [ -f /etc/libvirt/libvirt.conf ]; then
        if [ ! -f ~/.config/libvirt/libvirt.conf ]; then
            sudo cp -rv /etc/libvirt/libvirt.conf ~/.config/libvirt/ && sudo chown "${USER}":"${USER}" ~/.config/libvirt/libvirt.conf;
        fi
    else
        echo "Failed /etc/libvirt/libvirt.conf";
    fi
    gedit ~/.config/libvirt/libvirt.conf;
    #
    if [ ! -f /etc/polkit-1/rules.d/50-libvirt.rules ]; then
        sudo touch /etc/polkit-1/rules.d/50-libvirt.rules;
        echo "Control-V to paste in the settings";
        pushClipboard "/* Allow users in wheel group to manage the libvirt daemon without authentication */\npolkit.addRule(function(action, subject) {\n    if (action.id == 'org.libvirt.unix.manage' && subject.isInGroup('wheel')) {\n            return polkit.Result.YES;\n    }\n#});" 1;
        #/* Allow users in wheel group to manage the libvirt daemon without authentication */
        #polkit.addRule(function(action, subject) {
        #    if (action.id == 'org.libvirt.unix.manage' && subject.isInGroup('wheel')) {
        #            return polkit.Result.YES;
        #    }
        #});
        sudo gedit /etc/polkit-1/rules.d/50-libvirt.rules;
    fi
    #
    # Change #unix_sock_group = "libvirt" to unix_sock_group = "libvirt" by removing the # comment on around line 81
    # unix_sock_rw_perms = "0770" to unix_sock_rw_perms = "0770" around line 104
    # un_comment_file 'unix_sock_group = "libvirt"' /etc/libvirt/libvirtd.conf;
    # un_comment_file 'unix_sock_rw_perms = "0770"' /etc/libvirt/libvirtd.conf;
    # un_comment_file 'unix_sock_ro_perms = "0770"' /etc/libvirt/libvirtd.conf;
    # un_comment_file 'auth_unix_ro = "none"' /etc/libvirt/libvirtd.conf;
    # un_comment_file 'auth_unix_rw = "none"' /etc/libvirt/libvirtd.conf;
    
    # the above failed
    #sudo gedit /etc/libvirt/qemu.conf;
    
    #sudo gedit /etc/libvirt/libvirtd.conf;

    # Add libvirt to your group
    sudo usermod -a -G libvirt "$(whoami)";
    
    add_user_2_group "libvirt";
    #newgrp libvirt

    #add_option "/etc/libvirt/qemu.conf" "security_driver=" "none" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #security_driver = "none"
    #sudo gedit /etc/libvirt/qemu.conf;

    # Close KVM then run
    sudo modprobe -r kvm_intel;
    sudo modprobe kvm_intel nested=1;
    #
    if ! is_string_in_file /etc/modprobe.d/kvm-intel.conf "options kvm-intel nested=1"; then
        sudo touch /etc/modprobe.d/kvm-intel.conf; echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
    fi
    echo "nested = Y and nested_early_check = N";
    systool -m kvm_intel -v | grep nested  
    # $ systool -m kvm_intel -v | grep nested
    #     nested              = "Y"
    #     nested_early_check  = "N"
    # $ cat /sys/module/kvm_intel/parameters/nested 
    # Y
    if ! is_string_in_file /sys/module/kvm_intel/parameters/nested "Y"; then
        echo "Failed /sys/module/kvm_intel/parameters/nested";
    fi
    
    #
    #
    # https://computingforgeeks.com/using-vagrant-with-libvirt-on-linux/
    # 
    #vagrant plugin install vagrant-libvirt
    if ! vagrant plugin install vagrant-libvirt vagrant-share; then
        # if fails:
        echo "vagrant plugin failed";
#        yay -Rs vagrant;
#        rm -rf ~/vagrant.d
#        rm -f /usr/local/bin/vagrant
#        rm -rf /opt/vagrant
#        yay -S vagrant;
#        net-ssh;
#        net-scp;
    fi
    pip3 install virt-backup
    # qt-virt-manager
    #
    kvmFixBackup;
    #sudo gedit /etc/libvirt/qemu.conf;
    #user = "root" to user = "root" round line 519
    #group = "root" to group = "root"
    #un_comment_file 'user = "root"' /etc/libvirt/libvirtd.conf;
    #un_comment_file 'group = "root"' /etc/libvirt/libvirtd.conf;
    #sudo gedit /etc/libvirt/libvirtd.conf;
    # libvirtError: internal error: process exited while connecting to monitor: Could not access KVM kernel module: Permission denied failed to initialize KVM: Permission denied
    # Systemd 234 assigns a dynamic ID for the kvm group (see FS#54943). 
    # To avoid this error, you need edit the file /etc/libvirt/qemu.conf and change the line with group = "78" to group = "kvm"
    #replace_option "/etc/libvirt/qemu.conf" "group =" "kvm" "${FUNCNAME[0]} @ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    #sudo gedit /etc/libvirt/qemu.conf;
    #    
    restart_libvirt; # sudo systemctl start libvirtd.service || { sudo systemctl restart libvirtd.service; } && { sudo systemctl status libvirtd.service; }
    sudo systemctl enable libvirtd.service;
    sudo systemctl status libvirtd.service;
    sudo systemctl start libvirtd.service || { sudo systemctl restart libvirtd.service; } && { sudo systemctl status libvirtd.service; }
    
    sudo systemctl start virtlogd.socket || { sudo systemctl restart virtlogd.socket; } && { sudo systemctl status virtlogd.socket; } 
    sudo systemctl enable virtlogd.socket;
    sudo systemctl status virtlogd.socket;
    #    
    restart_libvirt;
    #
    #sudo gedit /etc/libvirt/qemu.conf;
   
    virsh net-start default;
    isDMAR;
    # virtualbox vde2 virtualbox-guest-utils virtualbox-guest-dkms virtualbox-ext-vnc virtualbox-host-dkms virtualbox-guest-iso linux318-virtualbox-host-modules linux318-virtualbox-guest-modules
    sudo cp -rv /etc/libvirt/libvirt.conf ~/.config/libvirt/ && sudo chown "${USER}":kvm ~/.config/libvirt/libvirt.conf
}
# #############################################################################
declare MY_KVM_NAME; MY_KVM_NAME="Ubuntu-Mate-Cinnamon-Hirsute-21_04";
declare MY_KVM_RAM; MY_KVM_RAM="12048";
declare MY_KVM_COW_PATH; MY_KVM_COW_PATH="/media/KvmStorage/Cows/images/Ubuntu-Mate-Cinnamon-Hirsute-21_04.qcow2";
declare MY_KVM_SIZE_GB; MY_KVM_SIZE_GB="333";
declare MY_KVM_VCPU; MY_KVM_VCPU="9";
declare MY_KVM_OS_TYPE; MY_KVM_OS_TYPE="linux"; 
declare MY_KVM_OS_VARIANT; MY_KVM_OS_VARIANT="generic"; 
declare MY_KVM_ISO_IMAGE; MY_KVM_ISO_IMAGE="/media/KvmStorage/Linux/ubuntu-mate-21.04-Hirsute-desktop-amd64.iso"; 
createKVM()
{
    virt-install --name "$MY_KVM_NAME"  --ram "$MY_KVM_RAM" --disk path="$MY_KVM_COW_PATH",size="$MY_KVM_SIZE_GB" --vcpus "$MY_KVM_VCPU" --os-type "$MY_KVM_OS_TYPE" --os-variant "$MY_KVM_OS_VARIANT" --console pty,target_type=serial --cdrom "$MY_KVM_ISO_IMAGE";
}
# #############################################################################
# Ubuntu Client
# sudo apt install -y qemu-guest-agent
# sudo apt update && sudo apt -y upgrade && sudo apt -y  install cinnamon-desktop-environment lightdm qemu-guest-agent
installKVM()
{
    print_caution "Install KVM" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    kvmTest;
    local -i thisPatch; thisPatch=0;
    # KVM 
    # https://wiki.archlinux.org/index.php/libvirt
    # https://octetz.com/docs/2020/2020-05-06-linux-hypervisor-setup/
    # virtualgl
    # openbsd-netcat and gnu-netcat are in conflict. Remove gnu-netcat
    # spice-guest-tools
    #
    sudo pacman --noconfirm -R playonlinux;
    sudo pacman --noconfirm -R gnu-netcat; 
    sudo pacman --noconfirm --needed -S openbsd-netcat;
    sudo pacman --noconfirm --needed -S playonlinux;
    sudo pacman --needed -S ebtables;
    # fail2ban iproute2 systemd ufw
    sudo pacman --noconfirm --needed -S dhclient dnsmasq dmidecode bridge-utils vde2 libguestfs spice-protocol packagekit kexec-tools fmt;
    sudo pacman --noconfirm --needed -S qemu qemu-arch-extra qemu-block-gluster qemu-block-iscsi qemu-block-rbd qemu-guest-agent libvirt virt-viewer virt-manager virt-install;
    sudo pacman --noconfirm --needed -S vagrant spice-vdagent xf86-video-qxl edk2-armvirt libvirt-python libvirt-storage-rbd libvirt-dbus libvirt-storage-gluster;
    sudo pacman --noconfirm --needed -S cockpit cockpit-machines;
    # edk2-ovmf 
    yay --noconfirm --needed -S vagrant-libvirt virt-backup virtio-win qt-virt-manager;
    yay --noconfirm --needed -S spice-guest-tools-windows;
    #if ! yay --noconfirm --needed -S ovmf-git; then sudo pacman --noconfirm --needed -S extra/edk2-ovmf; fi
    sudo pacman --noconfirm --needed -S extra/edk2-ovmf;
    #
    modifyKVM;
    fix_kvm;
}
# END installKVM
# #############################################################################
restart_libvirt()
{
    print_caution "Start or restart libvirt" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo systemctl start libvirtd.service || { sudo systemctl restart libvirtd.service; } && { sudo systemctl status libvirtd.service; }
}
# END restart_libvirt
# #############################################################################
fix_kvm()
{
    virsh net-autostart default;
    sudo virsh net-start default;
    #sudo semanage fcontext -a -t svirt_image_t "${HOME}/KvmShare(/.*)?";
}
# #############################################################################
getDMAR()
{
    sudo dmesg | grep DMAR | grep "DMAR: IOMMU enabled";
}
# END getDMAR
# #############################################################################
isDMAR()
{
    if [ "$(getDMAR)" != "" ]; then
        echo "DMAR: IOMMU is enabled";
        return 0;
    else
        echo "DMAR: IOMMU is Not enabled";
        return 1;
    fi
}
# END isDMAR
# #############################################################################
#
installBluetooth()
{
    print_caution "Install Bluetooth" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo systemctl start bluetooth.service
    sudo systemctl enable bluetooth.service

    sudo systemctl start bluetooth

    sudo pacman --noconfirm --needed -S bluez bluez-utils pulseaudio-bluetooth bluez-plugins blueberry
    sudo modprobe btusb
    yay --noconfirm --needed -S xf86-input-joystick bluez-rfcomm bluez-hcitool


    sudo dmesg | grep Bluetooth
    sudo journalctl | grep Bluetooth
}
# END installBluetooth
# #############################################################################
installEquipment()
{
    print_caution "Install Equipment" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    # Microscope
    sudo pacman --noconfirm --needed -S guvcview-qt
    # Epson XP-4100 pick top local not IP
    yay --noconfirm --needed  -S epson-inkjet-printer-201301w;
}
# END installEquipment
# #############################################################################
installNpm()
{
    print_caution "Install Npm" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo npm install -g npm
    sudo npm install -g html-minifier
    sudo npm install -g jshint
}
# END installNpm
# #############################################################################
fixNpm()
{
    print_caution "fix Npm" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo npm update; sudo npm install -g npm;
    sudo pacman --noconfirm -S npm --overwrite='*';
}
# END fixNpm
# #############################################################################
#
installDev()
{
    print_caution "Install Dev" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    # *****************************************************************************
    sudo pacman --noconfirm --needed -S base base-devel multilib-devel cmake make pkg-config wget gperf icu harfbuzz harfbuzz-icu mesa lib32-mesa;
    sudo pacman --noconfirm --needed -S gcc autoconf automake make cmake ruby perl glibc lib32-glibc libc++ autoconf bison flex autogen git texinfo bash zlib;
    sudo pacman --noconfirm --needed -S net-tools inetutils git lib32-openssl openssl clang lib32-clang llvm ninja python patch scons sed shellcheck;
    sudo pacman --noconfirm --needed -S gcc autoconf automake net-tools inetutils doxygen gettext libtool libtiff zlib gd graphicsmagick;
    sudo pacman --noconfirm --needed -S fontconfig freetype2 lib32-fontconfig lib32-freetype2 xorg-fonts-type1 p7zip unzip zip lzip bzip2;

    sudo pacman --noconfirm --needed -S bash bash-bats bash-bats-assert bash-bats-support bash-completion;
    sudo pacman --noconfirm --needed -S expat gtk2 libcanberra libpng12 libice libsm util-linux ncurses tcllibx11 libxau libxdmcp libxext libxft libxrender libxt libxtst ld-lsb;
    sudo pacman --noconfirm --needed -S lib32-expat lib32-gtk2 lib32-libcanberra lib32-libpng lib32-libpng12 lib32-libice lib32-libsm lib32-util-linux lib32-ncurses lib32-zlib lib32-libx11 lib32-libxau lib32-libxdmcp lib32-libxext lib32-libxft lib32-libxrender lib32-libxt lib32-libxtst;
    # libpng2?
    sudo pacman --noconfirm --needed -S libpng;
    sudo pacman --noconfirm --needed -S nodejs nasm qemu fuse perl-html-parser;
    sudo pacman --noconfirm --needed -S pkgfile parallel;
    sudo pacman --noconfirm --needed -S maven at-spi2-atk double-conversion zstd dbus-x11;
    sudo pacman --noconfirm --needed -S libxslt libxcursor libxcomposite libxdamage libxrandr libcap libxtst libpulse libpciaccess libxss libgcrypt libdrm;
    sudo pacman --noconfirm --needed -S libcups pciutils nss libxtst pulseaudio libgudev alsa-lib gstreamer atk wayland;  
    sudo pacman --noconfirm --needed -S libxcb xcb-proto xcb-util xcb-util-image xcb-util-wm libxi xcb-util-keysyms;
    sudo pacman --noconfirm --needed -S psensor detox libltdl;
    sudo pacman --noconfirm --needed -S binaryen nodejs libxml2;
    sudo pacman --noconfirm --needed -S emscripten;    
    sudo pacman --noconfirm --needed -S discover packagekit-qt5 flatpak fwupd mono mono-tools mono-msbuild mono-addins dotnet-host;
    sudo pacman --noconfirm --needed -S unoconv pngquant;
    sudo pacman --noconfirm --needed -S ghostscript tidy xmlstarlet vagrant;
    sudo pacman --noconfirm --needed -S rsync nano; 
    sudo pacman --noconfirm --needed -S cvsps mercurial bzr valgrind python2-paramiko openmpi guake; 
    sudo pacman --noconfirm --needed -S pluma kate gcolor2 pango; 
    sudo pacman --noconfirm --needed -S boost boost-libs; 
    sudo pacman --noconfirm --needed -S perl-libwww perl-term-readkey perl-mime-tools perl-net-smtp-ssl perl-authen-sasl; 
    sudo pacman --noconfirm --needed -S lshw whois nodejs npm atom electron lib32-gtk2 lib32-libxss lib32-nss xterm gdb tk; 
    sudo pacman --noconfirm --needed -S gnome-disk-utility htop sshpass rsync openssh psutils; 
    sudo pacman --noconfirm --needed -S arm-none-eabi-gcc arm-none-eabi-newlib;
    #
    sudo pacman --noconfirm --needed -S yasm mingw-w64-binutils mingw-w64-crt mingw-w64-gcc mingw-w64-headers mingw-w64-winpthreads autoconf-archive libdatrie;
    yay --noconfirm --needed -S mingw-w64-libdatrie mingw-w64-configure mingw-w64-bzip2 mingw-w64-zlib;
    
    yay --noconfirm --needed -S mingw-w64-libthai;
    yay --noconfirm --needed -S mingw-w64-fontconfig;
    yay --noconfirm --needed -S mingw-w64-harfbuzz;
    yay --noconfirm --needed -S mingw-w64-freetype2;
    yay --noconfirm --needed -S mingw-w64-qt5-base
    yay --noconfirm --needed -S mingw-w64-boost;
    
    yay --noconfirm --needed -S git-git;
    yay --noconfirm --needed -S automake autoconf intltool libffi glib2 pcre ncurses dejagnu tcl tk perl-tk php bison flex lua emsdk;
    #yay --noconfirm --needed -S monodevelop-stable;
    #yay --noconfirm --needed -S monodevelop-git;  
    yay --noconfirm --needed -S mono-basic;
    #yay --noconfirm --needed -S msbuild-stable monogame-git
    yay --noconfirm --needed -S gnome-sharp xsp;
}
# END installDev

# #############################################################################
installMxe()
{
    # Get to the directory of your app, and run the Qt Makefile generator tool:
    # <mxe root>/usr/bin/i686-w64-mingw32.static-qmake-qt5
    # Build your project:
    # make
    # You should find the binary in the ./release directory:
    # wine release/foo.exe
    # If you want a 64-bit executable, build Qt with:
    # make MXE_TARGETS=x86_64-w64-mingw32.static qtbase
    # The default MXE_TARGETS value is i686-w64-mingw32.static.
    #     
    if ! cd "$TheWorkSpace"; then
        mkdir -p "$TheWorkSpace";
        if ! cd "$TheWorkSpace"; then
            echo "Error could not find WorkSpace $TheWorkSpace";
            return;
        fi
    fi
    if [ -d "${TheWorkSpace}/mxe" ]; then return; fi
    git clone https://github.com/mxe/mxe.git;
    if ! cd mxe; then
        make check-requirements;
        make download;
        make update;
        make qt5 MXE_TARGETS='i686-w64-mingw32.static x86_64-w64-mingw32.static';
        
    fi    
    # shellcheck disable=SC2016
    echo 'export PATH="$HOME/workspace/mxe:$PATH"' >> ~/.bash_profile;
}
# END installMxe
# #############################################################################
installQt()
{
    #
    # Qt 6 https://wiki.archlinux.org/index.php/qt
    # Online installer https://www.qt.io/download-thank-you?hsLang=en
    # xscrnsaver dbus-1
    sudo pacman --noconfirm --needed -S clang lib32-clang llvm ninja cmake python compiler-rt kcachegrind libpng libjpeg-turbo;
    sudo pacman --noconfirm --needed -S qt5-translations qt5-examples qt5-doc qt5-graphicaleffects;
    sudo pacman --noconfirm --needed -S python-dulwich python-fastimport python-gpgme python-paramiko;
    sudo pacman --noconfirm --needed -S perf valgrind bzr mercurial git x11-ssh-askpass qbs cmake gdb assimp lib32-glibc tk;
    sudo pacman --noconfirm --needed -S qt6-base qt6-3d qt6-declarative qt6-doc qt6-examples qt6-imageformats qt6-networkauth qt6-quick3d qt6-quickcontrols2 qt6-quicktimeline 
    sudo pacman --noconfirm --needed -S qt6-shadertools qt6-svg qt6-tools qt6-translations qt6-wayland qtcreator;
    sudo pacman --noconfirm --needed -S qt6-charts qt6-datavis3d qt6-lottie qt6-virtualkeyboard qt6ct qt6-5compat qt6-scxml;
    sudo pacman --noconfirm --needed -S bison flex gperf python nodejs fontconfig libdrm libxcomposite libxcursor libxi libxrandr libxtst;

    sudo pacman --noconfirm --needed -S qt5-webengine python-pyqt5-webengine;
    
    #sudo pacman --noconfirm -R qtcreator; sudo pacman --noconfirm -S qtcreator;
    #
    # not support conflict yay --noconfirm --needed -S qtchooser;
}
# #############################################################################
installAndroid()
{
    # To enable multilib repository, uncomment the [multilib] section in /etc/pacman.conf
    # https://wiki.archlinux.org/title/Android
    # https://wiki.archlinux.org/title/qt
    # https://wiki.archlinux.org/title/Java#OpenJDK
    sudo pacman --noconfirm --needed -S "$(comm -12 <(pacman -Qq | sort) <(pacman -Slq multilib | sort))";
    sudo pacman --noconfirm --needed -S base-devel multilib-devel gcc repo git gnupg gperf sdl wxgtk2 squashfs-tools curl ncurses zlib schedtool perl-switch libxslt bc rsync ccache lib32-zlib lib32-ncurses lib32-readline ttf-dejavu;
    yay --noconfirm --needed -S android-armv7a-eabi-qt5;
    yay --noconfirm --needed -S android-x86-qt5;
    yay --noconfirm --needed -S android-x86-64-qt5;
    yay --noconfirm --needed -S android-apktool android-host-tools android-sdk android-sdk-build-tools android-sdk-platform-tools;
    yay --noconfirm --needed -S android-sdk-build-tools-dummy android-sdk-dummy android-sdk-platform-tools-dummy android-sdk-cmdline-tools-latest-dummy;
    yay --noconfirm --needed -S android-studio android-support heimdall simg-tools;
    yay --noconfirm --needed -S android-host-tools android-udev-rules;
    yay --noconfirm --needed -S android-studio;
    yay --noconfirm --needed -S ncurses5-compat-libs lib32-ncurses5-compat-libs aosp-devel;
    yay --noconfirm --needed -S android-aarch64-qt5;
    sudo pacman --noconfirm --needed -S jre8-openjdk java8-openjfx;
}
# #############################################################################
installMisc()
{
    print_caution "Install Misc" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    yay --noconfirm --needed -S cinnamon-sound-effects password-gorilla;
    yay --noconfirm --needed -S ananicy-git;
    yay --noconfirm --needed -S google-earth;
    yay --noconfirm --needed -S cryptkeeper revelation;
    yay --noconfirm --needed -S nvm;
    yay --noconfirm --needed -S maldet;
    sudo pacman --noconfirm --needed -S aspell-en hunspell-en_US bluefish bluegriffon;
    sudo pacman --noconfirm --needed -S ffmpeg rtmpdump atomicparsley python-pycryptodome youtube-dl;

    sudo pacman --noconfirm --needed -S calibre-common sigil bookworm foliate gnome-books;
    #
    sudo pacman --noconfirm --needed -S translate-shell nfs-utils;
    sudo pacman --noconfirm --needed -S audacity ardour brasero cheese dvd+rw-tools dvdauthor; 
    sudo pacman --noconfirm --needed -S ffmpeg gaupol kdenlive mjpegtools mpgtx mencoder openshot devede gpicview pitivi; 
    sudo pacman --noconfirm --needed -S gst-libav gst-plugins-ugly libburn libisofs python-chardet; 
    sudo pacman --noconfirm --needed -S recordmydesktop xine-ui kimageformats catdoc xjadeo harvid frei0r-plugins; 
    sudo pacman --noconfirm --needed -S python-pyenchant opusfile libquicktime kipi-plugins python-nose; 
    sudo pacman --noconfirm --needed -S faac gpac espeak faac antiword unrtf odt2txt txt2tags nrg2iso bchunk; 
    sudo pacman --noconfirm --needed -S mpv mplayer;
    
    sudo pacman --noconfirm --needed -S mkvtoolnix-cli;
    yay --noconfirm --needed -S mkvalidator;
    yay --noconfirm --needed -S cpu-checker-bzr;
    #yay --noconfirm --needed -S lib32-ffmpeg lib32-libffmpeg lib32-chromaprint lib32-gst-plugins-bad;
}
# END installMisc
# #############################################################################
installCadGraphics()
{
    sudo pacman --noconfirm --needed -S freecad kicad kicad-library kicad-library-3d;
    yay --noconfirm --needed -S kicad-library-digikey-git kicad-library-sparkfun-git kicad-templates;
    #  kicad-symbols remove: kicad-library-3d and kicad-packages3d will remove: kicad-library
    # gimp-plug
    sudo pacman --noconfirm --needed -S gimp;
    yay --noconfirm --needed -S gimp-plugin-normalmap;
    # requires password yay --noconfirm --needed -S gimp-plugin-reflection;
    yay --noconfirm --needed -S gimp-plugin-insanebump;
    yay --noconfirm --needed -S gimp-plugin-make-anaglyph;
    yay --noconfirm --needed -S gimp-plugin-astronomy;
    sudo pacman --noconfirm --needed -S blender;
    sudo pacman --noconfirm --needed -S handbrake handbrake-cli kdegraphics; 
}
# #############################################################################
installMakehuman()
{
    yay --noconfirm --needed -S makehuman;
}
# #############################################################################
installPostgreSql()
{
    #
    #
    # postgresql setup
    # https://wiki.archlinux.org/index.php/PostgreSQL
    # postgresql-libs: PostgreSQL driver
    # mariadb-libs: MariaDB driver
    # unixodbc: ODBC driver
    # libfbclient: Firebird/iBase driver
    # freetds: MS SQL driver
    
    #sudo pacman --noconfirm -R pgadmin4 python-psycopg2 postgresql postgresql-libs
    #sudo rm -r /var/lib/postgres/data
    sudo pacman --noconfirm --needed -S postgresql postgresql-libs pgadmin4 sqlite;

    sudo -iu postgres
    createuser --interactive --pwprompt;
    initdb --locale=en_US.UTF-8 -E UTF8 -D /var/lib/postgres/data;
    initdb --locale "$LANG" -E UTF8 -D /var/lib/postgres/data;

    sudo systemctl start postgresql.service;
    sudo systemctl status postgresql.service;
    sudo systemctl enable postgresql.service;

    sudo systemctl restart postgresql.service;

    # hostname
    #echo "$(hostname)";

    #
    sudo -iu postgres;
    #su - postgres

    #psql -f "${TheWorkSpace}wasmrust/axWeBook/realworld-rust-rocket-master/init.sql";


    #createuser realworld
    #createdb realworld

    #grant all privileges on database realworld to realworld;

    #createuser ${USER}
    #createdb ${USER}

    #createuser --interactive --pwprompt

    #
    sudo nano /var/lib/postgres/data/postgresql.conf;
    #listen_addresses = 'localhost'    # what IP address(es) to listen on;
    # max_connections = 121 or 124, test for higher
    #
    sudo nano /var/lib/postgres/data/pg_hba.conf;
    #local   all             ${USER}                                  trust
}
# #############################################################################
installHaru()
{
    echo " Haru Library for PDF Support. ";
    sudo pacman --noconfirm --needed -S libharu;
}
# #############################################################################
installHaproxy()
{
    sudo pacman --noconfirm --needed -S haproxy monit;
    #
    sudo systemctl start haproxy.service || { sudo systemctl restart haproxy.service; }
    sudo systemctl enable haproxy.service;
    sudo systemctl status haproxy.service;

    #sudo systemctl stop haproxy.service;
    #sudo systemctl disable haproxy.service;

    #
    sudo systemctl start monit.service || { sudo systemctl restart monit.service; }
    sudo systemctl enable monit.service;
    sudo systemctl status monit.service;

    #sudo systemctl stop monit.service;
    #sudo systemctl disable monit.service;
}
# #############################################################################
installJava()
{
    sudo pacman --noconfirm --needed -S java-runtime-common unoconv jdk8-openjdk jre8-openjdk openjdk8-src openjdk8-doc;
    yay --noconfirm --needed -S mvnvm;
    yay --noconfirm --needed -S server-jre;

    yay --noconfirm --needed -S jdk-dcevm;

    yay --noconfirm --needed -S java-gcj-compat;
    yay --noconfirm --needed -S gcc6-gcj-compat;
    yay --noconfirm --needed -S gjdoc;
    #yay --noconfirm --needed -S jdk6 jdk5 zulu-jdk jdk9-openj9-bin jdk7 jre7 jre6 jdk7-j9-bin jdk7r1-j9-bin jdk8-j9-bin tuxjdk jre8-openjdk-jetbrains
    #yay --noconfirm --needed -S jre-devel jdk8-openj9-bin jre7-openjdk-infinality intellij-jdk jdk8 jre8 jdk jre jdk9 jre9 jdk-devel
    #yay --noconfirm --needed -S java-8-openjdk-shenandoah jre8-openjdk-infinality jre10-openjdk jre7-openjdk jre8-openjdk jre9-openjdk
    #yay --noconfirm --needed -S jdk-arm

}
# #############################################################################
installArchive()
{
    sudo pacman --noconfirm --needed -S arj cabextract p7zip sharutils unace unrar unzip uudeview zip lzip bzip2 minizip; 
}
# #############################################################################
installUtil()
{
    #  qt5-base qt5-declarative qt5-doc qt5-webkit qtcreator qt5-imageformats
    #  openvpn easy-rsa networkmanager-openvpn pptpclient networkmanager-pptp
    # avidemux avidemux-qt torcs scorched3d banshee unetbootin

    #yay --noconfirm --needed -S epubcheck wkhtmltopdf-static linkchecker nodejs-jshint python-weasyprint stylelint kindlegen 
    yay --noconfirm --needed -S epubcheck;
    yay --noconfirm --needed -S wkhtmltopdf-static; 
    yay --noconfirm --needed -S linkchecker;
    yay --noconfirm --needed -S nodejs-jshint;
    yay --noconfirm --needed -S python-weasyprint;
    yay --noconfirm --needed -S stylelint;
    yay --noconfirm --needed -S kindlegen; 


    # failed 
    if ! yay --noconfirm --needed -S csslint; then
        # if fails
        sudo npm install -g csslint;
    fi
    sudo npm install -g uglify-js;
    sudo npm install -g kindlegen;
    sudo npm install -g stylelint;
    sudo npm install -g epubcheck;
    sudo npm install -g yuicompressor;
    sudo npm install -g minify;
    #  uglify-js
    yay --noconfirm --needed -S yuicompressor minify; 
    
    yay --noconfirm --needed -S nodejs-clean-css-cli;

    sudo pacman --noconfirm --needed -S git make maven;

    yay --noconfirm --needed -S closure-compiler;

}
# #############################################################################
installInternet()
{
    sudo pacman --noconfirm --needed -S evolution evolution-bogofilter evolution-spamassassin aspell-en nmap arp-scan dnsutils traceroute procmail m4;
    sudo pacman --noconfirm --needed -S filezilla pidgin amule chromium opera transmission-qt; 
    yay --noconfirm --needed -S sendmail;
}
# #############################################################################
installGames()
{
    #  doom3 quake3 quake4
    sudo pacman --noconfirm --needed -S frozen-bubble aisleriot pysolfc pysolfc-cardsets libkdegames supertuxkart pingus;
    sudo pacman --noconfirm --needed -S bsd-games kajongg gnuchess knights atomix kde-games-meta supertuxkart nInvaders glChess;
    yay --noconfirm --needed -S bs qcheckers chessx blockout2 eduke32 darkplaces ecwolf flightgear flightgear-data fs2_open;
}
# #############################################################################
installEd()
{
    # qalculcate-gtk
    sudo pacman --noconfirm --needed -S stellarium celestia marble-qt kstars anki libwlocate shapelib blinken cantor genius geogebra goldendict;
    sudo pacman --noconfirm --needed -S kgeography kig mathomatic qcad xplanet gnuplot rlwrap kde-education-meta kalzium; 
    #yay --noconfirm --needed -S bible-time gpsbable kalgabra 
}
# #############################################################################
installClamAV()
{
    print_caution "Install ClamAV" "" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    # ClamAV
    # https://wiki.archlinux.org/index.php/ClamAV
    #
    sudo pacman --noconfirm --needed -S clamav clamtk;
    sudo freshclam;

    sudo systemctl start clamav-daemon.service;
    sudo systemctl status clamav-daemon.service;
    sudo systemctl enable clamav-daemon.service;

    #sudo systemctl start clamav-freshclam.service
    #sudo systemctl enable clamav-freshclam.service
    #sudo systemctl restart clamav-freshclam.service
    #sudo systemctl status clamav-freshclam.service

    #sudo systemctl start clamav-milter.service
    #sudo systemctl enable clamav-milter.service
    #sudo systemctl restart clamav-milter.service
    #sudo systemctl status clamav-milter.service



    #sudo systemctl enable clamd.service
    #sudo systemctl restart clamd.service
    #sudo systemctl status clamd.service

}
# END installClamAV
# #############################################################################
#
doScan()
{
    sudo maldet -u;
    sudo freshclam;
    if [ ${TheScanLevelAV} -eq 1 ]; then
        # clamscan --infected --recursive --remove /home;
        sudo maldet -a /home;
        sudo ionice -c3 nice -n 19 clamscan --remove=yes -r -i  /home | mail -s "ClamAV Report" jeffrey.scott.flesher@gmail.com;
    elif [ ${TheScanLevelAV} -eq 2 ]; then
        sudo maldet -a /home;
        sudo ionice -c3 nice -n 19 clamscan --remove=yes --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin|^/mnt' / | mail -s "ClamAV Report" jeffrey.scott.flesher@gmail.com;
    elif [ ${TheScanLevelAV} -eq 3 ]; then
        sudo maldet -a /home;
        sudo ionice -c3 nice -n 19 clamscan --remove=yes --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin' / | mail -s "ClamAV Report" jeffrey.scott.flesher@gmail.com;
    fi
    # clamscan myfile
    # clamscan --recursive=yes --infected /home # or -r -i
    # clamscan --infected --recursive --remove $ThisRoofFolder/2.Websites
}
# #############################################################################
# installGedit
installGedit()
{
    print_caution "Install Gedit" "Plugins" "@ ${FUNCNAME[0]}() : ${LINENO[0]}";
    sudo pacman --noconfirm --needed -S  gedit gedit-plugins;
    yay  --noconfirm --needed -S gedit-duplicate-line;
    # gedit plugin shellcheck
    # https://github.com/lwindolf/gedit-shellcheck
    if [ ! -d "${HOME}/.local/share/gedit/plugins/" ]; then
        if cd ~/; then
            mkdir -p "${HOME}/.local/share/gedit/plugins/tmp/";
            if cd "${HOME}/.local/share/gedit/plugins/tmp/"; then
                git clone https://github.com/lwindolf/gedit-shellcheck.git;
                /usr/bin/cp -rf gedit-shellcheck/shellcheck.plugin gedit-shellcheck/shellcheck/ "${HOME}/.local/share/gedit/plugins/";
            fi
            if cd ~/; then
                /usr/bin/rm -rf "${HOME}/.local/share/gedit/plugins/tmp/";
            fi
        fi
    fi
}
# END installGedit
# #############################################################################
isError()
{
    # Troubleshooting
    sudo systemctl --failed;
    return "$?";
}
# END isError
# #############################################################################
# if ! sudoAppend "String to Apppend" "full-file-path-name-extentsion"; then echo "Failed"; fi
sudoAppend()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    if is_string_in_file "$2" "$1"; then return 0; fi    
    echo "$1" | sudo tee -a "$2" > /dev/null;
    return "$?";
}
# END sudoAppend
# #############################################################################
fixSudoTimeOut()
{
    #sudo visudo;
    #export EDITOR=nano; 
    #EDITOR=nano sudo visudo;
    local thisString; thisString="Defaults        env_reset,timestamp_timeout=666";
    sudo cp /etc/sudoers ~/Downloads;
    sudo chown "$USER":"$USER" ~/Downloads/sudoers;
    if is_string_in_file ~/Downloads/sudoers "$thisString"; then return 0; fi    
    #
    if sudoAppend "$thisString" ~/Downloads/sudoers; then 
        #
        if sudo visudo -c -f ~/Downloads/sudoers; then
            if ! sudoAppend "$thisString" /etc/sudoers; then 
                ifError "Failed ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}";
                sudo gedit /etc/sudoers; 
            fi
            if ! sudo visudo -c -f /etc/sudoers; then
                ifError "Failed ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}";
            fi
        fi
    else
        ifError "Failed ${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}";
        sudo gedit ~/Downloads/sudoers; 
    fi
}
# END fixSudoTimeOut
# #############################################################################
ifError()
{
    [[ $# -ne 1 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    print_error "$1" "@ $(basename "${BASH_SOURCE[0]}") -> ${FUNCNAME[0]}() : ${LINENO[0]}";
    
    if [ "$IsBeeper" -eq 1 ]; then
        dobeep;
    fi
}
# END ifError
# #############################################################################
# installThis "list of things to install"
# install_package_with 1->(Package) 2->(Confirm [1=no-confirm]) 3->(Force [1=Force]) 4->(alternet install [0=normal,1=alternet])
installThis()
{
    [[ $# -ne 2 ]] && { print_error "LOCALIZE_WRONG_ARGS_PASSED_TO" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}"; exit 1; }
    if [ "${SimulateThis}" -eq 0 ]; then
        echo "installThis";
        if ! install_package_with "$1" 1 0 "$2"; then
            ifError "Failed installThis";
        fi
    else
        echo "Simulate installThis";
    fi
}
# END installThis
# #############################################################################
# installGem bundler
# 
installGem()
{
    local gemname; gemname="$1";
    gem install "$gemname";
    sudo pacman --noconfirm --needed -S ruby-"$gemname";
}
# END installGem
# #############################################################################
# ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]
rubyVersion()
{
    local thisVersion; thisVersion="$(ruby -v)";
    thisVersion="${thisVersion:5}";
    thisVersion="${thisVersion%%p*}";
    echo "$thisVersion";
}
# END rubyVersion
# #############################################################################
installUnrealEngine()
{
    #
    if [ ! -d "$ThisUnrealEngineGitFolder" ]; then 
        if cd "${ThisRoofFolder}/workspace"; then
            git clone https://github.com/Light-Wizzard/UnrealEngine.git
            if ! cd UnrealEngine; then 
                echo "Error Unreal Engine";
                exit 1;
            fi
        fi
    fi
    #
    if cd "${TheWorkSpace}UnrealEngine/Engine"; then
        git pull; 
    fi
    #
    if cd "${TheWorkSpace}UnrealEngine"; then
        git pull;
        ./Setup.sh;
        ./GenerateProjectFiles.sh;
        make -j1;
    fi
    #
    if cd "${TheWorkSpace}UnrealEngine/Engine/Binaries/Linux"; then
        ./UE4Editor
        "${TheWorkSpace}UnrealEngine/Engine/Binaries/Linux/UnrealVersionSelector-Linux-Shipping" -editor %f;
    fi
    #
    sudo chmod -R a+rwX /opt/unreal-engine/Engine;
    if cd /opt/unreal-engine/Engine; then 
        git pull; 
    fi
    #
    # https://github.com/nmrugg/UE4Launcher
    if [ ! -d "$ThisUnrealEngineLauncherGitFolder" ]; then 
        if cd "${ThisRoofFolder}/workspace"; then
            git clone https://github.com/nmrugg/UE4Launcher.git;
        fi
    fi
    # Update
    if cd "${TheWorkSpace}UE4Launcher"; then
        git pull; 
        npm i; 
        npm audit fix; 
        npm start;
    fi
}
# #############################################################################
# You have to download the software from ST
# https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-performance-and-debuggers/stm32cubemonitor.html#get-software
# https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-ides/stm32cubeide.html
# https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stm32cubeprog.html
# https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-configurators-and-code-generators/stm32cubemx.html#get-software
# https://my.st.com/content/my_st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-utilities/st-mcu-finder-pc.html
installSTM32()
{
    yay --noconfirm --needed -S stm32cubemx;
    yay --noconfirm --needed -S stm32cubeide;
    yay --noconfirm --needed -S stm32flash;
    yay --noconfirm --needed -S stm32cubemonitor;
    yay --noconfirm --needed -S stm32cubeprog;
    yay --noconfirm --needed -S stmcufinder;
    #yay --noconfirm --needed -S sw4stm;
}
# #############################################################################
#installKDE()
#{
#    
#}
# #############################################################################
installWine()
{
    # pywinery bottles  
    sudo pacman --noconfirm -R jack;
    sudo pacman --noconfirm --needed -S jack2;
    sudo pacman --noconfirm --needed -S base-devel mono mono-tools xterm wine-staging playonlinux winetricks wine-gecko wine-mono zenity unixodbc wine-nine;
    sudo pacman --noconfirm --needed -S wget xosd cups samba dosbox ncurses giflib gnutls mpg123 openal v4l-utils opencl-icd-loader;
    sudo pacman --noconfirm --needed -S libldap libpulse alsa-plugins alsa-lib libjpeg-turbo libxcomposite libxinerama libxslt libva gst-plugins-base-libs vulkan-icd-loader;
    sudo pacman --noconfirm --needed -S lib32-mpg123 lib32-giflib lib32-libldap lib32-v4l-utils lib32-libjpeg-turbo lib32-libxcomposite lib32-gst-plugins-base lib32-gst-plugins-good;
    sudo pacman --noconfirm --needed -S lib32-gnutls lib32-libcups lib32-libxrandr lib32-libxinerama lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-alsa-oss lib32-openal lib32-ncurses;
    sudo pacman --noconfirm --needed -S lib32-opencl-icd-loader lib32-libxslt lib32-libva lib32-gst-plugins-base-libs lib32-vulkan-icd-loader;
    sudo pacman --noconfirm --needed -S libpng-apng lib32-libpng;
    sudo pacman --noconfirm --needed -S a2jmidid libffado jack2-dbus realtime-privileges zita-ajbridge lib32-giflib lib32-mpg123 lib32-v4l-utils opencl-icd-loader lib32-sdl opencl-driver;  
    sudo pacman --noconfirm --needed -S lib32-libxslt lib32-libva lib32-gst-plugins-base-libs lib32-vulkan-icd-loader vkd3d lib32-vkd3d dosbox kdialog lib32-opencl-driver opencl-headers;
    sudo pacman --noconfirm --needed -S lib32-libva-vdpau-driver lib32-libva-intel-driver opencl-clhpp;
    sudo pacman --noconfirm --needed -S fuseiso;
    #sudo pacman --noconfirm --needed -S libpng lib32-libpng;
    sudo winetricks --self-update;
    #  lib32-gst-plugins-ugly
    yay --noconfirm --needed -S q4wine dxvk-bin mono-basic wineasio wine-installer wine-browser-installer wine-libusb-git wine-mono-gecko-version-fix;
    regsvr32 wineasio.dll;
    wine64 regsvr32 wineasio.dll;
    # shellcheck disable=SC2046
    # shellcheck disable=SC2062
    sudo pacman --noconfirm --needed -Ss $(pacman -Qq | grep lib32-*);
    #for P in "$(pacman -Qq | grep lib32-*)"; do if ! (pacman -Q | grep ${P} > /dev/null); then sudo pacman --noconfirm --needed -S "${P}"; fi done    
    # shellcheck disable=SC2046
    sudo pacman --noconfirm --needed -S $(pactree -l wine-staging);
    sudo systemctl restart systemd-binfmt;
    sudo winetricks --self-update;
}
# #############################################################################
installCodec()
{
    sudo pacman --noconfirm --needed -S celt lame a52dec libdca libmad libmpcdec opencore-amr speex libvorbis faac faad2 libfdk-aac fdkaac jasper libwebp;
    sudo pacman --noconfirm --needed -S aom dav1d rav1e svt-av1 libde265 libdv libmpeg2 schroedinger libtheora libvpx x264 x265 xvidcore;
    sudo pacman --noconfirm --needed -S mkvtoolnix-cli mkvtoolnix-gui ogmtools xine-lib xine-ui gst-libav;
    yay --needed -S mp4joiner mp4tools; 
    yay --needed -S daala-git openjpeg;
    # yay --needed -S opus-git x264-git x265-hg libde265-git libvpx-git 
    #
    #yay --needed -S neroaac-bin 
}
# #############################################################################
# sudo rndc flushname fix-america-now.org
# 192.168.1.13
# 255.255.255.0
# 192.168.1.254
# nameserver 127.0.0.1
# nameserver 8.8.8.8
# nameserver 8.8.4.4
clearDNS()
{
    sudo systemctl restart nscd;
    sudo nscd -K;
    sudo systemctl restart dnsmasq;
    sudo systemctl restart named;
}
# #############################################################################
installSQLite()
{
    sudo pacman --noconfirm --needed -S sqlite sqlitebrowser;
}
# #############################################################################
installNTP()
{
    sudo pacman --noconfirm --needed -S ntp;
    sudo systemctl start ntpd;
    sudo systemctl status ntpd;
    sudo systemctl enable ntpd;
    sudo systemctl restart ntpd;

    #sudo systemctl enable ntp.service
    #sudo systemctl restart ntp.service

    #sudo gedit /etc/ntp.conf
    #iburst
    sudo timedatectl set-timezone America/Los_Angeles;
    sudo timedatectl set-local-rtc 0; # sets RTC to UTC
    
}
# #############################################################################
runThisStuff()
{
    echo "Running Stuff RUN_OPTIONS=${RUN_OPTIONS} and DoNotRun=$DoNotRun";
    if is_root_user; then echo "Do not run as root"; exit 1; fi
    # Begin Script
    echo "";
    if [ "$ThisClearOk" -eq 0 ]; then cls; fi # clear;
    echo "";
    sudo_Required "${FUNCNAME[0]}";
    # 
    if [ "${RUN_OPTIONS}" -eq 1 ] && [ "$DoNotRun" -eq 0 ]; then
        #
        # Start App belows
        echo "Run Stuff";
        #
        if [ "${TheRunFirst}" -eq 1 ] && [ "$DoNotRun" -eq 0 ]; then
            fixSudoTimeOut;
            pacmanFast;
            runFirst; # makeHome;
            installNTP;
            installGraphicCard;
            installFonts;
            installCodec;
            installDev;
            installMisc;
            installNpm;
            installClamAV;
            installGedit;
            installArchive;
            installInternet;
            installEquipment;
            installBluetooth;
            installJava;
            installUtil;
            installSamba;
            #installPostgreSql;
            installSQLite;
            installWine;
            installCadGraphics;
            installQt;
            installMxe;
            #installUnrealEngine;
            #installSTM32;
            #isDMAR;
            installGames;
            installEd;
            installKVM;
            installGem bundler;
            installGem net-ssh;
            installGem net-scp;
            #rubyVersion;
            #installQuartus;
            #installSagemath;
            #installAndroid;
            #installMakehuman;
            #installHaru;
        fi
        #
        # End App before here
        #    
    elif [ "$TheRunScan" -eq 1 ]; then
        echo "TheRunScan=1";
        doScan;
    elif [ "$TheKvmFixBackup" -eq 1 ]; then 
        kvmFixBackup;        
    fi
    #
    if [ "${SetDebug}" -eq 1 ]; then set +x; fi # turn OFF debug mode
    #
    print_this "WIZ_BYE" "${FUNCNAME[0]}() @ $(basename "${BASH_SOURCE[0]}") -> : ${LINENO[0]}";
    #
    tput sgr0; # Reset the Terminal on Exit
}
# END runThisStuff
# #############################################################################
if [ -f "${TheWizardPath}/wizard-common.sh" ]; then
    echo -e "\033[0;32mLoading\033[0m ${TheWizardPath}/wizard-common.sh ";
    #. "${TheWizardPath}/wizard-common.sh";
    # shellcheck disable=SC1091
    # shellcheck disable=SC1090
    source "${TheWizardPath}/wizard-common.sh";
else
    echo "File Not Found: ${TheWizardPath}/wizard-common.sh - $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
    #exit 1;
fi
# #############################################################################
startTime;
checkArgs "$@";
if [ -f "${TheWizardPath}/wizard.sh" ]; then
    echo -e "\033[0;32mLoading\033[0m ${TheWizardPath}/wizard.sh ";
    #. "${TheWizardPath}/wizard.sh";
    # shellcheck disable=SC1091
    # shellcheck disable=SC1090
    source "${TheWizardPath}/wizard.sh";
else
    echo "File Not Found: ${TheWizardPath}/wizard.sh - $(basename "${BASH_SOURCE[0]}") : ${LINENO[0]}";
    #exit 1;
fi
#
runThisStuff;
#
endTime;
# #############################################################################
# ******************************** End of Script ******************************

