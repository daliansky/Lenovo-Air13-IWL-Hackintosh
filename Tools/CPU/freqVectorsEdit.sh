#!/bin/bash

#
# Script (freqVectorsEdit.sh) to add 'FrequencyVectors' from a source plist to Mac-F60DEB81FF30ACF6.plist
#
# Version 3.2 - Copyright (c) 2013-2017 by Pike R. Alpha
#
# Updates:
#			- v0.5	Show Mac model info (Pike R. Alpha, December 2013)
#			-       Check for 'FrequencyVectors' in the Resource directory (Pike R. Alpha, December 2014)
#			-       Touch /S*/L*/Extensions (Pike R. Alpha, January 2014)
#			-       Ask if the user wants to reboot (Pike R. Alpha, February 2014)
#			- v0.6	Bug report/feedback info/link added (Pike R. Alpha, April 2014)
#			- v0.7	Cleanups/comments added (Pike R. Alpha, April 2014)
#			-       Implement gCallOpen like ssdtPRGen.sh (Pike R. Alpha, April 2014)
#			-       Implement _findPlistBuddy like ssdtPRGen.sh (Pike R. Alpha, April 2014)
#			- v0.8	Curl link and other typos fixed (Pike R. Alpha, April 2014)
#			- v0.9	Implement _selectEditor like dpEdit.sh (Pike R. Alpha, April 2014)
#			-       function _convertXML2BIN added (Pike R. Alpha, May 2014)
#			- v1.0	board-id's of the late iMac and Mac mini added (Pike R. Alpha, October 2014)
#			- v1.1	board-id's of the late 2014 iMac corrected (Pike R. Alpha, October 2014)
#			- v1.2	Implement _clearLines like AppleIntelFramebufferAzul.sh (Pike R. Alpha, October 2014)
#			-       Implement _showDelayedDots like AppleIntelFramebufferAzul.sh
#			- v1.3  Implement _invalidMenuAction like AppleIntelFramebufferAzul.sh (Pike R. Alpha, November 2014)
#			-       Implement _toLowerCase like AppleIntelFramebufferAzul.sh
#			-       Option 'Exit' to menus added (Pike R. Alpha, November 2014)
#			-       Improved layout of menus / styling added like AppleIntelFramebufferAzul.sh
#			- v1.4  Use function _getBoardID to set target plist (Pike R. Alpha, November 2014)
#			- v1.5  Use defaults write to store preferences (Pike R. Alpha, December 2015)
#			-       Copied _checkLibraryDirectory from ssdtPRGen.sh
#			-       Copied _checkForConfigFile from ssdtPRGen.sh
#			-       Copied _getScriptArguments from ssdtPRGen.sh
#			-       Copied _invalidArgumentError from ssdtPRGen.sh
#			-       New function _getPMValue added to read PM data values.
#			-       New function _toLittleEndian added to convert values for function _getPMValue.
#			- v1.6  Now using Models.cfg from ssdtPRGen.sh (Pike R. Alpha, January 2016)
#			-       Function _getModelByPlist replaced by _getModelByBoardID
#			- v1.7  Unused function _getModelByPlist removed (Pike R. Alpha, February 2016)
#			-       Expand function _convertXML2BIN to show new/missing PM data.
#			- v1.8  Use defaults read to select the editor (Pike R. Alpha, February 2016)
#			-       Cleanups done, typo fixed, style nit and bug fixes.
#			- v1.9  Fix defaults read to select the editor (Pike R. Alpha, February 2016)
#			-       Variable gFirstRun removed (no longer used).
#			-       Calls to _showHeader and _selectEditor moved out of main.
#			- v2.0  Dump HWP and EPP settings (Pike R. Alpha, April 2016)
#			- v2.1  Fix regression in debug output (Pike R. Alpha, April 2016)
#			- v2.2  Remove StepContextDict from plist (Pike R. Alpha, July 2016)
#			- v2.3  Check for FrequencyVectors array added.
#			-       Add array for FrequencyVectors when it is missing.
#			-       Quick and dirty fix for Xcode-beta.app added.
#			- v2.4  PM type NORMAL, KGROUND, LTIME_LONG and THRU_TIER0 added (Pike R. Alpha, October 2016)
#			- v2.5  PM type ratioratelimit, io_epp_boost, ring_mbd_ns and ring_ratio added (Pike R. Alpha, January 2017)
#			- v2.6  Kaby Lake support added (Pike R. Alpha, February 2017)
#			-       Fixed debug output/support for multiple FrequencyVectors added.
#			- v2.7  Debug output now also shows the LFM frequency (Pike R. Alpha, February 2017)
#			-       Automatic LFM frequency patching added.
#			- v2.8  Fix output styling (Pike R. Alpha, February 2017)
#			- v2.9  Add lost epp_override (Pike R. Alpha, February 2017)
#			- v3.0  Use frequency instead of index in filename (Pike R. Alpha, February 2017)
#			-       Function _getLFMFrequency now reads the binary file.
#			-       Function _patchLFM now relies on binary file instead of .dat file.
#			-       Function _getLowestFrequency (minimum ratio) added.
#			-       Function _getHighestFrequency (maximum ratio) added.
#			- v3.1  Show 'Unknown Model' in red (Pike R. Alpha, March 2017)
#			-       Function _getHWP added.
#			-       Function _getFrequencies added.
#			-       Show matching board-id in bold.
#			-       Show Frequencies and HWP setting.
#			- v3.2  Renamed _listmatchingFiles to _selectSourceResourceFile()
#
#
# Known issues:
#
#			- Multiple FrequencyVectors in a plist are currently not supported/show up blank.
#			- Available plist are shown in random order instead of Haswell, Broadwell and Skylake.
#
#
# Bugs:
#			- Bug reports can be filed at https://github.com/Piker-Alpha/freqVectorsEdit.sh/issues
#			  Please provide clear steps to reproduce the bug, the output of the script. Thank you!
#

#================================= GLOBAL VARS ==================================

#
# Script version info.
#
gScriptVersion=3.2

