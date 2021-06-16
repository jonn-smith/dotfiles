function randomDnaString 
{
	N=$1
	if [[ $# -lt 1 ]] ; then 
		N=10
	fi

	python -c "
import random
bases = ['A', 'T', 'G', 'C']
print(''.join([random.choice(bases) for i in range($N)]))
	"
}
