#\[\033[40m\]

# MY OLD PROMPT:
#PS1="\[\033]0;\w\a\]\n\[\033[0;36m\]\u\[\033[0;31m\]@\[\033[0;35m\]\h \[\033[0;33m\]\w\n\[\033[0;32m\]\$\[\033[0;0m\] "
# SEE BELOW FOR MY CURRENT PROMPT (ALLOWS Putty TO CHANGE TITLEBAR)

## PROMPT
## (inspired by: http://www.unix.com/unix-dummies-questions-answers/35518-name-path-2.html and later modified by me (Jonn). )

############################################################################
##
## Required libraries and settings:
##
############################################################################

source ${BASH_DIR}/PROMPT/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="verbose name git"

############################################################################

if [ "$TERM" != "void" -a "$TERM" != "dumb" ] ; then
  PROMPT_COMMAND=pc
fi

if [ -x /bin/hostname ] ; then
  hostcmd="/bin/hostname"
elif [ -x /bin/uname ] ; then
  hostcmd="/bin/uname -n"
fi

#Get hostname info:
myhostname=`$hostcmd | sed -e 's/\\..*//'`

#Get username info:
if [ -x /usr/ucb/whoami ] ; then
  myname=$(/usr/ucb/whoami)
else
  touch /tmp/temp$$
  myname=$( ls -l /tmp/temp$$ | awk '{print $3}' )
  rm /tmp/temp$$
fi
#Root is special, treat its prompt specially:
if expr $myname = "root" > /dev/null 2>&1 ; then
  mark="#"
else
  mark='$'
fi

# Colors for different users:
userNameColor="\[\033[0;36m\]"
case $USER in
  root)
    userNameColor="\[\033[1;37;41m\]"
    ;;
esac

# Color for the @ symbol:
atColor="\[\033[0;31m\]"

# Colors for specific hosts:
hostnameColor="\[\033[0;35m\]"
hn=$HOSTNAME

# Colorize our host name:
case $hn in
  *.integration3.*)
    hostnameColor="\[\033[1;36m\]"
    ;;
  *.integration2.*)
    hostnameColor="\[\033[1;32m\]"
    ;;
  *.integration.*)
    hostnameColor="\[\033[1;31m\]"
    ;;
  *.integration4.*)
    hostnameColor="\[\033[1;33m\]"
    ;;
  idesk.*)
    hostnameColor="\[\033[1;37m\]"
    ;;
esac

normalColor="\[\033[0;0m\]"
pathColor="\[\033[0;33m\]"
promptColor="\[\033[0;32m\]"
symbolColor="\[\033[1;0m\]"
successColor="\[\033[1;42m\]"
failColor="\[\033[1;41m\]"

tprompt="${userNameColor}$myname${atColor}@${hostnameColor}${myhostname}"
titlebar="$myhostname ::: $myname   "

# NEW PROMPT BASIS:
# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202
#PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

# These frames should depend on the term
# because unicode chars aren't always displayed
# correctly:
frame_uu=""
frame_ul="\342\224\214\342\224\200"
frame_um="\342\224\200"
frame_ur="\342\224\224\342\224\200\342\224\200\342\225\274"
frame_ll="\342\224\214\342\224\200"

frame_uu=" _"
frame_ul="/ ="
frame_um="--"
frame_ur="--"
frame_mm="| ="
frame_ll="\\_="

frame_uu_s=" \[\033[1;32m\]_${normalColor}"
frame_ul_s="\[\033[1;32m\]/${successColor} ${symbolColor}="
frame_um_s="--"
frame_ur_s="--"
frame_mm_s="\[\033[1:32m\]${successColor}| ${normalColor}\[\033[1:32m\]=${normalColor}"
frame_ll_s="\[\033[1;32m\]\\\\${successColor}_${symbolColor}="

frame_uu_f=" \[\033[1;31m\]_${normalColor}" 
frame_ul_f="\[\033[1;31m\]/${failColor} ${symbolColor}="
frame_um_f="--"
frame_ur_f="--"
frame_mm_f="\[\033[1:31m\]${failColor}| ${normalColor}\[\033[1:31m\]=${normalColor}"
frame_ll_f="\[\033[1;31m\]\\\\${failColor}_${symbolColor}="

