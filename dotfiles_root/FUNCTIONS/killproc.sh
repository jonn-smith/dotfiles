## Function to kill a process of a given name:
## USE pkill instead.
#function killproc () 
#{
#  if [[ $# < 1 ]] ; then
#    echo "Error: Enter a filename"
#    return;
#  else 
#    p=`ps eu | grep ${USER} | grep ${1} | grep -v grep | awk "{print $2;}"`;
#    if [[ ${#p} != 0 ]]; then 
#      kill ${p}; 
#    else 
#      echo "No Such Process."; 
#    fi 
#  fi
#  return;
#}
