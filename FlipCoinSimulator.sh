#!/bin/bash -x

#CONSTANTS
IS_HEAD=0

#VARIABLES
randomFlip=$((RANDOM%2))

#CHECKING FOR HEAD OR TAIL
if [ $randomFlip -eq $IS_HEAD ]
then
	echo Heads
else
	echo Tails
fi