#
# Path and filename setup.
#
gHome=$(echo $HOME)
gPath="${gHome}/Library/ssdtPRGen"
gDataPath="${gPath}/Data"
gPrefsPath="${gHome}/Library/Preferences"

#
# Possible editors.
#
gXcode="/usr/bin/open -Wa /Applications/Xcode.app"
gNano="/usr/bin/nano"
gVi="/usr/bin/vi"

#
# This is the selected editor. By default it is set to: "$gNano"
# and later, during the first run, updated (do not change this).
#

gEditor="$gNano"

#
# Initialised in function _selectSourceResourceFile()
#
gSourcePlist=""

#
# Initial target is MacPro6,1 (updated in function main)
#
gTargetPlist="Mac-F60DEB81FF30ACF6.plist"

#
#
#
gExtensionsDirectory="/System/Library/Extensions"

#
# Path to kext.
#
gResourcePath="${gExtensionsDirectory}/IOPlatformPluginFamily.kext/Contents/PlugIns/X86PlatformPlugin.kext/Contents/Resources"

#
# Get user id
#
let gID=$(id -u)

#
# Change this to 0 if you don't want additional styling (bold/underlined).
#
let gExtraStyling=1

#
# Setting the debug mode (default off).
#
let gDebug=0

#
# Global variable used for the used/target board-id.
#
gBoardID=""

#
# Global variable used for the used/target board-id.
#
gModelID=""

#
# Open generated SSDT on request (default value is 2).
#
# 0 = don't open the plist.
# 1 = open the plist in the editor of your choice.
# 2 = ask for confirmation before opening the plist in the editor of your choice.
#
let gCallOpen=2

#
# 
#
gTargetFileNames=""

#
# Settings block at 0x1680-0x1baf
#
gTargetData_1=('BACKGROUND','NORMAL','KGROUND','REALTIME_SHORT','REALTIME_LONG','KERNEL','LTIME_LONG','THRU_TIER0','THRU_TIER1','THRU_TIER2','THRU_TIER3','THRU_TIER4','THRU_TIER5','GRAPHICS_SERVER')
#
# Settings block at 0x1bb0-0x1df3
#
gTargetData_2=('hard-rt-ns','ubpc','off','on','hwp','epp','perf-bias','utility-tlvl','non-focal-tlvl')
gTargetData_3=('iocs_engage','iocs_disengage','iocs_cstflr','iocs_rtrigger')
gTargetData_4=('ring_mbd_ns','ring_ratio','ratioratelimit','epp_override','io_epp_boost')

#
# Output styling.
#
STYLE_RESET=$(tput sgr0)
STYLE_BOLD=$(tput bold)
STYLE_UNDERLINED=$(tput smul)
#
# Output Foreground Colours.
#
STYLE_RED_FG=$(tput setaf 1)
STYLE_GREEN_FG=$(tput setaf 2)
STYLE_YELLOW_FG=$(tput setaf 3)
STYLE_BLUE_FG=$(tput setaf 4)
STYLE_MAGENTA_FG=$(tput setaf 5)
STYLE_CYAN_FG=$(tput setaf 6)
STYLE_WHITE_FG=$(tput setaf 7)
#
# Output Background Colours.
#
STYLE_RED_BG=$(tput setab 1)
STYLE_GREEN_BG=$(tput setab 2)
STYLE_YELLOW_BG=$(tput setab 3)
STYLE_BLUE_BG=$(tput setab 4)
STYLE_MAGENTA_BG=$(tput setab 5)
STYLE_CYAN_BG=$(tput setab 6)
STYLE_WHITE_BG=$(tput setab 7)

#
#--------------------------------------------------------------------------------
#

function _PRINT_MSG()
{
  local message=$1
  #
  # Fancy output style?
  #
  if [[ $gExtraStyling -eq 1 ]];
    then
      if [[ $message =~ 'Aborting ...' ]];
        then
          local message=$(echo $message | sed -e 's/^Aborting ...//')
          local messageType='Aborting ...'
        else
          local messageType=$(echo $message | sed -e 's/:.*//g')

          if [[ $messageType =~ ^"\n" ]];
            then
              local messageTypeStripped=$(echo $messageType | sed -e 's/^[\n]*//')
            else
              local messageTypeStripped=$messageType
          fi

          local message=":"$(echo $message | sed -e "s/^[\n]*${messageTypeStripped}://")
      fi

      if [[ $messageType == "Error" ]];
        then
          printf "${STYLE_RED_FG}"
      fi

      printf "${STYLE_BOLD}${messageType}${STYLE_RESET}$message\n"
    else
      printf "${message}\n"
  fi
}

#
#--------------------------------------------------------------------------------
#

function _clearLines()
{
  let lines=$1

  if [[ ! lines ]];
    then
      let lines=1
  fi

  for ((line=0; line < lines; line++));
  do
    printf "\e[A\e[K"
  done
}

#
#--------------------------------------------------------------------------------
#

