function mdiff 
{

  d="0.0";
  while read line ; do

    if [[ $d != "0.0" ]] && [[ ${#line} -eq 0 ]] ; then
      continue;
    fi

    d=`echo "scale=9; ${line}-${d}" | bc`;
    echo $d;
    d=$line;

  done
}
