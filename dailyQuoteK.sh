# Quotes from influential Figures. Timeless Wisdom shown daily...

# GENERAL VARIABLES
httpCode=$(curl -s -o /null -I -w "%{http_code}" https://type.fit/api/quotes) # Get http request-code only
									      # to check if "https://type.fit/api/quotes" can be reached

setJson="/home/$USER/bin/newDay/set.json"
delta=$(jq ".array[0]" $setJson)
if [ $delta -gt 1 ]
then
        preSet="{ \"array\": [0] }"
        echo $preSet > $setJson
	#delta=$(jq ".array[0]" $setJson)
	delta=0
fi
ranges="/home/$USER/bin/newDay/ranges.json"
range=$(jq -r ".array[$delta]" $ranges)
index=$(shuf -i $range -n 1) # Generate random index
indices="/home/$USER/bin/newDay/indices.json" # Array of Indexes of Quotes already displayed
len=$(jq "[.array[] | select(.)] | length" $indices) # Amount of Indexes on the $indices array, i.e # of Quotes already displayed
ocurrences=$(jq "[.array[] | select(. == $index)] | length" $indices) # Amount of times a certain Quote has
								      # been displayed (should be either 0 or 1)

#REMOTE VARIABLES
qtsRem="https://type.fit/api/quotes" # Remote quotes and authors
qtRem=$(curl -s $qtsRem | jq ".[$index].text") # Picking random Remote quote
auRem=$(curl -s $qtsRem | jq -r ".[$index].author") # Picking random Remote author


#LOCAL VARIABLES
qtsLoc="/home/$USER/bin/newDay/qt.json" # Local quotes and authors
qtLoc=$(jq ".[$index].text" $qtsLoc) # Picking random Local quote
auLoc=$(jq -r ".[$index].author" $qtsLoc) #Picking random Local author







if [ $len -eq 5 ]
then	
	if [ $delta -eq 1 ]
	then
        	preSet="{ \"array\": [0] }"
	        echo $preSet > $setJson
        	delta=0
	else
		delta=$(( delta+1 ))		
	fi

	range=$(jq -r ".array[$delta]" $ranges)
	index=$(shuf -i $range -n 1)	
	qtRem=$(curl -s $qtsRem | jq ".[$index].text")
	auRem=$(curl -s $qtsRem | jq -r ".[$index].author")


	echo -e "$index: $qtRem \n -$auRem" | lolcat

	newindices="{ \"array\": [$index] }"
	echo $newindices > $indices

        preSet="{ \"array\": [$delta] }"
        echo $preSet > $setJson	
fi










echo $range












# Checking if author is 'null' and setting it as 'anonymous' instead
if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
then
        auRem="anonymous"
	auLoc="anonymous"
fi


#DISPLAYING QUOTE OF THE DAY WITH ITS AUTHOR:
# Making sure quote and author (Remote/Local) have not been displayed before...

if [ $len -lt 5 ] # @thisLine3 
then
        until [ $ocurrences -eq 0 ] # Until the previously generated $index is not on the $indices array 
				    # (meaning the quote which belongs to that $index has not been displayed yet)
				    # it will keep: Generating new $index, Updating quote and author (Remote/Local) and
				    # Checking if author is 'null' and setting it as 'anonymous' instead.	
				    # When done ( i.e when $index is not found the $indices array) it'll jump to @thisLine1
        do
                index=$(shuf -i $range -n 1)
		ocurrences=$(jq "[.array[] | select(. == $index)] | length" $indices)
		qtLoc=$(jq ".[$index].text" $qtsLoc)
		auLoc=$(jq -r ".[$index].author" $qtsLoc)
		qtRem=$(curl -s $qtsRem | jq ".[$index].text")
		auRem=$(curl -s $qtsRem | jq -r ".[$index].author")
		
		if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
		then
        		auRem="anonymous"
        		auLoc="anonymous"
		fi
        done

	if [ $httpCode -eq 200 ] # @thisLine1... from here it checks whether "https://type.fit/api/quotes" can be reached or not...
				 # If it does it displays Remote quote and author, it displays Local quote and author otherwise
	then
        	echo -e "$index: $qtRem \n -$auRem" | lolcat
	else
        	echo -e "$index: $qtLoc \n -$auLoc" | lolcat

	fi	
	
	newindices=$(jq ".array += [$index]" $indices) # Once quote and author (Remote/Local) are displayed...
						       # $indices array gets updated with the last $index generated,
						       # which is the one associated with the quote and author (Remote/Local) just displayed...
						       # That way those quote and author (Remote/Local) won't be displayed again in the future
						       # until $indices array gets filled up (meaning all the quotes and its authors (Remote/Local) 
						       # have been displayed), when it does it is handled in @thisLine2

	echo $newindices > $indices # $indices gets updated with last $index generated
fi


if [ $len -eq 999 ] # @thisLine2... given $indices array is filled up, now it'll:

		     # Display the quote and author (Remote/Local) associated with the $index generated at the beginning of the script
		     # Make $indices empty and then add the $index generated at the beginning of the script to the $indices array

		     # so the next time the script is executed the flow will be catched by @thisLine3
then  	
	if [ $httpCode -eq 200 ] # @thisLine1... from here it checks whether "https://type.fit/api/quotes" can be reached or not
                                 # and displays Remote quote and author if it does, or Local quote and author otherwise
	then
        	echo -e "$index: $qtRem \n -$auRem" | lolcat
	else
        	echo -e "$index: $qtLoc \n -$auLoc" | lolcat
	fi

	newindices="{ \"array\": [$index] }"
	echo $newindices > $indices # $indices gets updated with last $index generated
fi