function _showDelayedDots()
{
  local let index=0

  while [[ $index -lt 3 ]]
  do
    let index++
    sleep 0.150
    printf "."
  done

  sleep 0.200

  if [ $# ];
    then
      printf $1
  fi
}

#
#--------------------------------------------------------------------------------
#

function _invalidMenuAction()
{
  _PRINT_MSG "Error: Invalid choice!\n       Retrying "
  _showDelayedDots
  _clearLines $1+6
}

#
#--------------------------------------------------------------------------------
#

function _toLowerCase()
{
  echo "`echo $1 | tr '[:upper:]' '[:lower:]'`"
}

#
#--------------------------------------------------------------------------------
#

function _showHeader()
{
  printf "${STYLE_BOLD}freqVectorsEdit.sh${STYLE_RESET} v${gScriptVersion} Copyright (c) 2013-$(date "+%Y") by Pike R. Alpha.\n"
  echo '-----------------------------------------------------------------'
  printf "${STYLE_BOLD}Bugs${STYLE_RESET} > ${STYLE_BLUE_FG}https://github.com/Piker-Alpha/freqVectorsEdit.sh/issues${STYLE_RESET} <\n\n"
}

#
#--------------------------------------------------------------------------------
#

function _DEBUG_PRINT()
{
  if [[ $gDebug -eq 1 ]];
    then
      echo -e $1
  fi
}

#
#--------------------------------------------------------------------------------
#
function _ABORT()
{
  _PRINT_MSG "Aborting ...\nDone.\n\n"

  exit $1
}

#
#--------------------------------------------------------------------------------
#

function _selectEditor()
{
  if [[ -f "${gPrefsPath}/com.wordpress.pikeralpha.plist" ]];
    then
      local editor=$(defaults read "${gPrefsPath}/com.wordpress.pikeralpha" freqVectorsEditor)

      case "$editor" in
        xcode) _DEBUG_PRINT XCODE_SELECTED_AS_EDITOR

               if [ -x /Applications/Xcode-beta.app ];
                 then
                   gXcode="/usr/bin/open -Wa /Applications/Xcode-beta.app"
               fi

               gEditor="$gXcode"
               ;;

        nano  ) _DEBUG_PRINT NANO_SELECTED_AS_EDITOR
                gEditor="$gNano"
                ;;

        vi    ) _DEBUG_PRINT VI_SELECTED_AS_EDITOR
                gEditor="$gVi"
                ;;
      esac
    else
      echo 'First run detected, select editor:'
      echo ''
      echo '[ 1 ] Xcode'
      echo '[ 2 ] nano'
      echo '[ 3 ] vi'
      echo ''
      printf "Please choose the editor that you want to use (${STYLE_UNDERLINED}E${STYLE_RESET}xit/1/2/3)"
      read -p " ? " editorSelection
      case "$(_toLowerCase $editorSelection)" in
        1     ) _DEBUG_PRINT XCODE_SELECTED_AS_EDITOR
                defaults write "${gPrefsPath}/com.wordpress.pikeralpha" freqVectorsEditor -string xcode
                gEditor="$gXcode"
                ;;

        2     ) _DEBUG_PRINT NANO_SELECTED_AS_EDITOR
                defaults write "${gPrefsPath}/com.wordpress.pikeralpha" freqVectorsEditor -string nano
                gEditor="$gNano"
                ;;

        3     ) _DEBUG_PRINT VI_SELECTED_AS_EDITOR
                defaults write "${gPrefsPath}/com.wordpress.pikeralpha" freqVectorsEditor -string vi
                gEditor="$gVi"
                ;;

        e|exit) printf 'Aborting script '
                _showDelayedDots
                _clearLines 8
                echo 'Done'
                exit -0
                ;;

        *     ) _invalidMenuAction 3
                _selectEditor
                ;;
      esac
      _clearLines 7
  fi
}

#
#--------------------------------------------------------------------------------
#

function _getModelID()
{
  #
  # Grab 'compatible' property from ioreg (stripped with sed / RegEX magic).
  #
  gModelID=$(ioreg -p IODeviceTree -d 2 -k compatible | grep compatible | sed -e 's/ *["=<>]//g' -e 's/compatible//')
}

#
#--------------------------------------------------------------------------------
#

function _getBoardID()
{
  #
  # Grab 'board-id' property from ioreg (stripped with sed / RegEX magic).
  #
  gBoardID=$(ioreg -p IODeviceTree -d 2 -k board-id | grep board-id | sed -e 's/ *["=<>]//g' -e 's/board-id//')
}

#
#--------------------------------------------------------------------------------
#

function _getLowestFrequency()
{
  #
  # Get minimum ratio from: machdep.xcpm.hard_plimit_min_100mhz_ratio
  #
  gLowestFrequency=$(sysctl -nx machdep.xcpm.hard_plimit_min_100mhz_ratio)
}

#
#--------------------------------------------------------------------------------
#

function _getHighestFrequency()
{
  #
  # Get maximum ratio from: machdep.xcpm.hard_plimit_max_100mhz_ratio
  #
  let gHighestFrequency=($(sysctl -n machdep.xcpm.hard_plimit_max_100mhz_ratio) * 100)
}

#
#--------------------------------------------------------------------------------
#

function _getHWP()
{
  local filename=$1
  local value=0;

  if [[ $(grep -c "hwp" "${filename}") -gt 0 ]];
    then
      #
      # Get settings data from binary file.
      #
      gFreqVectorData=$(xxd -s 7088 -l 580 -c 256 -ps "${filename}")
      #
      # Get HWP enable value (should be 1).
      #
      let value=$(_getPMValue "hwp")
      #
      # HWP enabled?
      #
      if [[ $value -eq 1 ]];
        then
          #
          # HWP will be enabled. Return one.
          #
          return 1
      fi
  fi
  #
  # HWP will not be enabled. Return zero.
  #
  return 0
}

#
#--------------------------------------------------------------------------------
#

