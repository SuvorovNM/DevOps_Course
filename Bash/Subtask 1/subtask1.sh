#!/bin/bash
while [[ $# -gt 0 ]]
do
    key=$1
    case $key in
        -w|--workers_count)
            WORKERS_COUNT=$2
            shift 2
            ;;
        -c|--column_index)
            COLUMN_INDEX=$2
            shift 2
            ;;
        -f|--folder_output)
            FOLDER_OUTPUT=$2
            shift 2
            ;;
    esac
done

first_line=$(head -n 1 dataset.csv)
IFS=';' read -r -a x <<< "$first_line"

for i in $(seq 0 ${#x[@]});
do
    if [[ "${x[i]}" = "${COLUMN_INDEX}" ]]; then    
	echo "Column ${x[i]} is found, starting processing..."
    	grep "${VALUE}" dataset.csv | cut -d';' -f$((${i}+1)) | parallel -j ${WORKERS_COUNT:-4} wget -q -P ${FOLDER_OUTPUT:-downloads} {}
	echo "Processing is finished!";
    fi
done


