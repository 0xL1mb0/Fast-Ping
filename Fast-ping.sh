#!/bin/bash
set -m # Enable Job Control
if [[ $? == 0 ]]
then
export lines=$(wc -l $1| awk '{print $1}')
echo "Total lines is $lines"
if [[ $lines -gt 26 ]]
then
export l=$(($lines/26))
echo "Each thread will be play with $l subdomain "
rm -r $PWD/spliter 2> /dev/null
rm $PWD/out.txt 2> /dev/null
mkdir $PWD/spliter

split -l $l $1 $PWD/spliter/a_

ls -1 $PWD/spliter\/  > $PWD/all_files

for sub in $(cat $PWD/all_files);
do
	for l in $(cat $PWD/spliter/$sub); do ping -t 1 -c 1  $l 2> /dev/null | head -n 1 | cut -d " " -f 2 >> $PWD/out.txt;done&
	a=$(( $(wc $1 | awk '{print $1}')-$(wc out.txt | awk '{print $1}') ))
	echo "$a Left to finsh the process"

done


else
echo "This is step 2"
rm $PWD/out.txt
for h in $(cat $1); do ping -c 1  $h 2> /dev/null | head -n 1 | cut -d " " -f 2 >> $PWD/out.txt;done
fi

else
	echo "enter a file like sub.txt"
fi
# Wait for all parallel jobs to finish
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done