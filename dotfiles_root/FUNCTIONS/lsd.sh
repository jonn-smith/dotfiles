function lsd () 
{

  if [[ $# == 0 ]] ; then
    ls -ad */
  else

    ds=""
    for a in "${@}" ; do

      ds="${ds} ${a}*/ "

    done

    ls -ad ${ds}

  fi

}
