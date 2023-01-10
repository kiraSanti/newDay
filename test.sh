: '
a=1
b=1


if [ $a -eq 1 ] && [ $b -eq 1 ]
then
	echo yupi!
else
	echo nopi :c
fi'





setJson="/home/$USER/bin/newDay/seT.json"
delta=$(jq ".array[0]" $setJson)

echo $delta

preSet="{ \"array\": [0] }"
echo $preSet > $setJson

echo $delta























: '
range=""


n=1

echo n=$n

if [ $n == 1 ]
then
	range="0-2"
fi


if [ $n == 2 ]
then
	range="3-5"
fi




if [ $n == 3 ]
then
	range="6-8"
fi



index=$(shuf -i $range -n 1)

echo $index'

