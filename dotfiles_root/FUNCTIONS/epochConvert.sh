function epochConvert () 
{

  s=""
  rem="000"
  micros=false
  millis=false
  doQuiet=false
  doUTC=false

  args=""

  while [[ $1 ]] ; do
    case $1 in 
      -m)
        if $micros ; then echo "Error: Already specified microseconds." 1>&2; return 1 
        elif $millis ; then echo "Error: Already specified milliseconds." 1>&2; return 1
        else millis=true ; fi
        ;;
      -u)
        if $micros ; then echo "Error: Already specified microseconds." 1>&2; return 1 
        elif $millis ; then echo "Error: Already specified milliseconds." 1>&2; return 1
        else micros=true ; fi
        ;;
      -q)
        doQuiet=true;
        ;;
      -UTC)
        doUTC=true
        ;;
      *)
        args="$args $1"
        ;;
    esac
    shift
  done

  for s in $args ; do

    if ! $millis && ! $micros ; then
      if [[ ${#s} -eq 13 ]] ; then 
        millis=true; 
        if ! $doQuiet ; then 
          echo "Assuming timestamp is in milliseconds..." 
        fi
      elif [[ ${#s} -eq 16 ]] ; then 
        micros=true; 
        if ! $doQuiet ; then 
          echo "Assuming timestamp is in microseconds..."
        fi
      fi
    fi

    if $millis ; then
      s=`echo $s | sed 's#[0-9][0-9][0-9]$##g'`
      rem=`echo $s | sed 's#.*\([0-9][0-9][0-9]\)$#\1#g'`
    elif $micros ; then
      s=`echo $s | sed 's#[0-9][0-9][0-9][0-9][0-9][0-9]$##g'`
      rem=`echo $s | sed 's#.*\([0-9][0-9][0-9][0-9][0-9][0-9]\)$#\1#g'`
    fi

    if $doUTC; then
      echo `date -u --date="1970-01-01 $s sec GMT"` 
    else
      echo `date --date="1970-01-01 $s sec GMT"` 
    fi

    millis=false;
    micros=false;

  done
}