function _getFrequencies()
{
  local index=0
  local boardID=$1
  local filenames=($(ls /tmp/"${boardID}"*.bin))
  local itemCount="${#filenames[@]}"

  for filename in "${filenames[@]}"
  do
    let index++
    #
    # Chop file extension from filename.
    #
    local basename=${filename%.*}
    #
    # Chop path and Mac- from filename.
    #
    local basename=${basename##*Mac-}
    #
    # Check for minus character in basename.
    #
    if [[ $basename =~ "-" ]];
      then
        #
        # Show @ sign for first item (if frequencies are found).
        #
        if [[ $index -eq 1 && $itemCount -gt 0 ]];
          then
            printf " @ "
        fi
      else
        #
        # Not there. Add it.
        #
        basename=$basename+"-"
    fi
    #
    # Get frequency (by chopping off everything before the minus sign).
    #
    local frequency=${basename##*-}
    #
    # Do we have a match with the turbo frequency?
    #
    if [[ $frequency == $gHighestFrequency ]];
      then
        #
        # Yes. Show frequency with a green forground colour.
        #
        printf "${STYLE_GREEN_FG}${frequency}${STYLE_RESET}"
      else
        #
        # No. Show frequency in the default forground colour.
        #
        printf "${frequency}"
    fi
    #
    # Check for the HWP enable setting.
    #
    _getHWP $filename

    if [[ $? -eq 1 ]];
      then
        #
        # Last item?
        #
        if [[ $index -le $itemCount ]];
          then
            #
            # No. Print separator.
            #
            printf ' '
        fi

        printf "HWP"
    fi
    #
    # Last item?
    #
    if [[ $index -lt $itemCount ]];
      then
        #
        # No. Print delimiter.
        #
        printf '/'
    fi
  done

  printf ")"
}

#
#--------------------------------------------------------------------------------
#

function _getResourceFiles()
{
  cd "${gResourcePath}"

  gTargetFileNames=($(grep -rlse 'FrequencyVectors' .))

  if [[ "${#gTargetFileNames[@]}" -eq 0 ]];
    then
      _PRINT_MSG 'Error: FrequencyVector data found in X86PlatformPlugin.kext!'
      _ABORT
    else
      _DEBUG_PRINT "${#gTargetFileNames[@]} plists found with FrequencyVectors"
  fi
}

#
#--------------------------------------------------------------------------------
#

function _selectSourceResourceFile()
{
  local index=0
  local selection=0

  echo 'Available resource files (plists) with FrequencyVectors:'
  echo ''

  for filename in "${gTargetFileNames[@]}"
  do
    let index++
    #
    # Strip path from filename.
    #
    local file=${filename##*/}
    #
    # Get board-id (by chopping off the file extension).
    #
    local boardID=${file%.*}
    #
    # Match board-id with model name.
    #
    local model=$(_getModelByBoardID $boardID)
    #
    #
    #
    if [[ $gBoardID == $boardID ]];
      then
        printf "${STYLE_BOLD}"
    fi
    #
    # Show item.
    #
    if [[ $model == "" ]];
      then
        printf " [ ${STYLE_RED_FG}%2d${STYLE_RESET} ] $file (${STYLE_RED_FG}Unknown Model${STYLE_RESET}" $index
      else
        printf " [ %2d ] $file ($model" $index
    fi
    #
    #
    #
    _getFrequencies $boardID

    echo "${STYLE_RESET}"
  done
  #
  #
  #
  echo ''
  #
  # Let user make a selection.
  #
  printf "Please choose the desired plist for your hardware (${STYLE_UNDERLINED}E${STYLE_RESET}xit/1-${index})"
  read -p " ? " selection
  case "$(_toLowerCase $selection)" in
    e|exit       ) printf 'Aborting script '
                   _showDelayedDots

                   if [[ $gDebug -eq 1 ]];
                     then
                       _clearLines 8+$index
                     else
                       _clearLines 5+$index
                   fi

                   echo 'Done'
                   exit -0
                   ;;

    [[:digit:]]* ) if [[ $selection -lt 1 || $selection -gt $index ]];
                     then
                       clear
                       _showHeader
                       _selectSourceResourceFile
                     else
                     #
                     # Lower selection (arrays start at zero).
                     #
                     let selection-=1
                     #
                     # Initialise global variable with the selected plist.
                     #
                     gSourcePlist=${gTargetFileNames[$selection]}

                     _DEBUG_PRINT "gSourcePlist: $gSourcePlist"
                   fi
                   ;;

    *            ) _invalidMenuAction $index
                   _selectSourceResourceFile
                   ;;
  esac
  #
  #
  echo ''
}


#
#--------------------------------------------------------------------------------
#

