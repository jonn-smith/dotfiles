# This function will ruin your keyboard mapping and make your life miserable.
# Or it would if it actually worked...
function ruinKeyboard()
{
  for i in {32..127} ; do

    n=$RANDOM
    while [[ $n -lt 32 ]] ; do
      let "$n %= 127"
    done

    printf "\033[%d;%dp" $i $n

  done
}
