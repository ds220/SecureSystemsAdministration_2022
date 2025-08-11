#!/usr/bin/bash

#Declaring Variables
arg="$1"

#Arrays with characters
onep=("A" "E" "I" "O" "R" "S" "T")
twop=("D" "L" "N" "U")
threep=("G" "H" "Y")
fourp=("B" "C" "F" "M" "P" "W")
fivep=("K" "V")
eightp=("X")
tenp=("J" "Q" "Z")

#Sum which added for each occurence of characters
sum=0

#Functions for each point values for modularity
checkonep () {

for ((i=0; i<$(echo ${#onep[@]}); i++ )); #For length array, add one to i each time the sum is added
do
	let sum=sum+$(grep -o ${onep[i]} <<<${arg^^} | wc -l) #Add 1 for each occurence of characters in array
done
}

checktwop () {

for ((i=0; i<$(echo ${#twop[@]}); i++ ));
do
	let sum=sum+$(grep -o ${twop[i]} <<<${arg^^} | wc -l)*2 #Multiply occurences by 2 to make each point doubled
done
}

#Add three points for every occurence of character in array
checkthreep () {

for ((i=0; i<$(echo ${#threep[@]}); i++ ));
do
	let sum=sum+$(grep -o ${threep[i]} <<<${arg^^} | wc -l)*3
done
}

#Add four points for every occurence of character in array
checkfourp () {

for ((i=0; i<$(echo ${#fourp[@]}); i++ ));
do
	let sum=sum+$(grep -o ${fourp[i]} <<<${arg^^} | wc -l)*4
done
}

#Add five points for every occurence of character in array
checkfivep () {

for ((i=0; i<$(echo ${#fivep[@]}); i++ ));
do
	let sum=sum+$(grep -o ${fivep[i]} <<<${arg^^} | wc -l)*5
done
}

#Add eight points for every occurence of character in array
checkeightp () {

for ((i=0; i<$(echo ${#eightp[@]}); i++ ));
do
	let sum=sum+$(grep -o ${eightp[i]} <<<${arg^^} | wc -l)*8
done
}

#Add ten points for every occurence of character in array
checktenp () {

for ((i=0; i<$(echo ${#tenp[@]}); i++ ));
do
	let sum=sum+$(grep -o ${tenp[i]} <<<${arg^^} | wc -l)*10
done
}

#Call functions
checkonep
checktwop
checkthreep
checkfourp
checkfivep
checkeightp
checktenp

#Print output
echo $sum

#FOR FURTHER DETAIL PLEASE READ: https://pastebin.com/ECx0ni02

#REFERENCES
#1. https://www.putorius.net/grep-string-from-a-variable.html
#2. https://www.freecodecamp.org/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/
#3. https://stackoverflow.com/questions/49110/how-do-i-write-a-for-loop-in-bash
#4. https://linuxhint.com/bash_lowercase_uppercase_strings/#:~:text=You%20can%20convert%20the%20case,whole%20string%20to%20the%20uppercase.
#5. https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/
