function random 
{
  local mean=$1
  local num_values=$2 

  if [[ $# -eq 0 ]] ; then
    echo $[(${RANDOM}%100+${RANDOM}%100)/2+1] 
  elif [[ $# -eq 1 ]] ; then

    # Make sure arg is numeric:
    if ! [[ $mean =~ ^[0-9]+$ ]] ; then
      echo "Error: specified mean is non-numeric: $mean" 1>&2
      return 1
    fi

    echo $[(${RANDOM}%${mean}+${RANDOM}%${mean})/2+1]
  elif [[ $# -eq 2 ]] ; then
    
    # Make sure args are numeric:
    if ! [[ $mean =~ ^[0-9]+$ ]] ; then
      echo "Error: specified mean is non-numeric: $mean" 1>&2
      return 1
    fi
    if ! [[ $num_values =~ ^[0-9]+$ ]] ; then
      echo "Error: specified number of values is non-numeric: $num_values" 1>&2
      return 1
    fi

    for ((i=0; i < num_values ; i++)); do
      echo $[(${RANDOM}%${mean}+${RANDOM}%${mean})/2+1]
    done 
  else
    echo "random [mean] [num_values]" 1>&2
    return 1
  fi
}
