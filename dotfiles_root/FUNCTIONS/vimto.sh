function vimto () 
{

  if [[ $# < 1 ]] ; then
    echo "vimto file:linenumber [file:linenumber2 ...]"
    return 1;
  else
    vimarguments="";
    for arg in $@ ; do
      linenumber=`echo ${arg} | perl -pe "s/.*?:(\d+).*/\1/g"`;
      filename=`echo ${arg} | perl -pe "s/(.*?):.*/\1/g"`;

      vimarguments="${vimarguments} ${filename} +${linenumber}"      
    done

    vim ${vimarguments}
  fi
}