function _toLittleEndian()
{
  local data=$1
  local i=${#data}
  local value

  while [ $i -gt 0 ]
  do
    i=$[$i-2]
    value+=${data:$i:2}
  done

  let value="0x${value}"

  echo -n "$value"
}


#
#--------------------------------------------------------------------------------
#

function _getLFMFrequency()
{
  local lfm=0
  local boardID=$1
  local matchingData=$(xxd -ps -l 16 "/tmp/${boardID}.bin")

  if [[ ${matchingData:0:8} == "02000000" && ${matchingData:16:8} == "01000000" ]];
    then
      let lfm="0x${matchingData:8:2}"
      printf "Low Frequency Mode: ${lfm}00 MHz\n\t  "
  fi
}


#
#--------------------------------------------------------------------------------
#


function _patchLFM()
{
  local currentLFM=0
  local humanLFM=0
  local updatedLFM=0
  local matchingData=$(xxd -ps -l 16 "/tmp/FrequencyVectors.bin")
  #
  # Check for the LFM restriction.
  #
  if [[ ${matchingData:0:8} == "02000000" && ${matchingData:16:8} == "01000000" ]];
    then
      #
      # Get LFM frequency from plist.
      #
      let currentLFM=0x"${matchingData:8:2}"
      #
      # Lower frequency to what machdep.xcpm.hard_plimit_min_100mhz_ratio is.
      #
      updatedLFM="${gLowestFrequency:8:2}"
      let humanLFM=0x"${updatedLFM}"
      printf "Patching LFM from: ${currentLFM}00 MHz to ${humanLFM}00 MHz\n"
      #
      # Setup search pattern.
      #
      local searchPattern=$(xxd -l 16 -g 1 "/tmp/FrequencyVectors.bin" | sed -e 's/^.*://' -e 's/  .*//' -e 's/ /\\x/g')
#     echo "SearchPattern.: >${searchPattern}<"
      #
      # Setup replace pattern.
      #
      local replacePattern="\x02\x00\x00\x00\x${updatedLFM}\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00"
#     echo "ReplacePattern: >${replacePattern}<"
      #
      # Patch binary.
      #
      /usr/bin/perl -pi -e "s|${searchPattern}|${replacePattern}|" /tmp/FrequencyVectors.bin
  fi
}


#
#--------------------------------------------------------------------------------
#

function _getPMValue()
{
  local setting=$1
  local matchingData

  case "$setting" in
    hard-rt-ns    ) # 68 61 72 64 2D 72 74 2D 6E 73 00 00 00 00 00 00 00 00 00 00 00 09 3D 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '686172642d72742d6e730{20}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    ubpc          ) # 75 62 70 63 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '756270630{24}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:32:8}"
                    ;;

    off           ) # 6F 66 66 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6F66660{18}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:24:8}"
                    ;;

    on            ) # 6F 6E 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6F6E{28}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:24:8}"
                    ;;

    hwp           ) #
                    # HardWare-controlled Performance states.
                    #
                    # 68 77 70 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6877700{26}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:32:8}"
                    ;;

    epp           ) #
                    # Energy Performance Preference.
                    #
                    # Conveys a hint to the HWP hardware. The OS may write a range of values from 0 (performance preference) to 0FFH (energy efficiency preference)
                    # to influence the rate of performance increase / decrease and the result of the hardware's energy efficiency and performance optimizations. The
                    # default value of this field is 80H.
                    #
                    # Note: If CPUID.06H:EAX[bit 10] indicates that this field is not supported, HWP uses the value of the IA32_ENERGY_PERF_BIAS MSR (perf-bias) to
                    #       determine the energy efficiency / performance preference.
                    #
                    # 65 70 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 92 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6570700{34}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    epp_override  ) #
                    # 65 70 70 5F 6F 76 65 72 72 69 64 65 00 00 00 00 00 00 00 00 78 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6570705f6f766572726964650{16}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    perf-bias     ) # 70 65 72 66 2D 62 69 61 73 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00
                    # 70 65 72 66 2D 62 69 61 73 00 00 00 00 00 00 00 00 00 00 00 05 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '706572662d626961730{22}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    utility-tlvl  ) # 75 74 69 6C 69 74 79 2D 74 6C 76 6C 00 00 00 00 00 00 00 00 28 00 00 00
                    # 75 74 69 6C 69 74 79 2D 74 6C 76 6C 00 00 00 00 00 00 00 00 3d 00 00 00
                    # 75 74 69 6C 69 74 79 2D 74 6C 76 6C 00 00 00 00 00 00 00 00 3e 00 00 00
                    # 75 74 69 6C 69 74 79 2D 74 6C 76 6C 00 00 00 00 00 00 00 00 4e 00 00 00
                    # 75 74 69 6C 69 74 79 2D 74 6C 76 6C 00 00 00 00 00 00 00 00 4f 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '7574696c6974792d746c766c0{16}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    non-focal-tlvl) # 6E 6F 6E 2D 66 6F 63 61 6C 2D 74 6C 76 6C 00 00 00 00 00 00 FA 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '6e6f6e2d666f63616c2d746c766c0{12}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    iocs_engage   ) # 69 6F 63 73 5F 65 6E 67 61 67 65 00 00 00 00 00 00 00 00 00 00 6A 18 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '696f63735f656e676167650{18}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    iocs_disengage) # 69 6F 63 73 5F 64 69 73 65 6E 67 61 67 65 00 00 00 00 00 00 A0 25 26 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '696f63735f646973656e676167650{12}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    iocs_cstflr   ) # 69 6F 63 73 5F 63 73 74 66 6C 72 00 00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '696f63735f637374666c720{18}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    iocs_rtrigger ) # 69 6F 63 73 5F 72 74 72 69 67 67 65 72 00 00 00 00 00 00 00 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '696f63735f72747269676765720{14}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    ratioratelimit) # 72 61 74 69 6F 72 61 74 65 6C 69 6D 69 74 00 00 00 00 00 00 C0 C6 2D 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '726174696f726174656c696d69740{12}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    io_epp_boost  ) # 69 6F 5F 65 70 70 5F 62 6F 6F 73 74 00 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '696f5f6570705f626f6f73740{16}[0-9a-f]{2}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    ring_mbd_ns   ) # 72 69 6E 67 5F 6D 62 64 5F 6E 73 00 00 00 00 00 00 00 00 00 10 27 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '72696e675f6d62645f6e730{18}[0-9a-f]{8}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    ring_ratio    ) # 72 69 6E 67 5F 72 61 74 69 6F 00 00 00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                    matchingData=$(echo $gFreqVectorData | egrep -o '72696e675f726174696f0{20}[0-9a-f]{2}')
                    _toLittleEndian "${matchingData:40:8}"
                    ;;

    *             )
                    ;;
  esac
}


#
#--------------------------------------------------------------------------------
#

function _checkPlistForEntry()
{
  local entry=$1
  local plist=$2
  local result=$(/usr/libexec/PlistBuddy -x -c "Print ${entry}" "${plist}" 2>&1)

  if [[ $result =~ "Does Not Exist" ]];
    then
      return 0
  fi

  return 1
}


#
#--------------------------------------------------------------------------------
#

function _dumpData()
{
  local boardID=$1
  local targetList=$2

  case "$targetList" in
    1) local targetData=$gTargetData_1
       printf "\n${STYLE_BOLD}Settings:${STYLE_RESET} "
       _getLFMFrequency $boardID
       ;;

    2) local targetData=$gTargetData_2
       ;;

    3) local targetData=$gTargetData_3
       ;;

    4) local targetData=$gTargetData_4
       ;;
  esac

  #
  # Save default (0) delimiter.
  #
  local ifs=$IFS
  #
  # Change delimiter to a comma character.
  #
  IFS=","
  #
  # Split vars.
  #
  local data=($targetData)
  #
  # Restore the default (0) delimiter.
  #
  IFS=$ifs
  #
  #
  #
  local item=0
  local matched=0
  #
  #
  #
  for target in "${data[@]}"
    do
      if [[ $(grep -c "${target}" "/tmp/${boardID}.bin") -gt 0 ]];
        then
          let matched+=1

          if [[ $targetList -gt 1 && $item -eq 0 ]];
            then
              targetList=-1
              printf "\t  "
          fi

          if [[ $item -gt 0 ]];
            then
              printf ", "
          fi

          printf "${target}"

          let item+=1

          if [[ $targetList -eq -1 ]];
            then
              local value=$(_getPMValue $target)
              printf " (${value})"
          fi
      fi
  done

  if [[ $matched -gt 0 ]];
    then
      echo ''
  fi
}


#
#--------------------------------------------------------------------------------
#

