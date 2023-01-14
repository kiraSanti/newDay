n=0
testt="test.sh"

while [ $n -lt 1635 ]
do
        echo "$n"
	./$testt
	n=$(( n+1 ))		

	echo "___________________________________________"
	echo -e "\n"	
       
done


