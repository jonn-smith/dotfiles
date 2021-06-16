function getWaPoArticle() {
	local url=$1

	local ARTICLE_DIR="~/.tmp_articles/"
	mkdir -p $ARTICLE_DIR 

	local name=$(echo "$url" | tr '.' '_' | tr '/' '_' | tr -d "\\~:?#[]{}@&=;,+%" | tr -d '!"$')
	local outfile="${ARTICLE_DIR}/${name}.html"

	curl -Ls ${url} | tr -d '\r\n' | perl -pe 's$\<script\>.*?\</script\>$$g' > ${outfile}
	echo "Article saved to ${outfile}"

	if [[ "$( uname )" == "Darwin" ]] ; then
		open ${outfile}
	fi
}

