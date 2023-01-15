n=0

while [ $n -lt 1640 ]
do
        echo "$n"
	./dailyQt.sh
	n=$(( n+1 ))		

	echo "___________________________________________"
	echo -e "\n"	
       
done