function _exportFrequencyVectors()
{
  local index=$1
  local plist=$2
  local boardID=$3
  local frequency=$4

  if [ $index -gt -1 ];
    then
      boardID="${3}-${frequency}"
  fi

  if [ $index -eq -1 ];
    then
      index=0
  fi

  #
  # Export the FrequencyVectors (with help of the Print command) to /tmp/[board-id].bin
  #
  /usr/libexec/PlistBuddy -c "Print IOPlatformPowerProfile:FrequencyVectors:${index}" "${plist}" > "/tmp/${boardID}.bin"
  #
  # Remove the trailing 0x0A byte (we don't want that).
  #
  perl -pi -e 'chomp if eof' "/tmp/${boardID}.bin"
  #
  # Get filesize.
  #
  local filesize=$(stat -f%z "/tmp/${boardID}.bin")
  #
  #
  #
  if [[ $gDebug -eq 1 ]];
    then
      printf "Converted to: /tmp/${boardID}.bin ($filesize bytes)"
      #
      #
      #
      gFreqVectorData=$(xxd -s 5760 -l 1328 -c 256 -ps "/tmp/${boardID}.bin" | tr -d '\n')
      #
      #
      #
      _dumpData $boardID 1
      #
      #
      #
      gFreqVectorData=$(xxd -s 7088 -l 580 -c 256 -ps "/tmp/${boardID}.bin" | tr -d '\n')
      #
      #
      #
      _dumpData $boardID 2
      _dumpData $boardID 3
      _dumpData $boardID 4
  fi
}


#
#--------------------------------------------------------------------------------
#

function _convertXML2BIN()
{
  local index=0

  _DEBUG_PRINT "\nConverting XML data to binary files ..."

  for plist in "${gTargetFileNames[@]}"
  do
    #
    # Convert filename.
    #
    local filename=$(basename $plist)
    #
    # Get board-id (by chopping off the extension).
    #
    local boardID=${filename%.*}
    #
    # Get model identifier from board-id.
    #
    local model=$(_getModelByBoardID $boardID)

    if [[ $gDebug -eq 1 ]];
      then
        echo ''
        printf "Examining data of: ${STYLE_BOLD}${boardID}${STYLE_RESET}.plist (${STYLE_BOLD}"

        if [[ $model == "" ]];
          then
            printf "${STYLE_RED_FG}Unknown Model"
          else
            printf "${model}"
        fi

        echo "${STYLE_RESET}) ..."
        echo '-----------------------------------------------------------------'
    fi

    _checkPlistForEntry "IOPlatformPowerProfile:Frequencies" "${plist}"
    #
    # Are there any Frequencies in the plist?
    #
    if [[ $? -eq 1 ]];
      then
        #
        # Yes. Get Frequencies.
        #
        local index=0
        local frequencies=$(/usr/libexec/PlistBuddy -c "Print IOPlatformPowerProfile:Frequencies" "${plist}" 2>&1)
        #
        # frequencies is now something like this:
        #
        # Dict {
        #     2600 = 1
        #     2900 = 2
        #     2400 = 0
        # }
        #
        frequencies=$(echo $frequencies | sed -e 's/Dict {//' -e 's/}//'  -e 's/=//g')
        #
        # Now we have this.
        #
        #     2600 = 1
        #     2900 = 2
        #     2400 = 0
        #
        frequencies=($frequencies)
        #
        # And now this:
        #
        # 2600
        # 1
        # 2900
        # 2
        # 2400
        # 0
        #

        while [ $index -lt "${#frequencies[@]}" ];
          do
            if [ $index -gt 1 ];
              then
                _DEBUG_PRINT ''
            fi

            if [[ $gDebug -eq 1 ]];
              then
                if [[ "${frequencies[${index}]}" == "${gHighestFrequency}" ]];
                  then
                    printf "${STYLE_BOLD}Max Turbo Boost:${STYLE_BLUE_FG}"
                  else
                     printf "${STYLE_BOLD}Max Turbo Boost:${STYLE_RED_FG}"
                fi

                printf " ${frequencies[${index}]} MHZ${STYLE_RESET} (FrequencyVectors @ ${frequencies[${index}+1]}) "
            fi
            #
            # Export the FrequencyVectors. Export all FrequencyVectors.
            #
            _exportFrequencyVectors ${frequencies[${index+1}]} $plist $boardID ${frequencies[${index}]}

            let index+=2
        done
      else
        #
        # No Frequencies found. Export FrequencyVectors
        #
        _exportFrequencyVectors -1 $plist $boardID
    fi
  done
}

#
#--------------------------------------------------------------------------------
#

function _findPlistBuddy()
{
  #
  # Lookup PlistBuddy (should be there after the first run).
  #
  if [ ! -f /usr/libexec/PlistBuddy ];
    then
      echo 'PlistBuddy not found ... Downloading PlistBuddy ...'
      curl https://raw.github.com/Piker-Alpha/freqVectorsEdit.sh/master/Tools/PlistBuddy -o /usr/libexec/PlistBuddy --create-dirs
      chmod +x /usr/libexec/PlistBuddy
      printf 'Done.'
  fi
}

#
#--------------------------------------------------------------------------------
#

function _checkForConfigFile
{
  #
  # Does the target file exist?
  #
  if [ ! -f "${gDataPath}/${1}" ];
    then
      #
      # No. Return state is 2.
      #
      return 1
  fi
  #
  #
  #
  if [[ $(wc -c "${gDataPath}/${1}" | awk '{print $1}') -lt 100 ]];
    then
      #
      # Remove file.
      #
      rm "${gDataPath}/$1"
      #
      # No. Return state is 3.
      #
      return 3
  fi

  return 0
}

#
#--------------------------------------------------------------------------------
#

function _invalidArgumentError()
{
  _PRINT_MSG "Error: Invalid argument detected: ${1} (check ssdtPRGen.sh -h)"

  _ABORT
}

#
#--------------------------------------------------------------------------------
#

function _getModelByBoardID()
{
  #
  # Model/board-id arrays from models.cfg
  #
  local modelData=("gHaswellModelData[@]" "gBroadwellModelData[@]" "gSkylakeModelData[@]" "gKabyLakeModelData[@]")
  #
  # Loop through the available model data.
  #
  for dataset in "${modelData[@]}"
  do
    #
    # Split 'dataset' into array 'targetList'.
    #
    local targetList=("${!dataset}")
    #
    # Loop through the target list.
    #
    for currentModel in "${targetList[@]}"
    do
      local boardID="${currentModel%:*}"

      if [[ $1 =~ $boardID ]];
        then
          #
          # Get model (by chopping off the colon and board-id).
          #
          echo "${currentModel##*:}"
          break
      fi
    done
  done
}

