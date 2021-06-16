function remindMe()
{
  local r nargin seconds='' message='' reminderFile='' reminderId='' reminderFolder=~/.bash_reminders

  nargin=$#
  if [[ $nargin -ne 2 ]] ; then
    echo "remindMe <SECONDS> <MESSAGE>"
    return 1
  fi

  while [[ $1 ]] ; do
    case $1 in 
      -h|--help)
        echo "remindMe <SECONDS> <MESSAGE>"
        return 0
        ;;
      *)
        if [[ ${#seconds} -ne 0 ]] ; then
          message=$1
        else
          seconds=$1
        fi
        ;;
    esac
    shift
  done

  mkdir -p $reminderFolder

  reminderId=`uuidgen`
  reminderFile=$reminderFolder/$reminderId

  echo "$seconds $message" > $reminderFile

  while [ -e $reminderFile ] ; do
    sleep $seconds
    zenity --title="REMINDER" --question --text="$message"
    r=$?
    if [ $r -eq 1 ] ; then
      rm -f $reminderFile $reminderFolder/${pid}_${reminderId}
    fi
  done &
  pid=$!
  touch $reminderFolder/${pid}_${reminderId}
}
