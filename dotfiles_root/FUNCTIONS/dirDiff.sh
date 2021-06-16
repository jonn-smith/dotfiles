function dirDiff
{
  diffFile=`mktemp`
  allFilesFile=`mktemp`
  outFormatFile=`mktemp`
  tmpFile=`mktemp`

  if [[ $# -ne 2 ]] ; then
    echo "ERROR: Must provide 2 directories to compare. "
    echo "       See --help for more info."
  fi

  for arg in $@ ; do
    case arg in
      -h|--help|-\?)
        echo "`echo $0 | sed 's#.*/##g'` DIR1 DIR2"
        echo "Displays a visual diff of 2 directories."
        return 0
    esac
  done

  f1=$1
  f2=$2

  marker=`uuidgen`

  diff -qr $1 $2 | sed "s#^Files \\(.*\\) and \\(.*\\) differ#\\1 \\2#g" > $diffFile
  sed 's#^Only in \(.*\): \(.*\)#\1/\2#g' $diffFile  > $outFormatFile
  awk '{print $NF}' $outFormatFile > $allFilesFile

  maxLength=0
  while read line ; do
    if [[ ${#line} -gt $maxLength ]] ; then
      maxLength=${#line}
    fi
  done < $allFilesFile

  diff -qr $1 $2 | sed "s#^Files \\(.*\\) and \\(.*\\) differ#\\1${marker}\\2#g" > $diffFile
  sed 's#^Only in \(.*\): \(.*\)#\1/\2#g' $diffFile  > $tmpFile
  while read line ; do

    echo $line | grep "${marker}" &> /dev/null
    r=$?

    if [[ $r -eq 0 ]] ; then

      d1=$( echo ${line} | awk "BEGIN { FS = \"${marker}\" } ; { print \$1 }" )
      d2=$( echo ${line} | awk "BEGIN { FS = \"${marker}\" } ; { print \$2 }" )

      printf "| \033[0;41m%${maxLength}s | %-${maxLength}s\033[0;0m |\n" $d1 $d2 
    else
      line=$( echo $line | sed 's#^[\t ]*##g'| sed 's#[\t ]*$##g' )
      echo $line | grep "${f1}" &> /dev/null  
      r=$?
      if [[ $r -eq 0 ]] ; then
        printf "| %${maxLength}s | \033[0;47m%-${maxLength}s\033[0;0m |\n" $line "" 
      else
        printf "| \033[0;47m%${maxLength}s\033[0;0m | %-${maxLength}s |\n" "" $line 
      fi
    fi

  done < $tmpFile > $outFormatFile

  python -c "print '+' + '-'*($maxLength * 2 + 5) + '+'"
  printf "| %-${maxLength}s | %-${maxLength}s |\n" $f1 $f2 
  python -c "print '+' + '-'*($maxLength * 2 + 5) + '+'"
  cat $outFormatFile
  python -c "print '+' + '-'*($maxLength * 2 + 5) + '+'"

  rm $diffFile $allFilesFile $outFormatFile $tmpFile
}
