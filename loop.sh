n=0
testt="test.sh"

while [ $n -lt 1643 ]
do
        echo "$n"
	./$testt
	number=$(( number+1 ))		

	echo "___________________________________________"
	echo -e "\n"	
       
done


