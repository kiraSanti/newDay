indices="/home/bob/bin/array/indices.json"
index=$(shuf -i 0-5 -n 1)
len=$(jq "[.array[] | select(.)] | length" $indices)
ocurrences=$(jq "[.array[] | select(. == $index)] | length" $indices)


quotes="/home/bob/bin/array/qt.json"
quoteLocal=$(jq ".[$index].text" $quotes)
authorLocal=$(jq -r ".[$index].author" $quotes)


if [ $len -lt 6 ]
then
        until [ $ocurrences -eq 0 ]
        do
                index=$(shuf -i 0-5 -n 1)
		ocurrences=$(jq "[.array[] | select(. == $index)] | length" $indices)
		quoteLocal=$(jq ".[$index].text" $quotes)
		authorLocal=$(jq -r ".[$index].author" $quotes)
        done
	
	echo -e "$index : $quoteLocal \n -$authorLocal" | lolcat
        newindices=$(jq ".array += [$index]" $indices)
	echo $newindices > $indices
fi

if [ $len -eq 6 ]
then 
 	echo -e "$index : $quoteLocal \n -$authorLocal" | lolcat	
	newindices="{ \"array\": [] }"
	echo $newindices > $indices
fi

