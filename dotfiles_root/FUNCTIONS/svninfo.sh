function svninfo () 
{

  tmpfile=`mktemp`
  tmpfile2=`mktemp`

  target=$1

  if [[ $# -ne 1 ]] ; then
    target='.'
  fi

  echo "###################################   Info    ###################################"
  echo
  svn info $target
  echo "###################################    Ls     ###################################"
  svn ls -v $target
  echo
  echo "################################### Externals ###################################"
  svn pg svn:externals $target > $tmpfile
  while read line ; do

    grep -E ' -r |@' $line &> /dev/null
    r=$?
    if [[ $r -ne 1 ]] ; then
      found=false
      for field in $line ; do

        if [[ -e $field ]] ; then 
          echo  -n "$field "
          svn info $field > $tmpfile2
          echo -n "`cat $tmpfile2 | \grep '^URL' | awk '{print $2}'` -r"
          cat $tmpfile2 | \grep '^Last Changed Rev' | awk '{print $4}'
          svn log --limit 1 $field | sed 's$^$    $g'
          found=true
          break
        fi

      done

      if ! $found ; then
        echo "$line - UNKNOWN REVISION"
      fi

    else
      echo $line
    fi
  done < $tmpfile
  rm $tmpfile
  echo 
  echo "###################################    Log    ###################################"
  svn log $target -v --limit 5
  echo
}
