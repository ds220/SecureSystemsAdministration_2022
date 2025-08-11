INP=./StudentList.csv
FILE=$(realpath redhat_upload.csv)

declare -a EMAIL
declare -a FNAME
declare -a LNAME
declare -a RHNID

read_csv () {

#Loop to populate array's with nessecary information about students.
counter=1
while IFS= read -r line || [ -n "$line" ]
	do
		LNAME[$counter]=$(echo $line | awk -F "," '{print $2}')
		FNAME[$counter]=$(echo $line | awk -F "," '{print $3}')
		EMAIL[$counter]=$(echo $line | awk -F "," '{print $4}')
		let counter=counter+1;
	done < $INP
}

edit_values () {
#Strip quotes from name, and remove email handle to generate RHNID 
	for ((i=1; i<$counter; i++ ));
	do
		FNAME[$i]=$(echo ${FNAME[i]} | sed 's/"//')
		LNAME[$i]=$(echo ${LNAME[i]} | sed 's/"//')
		RHNID[$i]=$(echo ${EMAIL[i]} | sed 's/@.*//')
	done
}

write_new_csv () {
	#Create header for CSV file.
	echo "RHNID,EMAIL,FIRSTNAME,LASTNAME" > $FILE

	#Write data from array to CSV file
	for ((i=1; i<$counter; i++ ));
	do
		output=${RHNID[i]},${EMAIL[i]},${FNAME[i]},${LNAME[i]}
		echo "${output}"  >> $FILE
	done

	#Print message with a cow telling you the file has been written
	cowsay "File written successfully to $FILE" 2> /dev/null

	#Print standard message if cowsay is not installed
	if [ $? -ne 0 ]; then
		echo "File written successfully to $FILE"
	fi
}

#Determine if the exists already to prevent accidental overwriting
if [ -f "$FILE" ]; then
	echo "$FILE already exists, exiting..."
else
	touch $FILE
	read_csv
	edit_values
	write_new_csv
fi

#FOR MORE DETAILED NOTES PLEASE READ: https://pastebin.com/9Z7y3i1s

#REFERENCES:
#1. https://cht.sh/awk for AWK switches
#2. https://unix.stackexchange.com/question/482517 for fixing bug with last line not being read by the CSV
#3. https://linuxize.com/ for bash functions, and determining if a file exists
#4. https://stackoverflow.com/questions/4168371 for removing all text after a point
#5. https://linuxconfig.org/how-to-use-arrays-in-bash-script for initialising arrays in script
#6. https://stackoverflow.com/questions/26675681 for using using the exit status in if statements
#7. https://stackoverflow.com/questions/3915040 for getting absolute path to file
#8. https://stackoverflow.com/questions/49110/how-do-i-write-a-for-loop-in-bash
