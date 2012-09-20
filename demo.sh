#!/bin/bash

INPUT_DATA=./inputData/input*.txt
TIMESTAMP=`date -u +\%Y\%m\%dT\%H\%M\%SZ`
OUTPUT_FOLDER=output_$TIMESTAMP

BASE_COMMAND="hadoop jar $HADOOP_HOME/libexec/contrib/streaming/hadoop-streaming-1.0.3.jar -D stream.num.map.output.key.fields=2 -D mapred.text.key.comparator.options=-k1,2 -D mapred.text.key.partitioner.options=-k1,2 -D mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator -mapper ./mapper.py -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner -reducer ./reducer.py -input $INPUT_DATA"

`$BASE_COMMAND -output $OUTPUT_FOLDER/no_combiner/`
`$BASE_COMMAND -combiner ./combiner.py -output $OUTPUT_FOLDER/with_combiner/`

echo "Are there duplicates in the job output when used without combiner?"
cat $OUTPUT_FOLDER/no_combiner/part-* | cut -f1,2 | sort | uniq -c | grep -v "\b1\b" | head -10

echo "Are there duplicates in the job output when used with a combiner?"
cat $OUTPUT_FOLDER/with_combiner/part-* | cut -f1,2 | sort | uniq -c | grep -v "\b1\b" | head -10