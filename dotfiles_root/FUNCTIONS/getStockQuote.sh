function getStockQuote() {
	if [[ $# -lt 1 ]] ; then 
		echo "getStockQuote SYMBOL" 1>&2
		echo "Get a stock quote from yahoo finance." 1>&2
		return
	fi

	curl -s https://finance.yahoo.com/quote/${1}?p=${1} \
		| \grep -o 'span class="Trsdu(0.3s) Fw(b) Fz(36px) Mb(-4px) D(ib)" data-reactid="50">[0-9]*\.[0-9]*<' \
		| \grep -o '>[0-9]*\.[0-9]*<' \
		| tr -d '<>'
}
