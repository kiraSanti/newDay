number=0

while [ $number -lt 20 ]
do
        echo "$number"
	./dailyQuoteK.sh
        number=$(( number+1 ))
done
