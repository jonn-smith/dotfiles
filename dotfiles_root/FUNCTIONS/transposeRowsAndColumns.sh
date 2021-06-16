function transposeRowsAndColumns()
{
  local fileName=$1

  if [[ $# -ne 1 ]] ; then
    echo "ERROR: Must give a file of data to transpose." 1>&2
    return 1
  fi

  awk '{ for (i = 1; i <= NF; i++) f[i] = f[i] " " $i ; if (NF > n) n = NF }
  END { for (i = 1; i <= n; i++) sub(/^  */, "", f[i]) ; for (i = 1; i <= n; i++) print f[i] }
  ' $fileName
}
