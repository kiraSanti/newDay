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

echo $index

