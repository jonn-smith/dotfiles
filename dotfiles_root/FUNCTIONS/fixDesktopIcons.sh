function fixDesktopIcons()
{

  local offset=320
  if [[ $# -eq 1 ]] ; then
    echo $1 | grep '[0-9]*' &> /dev/null
    r=$?
    if [[ $r -eq 0 ]] ; then
      offset=$1
    fi
  fi

  for f in $( find ~/Desktop -maxdepth 1 ); do

    local xCoord=$( gvfs-info $f | \grep 'position:' | awk '{print $NF}' | sed 's#,.*##g' )
    local yCoord=$( gvfs-info $f | \grep 'position:' | awk '{print $NF}' | sed 's#.*,##g' )

    if [[ ${#xCoord} -gt 0 ]] && [[ ${#yCoord} -gt 0 ]] ; then
      let xCoord=${xCoord}+${offset}
      gvfs-set-attribute $f metadata::nautilus-icon-position ${xCoord},${yCoord} 
    fi
  done
}
