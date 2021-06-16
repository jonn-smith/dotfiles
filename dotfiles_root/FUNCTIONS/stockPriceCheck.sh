function stockPriceCheck() { 

	if [[ $# -lt 1 ]] ; then
		echo "stockPriceCheck CUR_PRICE [START_PRICE=2.9] [NUM_SHARES=1000]" 1>&2
		return
	fi

  local cur_price=$1
	local start_price=$2
	local num_shares=$3
	if [[ $start_price == "" ]] ; then 
		start_price=2.9
	fi
	if [[ $num_shares == "" ]] ; then 
		num_shares=1000
	fi
	python -c "z = ($cur_price-$start_price)/$start_price*100;print(f'{z:2.2f}% | +\${($num_shares*$cur_price)-($num_shares*$start_price):2.2f} | \${$num_shares*$cur_price:2.2f}')"
}

