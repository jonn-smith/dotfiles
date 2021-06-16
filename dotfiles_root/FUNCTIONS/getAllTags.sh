# Get all occurances of a given XML tag of the given name.
# getAllTags TAGNAME FILE
function getAllTags()
{
  #tagname='Vulnerability';sed -n "/<${tagname}/,/<\/${tagname}/p" audit.fvdl | sed -e 's#^[\t ]*##g' -e 's#[\t ]*$##g' | tr -d '\n' | sed "s#</${tagname}>#</${tagname}>\n#g"
  if [[ $# -ne 2 ]] ; then
    echo "Error: Must give a Tag name and a File name." 1>&2
    echo "getAllTags TAGNAME FILE" 1>&2
    return 1
  fi

  tagname=$1
  filename=$2

  if [ ! -e $filename ] ; then
    echo "Error: file does not exist: $filename" 1>&2
    return 2
  fi

  sed -n "/<${tagname}/,/<\/${tagname}/p" ${filename} | sed -e 's#^[\t ]*##g' -e 's#[\t ]*$##g' | tr -d '\n' | sed "s#</${tagname}>#</${tagname}>\n#g"
}
