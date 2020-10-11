#!/bin/bash

# sethome [tag] \ Sets current directory as a home identified by the tag
# delhome [tag] \ Deletes a home by the tag
# home [tag]	\ Go to a home identified by the tag 
# resethomes	\ Resets all homes
# homes	        \ Lists all homes avaiable
# work [tag]	\ Open vscode editor with the specified home


# File Format 
# tag path/to/dir
HOMES=~/.config/homes/config

function sethome 
{
	if [ ! -z "$1" ]; then

		if [[ ! -e $HOMES ]]; then
    		touch $HOMES
		fi

		while read l; do
			IFS=' ' read -ra tmp_arr <<< $l
			#echo ${tmp_arr[0]}
			if [ $1 == ${tmp_arr[0]} ]; then
				echo "Home already exists"
				return
			fi
		done <$HOMES

		DIR=$(pwd)
		echo "$1 $DIR" >> $HOMES
		echo "Home set"	

	else
		echo "error: sethome [tag]"
	fi
}

function resethomes
{
	rm -f $HOMES
	echo "Homes reseted"
}

function homes
{
	if [ ! -e $HOMES ] || [ ! -s $HOMES ]; then
		echo "No homes avaiable :("
	else
		cat $HOMES
	fi	
}

function home
{
	if [ -z "$1" ]; then
		echo "error: home [tag]"
		return
	fi

	while read l; do
		IFS=' ' read -ra tmp_arr <<< $l

		if [ $1 == ${tmp_arr[0]} ]; then
			cd ${tmp_arr[1]}
			return
		fi
	done <$HOMES
	echo "error: home not found"
}

function delhome
{
	if [ -z "$1" ]; then	
		echo "error: delhome [tag]"
	else
		sed -i "/$1 /d" $HOMES
	fi
}

function work
{
	if [ -z "$1" ]; then
		echo "error: work [tag]"
		return
	fi

	while read l; do
		IFS=' ' read -ra tmp_arr <<< $l

		if [ $1 == ${tmp_arr[0]} ]; then
			code ${tmp_arr[1]}
			return
		fi
	done <$HOMES
	echo "error: home not found"
}