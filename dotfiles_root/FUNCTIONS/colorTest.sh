function colorTest()
{
  ############################################################
  # Nico Golde <nico(at)ngolde.de> Homepage: http://www.ngolde.de
  # Last change: Mon Feb 16 16:24:41 CET 2004
  ############################################################

  for attr in 0 1 2 3 4 5 7 8 9 ; do
    echo "----------------------------------------------------------------"
    printf "ESC[%s;Foreground;Background - \n" $attr
    for fore in 30 31 32 33 34 35 36 37; do
      for back in 40 41 42 43 44 45 46 47; do
        printf '\033[%s;%s;%sm %02s;%02s  ' $attr $fore $back $fore $back
      done
      printf '\n'
    done
    printf '\033[0m'
  done
}

function colorTest256()
{
  # This program is free software. It comes without any warranty, to
  # the extent permitted by applicable law. You can redistribute it
  # and/or modify it under the terms of the Do What The Fuck You Want
  # To Public License, Version 2, as published by Sam Hocevar. See
  # http://sam.zoy.org/wtfpl/COPYING for more details.

  for fgbg in 38 48 ; do #Foreground/Background
    for color in {0..256} ; do #Colors
      #Display the color
      echo -en "\033[${fgbg};5;${color}m ${color}\t\033[0m"
      #Display 10 colors per lines
      if [ $((($color + 1) % 10)) == 0 ] ; then
        echo #New line
      fi
    done
    echo #New line
  done

  return 0
}
