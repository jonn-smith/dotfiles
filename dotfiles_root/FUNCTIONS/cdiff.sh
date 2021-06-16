# Color diffs:
function cdiff () 
{ 

  if [[ $# -eq 0 ]] ; then

    local tmpout=`mktemp`;
    local foundDiff=0

    while read line ; do
      echo "$line" >> $tmpout
      if [[ ${line} == "---" ]] ; then
        echo "${line}"
      elif [[ ${line} =~ "^-" ]] || [[ ${line} =~ "^<" ]] ; then 
        printf "\033[1;31;40m${line}\033[0m\n"; 
        foundDiff=1;
      elif [[ ${line} =~ "^\+" ]] || [[ ${line} =~ "^>" ]] ; then 
        printf "\033[1;32;40m${line}\033[0m\n"; 
        foundDiff=1;
      elif [[ ${line} =~ "^\@@" ]] || [[ ${line} =~ "^[[:digit:]]+,?[[:digit:]]*[[:alpha:]]?[[:digit:]]*,?[[:digit:]]*" ]] ; then 
        printf "\033[1;36;40m${line}\033[0m\n"; 
        foundDiff=1;
      elif [[ ${line} =~ "^======" ]] ; then
        printf "\033[1;36;40m${line}\033[0m\n";
        foundDiff=1;
      elif [[ ${line} =~ "^Index: " ]] ; then
        printf "\033[1;36;40m${line}\033[0m\n";
        foundDiff=1;
      else 
        echo "${line}"; 
      fi; 
    done

    # If we didn't get any "Diff-style lines from the file, try another style!
    if [[ $foundDiff == 0 ]] ; then

      while read line ; do
        echo "$line" >> $tmpout
        if [[ ${line} =~ "^<" ]] ; then 
          printf "\033[1;31;40m${line}\033[0m\n"; 
        elif [[ ${line} =~ "^>" ]] ; then 
          printf "\033[1;32;40m${line}\033[0m\n"; 
        elif [[ ${line} =~ "^[:digit:]+,[:digit:]+" ]] ; then 
          printf "\033[1;36;40m${line}\033[0m\n"; 
        else 
          echo "${line}"; 
        fi; 
      done

    fi  

  else

    for arg in $@; do

      case $arg in
        -h)
          echo "`echo $0 | sed 's#.*/##g'` [FILE1 FILE2]"
          echo "  Displays diff of FILE1 vs. FILE2 in color."
          echo "  If no files are given, reads a diff stream"
          echo "  from stdout."
          return 1;
          ;;
      esac

    done

    if [[ $# -lt 2 ]] ; then
      echo "ERROR: must give 2 files to diff"
      return 2;
    fi

    if [[ ! -e $1 ]] ; then
      echo "ERROR: FILE1 does not exist: $1"
      return 3;
    elif [[ ! -e $2 ]] ; then 
      echo "ERROR: FILE2 does not exist: $2"
      return 4;
    fi 

    diff $1 $2 | cdiff

  fi
}
