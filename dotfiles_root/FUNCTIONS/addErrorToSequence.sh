function addErrorToSequence()
{
	probError=0.1
	python -c "
import sys, random, string
base_set = set(['A', 'T', 'G', 'C'])
sys.stdout.write(''.join([ random.choice(list(base_set.difference(string.upper(b)))) if random.random() <= ${probError} else b for b in sys.stdin.readline().strip()]))
print('')
"
}
