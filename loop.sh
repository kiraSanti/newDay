number=0
setJson=

while [ $number -lt 1650 ]
do
        echo "$number"
	./dailyQuoteK.sh
	jq ".array[]" indices.json | sort -n
	cat seT.json
	echo "#"
	jq "[.array[] | select(.)] | length" indices.json	
	echo "___________________________________________"
	echo -e "\n"	
       
        number=$(( number+1 ))
done

: '
./dailyQuoteK.sh
        cat indices.json
        cat seT.json
        echo -e "\n"'
