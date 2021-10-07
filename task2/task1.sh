#!/bin/bash

# parsing command line arguments
while getopts ":n:d:c:" opt
do
  case $opt in
    n) num_tasks="$OPTARG"
    ;;
    d) folder="$OPTARG"
    ;;
    c) column="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG"
    exit 1
    ;;
  esac
done
shift $((OPTIND-1))

# checking that the number of jobs is integer
if ! [[ "$num_tasks" =~ ^[0-9]+$ ]]; then
        echo "Argument n should be integer"
        exit 1
fi

# creating directory for the files
if ! [[ -d $folder ]]; then
    mkdir -p $folder
fi

cd $folder

# downloading csv with information
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1EfRc2RLVdwWlXWz3nDIBEv_EvvOMd9ip' -O links.csv

# finding the number of column in which data links are located
link_index=$(awk 'NR==1 {print}' links.csv | awk -v col=$column '{split($0,a,";"); for(i = 1; i <= length(a); i++){if(a[i] == col){print i}}}')

# downloading dataset from the links in parallel
awk -F ";" -v i=$link_index '{print $i}' links.csv | parallel -j $num_tasks wget -q {}
