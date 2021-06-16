## So you can monitor your stuff as it grows:
## NOTE: the `watch` command also does this.
#function monitor() 
#{
#
#  tput sc;
#  lst='';
#
#  if [[ $# == 1 ]] ; then 
#    let cntr=0;
#    while [ 1 ] ; do 
#      x=`bash -c "ls -l $1"`
#      y=`bash -c "wc -l $1 | sed 's/\([0-9][0-9]*\).*/\1/g'"`
#      if [[ $x != $lst  ]] ; then
#        tput rc;
#        echo -en "$y $x"
#        lst=$x;
#        let cntr=0;
#      elif [[ $cntr -gt 100 ]] ; then
#        break;
#      else 
#        let cntr=$cntr+1;
#      fi
#      sleep 0.1;
#    done;
#  fi
#}
