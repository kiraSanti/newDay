# Quotes from influential Figures. Timeless Wisdom shown daily

# GENERAL VARIABLES
httpCode=$(curl -s -o /null -I -w "%{http_code}" https://type.fit/api/quotes) #Get http request code only
index=$(shuf -i 0-1643 -n 1) #Generate random index

#REMOTE VARIABLES
api="https://type.fit/api/quotes"
quoteRemote=$(curl -s $api | jq ".[$index].text") #Picking random quote
authorRemote=$(curl -s $api | jq -r ".[$index].author") #Picking random author

#LOCAL VARIABLES
json="/home/$USER/bin/newDay/quotes.json"
quoteLocal=$(jq ".[$index].text" $json)
authorLocal=$(jq -r ".[$index].author" $json)


#DISPLAYING QUOTE OF THE DAY WITH ITS AUTHOR:
if [ $httpCode -eq 200 ]
then
	echo -e "$quoteRemote \n -$authorRemote" | lolcat
else 
	echo -e "$quoteLocal \n -$authorLocal" | lolcat
fi
