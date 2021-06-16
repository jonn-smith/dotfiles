function tidyxml () 
{
  if [[ $# == 0 ]] ; then
    xmllint --format -
  else
    xmllint --format $1
  fi
}

function tidyxmlw () 
{

  wholedata="<HANDYDANDYGENERICXMLWRAPPER>"

  if [[ $# == 0 ]] ; then
    while read data; do
      wholedata="${wholedata}${data}"
    done
  else
    for arg in $@ ; do
      wholedata="${wholedata}${arg}"
    done
  fi

  wholedata="${wholedata}</HANDYDANDYGENERICXMLWRAPPER>"
  echo ${wholedata} | xmllint --format -

}

function untidyxml () 
{

  if [[ $# -ne 0 ]] ; then

    for f in $@ ; do
      sed 's#^[ \t]*##g' $f | sed 's#[ \t]*$##g' | tr -d '\r\n' | sed 's#>[\t ]*<#><#g' | perl -pe 's#^<\?xml.*?\?>##g'
      echo
      echo
    done

  else
    sed 's#^[ \t]*##g' - | sed 's#[ \t]*$##g' | tr -d '\r\n' | sed 's#>[\t ]*<#><#g' | perl -pe 's#^<\?xml.*?\?>##g'
  fi

}
