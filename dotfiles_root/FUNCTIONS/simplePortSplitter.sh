function simplePortForwarder() 
{
  if [[ $# -ne 2 ]] ; then
    echo "Usage: simplePortForwarder INCOMING_PORT OUTGOING_PORT" 1>&2
    return 1
  fi

  INCOMING=$1
  OUTGOING=$2

  echo "1:|$1|"
  echo "2:|$2|"

  ## Check to make sure the ports are numerical:
  #if [[ ! $INCOMING =~ '[0-9]*' ]] ; then 
  #  echo "ERROR: invalid value for INCOMING_PORT : $INCOMING" 1>&2 
  #  return 2
  #fi

  #if [[ ! $OUTGOING =~ '[0-9]*' ]] ; then 
  #  echo "ERROR: invalid value for OUTGOING_PORT : $OUTGOING" 1>&2 
  #  return 3
  #fi

  # Check to see if the ports are in use:
  ports=`netstat -lean | grep -v "^Proto" |  grep -v '^Active' | grep -v '^unix' | awk '{print $4}' | sed 's#.*:##g' | sort -n | uniq`

  if [[ $ports =~ $INCOMING ]] ; then
    echo "ERROR: INCOMING_PORT is in use: $INCOMING" 1>&2 
    return 4
  fi

  if [[ $ports =~ $OUTGOING ]] ; then
    echo "ERROR: OUTGOING_PORT is in use: $OUTGOING" 1>&2 
    return 5
  fi

  # Make the necessary fifofile:
  fifoName="/tmp/`uuidgen`.`date +%s.%N`.fifofile"
  mkfifo $fifoName

  # Let user know what's going on:
  echo "Forwarding Port $INCOMING to $OUTGOING now..."

  # Create the port forwarder:
  nc -l $INCOMING -k 0<$fifoName | nc -l -k $OUTGOING 1>$fifoName

  # Cleanup:
  rm $fifoName
}

function simplePortSplitter2 () 
{
  if [[ $# -ne 3 ]] ; then
    echo "Usage: simplePortSplitter INCOMING_PORT OUTGOING_PORT1 OUTGOING_PORT2" 1>&2
    return 1
  fi

  INCOMING=$1
  OUTGOING1=$2
  OUTGOING2=$3

  # Check to make sure the ports are numerical:
  if [[ ! $INCOMING =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for INCOMING_PORT : $INCOMING" 1>&2 
    return 2
  fi

  if [[ ! $OUTGOING1 =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for OUTGOING_PORT1 : $OUTGOING1" 1>&2 
    return 3
  fi

  if [[ ! $OUTGOING2 =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for OUTGOING_PORT2 : $OUTGOING2" 1>&2 
    return 3
  fi

  # Check to see if the ports are in use:
  ports=`netstat -lean | grep -v "^Proto" |  grep -v '^Active' | grep -v '^unix' | awk '{print $4}' | sed 's#.*:##g' | sort -n | uniq`

  portInUse="0"
  if [[ $ports =~ $INCOMING ]] ; then
    echo "ERROR: INCOMING_PORT is in use: $INCOMING" 1>&2 
    portInUse=1
  fi

  if [[ $ports =~ $OUTGOING1 ]] ; then
    echo "ERROR: OUTGOING_PORT1 is in use: $OUTGOING1" 1>&2 
    portInUse=1
  fi

  if [[ $ports =~ $OUTGOING2 ]] ; then
    echo "ERROR: OUTGOING_PORT2 is in use: $OUTGOING2" 1>&2 
    portInUse=1
  fi

  if [[ $portInUse -ne 0 ]] ; then
    return 4
  fi

  # Make the necessary fifofiles:
  returnFifoName="/tmp/`uuidgen`.`date +%s.%N`.return.fifofile"
  intermediateFifoName="/tmp/`uuidgen`.`date +%s.%N`.intermediate.fifofile"

  echo $returnFifoName
  echo $intermediateFifoName

  mkfifo $returnFifoName
  mkfifo $intermediateFifoName

  # Let user know what's going on:
  echo "Forwarding Port $INCOMING to $OUTGOING1 and $OUTGOING2 now..."

  nc -l $OUTGOING1 -k 0<$intermediateFifoName 1>$returnFifoName &
  pid1=$!

  nc -l $OUTGOING2 -k 0<$intermediateFifoName 1>$returnFifoName &
  pid2=$!

  # Create the port forwarder:
  nc -l $INCOMING -k 0<$returnFifoName 1> $intermediateFifoName 

  # Cleanup:
  kill -9 $pid1
  kill -9 $pid2

  rm $returnFifoName
  rm $intermediateFifoName
}

function simplePortSplitter() 
{
  if [[ $# -ne 3 ]] ; then
    echo "Usage: simplePortSplitter INCOMING_PORT OUTGOING_PORT1 OUTGOING_PORT2" 1>&2
    return 1
  fi

  INCOMING=$1
  OUTGOING1=$2
  OUTGOING2=$3

  # Check to make sure the ports are numerical:
  if [[ ! $INCOMING =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for INCOMING_PORT : $INCOMING" 1>&2 
    return 2
  fi

  if [[ ! $OUTGOING1 =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for OUTGOING_PORT1 : $OUTGOING1" 1>&2 
    return 3
  fi

  if [[ ! $OUTGOING2 =~ '[0-9]*' ]] ; then 
    echo "ERROR: invalid value for OUTGOING_PORT2 : $OUTGOING2" 1>&2 
    return 3
  fi

  # Check to see if the ports are in use:
  ports=`netstat -lean | grep -v "^Proto" |  grep -v '^Active' | grep -v '^unix' | awk '{print $4}' | sed 's#.*:##g' | sort -n | uniq`

  portInUse="0"
  if [[ $ports =~ $INCOMING ]] ; then
    echo "ERROR: INCOMING_PORT is in use: $INCOMING" 1>&2 
    portInUse=1
  fi

  if [[ $ports =~ $OUTGOING1 ]] ; then
    echo "ERROR: OUTGOING_PORT1 is in use: $OUTGOING1" 1>&2 
    portInUse=1
  fi

  if [[ $ports =~ $OUTGOING2 ]] ; then
    echo "ERROR: OUTGOING_PORT2 is in use: $OUTGOING2" 1>&2 
    portInUse=1
  fi

  if [[ $portInUse -ne 0 ]] ; then
    return 4
  fi

  # Make the necessary fifofiles:
  returnFifoName="/tmp/`uuidgen`.`date +%s.%N`.return.fifofile"
  outputForSecondPort="/tmp/`uuidgen`.`date +%s.%N`.outport.port2.fifofile"

  mkfifo $returnFifoName
  mkfifo $outputForSecondPort

  # Let user know what's going on:
  echo "Forwarding Port $INCOMING to $OUTGOING1 and $OUTGOING2 now..."

  # Make a dummy process
  while true ; do 
    sleep 30; 
  done &
  tmpPid=$!

  # Send the output to the second port before any input can come in:
  tail -f --pid=$tmpPid -q -s 0.1 $outputForSecondPort | nc -l $OUTGOING2 -k 1>$returnFifoName &
  pid=$!
  echo "" > $outputForSecondPort

  # Create the port forwarder:
  nc -l $INCOMING -k 0<$returnFifoName | tee $outputForSecondPort | nc -l $OUTGOING1 -k 1>$returnFifoName

  # Cleanup:
  kill -9 $tmpPid
  kill -9 $pid
  rm $returnFifoName
  rm $outputForSecondPort 
}
