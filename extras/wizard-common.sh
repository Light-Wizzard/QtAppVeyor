#!/bin/bash
#
#
# XXX
# Check to see if set
#if [ -z ${XXX+x} ]; then declare -ix XXX; XXX=0; export XXX; fi

# Localization of all script tags to support language
# TheRunLocalizer
# Check to see if set
if [ -z ${TheRunLocalizer+x} ]; then declare -i TheRunLocalizer; TheRunLocalizer=0; export TheRunLocalizer; fi
#
# PrintDebug
# Check to see if set
if [ -z ${PrintDebug+x} ]; then declare -i PrintDebug; PrintDebug=0; export PrintDebug; fi
#
# ThisArrayIndex
# Check to see if set
if [ -z ${ThisArrayIndex+x} ]; then declare -i ThisArrayIndex; ThisArrayIndex=0; export ThisArrayIndex;  fi
#
# YN_OPTION
# Check to see if set
if [ -z ${YN_OPTION+x} ]; then declare -ix YN_OPTION; YN_OPTION=0; export YN_OPTION;  fi
# #############################################################################
# printLocalized "Locized this" "Optional Text not Localized"
printLocalized()
{
    if [ $# -ne 2 ]; then gettext -s "LOCALIZE_WA_PRINT_LOCALIZED"; exit 1; fi
    [[ -z ${1+x} ]] && { return 1; }
    [[ -z ${2+x} ]] && { return 1; }
    #printf "%s %s\n" "$(gettext -s "${1}")" "${2}";
    if [ $# -eq 1 ]; then echo -e "$(gettext -s "${1}")"; else echo -e "$(gettext -s "${1}") ${2}"; fi
}
# END 
export -f printLocalized;
# #############################################################################
# YN_OPTION
# Check to see if set
if [ -z ${YN_OPTION+x} ]; then declare -x YN_OPTION; YN_OPTION=""; export YN_OPTION; fi
# read_input_yn_c "Do you want to do this" "" 1;
# 
declare -i TheAnswer; TheAnswer=0;
read_input_yn_c()
{
    if [ $# -ne 3 ]; then printLocalized "LOCALIZE_WA_READ_INPUT" ""; exit 1; fi
    [[ -z ${1+x} ]] && { return 1; }
    [[ -z ${2+x} ]] && { return 1; }
    [[ -z ${3+x} ]] && { return 1; }
    local -i thisOption; thisOption=0;
    # read_input_yn_c "Is this Correct" "This" 1
    # GET INPUT YN
    get_input_yn()
    {
        echo "";
        if [ "${3}" == "1" ]; then
            printf "%s %s %s\n" "${1}" "${2}" "[Y/n]:";
        else
            printf "%s %s %s\n" "${1}" "${2}" "[y/N]:";
        fi
        read -r -n 1;
        echo "";
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
            printLocalized "LOCALIZE_WK_READ_INPUT" "${thisAN}";
        fi
    done
}
# END 
export -f read_input_yn_c;
# #############################################################################
# Time Variables to show execution time
declare -x TimeStart; export TimeStart;
declare -x TimeEnd;   export TimeEnd;
declare -x TimeRun;   export TimeRun;
# #############################################################################
startTime()
{
    TimeStart="$(date +"%s.%N")";
}
# END 
export -f startTime;
# #############################################################################
endTime()
{
    local dd dh dm ds TimeRunDays TimeRunHours;
    #
    TimeEnd="$(date +"%s.%N")";
    #
    TimeRun="$(echo "${TimeEnd} - ${TimeStart}" | bc)";
    # Day
    dd="$(echo "${TimeRun}/86400" | bc)";
    TimeRunDays="$(echo "${TimeRun}-86400*${dd}" | bc)";
    # Hour
    dh="$(echo "${TimeRunDays}/3600" | bc)";
    TimeRunHours="$(echo "${TimeRunDays}-3600*${dh}" | bc)";
    # Minute
    dm="$(echo "${TimeRunHours}/60" | bc)";
    # Second
    ds="$(echo "${TimeRunHours}-60*${dm}" | bc)";
    # Print it to screen
    LC_NUMERIC=C printf "$(printLocalized "LOCALIZE_RUNTIME" ""): %d:%02d:%02d:%02.4f\n" "${dd}" "${dh}" "${dm}" "${ds}";
}
# END 
export -f endTime;
# #############################################################################
# found in wizard-common.sh
if [ "${TheRunLocalizer}" -eq 1 ]; then localize_common; fi
# ################################ END OF SCRIPT ##############################
