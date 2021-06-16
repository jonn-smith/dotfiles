function mountRamDisk()
{
  #local TYPE=ramfs
  local TYPE=tmpfs
  local FSTYPE=tmpfs

  if [[ $# -ne 2 ]] ; then
    echo "ERROR: Must give size and mount point." 1>&2;
    return 1;
  fi

  local sz=$1
  local folder=$2

  folder=$( python -c "import os;print os.path.abspath('${folder}'); ")

  echo "Executing mount command as root:mount -t ${TYPE} -o size=$sz ${FSTYPE} $folder"
  sudo mount -t ${TYPE} -o size=$sz ${FSTYPE} $folder
}
