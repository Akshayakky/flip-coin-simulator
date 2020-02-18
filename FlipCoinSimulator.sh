#!/bin/bash -x

#CONSTANTS
IS_HEAD=0
SINGLET=1

#DECLARE DICTIONARY
declare -A combinationDictionary

#FUNCTION TO SIMULATE SINGLET COMBINATION
function flipCoin(){
	local NO_OF_COINS=$2
	for (( index=1; index<=$1; index++ ))
	do
		for (( coins=1; coins<=$NO_OF_COINS; coins++ ))
		do
			randomFlip=$((RANDOM%2))
			if [ $randomFlip -eq $IS_HEAD ]
			then
				flipCombination=$flipCombination"H"
			else
				flipCombination=$flipCombination"T"
			fi
		done

		#STORING HEAD AND TAIL COMBINATION COUNT IN COMBINATION DICTIONARY
		((combinationDictionary[$flipCombination]++))
		flipCombination=""
	done
}

#FUNCTION TO CONVERT DICTIONARY TO ARRAY OF COMBINATIONS AND COUNTS
function dictionaryToArray(){
	local combinationAndCountArray=("$@")
	local NO_OF_RECORDS=$((${#combinationAndCountArray[@]}/2))
	for (( i=0; i<$NO_OF_RECORDS; i++ ))
	do
		newCombinationAndCountArray[$i]=${combinationAndCountArray[$i]}:${combinationAndCountArray[$NO_OF_RECORDS + $i]}
	done
	echo ${newCombinationAndCountArray[@]}
}

#CONVERTING COUNT TO PERCENTAGE IN COMBINATION ARRAY
function calculatePercentage(){
	local combinationAndCountArray=("$@")
	for i in ${!combinationAndCountArray[@]}
	do
		key=$(echo ${combinationAndCountArray[$i]} | cut -f 1 -d ":")
		count=$(echo ${combinationAndCountArray[$i]} | cut -f 2 -d ":")
		combinationAndPercentArray[$i]=$key:`echo "scale=2; $count*100/$numberIteration" | bc`
	done
	echo ${combinationAndPercentArray[@]}
}

#READING NO OF ITERATION FROM USER
read -p "Enter No of Iteration : " numberIteration 

flipCoin $numberIteration $SINGLET

combinationArray=($(dictionaryToArray ${!combinationDictionary[@]} ${combinationDictionary[@]}))
combinationArray=($(calculatePercentage ${combinationArray[@]}))
