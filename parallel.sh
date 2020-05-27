#!/bin/bash

# simulate hadoop by pipeline in bash
# python/python3 must in your env

# set path var in your computer
HADOOP_PATH="hadoop"
STREAM_JAR_PATH="/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar"

# choose file and language
read -p "please enter the input file name: " IN_FILE
read -p "please choose language, python(0) and cpp(1), enter 0 or 1: " Language

# makdir /input in hdfs
${HADOOP_PATH} fs -test -e "/input"
if [ $? -eq 1 ]; then
   hdfs dfs -mkdir "/input"
fi

# makdir /output in hdfs
${HADOOP_PATH} fs -test -e "/output"
if [ $? -eq 1 ]; then
   hdfs dfs -mkdir "/output"
fi

# update input file
${HADOOP_PATH} fs -test -e "/input/${IN_FILE}"
if [ $? -eq 0 ]; then
    hdfs dfs -rm -r "/input/${IN_FILE}"
    hdfs dfs -put ${IN_FILE} "/input"
else
    hdfs dfs -put ${IN_FILE} "/input"
fi

# update output file
${HADOOP_PATH} fs -test -e "/output/out_${IN_FILE}"
if [ $? -eq 0 ]; then
    hdfs dfs -rm -r "/output/out_${IN_FILE}"
fi

# count time begin
startTime=$(date +%s)
# hadoop procedure
if [ ${Language} -eq 0 ]; then
    ${HADOOP_PATH} jar ${STREAM_JAR_PATH}\
        -files "mapper.py,reducer.py"\
        -mapper "python3 mapper.py"\
        -reducer "python3 reducer.py"\
        -input "/input/${IN_FILE}"\
        -output "/output/out_${IN_FILE}"
elif [ ${Language} -eq 1 ]; then
    g++ mapper.cpp -std=c++11 -o mapper.o
    g++ reducer.cpp -std=c++11 -o reducer.o
    ${HADOOP_PATH} jar ${STREAM_JAR_PATH}\
        -files "mapper.o,reducer.o"\
        -mapper "./mapper.o"\
        -reducer "./reducer.o"\
        -input "/input/${IN_FILE}"\
        -output "/output/out_${IN_FILE}"
fi
# count time end, and output time
endTime=$(date +%s)
costTime=$(( endTime - startTime ))
echo "Time taken to execute hadoop is ${costTime} seconds."

# output reslut
read -p "show result in terminal(0) or file(1), please enter 0 or 1: " RESULT
if [ ${RESULT} -eq 0 ]; then
    hdfs dfs -cat "/output/out_${IN_FILE}/part-00000"
elif [ ${RESULT} -eq 1 ]; then
    hdfs dfs -get "/output/out_${IN_FILE}/part-00000" "./out_${IN_FILE}"
fi
