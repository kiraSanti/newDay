# Quotes from influential Figures. Timeless Wisdom shown daily...

# GENERAL VARIABLES

httpCode=$(curl -s -o /null -I -w "%{http_code}" https://type.fit/api/quotes) # Get http request-code only
                                                                              # to check if "https://type.fit/api/quotes" can be reached

: '
indices="/home/$USER/bin/newDay/indices.json" # Indices of quotes already displayed
numbers="/home/$USER/bin/newDay/numbers.json" # Indices of quotes no displayed yet
len=$(jq "[.array[] | select(.)] | length" $numbers)'

numbers="./numbers.json" # Indices of quotes not displayed yet
indices="./indices.json" # Indices of quotes already displayed
len=$(jq "[.array[] | select(.)] | length" $numbers) # Amount of quotes not displayed yet



# FUNCTIONS

# Vatiables Declaration
function init()
{
	#REMOTE VARIABLES
        qtsRem="https://type.fit/api/quotes" # Remote quotes and authors
        qtRem=$(curl -s $qtsRem | jq ".[$index].text") # Picking random Remote quote
        auRem=$(curl -s $qtsRem | jq -r ".[$index].author") # Picking random Remote author

        #LOCAL VARIABLES
        qtsLoc="/home/$USER/bin/newDay/qt.json" # Local quotes and authors
        qtLoc=$(jq ".[$index].text" $qtsLoc) # Picking random Local quote
        auLoc=$(jq -r ".[$index].author" $qtsLoc) #Picking random Local author
}


# Quote and its Author displayed Remotely/Locally depending if there is connection or not
function remloc()
{
	if [ $httpCode -eq 200 ] 
        then
                echo -e "$index: $qtRem \n -$auRem" | lolcat
        else
                echo -e "$qtLoc \n -$auLoc" | lolcat
        fi
}


# Checking if author is "null" and setting it as "anonymous" instead
function anonymous()
{
        if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
        then
                auRem="anonymous"
                auLoc="anonymous"
        fi
}


# Removing $index from numbers.json of the quote just displayed
# and adding it to the indices.json which are indices of the quotes already displayed
function refresh()
{
	newNumbers=$(jq ".array -= [$index]" $numbers)
        echo $newNumbers > $numbers
        jq ".array[]" $numbers > numbers.txt

        newIndices=$(jq ".array += [$index]" $indices)
        echo $newIndices > $indices
}


# Display Quote and its Author
# Fill numbers.json with 0-1642 numbers
# Fill numbers.txt with numbers from numbers.json
# Make indices.json empty 
# Add $index of the Quote and its Author just displayed to indices.json
function reset()
{
	go=0
	
	while [ $go -lt 1643 ] 
	do
		newNumbers=$(jq ".array += [$go]" $numbers)
        	echo $newNumbers > $numbers		
	        go=$(( go+1 ))	
	done
						
	jq ".array[]" $numbers > numbers.txt

	newindices="{ \"array\": [] }"
        echo $newindices > $indices
}
#________________________________________________________________________________________

echo $len

if [ $len -eq 0 ]
then		
	index=$(shuf -i 0-1642 -n 1)
	init	
	anonymous
	remloc	
	reset
	refresh
fi


if [ $len -ne 0 ]
then
	mapfile arr < numbers.txt
	index=( $(shuf -e "${arr[@]}") ) # Generate random index from numbers on numbers.txt
	init
	anonymous
	remloc
	refresh
fi






