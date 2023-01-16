# Quotes from influential Figures. Timeless Wisdom shown daily...

#________________________
# GENERAL VARIABLES

httpCode=$(curl -s -o /null -I -w "%{http_code}" https://type.fit/api/quotes) # Get http request-code only to check if
                                                                              # "https://type.fit/api/quotes" can be reached or not


notDisplayedYet="./notDisplayedYet.json" # Indices of Quotes not displayed yet
displayed="./displayed.json" # Indices of Quotes already displayed
len=$(jq "[.array[] | select(.)] | length" $notDisplayedYet) # Amount of Quotes not displayed yet

#________________________
# FUNCTIONS

# Variables Declaration
function init()
{
        #REMOTE VARIABLES
        qtsRem="https://type.fit/api/quotes" # Remote Quotes and Authors
        qtRem=$(curl -s $qtsRem | jq ".[$index].text") # Picking random Remote Quote
        auRem=$(curl -s $qtsRem | jq -r ".[$index].author") # Picking random Remote Author

        #LOCAL VARIABLES
        qtsLoc="./qts.json" # Local Quotes and Authors
        qtLoc=$(jq ".[$index].text" $qtsLoc) # Picking random Local Quote
        auLoc=$(jq -r ".[$index].author" $qtsLoc) #Picking random Local Author
}


# Checking if Author is "null" and setting it as "anonymous" instead
function anonymous()
{
        if [ "$auRem" = "null" ]  || [ "$auLoc" = "null" ]
        then
                auRem="anonymous"
                auLoc="anonymous"
        fi
}


# Quote and its Author displayed Remotely/Locally depending if there is connection or not
function remloc()
{
        if [ $httpCode -eq 200 ]
        then
                echo -e "$qtRem \n -$auRem" | lolcat
        else
                echo -e "$qtLoc \n -$auLoc" | lolcat
        fi
}


# Removing $index (of the quote just displayed) from notDisplayedYet.json
# and adding it to displayed.json (which are indices of the quotes already displayed)
function refresh()
{
        temp=$(jq ".array -= [$index]" $notDisplayedYet)
        echo $temp > $notDisplayedYet

        temp=$(jq ".array += [$index]" $displayed)
        echo $temp > $displayed
}


# Fill notDisplayedYet.json with 0-1642 numbers
# Make displayed.json empty
function reset()
{
        go=0

        while [ $go -lt 1643 ]
        do
                temp=$(jq ".array += [$go]" $notDisplayedYet)
                echo $temp > $notDisplayedYet
                go=$(( go+1 ))
        done


        temp="{ \"array\": [] }"
        echo $temp > $displayed
}


# Execution
function exe()
{
	if [ $len -eq 0 ]
	then
        	index=$(shuf -i 0-1642 -n 1)
	        init
        	anonymous
	        remloc
        	reset
	        refresh
	else
		mapfile arr < <(jq ".array[]" $notDisplayedYet) # Generate array of numbers from notDisplayedYet.json
	        index=( $(shuf -e "${arr[@]}") ) # Generate random index from arr
        	init
	        anonymous
        	remloc
	        refresh
	fi
}

#________________________
# EXECUTION

exe

