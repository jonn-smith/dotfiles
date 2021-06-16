#!/bin/bash

function pullAllGitRepos()
{
  local wid d dList updatedList hasFiglet

  wid=$( tput cols )

  hasFiglet=false
  which figlet &> /dev/null
  [ $? -eq 0 ] && hasFiglet=true

  dList=$( mktemp )

  find . -maxdepth 1 -type d | grep -v '^[ \t]*\.[ \t]*$' > ${dList}

  while read d ; do
    if [ -d ${d}/.git ] ; then
      pushd ${d} &> /dev/null
      echo "Pulling down changes for:"
     
      d=$( echo ${d} | sed 's#^\.*/*##' )

      if $hasFiglet ; then
        figlet -w ${wid} ${d}
      else
        echo ${d}
      fi
      
      git remote show origin | \grep -E '^[\t ]*Push|^[\t ]*Fetch' | sed 's#^[ \t]*##'
      echo
      git pull
     
      echo "Done."
      echo
      echo "================================================================================"
      echo
      popd &> /dev/null
    fi
  done < ${dList}

  [ -f ${dList} ] && rm ${dList}
}

