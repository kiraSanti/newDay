
: '
ranges="/home/$USER/bin/newDay/ranges.json"
range=$(jq ".array[0]" $ranges)
'
: '
setJson="/home/$USER/bin/newDay/set.json"
x=$(jq ".array[0]" $setJson)

echo $setJson

echo $x

 
n=1

preSet="{ \"array\": [$n] }"

echo $preSet > $setJson

x=$(jq ".array[0]" $setJson)

echo $x'

: '
ranges="/home/$USER/bin/newDay/ranges.json"
range=$(jq ".array[0]" $ranges)



setJson="/home/$USER/bin/newDay/set.json"
delta=$(jq ".array[0]" $setJson)


echo $range $delta

a=10

if [ $a -eq 10 ]
then
        #git restore ./indices.json
        delta=$(( delta+1 ))
        range=$(jq ".array[$delta]" $ranges)
	preSet="{ \"array\": [$delta] }"
        echo $preSet > $setJson

fi

echo $range $delta'

ranges="/home/$USER/bin/newDay/ranges.json"

rangeA="0-4"
rangeB=$(jq -r ".array[0]" $ranges)
index=$(shuf -i $rangeB -n 1) 



echo $rangeA

echo $rangeB

echo $index