#
#--------------------------------------------------------------------------------
#

function _showSupportedBoardIDsAndModels()
{
  #
  # Save default (0) delimiter.
  #
  local ifs=$IFS
  #
  # Setup a local variable pointing to a list with supported model data.
  #
  case "$1" in
      Haswell) local modelDataList="gHaswellModelData[@]"
               ;;
    Broadwell) local modelDataList="gBroadwellModelData[@]"
               ;;
      Skylake) local modelDataList="gSkylakeModelData[@]"
               ;;
     KabyLake) local modelDataList="gKabyLakeModelData[@]"
               ;;
  esac
  #
  # Split 'modelDataList' into array.
  #
  local targetList=("${!modelDataList}")

  printf "${STYLE_BOLD}$1${STYLE_RESET}\n"
  #
  # Change delimiter to a colon character.
  #
  IFS=":"
  #
  # Loop through target list.
  #
  for modelData in "${targetList[@]}"
  do
    #
    # Split 'modelData' into array.
    #
    local data=($modelData)
    echo "${data[0]} / ${data[1]}"
  done
  #
  # Restore the default (0) delimiter.
  #
  IFS=$ifs
  #
  # Print extra newline for a cleaner layout.
  #
  printf "\n"
}

#
#--------------------------------------------------------------------------------
#

function _checkLibraryDirectory()
{
  #
  # Do we have the ssdtPRGen.sh data directory?
  #
  if [ ! -d "${gDataPath}" ];
    then
      #
      # No. Not there. Create the directory.
      #
      mkdir -p "${gDataPath}"
  fi

  _checkForConfigFile "Models.cfg"

  if [[ $? -ge 1 ]];
    then
      #
      # Not there or damaged. Download it from the ssdtPRGen.sh repository.
      #
      curl -o "${gDataPath}/Models.cfg" --silent https://raw.githubusercontent.com/Piker-Alpha/ssdtPRGen.sh/Beta/Data/Models.cfg
  fi
  #
  # Load model data.
  #
  source "${gDataPath}/Models.cfg"
}

#
#--------------------------------------------------------------------------------
#

function _getScriptArguments()
{
  #
  # Are we fired up with arguments?
  #
  if [ $# -gt 0 ];
    then
      #
      # Yes. Do we have a single (-help) argument?
      #
      local argument=$(echo "$1" | tr '[:upper:]' '[:lower:]')

      if [[ $# -eq 1 && "$argument" == "-h" || "$argument" == "-help"  ]];
        then
          printf "\n${STYLE_BOLD}Usage:${STYLE_RESET} ./freqVectorEdit.sh [-bhmosw]\n"
          printf "       -${STYLE_BOLD}b${STYLE_RESET}oard-id (example: Mac-F60DEB81FF30ACF6)\n"
          printf "       -${STYLE_BOLD}d${STYLE_RESET}ebug output:\n"
          printf "          0 = no debug output\n"
          printf "          1 = debug output\n"
          printf "       -${STYLE_BOLD}m${STYLE_RESET}odel (example: MacPro6,1)\n"
          printf "       -${STYLE_BOLD}show${STYLE_RESET} supported board-id and model combinations:\n"
          printf "          Haswell\n"
          printf "          Broadwell\n"
          printf "          Skylake\n"
          printf "          KabyLake\n"
          #
          # Stop script (success).
          #
          exit 0
      fi

      if [[ $# -eq 1 && "$argument" == "-show" ]];
        then
          printf "\nSupported board-id / model combinations for:\n"
          echo -e "--------------------------------------------\n"

          _showSupportedBoardIDsAndModels "KabyLake"
          _showSupportedBoardIDsAndModels "Skylake"
          _showSupportedBoardIDsAndModels "Broadwell"
          _showSupportedBoardIDsAndModels "Haswell"
          #
          # Stop script (success).
          #
          exit 0
      fi

      if [[ $# -eq 2 && "$argument" == "-show" ]];
        then
          printf "\nSupported board-id / model combinations for:\n"
          echo -e "--------------------------------------------\n"

          case "$(echo $2 | tr '[:lower:]' '[:upper:]')" in
            HASWELL  ) _showSupportedBoardIDsAndModels "Haswell"
                       ;;
            BROADWELL) _showSupportedBoardIDsAndModels "Broadwell"
                       ;;
            SKYLAKE  ) _showSupportedBoardIDsAndModels "Skylake"
                       ;;
            KABYLAKE ) _showSupportedBoardIDsAndModels "KabyLake"
                       ;;
          esac
          #
          # Stop script (success).
          #
          exit 0
        else
          #
          # Figure out what arguments are used.
          #
          while [ "$1" ];
          do
            #
            # Store lowercase value of $1 in $flag
            #
            local flag=$(echo "$1" | tr '[:upper:]' '[:lower:]')
            #
            # Is this a valid flag?
            #
            if [[ "${flag}" =~ ^[-bdm]+$ ]];
              then
                #
                # Yes. Figure out what flag it is.
                #
                case "${flag}" in
                  -b) shift

                      if [[ "$1" =~ ^Mac-[0-9A-F]+$ ]];
                        then
                          if [[ $gBoardID != "$1" ]];
                            then
                              gBoardID=$1
                              _PRINT_MSG "Override value: (-b) board-id, now using: ${gBoardID}!"
                          fi
                        else
                          _invalidArgumentError "-b $1"
                      fi
                      ;;

                  -d) shift

                      if [[ "$1" =~ ^[01]+$ ]];
                        then
                          if [[ $gDebug -ne $1 ]];
                            then
                              let gDebug=$1
                              _PRINT_MSG "Override value: (-d) debug mode, now using: ${gDebug}!"
                          fi
                        else
                          _invalidArgumentError "-d $1"
                      fi
                      ;;

                  -m) shift

                      if [[ "$1" =~ ^[a-zA-Z,0-9]+$ ]];
                        then
                          if [[ "$gModelID" != "$1" ]];
                            then
                              _PRINT_MSG "Override value: (-m) model, now using: ${1}!"
                              gModelID="$1"
                          fi
                        else
                          _invalidArgumentError "-m $1"
                      fi
                      ;;

                  *) _invalidArgumentError "$1"
                     ;;
                esac
              else
                _invalidArgumentError "$1"
            fi
            shift;
          done;
      fi
  fi
}

