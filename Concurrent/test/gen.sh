#!/bin/bash

scale=1
# datasettype = $2
# Random RO
./datagen -o $scale -r 1 -i 0 -g $1
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