# Designed to be called from within generatePrompt.
function getGitInfo()
{
  # Git info:
  # [Remote_repo]:(Branch)

  local remote branch

  remote=$( git remote -v | head -n1 | awk '{print $2}' | sed -e 's#http[s]://github.com/#GH:#g' -e 's#\.git[\t ]*#.#g' )
  branch=$( git branch | grep '^\*' | awk '{print $2}')
  
  echo "[${remote}]:(${branch})"
}

# Designed to be called from within generatePrompt.
function getSvnInfo()
{
  echo
}

# Designed to be called from within generatePrompt.
function getVersionControlInfo()
{
  git status &> /dev/null
  r=$?
  if [[ $r -eq 0 ]] ; then
    #getGitInfo
    __git_ps1
    return
  fi

  svn status &> /dev/null
  r=$?
  if [[ $r -eq 0 ]] ; then
    getSvnInfo
    return
  fi
}

# This function is designed to be called from within the function `pc`.
function generatePrompt()
{
  local RC ts vcInfo

  RC=$1

  history -a

  PS1="\n"
  #[[ $RC -eq 0 ]] && PS1+="$frame_uu_s"
  #[[ $RC -ne 0 ]] && PS1+="$frame_uu_f"
  #PS1+="\n"
  [[ $RC -eq 0 ]] && PS1+="$frame_ul_s"
  [[ $RC -ne 0 ]] && PS1+="$frame_ul_f"

  if [[ $RC != 0 ]] ; then 
    ts=`printf "[\[\033[1;31m\]%03d\[\033[0;0m]\]" "$RC"`
    PS1+="$ts"
  else 
    PS1+="[\[\033[0;32m\]000\[\033[0;0m\]]"
  fi

  [[ $RC -eq 0 ]] && PS1+="$frame_um_s"
  [[ $RC -ne 0 ]] && PS1+="$frame_um_f"
  
  PS1+="${symbolColor}${tprompt}${symbolColor}"
  
  [[ $RC -eq 0 ]] && PS1+="$frame_ur_s"
  [[ $RC -ne 0 ]] && PS1+="$frame_ur_f"

  # pc_path defined in the function `pc`
  PS1+="[${pathColor}${pc_path}${symbolColor}]\n"
  
  vcInfo=$( getVersionControlInfo )
  if [ ${#vcInfo} -ne 0 ] ; then
    [[ $RC -eq 0 ]] && PS1+="$frame_mm_s"
    [[ $RC -ne 0 ]] && PS1+="$frame_mm_f"
    
    PS1+="${vcInfo}\[\033[0;0m\]\n"
  fi

  [[ $RC -eq 0 ]] && PS1+="$frame_ll_s"
  [[ $RC -ne 0 ]] && PS1+="$frame_ll_f"
  
  ## pc_suffix is defined in the function `pc` 
  PS1+=">${promptColor}${pc_suffix}\[\033[0;0m\]"
}

function pc
{
  # Get the last return code from the terminal:
  lastRC=$?

  pc_wd=`pwd`
  if [ \( "$TERM" = "vt100" \) -o \( "$TERM" = "xterm" \) ] ; then
    wt "$titlebar << `pwd` >>" > `tty`
  elif [[ ${TERM} == 'screen' ]] ; then
    wt "$titlebar << `pwd` >>" > `tty`
  fi

  # Go to a 2-line prompt if >38 chars in path...
  case "$pc_wd" in
    /)
      pc_path="/" ; pc_suffix="\$ "
      ;;
    $HOME)
      pc_path="~" ; pc_suffix="\$ "
      ;;
    *)
      pc_path=$pc_wd ; pc_suffix="\$ "
      ;;
  esac

  # Sometimes Linux is funny.  I have left this if statement in for future
  # consideration, even though there's no diff between if and else...
  if [ `uname -s` = "Linux" ] ; then
    generatePrompt $lastRC
  else
    generatePrompt $lastRC
  fi
  return
}

# X title stuff
function wt ()
{
  echo -n "]2;${@}"  
  # In all of these, ^[ is really the "escape" character.
  # You put it into a file using vi, by typing control-V and then hitting the Escape key.
  # Likewise, ^G is the control-G character.  Again, hit control-V then hit control-G
}

