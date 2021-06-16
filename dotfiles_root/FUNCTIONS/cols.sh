# Get the columns from the input:
function cols() 
{

  if [[ $# -eq 0 ]] ; then

    while read line; do
      echo $line
    done

  else 

    if [[ $1 == '--help' ]] || [[ $1 == '-h' ]]; then
      echo "$0 [column number 1][column number 2] ... [file]"
      echo "NOTE: if a file exists of the same name as a specified"
      echo "      column, that will be the file printed."
    fi

    lines='';
    file='';

    for arg in $@; do

      # If it's just a line number
      if [[ `echo $arg | sed -n '/^[0-9]*$/p'` != '' ]] && [[ ! -e $arg ]] ; then
        lines="$lines \$$arg"
      elif [[ "$arg" == "LAST" ]] ; then 
        arg="NF";
        lines="$lines \$$arg"
      else
        file=$arg
        break
      fi

    done

    if [[ $file == '' ]] ; then
      while read line; do
        echo $line | awk "{print ${lines};}" 
      done
    else 
      awk "{print ${lines};}" $file
    fi


  fi
}
