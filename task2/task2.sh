#!/bin/bash

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -i|--input)
      dataset_file="$2"
      shift
      shift
      ;;
    -t|--train_ratio )
      train_size="$2"
      shift
      shift
      ;;
    -y|--y_column)
      target="$2"
      shift
      shift
      ;;
    *)    # unknown option
    echo "Invalid option $key"
      exit 1
      ;;
  esac
done

# checking that the number of jobs is integer
if ! [[ "$train_size" =~ ^[0-9]+$ ]]; then
        echo "Argument train_ratio (t) should be integer"
        exit 1
fi

# creating directory for the files
if ! [[ -e $dataset_file ]]; then
    echo "Specified data file does not exist"
    exit 1
fi

# finding the number of column in which data links are located
link_index=$(awk 'NR==1 {print}' $dataset_file | awk -v col=$target '{split($0,a,","); for(i = 1; i <= length(a); i++){if(a[i] == col){print i}}}')

# checking that the target column is in dataset
if ! [[ "$link_index" =~ ^[0-9]+$ ]]; then
        echo "There is no target column in dataset"
        exit 1
fi

# preparing files
mkdir -p result
awk 'NR==1 {print}' $dataset_file > result/test.csv
awk 'NR==1 {print}' $dataset_file > result/train.csv
awk 'NR>1 {print}' $dataset_file > result/new.csv
sort -R result/new.csv > result/new1.csv
rm result/new.csv

# counting the number of rows for train and test
num_rows=$(awk 'END{print FNR}' result/new1.csv )
cmd="scale=0; $num_rows*$train_size/100"
num_rows_train=$(bc <<< $cmd)
num_rows_test=$(( $num_rows - $num_rows_train ))

echo $num_rows_train
echo $num_rows_test

#spliting
awk -v train=$num_rows_train 'NR<train {print}' result/new1.csv >> result/train.csv
awk -v test=$num_rows_train 'NR>=test {print}' result/new1.csv >> result/test.csv
rm result/new1.csv
