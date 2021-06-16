#!/usr/bin/env bash

################################################################################

# Installer script for Jonn's Dotfiles.
# Author: Jonn Smith

################################################################################

#Setup variables for the script:
which python &> /dev/null
r=$?
which python3 &> /dev/null
r3=$?
if [ $r -eq 0 ] ; then
  UNALIASED_SCRIPT_NAME=$( python -c "import os;print (os.path.realpath(\"${BASH_SOURCE[0]}\"))" )
elif [ $r3 -eq 0 ] ; then
  UNALIASED_SCRIPT_NAME=$( python3 -c "import os;print (os.path.realpath(\"${BASH_SOURCE[0]}\"))" )
else
  echo "ERROR: Must have python or python3 for installation.  Aborting." 1>&2
  exit 1
fi

SCRIPTDIR="$( cd "$( dirname "${UNALIASED_SCRIPT_NAME}" )" && pwd )"
SCRIPTNAME=$( echo $0 | sed 's#.*/##g' )
MINARGS=0
MAXARGS=1
PREREQUISITES=""

# Determine if this shell is interactive:
ISCALLEDBYUSER=true
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && ISCALLEDBYUSER=false

# Required for any aliased calls:
shopt -s expand_aliases

################################################################################

#Display a message to std error:
function error() 
{
  echo "$1" 1>&2 
}

# Make a temporary file that will be cleaned after this script finishes. 
function makeTemp()
{
  local f
  f=$( mktemp )
  TMPFILELIST="${TMPFILELIST} $f"
  echo $f
}
TMPFILELIST=''

# Clean all temporary files made in this script:
function cleanTempVars()
{
  rm -f ${TMPFILELIST}
}

# Function run in the exit trap.
function at_exit()
{
  cleanTempVars
}

# Checks the bash built-in PIPESTATUS variable for any failures
# If given strings will output the string corresponding to the failure
# position in PIPESTATUS of any failures in the chain of commands 
# that occurred.
# This function should be called as `checkPipeStatus` as per the 
# alias below it.
function _checkPipeStatus() {

  local hadFailure=false

  for (( i = 0 ; i < ${#RC[@]} ; i++ )) ; do 
    st=${RC[i]}
    echo "st = ${st}"
    if [ $st -ne 0 ] ; then
      # If we were passed a description string for this error in the pipe, then we print it:
      let argIndex=$i+1
      description=${!argIndex}
      [[ ${#description} -ne 0 ]] && error "$description"
      hadFailure=true  
    fi
  done

  if $hadFailure ; then
    return 10
  fi
  return 0
}
alias checkPipeStatus='RC=( "${PIPESTATUS[@]}" );_checkPipeStatus'

# Get an answer from the user in as annoying a method as possible.
# Example:
#  getAnswerFromUser "Are you sure you want to CLEAR the listed records? " 'Yes No' answer 
function getAnswerFromUser()
{
  local prompt="${1}" 
  local acceptableValues="${2}"
  local responseVar="${3}" 

  local haveGoodValue=false
  while ! ${haveGoodValue} ; do
    read -p "${prompt} [$( echo ${acceptableValues} | tr ' ' '/' )] : " ${responseVar}

    for okVal in ${acceptableValues} ; do
      if [[ "$( echo ${!responseVar} | tr a-z A-Z)" == "$( echo ${okVal} | tr a-z A-Z)" ]] ; then
        haveGoodValue=true
      fi
    done

    ! ${haveGoodValue} && error "Please enter one of the following: $( echo ${acceptableValues} | tr ' ' '/' )" && error ""
  done
}


################################################################################

error '########################################'
error '  You are now installing... '
error '########################################'
error '       _                   _         '  
error '      | | ___  _ __  _ __ ( )___     '
error "   _  | |/ _ \\| '_ \\| '_ \\|// __|    "
error '  | |_| | (_) | | | | | | | \__ \    '
error '   \___/ \___/|_| |_|_| |_| |___/    '
error ''       
error ' ____        _    __ _ _             '
error '|  _ \  ___ | |_ / _(_) | ___  ___   '
error '| | | |/ _ \| __| |_| | |/ _ \/ __|  '
error '| |_| | (_) | |_|  _| | |  __/\__ \  '
error '|____/ \___/ \__|_| |_|_|\___||___/  '
error '                                     '
error '########################################'
error

getAnswerFromUser "This will overwrite most of your dotfiles in ~/  Do you accept this? " 'Yes No' answer 

if [[ "$( echo ${answer} | tr a-z A-Z)" == "NO" ]] ; then
  error "Aborting installation."
  exit 0
fi
error ""

#----------------------------------------  
# Update the user email address for notifications:

# Get the user's email address:
read -p "Please enter your email address (so you can email yourself when long finish): " user_email
answer="No"
while [[ "${answer}" == "No" ]] ; do
  getAnswerFromUser "Please confirm: your email address is: ${user_email}" 'Yes No' answer 
  if [[ "${answer}" == "No" ]] ; then
    read -p "Please enter your email address (so you can email yourself when long finish): " user_email
  fi
done

# Replace the email address in all of our files:
email_lines=$( makeTemp )
grep -rn '__Z91e35c89Z__USER_NOTIFY_EMAIL__Zb802891efZ__' ${SCRIPTDIR}/* > ${email_lines}

while read line ; do
  file_name=$( echo "${line}" | tr ':' '\n' | head -n1 | tr '\n' ":" | sed 's#:$##' )

  tmp_file=$( makeTemp )
  sed "s#__Z91e35c89Z__USER_NOTIFY_EMAIL__Zb802891efZ__#${user_email}#g" ${file_name} > ${tmp_file}
  mv ${tmp_file} ${file_name}
done < ${email_lines}


#----------------------------------------  

# Make a backup of old dotfiles just in case:
d=$( date +%Y%m%dT%H%M )
old_df_folder=~/${d}_dotfiles_backup

set -e

dotfile_list="bashrc screenrc vimrc gitconfig tmux.conf"

mkdir ${old_df_folder}
error "Backing up old dotfiles to: ${old_df_folder}"
for f in $dotfile_list ; do 
  if [ -e ~/.${f} ] ; then
    cp -v ~/.${f} ${old_df_folder}
  elif [ -L ~/.${f} ] ; then
    rm ~/.${f}
  fi 
done
error ""

if [ -e ~/.dotfiles_root ] || [ -L ~/.dotfiles_root ] ; then
  mv ~/.dotfiles_root ${old_df_folder}
fi
ln -s ${SCRIPTDIR} ~/.dotfiles_root

#----------------------------------------  

# Create new symlinks to activate dotfiles:
error "Linking in new dotfiles for activation..."
for f in $dotfile_list ; do
  [ -e ~/.${f} ] && rm -v ~/.${f}
  ln -sv ${SCRIPTDIR}/${f} ~/.${f}
done
error ""

#----------------------------------------  
error "Jonn's Dotfiles now Installed."
error "Open a new terminal window or source ~/.bashrc to begin using."
error

