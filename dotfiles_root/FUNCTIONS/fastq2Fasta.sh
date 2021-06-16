#!/usr/bin/env bash

function fastq2Fasta()
{
  local inFile=$1
  if [[ $# -ne 1 ]] ; then
    echo "ERROR: Must specify an inFile file." 1>&2
    return 2
  elif [[ ! -f $1 ]] ; then
    echo "ERROR: inFile file does not exist: $inFile" 1>&2
    return 3
  fi

  outName=$( echo "$inFile" | sed 's#.*\.#.fasta#g' )

  echo "Converting $inFile to FASTA format..." 
  paste - - - - < $inFile | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" > $outName
  echo "FASTA written to $outName"
}