#
#--------------------------------------------------------------------------------
#

function main()
{
  _checkLibraryDirectory
  _getScriptArguments "$@"
  #
  # Check if PlistBuddy is installed – download it when missing.
  #
  _findPlistBuddy
  _getResourceFiles
  _getLowestFrequency
  _getHighestFrequency
  #
  # Convert FrequencyVectors base64 data to bin files.
  #
  _convertXML2BIN
  #
  # Check if -b argument was used.
  #
  if [[ $gBoardID == "" ]];
    then
      _getBoardID
  fi
  #
  # Check if -m argument was used.
  #
  if [[ $gModelID == "" ]];
    then
      _getModelID
  fi

  _DEBUG_PRINT "Used board-id: ${gBoardID}"
  _DEBUG_PRINT "Used model...: ${gModelID}\n"

  _selectSourceResourceFile
  #
  # Update target plist
  #
  gTargetPlist="${gBoardID}.plist"
  #
  #
  #
  if [[ ! -f /tmp/FrequencyVectors.bin ]];
    then
      #
      # Export the FrequencyVectors (with help of the Print command) to /tmp/FrequencyVectors.bin
      #
      /usr/libexec/PlistBuddy -c "Print IOPlatformPowerProfile:FrequencyVectors:0" "${gSourcePlist}" > /tmp/FrequencyVectors.bin
  fi
  #
  # Remove the trailing 0x0A byte (we don't want that).
  #
  perl -pi -e 'chomp if eof' /tmp/FrequencyVectors.bin
  #
  # Check for FrequencyVectors array.
  #
  _checkPlistForEntry "IOPlatformPowerProfile:FrequencyVectors" "${gTargetPlist}"
  #
  # Is there a FrequencyVectors array in the target plist?
  #
  if [[ $? -eq 0 ]];
    then
      #
      # No. Not there. Let's add the array.
      #
      /usr/libexec/PlistBuddy -c "Add IOPlatformPowerProfile:FrequencyVectors array" "${gTargetPlist}"
  fi
  #
  #
  #
  _patchLFM

  if [ -e "/tmp/FrequencyVectorsPatched.bin" ];
    then
      #
      # Import Patched FrequencyVectors into target plist (for example: Mac-F60DEB81FF30ACF6.plist).
      #
      /usr/libexec/PlistBuddy -c "Import IOPlatformPowerProfile:FrequencyVectors:0 /tmp/FrequencyVectorsPatched.bin" "${gTargetPlist}"
    else
      #
      # Import FrequencyVectors into target plist (for example: Mac-F60DEB81FF30ACF6.plist).
      #
      /usr/libexec/PlistBuddy -c "Import IOPlatformPowerProfile:FrequencyVectors:0 /tmp/FrequencyVectors.bin" "${gTargetPlist}"
  fi

  #
  # Check for StepContextDict.
  #
  _checkPlistForEntry "IOPlatformPowerProfile:StepContextDict" "${gTargetPlist}"
  #
  # Is there a StepContextDict dictionary in the target plist?
  #
  if [[ $? -eq 1 ]];
    then
      #
      # Yes. Remove it (we don't want it).
      #
      /usr/libexec/PlistBuddy -c "Remove IOPlatformPowerProfile:StepContextDict" "${gTargetPlist}"
  fi
  #
  #
  #
  echo ''
  echo 'Triggering a kernelcache refresh ...'
  touch "${gExtensionsDirectory}"
  #
  # Ask for confirmation before opening the plist?
  #
  if [[ $gCallOpen -eq 2 ]];
    then
      #
      #
      #
      echo ''
      #
      # Yes. Ask for confirmation.
      #
      read -p "Do you want to open ${gTargetPlist} (y/n)? " openAnswer
      case "$openAnswer" in
          y|Y ) #
                # Ok. Override default behaviour.
                #
                let gCallOpen=1
          ;;
      esac
  fi
  #
  # Should we open the Mac-*.plist?
  #
  if [[ $gCallOpen -eq 1 ]];
    then
      #
      # Yes. Open Mac-*.plist in TextEdit.
      #
      xcodePath=$(xcode-select --print-path)
      #
      # Check Xcode path (editor fails with commands line tools only installed).
      #
      if [[ $xcodePath =~ "CommandLineTools" ]];
        then
          #
          # Check if the Xcode.app is installed.
          #
          if [ -x /Applications/Xcode.app ];
            then
              local XcodeIsFound=1
            else
              #
              # Check if the Xcode-beta.app is installed.
              #
              if [ -x /Applications/Xcode-beta.app ];
                then
                  local XcodeIsFound=1
                else
                  #
                  # Yikes. Also not there. Error out.
                  #
                  _PRINT_MSG "Error: Xcode.app not found. Please install it!\n"
                  _ABORT
              fi
          fi
        else
          local XcodeIsFound=1
      fi

      if [[ $XcodeIsFound -eq 1 ]];
        then
          _DEBUG_PRINT "Launching $gEditor for: ${gTargetPlist}"
          $gEditor "${gResourcePath}/${gTargetPlist}"
      fi
  fi

  read -p "Do you want to reboot now? (y/n) " choice
  case "$choice" in
    y|Y) reboot now
         ;;
  esac

  echo ''
}

#==================================== START =====================================

clear
_showHeader
_selectEditor

if [[ $gID -ne 0 ]];
  then
    printf "This script ${STYLE_UNDERLINED}must${STYLE_RESET} be run as root!" 1>&2
    echo ''
    #
    # Re-run script with arguments.
    #
    sudo "$0" "$@"
  else
    #
    # We are root. Call main with arguments.
    #
    main "$@"
fi

exit 0

#================================================================================
