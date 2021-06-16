function hist() 
{
  rv=$?

  COLS=$( tput cols )

  MAX_WIDTH=$( echo "${COLS} / 2" | bc )

  numBins=10
  binWidth=10
  rangeMin=-1
  rangeMax=-1

  usageString='hist [-n NUM_BINS] [-m BIN_RANGE_MIN] [-x BIN_RANGE_MAX] [-w BIN_WIDTH]'

  while getopts ":n:m:x:w:" opt; do
    case ${opt} in
      n )
        numBins=$OPTARG
        ;;
      m )
        rangeMin=$OPTARG
        ;;
      x )
        rangeMax=$OPTARG
        ;;
      w )
        binWidth=$OPTARG
        ;;
      \? )
        echo "ERROR: Invalid option: $OPTARG" 1>&2
        echo "${usageString}" 1>&2
        return 1
        ;;
      : )
        echo "ERROR: Invalid option: $OPTARG requires an argument" 1>&2
        echo "${usageString}" 1>&2
        return 2
        ;;
    esac
  done
  shift $((OPTIND - 1))
  
  rangeString=""
  if [[ $rangeMin -ne -1 ]] && [[ $rangeMax -ne -1 ]]; then 
    echo "Setting bin range to: ($rangeMin, $rangeMax)" 1>&2
    rangeString="range = ($rangeMin, $rangeMax)"
  elif [[ $rangeMin -ne -1 ]] && [[ $rangeMax -eq -1 ]]; then
    echo "WARNING: must set both range min and range max. Using default range (based on data)." 1>&2
  elif [[ $rangeMin -eq -1 ]] && [[ $rangeMax -ne -1 ]]; then
    echo "WARNING: must set both range min and range max. Using default range (based on data)." 1>&2
  fi

  # Read from stdin:
  which python &> /dev/null
  r=$?
  if [[ $r -ne 0 ]] ; then
    echo "ERROR: You must install python." 1>&2
    return 3
  fi

  echo

  python -c "import sys
try: 
  import numpy as np
except ImportError, e:
  sys.stderr.write('ERROR: You must install the numpy python package.\\n')
  sys.exit(4)

data = np.empty(100)
num_elements = 0
def add_element(e):
  global num_elements
  if data.size == num_elements:
    data.resize(data.size * 2, refcheck=False)
  data[num_elements] = e
  num_elements += 1

for num in sys.stdin:
  add_element(num)

counts, bin_edges = np.histogram(data, bins = ${numBins} ${rangeString}) 
bin_mids = [ (bin_edges[i] + bin_edges[i+1]) / 2 for i in range(0, len(counts)) ]

min_c = np.min(counts)
max_c = np.max(counts)

scale_denominator = (max_c - min_c) if (max_c - min_c) != 0 else 1

# Get number of digits in our biggest count (including 2 decimal places and the .):
digits=int(np.ceil(np.log10(np.max(bin_mids)))) + 3

count_digits = int(np.ceil(np.log10(max_c)))

# calculate the width of the printable field:
col_width = ${MAX_WIDTH} - digits - 1 - count_digits
counts_scaled = ((col_width - digits) * (counts - min_c))/(scale_denominator)

# Make sure our scaled data are not all zero.
# This should only happen if we happen to have a uniform distribution.
if not np.any(counts_scaled):
  counts_scaled = [(col_width - digits)/2 for i in range(len(counts_scaled))]

# Print a nice header:
print('BINS{:}COUNTS'.format( ' ' *  (col_width - count_digits - 4)))
print('-' * (col_width + 4))

# Print out the counts and bins:
format_string = '{0:<' + str(digits) + '.2f} {1:<' + str(col_width - digits) + 's} {2:>' + str(count_digits) + 'd}' 
for i in range(len(counts)):
  b = bin_mids[i]
  c = counts[i]
  c_scaled = counts_scaled[i]

  s = format_string.format(b, '#' * int(c_scaled), c)
  print(s)

# Print some summary statistics:
print('')
print('----------')
print('')
print('Min:     {:>2.2f}'.format(np.min(data)))
print('Max:     {:>2.2f}'.format(np.max(data)))
print('Mean:    {:>2.2f}'.format(np.mean(data)))
print('Median:  {:>2.2f}'.format(np.median(data)))
print('Stdev:   {:>2.2f}'.format(np.std(data)))
print('# vals:  {:>d}'.format(len(data)))
"
    rv=$?

  return $rv
}

