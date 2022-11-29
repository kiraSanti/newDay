# Quotes from influential Figures. Timeless Wisdom shown daily

# VARIABLES
path="/home/kira/bin/newDay"
json="quotes.json"
index=$(shuf -i 0-1643 -n 1)

cd $path

# Picking random Quote of the day with its Author
quote=$(jq ".[$index].text" $json)
author=$(jq -r ".[$index].author" $json)

# Displaying Quote of the day and its Author
echo -e "$quote \n -$author" | lolcat
