# Quotes from influential Figures. Timeless Wisdom shown daily...

# GENERAL VARIABLES
httpCode=$(curl -s -o /null -I -w "%{http_code}" https://type.fit/api/quotes) # Get http request-code only
                                                                              # to check if "https://type.fit/api/quotes" can be reached


indices="/home/$USER/bin/newDay/indices.json" # Indices of quotes already displayed
numbers="/home/$USER/bin/newDay/numbers.json" # Indices of quotes no displayed yet
len=$(jq "[.array[] | select(.)] | length" $numbers)


echo $len


if [ $len -eq 0 ]
then
	
	index=$(shuf -i 0-1642 -n 1)

	#.................................................................................
	#REMOTE VARIABLES

	qtsRem="https://type.fit/api/quotes" # Remote quotes and authors
	qtRem=$(curl -s $qtsRem | jq ".[$index].text") # Picking random Remote quote
	auRem=$(curl -s $qtsRem | jq -r ".[$index].author") # Picking random Remote author


	#LOCAL VARIABLES
	qtsLoc="/home/$USER/bin/newDay/qt.json" # Local quotes and authors
	qtLoc=$(jq ".[$index].text" $qtsLoc) # Picking random Local quote
	auLoc=$(jq -r ".[$index].author" $qtsLoc) #Picking random Local author
	#.................................................................................

#----------------------------------------------------------------------------------------------------
	
	#.................................................................................
	# Checking if author is "null" and setting it as "anonymous" instead
	if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
	then
        	auRem="anonymous"
	        auLoc="anonymous"
	fi
	#.................................................................................




	echo $index

	#.................................................................................
	if [ $httpCode -eq 200 ] # @thisLine1... from here it checks whether "https://type.fit/api/quotes" can be reached or not...
                                 # If it does it displays Remote quote and author, it displays Local quote and author otherwise
	then
		echo -e "$qtRem \n -$auRem" | lolcat
	else
		echo -e "$qtLoc \n -$auLoc" | lolcat
	fi
	#.................................................................................

#////////////////////////////////////////////////////////////////////////////////////////////////////
	
	go=0
	
	#.................................................................................
	while [ $go -lt 1643 ] 
	do
		newNumbers=$(jq ".array += [$go]" $numbers)
        	echo $newNumbers > $numbers		
	        go=$(( go+1 ))	
	done

	jq ".array[]" $numbers > numbers.txt

	newindices="{ \"array\": [] }"
        echo $newindices > $indices
	#.................................................................................


	
	#.................................................................................
	newNumbers=$(jq ".array -= [$index]" $numbers)
	echo $newNumbers > $numbers

	jq ".array[]" $numbers > numbers.txt


	newIndices=$(jq ".array += [$index]" $indices)
	echo $newIndices > $indices
	#.................................................................................


fi


if [ $len -ne 0 ]
then



	mapfile arr < numbers.txt

	index=( $(shuf -e "${arr[@]}") ) # Generate random index from numbers on numbers.txt


	#.................................................................................
	#REMOTE VARIABLES
	qtsRem="https://type.fit/api/quotes" # Remote quotes and authors
	qtRem=$(curl -s $qtsRem | jq ".[$index].text") # Picking random Remote quote
	auRem=$(curl -s $qtsRem | jq -r ".[$index].author") # Picking random Remote author


	#LOCAL VARIABLES
	qtsLoc="/home/$USER/bin/newDay/qt.json" # Local quotes and authors
	qtLoc=$(jq ".[$index].text" $qtsLoc) # Picking random Local quote
	auLoc=$(jq -r ".[$index].author" $qtsLoc) #Picking random Local author
	#.................................................................................

#--------------------------------------------------------------------------------------------------------


	#.................................................................................
	# Checking if author is "null" and setting it as "anonymous" instead
	if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
	then
        	auRem="anonymous"
	        auLoc="anonymous"
	fi
	#.................................................................................




	#.................................................................................
	echo $index

	if [ $httpCode -eq 200 ] # @thisLine1... from here it checks whether "https://type.fit/api/quotes" can be reached or not...
                                 # If it does it displays Remote quote and author, it displays Local quote and author otherwise
	then
		echo -e "$qtRem \n -$auRem" | lolcat
	else
		echo -e "$qtLoc \n -$auLoc" | lolcat
	fi
	#.................................................................................

#/////////////////////////////////////////////////////////////////////////////////////////////////////////



	#.................................................................................
	newNumbers=$(jq ".array -= [$index]" $numbers)
	echo $newNumbers > $numbers

	jq ".array[]" $numbers > numbers.txt


	newIndices=$(jq ".array += [$index]" $indices)
	echo $newIndices > $indices
	#.................................................................................


fi






