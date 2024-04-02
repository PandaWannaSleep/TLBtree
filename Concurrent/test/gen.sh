#!/bin/bash

scale=$1
if [ $# -lt 1 ]; then
    scale=1
fi

# Random RO
./datagen -o $scale -r 1 -i 0
mv workload.txt workload1.txt

# Random RH
./datagen -o $scale -r 0.95 -i 0.05
mv workload.txt workload2.txt

# Random WH
./datagen -o $scale -r 0.5 -i 0.5
mv workload.txt workload3.txt

# Random WO
./datagen -o $scale -r 0 -i 1
mv workload.txt workload4.txt

