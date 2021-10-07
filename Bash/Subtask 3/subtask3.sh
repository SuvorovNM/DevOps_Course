#!/bin/bash
while [[ $# -gt 0 ]]
do
    key=$1
    case $key in
        -w|--workers_count)
            WORKERS_COUNT=$2
            shift 2
            ;;
    esac
done

find . -type f -name '*.txt' -print0 | xargs -0 -n1 -P${WORKERS_COUNT:-4} mawk '{if ($1 == "A") a++; if ($1 == "B") b++; if ($1 == "C") c++ } END { print a+b+c, a, b, c }'| mawk '{total += $1; a += $2; b += $3; c += $4; } END { print "Total:", total, "\nA:", a, "\nB:", b, "\nC:", c }'
