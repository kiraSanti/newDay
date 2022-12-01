# Quotes from influential Figures. Timeless Wisdom shown daily

# VARIABLES
api="https://type.fit/api/quotes"
index=$(shuf -i 0-1643 -n 1)
quote=$(curl -s $api | jq ".[$index].text")
author=$(curl -s $api | jq -r ".[$index].author")

#Displaying Quote with its Author...
echo -e "$quote \n -$author" | lolcat
