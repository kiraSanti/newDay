number=0
setJson=

while [ $number -lt 110 ]
do
        echo "$number"
	./dailyQuoteK.sh
	cat indices.json
	cat seT.json
	echo -e "\n"	
       
        number=$(( number+1 ))
done
