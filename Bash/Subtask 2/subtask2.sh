#!/bin/bash
while [[ $# -gt 0 ]]
do
    key=$1
    #echo $key $2
    case $key in
        -i|--input)
            FILE_PATH=$2
            shift 2
            ;;
        -t|--train_ratio)
            TRAIN_RATIO=$2
            shift 2
            ;;
        -y|--y_column)
            COLUMN_NAME=$2
            shift 2
            ;;
    esac
done

if [[ -z "$COLUMN_NAME" ]]; then
    echo "Error: Column name should be defined!"
    exit 1
fi
if [[ -z "$FILE_PATH" ]]; then
    echo "Error: File path should be defined!"
    exit 1
fi
if [[ -z "$TRAIN_RATIO" ]]; then
    echo "Error: Train ratio should be defined!"
    exit 1
fi


TRAIN_OUT=train.csv
TEST_OUT=test.csv

DATA_LENGTH=$(($(cat ${FILE_PATH} | wc -l)-1))
echo "Total file length: ${DATA_LENGTH}"

LINES_COUNT_TRAIN=$(( ${DATA_LENGTH}*${TRAIN_RATIO}/100 ))
echo "Train set length: ${LINES_COUNT_TRAIN}"


awk -v lines=${FILE_PATH} -v fact=${LINES_COUNT_TRAIN} 'NR <= fact {
              if (NR > 1) print > "train.csv"; next} {print > "test.csv"}' "${FILE_PATH}"

first_line=$(head -n 1 ${FILE_PATH})
sed -i "1s/^/${first_line}/" ${TRAIN_OUT}
sed -i "1s/^/${first_line}/" ${TEST_OUT}

