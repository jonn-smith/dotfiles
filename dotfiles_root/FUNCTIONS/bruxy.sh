#===============================================================================
## Functions from BruXy.
## http://bruxy.regnet.cz/web/linux/EN/
function teh_matrix()
{
  #  echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true 
  #  do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
  #  do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
  #    $e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
  #  then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
  #  do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done #(c) 2011 -- [ BruXy ]

  echo -e "\033[2J\033[?25l"
  R=`tput lines` 
  C=`tput cols`
  : $[R--] 
  while true ; do 
    (   
    e=echo\ -e 
    s=sleep 
    j=$[RANDOM%C] 
    d=$[RANDOM%R]
    for i in `eval $e {1..$R}`; do  
      c=`printf '\\\\0%o' $[RANDOM%57+33]` 
      $e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c
      $s 0.1 
      if [ $i -ge $d ] ; then 
        $e "\033[$[i-d];${j}H "
      fi  
    done
    for i in `eval $e {$[i-d]..$R}`; do  
      echo -e "\033[$i;${j}f "
      $s 0.1 
    done
    ) & sleep 0.05
  done 
  ### http://bruxy.regnet.cz/web/linux ###
  #[mat!rix]
  #(c) 2011 -- [ BruXy ]
}

function bigClock()
{
  F=(`zcat /lib/kbd/consolefonts/drdos8x8.psfu.gz| hexdump -v -e'1/1 "%x\n"'`)
  e=echo\ -e;$e "\033[2J\033[?25l"; 
  while true ; do 
    A=''  T=`date +" "%H:%M:%S`
    $e "\033[0;0H" 
    for c in `eval $e {0..$[${#T}-1]}`; do 
      a=`$e -n ${T:$c:1}|hexdump -v -e'1/1 "%u\n"' `
      A=$A" "$[32+8*a]
    done
    for j in {0..7};do 
      for i in $A; do 
        d=0x${F[$[i+j]]} 
        m=$((0x80))
        while [ $m -gt 0 ] ; do 
          bit=$[d&m]
          $e -n $[bit/m] | sed -e 'y/01/ ▀/'
          : $[m>>=1]
        done
      done
      echo
    done
  done # BruXy
}

function static() 
{
	# Taken from: http://bruxy.regnet.cz/web/linux/EN/useless-bash/
	P=(' ' █ ░ ▒ ▓);while :;do printf "\e[$[RANDOM%LINES+1];$[RANDOM%COLUMNS+1]f${P[$RANDOM%5]}";done
}

function knightRider()
{
	# Adapted from: http://bruxy.regnet.cz/web/linux/EN/useless-bash/
	# Original:
	#while :;do for i in {1..20} {19..2};do printf "\e[31;1m%${i}s \r" █;sleep 0.02;done;done

	width=$COLUMNS
	let rb=$width-1

	while :;do for i in $( eval echo {1..$width} {$rb..2} );do printf "\e[31;1m%${i}s \r" █;sleep 0.02;done;done
}

function nyan_cat()
{
  echo 'FINISH ME!'
}

function fire()
{
X=`tput cols` Y=`tput lines` e=echo M=`eval $e {1..$[X*Y]}` P=`eval $e {1..$X}`;
B=(' ' '\E[0;31m.' '\E[0;31m:' '\E[1;31m+' '\E[0;33m+' '\E[1;33mU' '\E[1;33mW');
$e -e "\E[2J\E[?25l" ; while true; do p=''; for j in  $P; do p=$p$[$RANDOM%2*9];
done;O=${C:0:$[X*(Y-1)]}$p;C='' S='';for p in $M;do #  _-=[ BruXy.RegNet.CZ ]=-_
read a b c d <<< "${O:$[p+X-1]:1} ${O:$[p+X]:1} ${O:$[p+X+1]:1} ${O:$[p+X+X]:1}"
v=$[(a+b+c+d)/4] C=$C$v S=$S${B[$v]}; done; printf "\E[1;1f$S"; done  # (c) 2012
}
