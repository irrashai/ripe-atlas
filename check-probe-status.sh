#!/bin/bash
# This script checks the status of the RIPE atlas probes given file with probe IDs


#path="~/WORKSPACE/ripe-atlas/"
probelist="probes.txt"
counter=0

# Working dir
#cd $path


datenow=`date +%Y-%m-%d`

echo $datenow

for i in `cat $probelist | awk -F"," '{print $1}' `;
do
	#echo -n "Checking $i ..."
	#response=$(/usr/bin/curl --silent https://atlas.ripe.net/api/v2/probes/$i/ | jq -r '.status | "\(.name) \(.since)"' | xargs)
	#echo $i: $response

	read status datesince < <(echo $(/usr/bin/curl --silent https://atlas.ripe.net/api/v2/probes/$i/ | jq -r '.status | "\(.name) \(.since)"' | xargs))
	
	echo $i : $status $datesince

	if [ "$status" = "Connected" ]; then
		((counter++))
	fi

done

#echo "$counter probe(s) connected"
echo "Probes connected ($datenow): $counter"
