number=0
setJson=

while [ $number -lt 40 ]
do
        echo "$number"
	./dailyQuoteK.sh
	cat indices.json
	cat seT.json
	echo -e "\n"	
       
        number=$(( number+1 ))
done

: '
./dailyQuoteK.sh
        cat indices.json
        cat seT.json
        echo -e "\n"'
