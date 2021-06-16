function reverseComplement() 
{
  python -c "
import sys

# IUPAC RC's from: http://arep.med.harvard.edu/labgc/adnan/projects/Utilities/revcomp.html and https://www.dnabaser.com/articles/IUPAC%20ambiguity%20codes.html
base_map = { 'N':'N', 'A':'T', 'T':'A', 'G':'C', 'C':'G', 'Y':'R', 'R':'Y', 'S':'S', 'W':'W', 'K':'M', 'M':'K', 'B':'V', 'V':'B', 'D':'H', 'H':'D', 'n':'n', 'a':'t', 't':'a', 'g':'c', 'c':'g', 'y':'r', 'r':'y', 's':'s', 'w':'w', 'k':'m', 'm':'k', 'b':'v', 'v':'b', 'd':'h', 'h':'d' }
try:
  for line in sys.stdin:
    in_line = line.strip()[::-1]
    sys.stdout.write( ''.join(map(lambda b: base_map[b], in_line )) )
    print('')
except IOError as e:
  pass
"
}

