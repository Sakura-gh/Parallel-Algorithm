#!/bin/bash

# read file and language
read -p "please enter the file name: " FILE_IN
read -p "please choose python(0) and cpp(1), enter 0 or 1: " Language

# if output file exists, remove
if [ -f "out_${FILE_IN}" ];then
    rm "out_${FILE_IN}"
fi

# count time begin
startTime=$(date +%s)

# procedure
if [ ${Language} -eq 0 ]; then
    cat ${FILE_IN} | python3 mapper.py | sort -k1,1 | python3 reducer.py > "out_${FILE_IN}"
elif [ ${Language} -eq 1 ]; then
    g++ -std=c++11 mapper.cpp -o mapper.o
    g++ -std=c++11 reducer.cpp -o reducer.o
    cat ${FILE_IN} | ./mapper.o | sort -k1,1 | ./reducer.o > "out_${FILE_IN}"
fi

# count time end, and output time
endTime=$(date +%s)
costTime=$(( endTime - startTime ))
echo "Time taken to execute is ${costTime} seconds."
