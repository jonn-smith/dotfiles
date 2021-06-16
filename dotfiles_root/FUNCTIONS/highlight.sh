function highlight()
{
  for arg in $@ ; do
    if [[ ${arg} == '--help' ]] ; then
      echo "highlight TARGETSTRING [TARGETSTRING ...] FILE"
      echo "highlights all matches of TARGETSTRINGs found in FILE"
      return 0
    fi
  done

  targetStrings=""
  let n=0
  fin=""
  for arg in $@ ; do
    if [[ $n -eq $# ]] ; then
      fin=$arg
      break
    else
      targetStrings="${targetStrings}${arg}|"
      let n=$n+1
    fi
  done

  if [[ ! -e $fin ]] ; then
    \grep -E --color "${targetStrings}\$" -
  else
    \grep -E --color "${targetStrings}\$" $fin 
  fi

}
