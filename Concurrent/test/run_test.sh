#!/bin/bash

# rm /mnt/pmem/tlbtree.pool
# ./preload

wl_fname=$1


iter=10
i=1
time1=0
time2=0
time4=0
time8=0
time12=0
time16=0



while(($i<=$iter))
do
    echo $i
    # let time1+=$(./main -f $wl_fname -t 1)
    # let time2+=$(./main -f $wl_fname -t 2)
    # let time4+=$(./main -f $wl_fname -t 4)
    # let time8+=$(./main -f $wl_fname -t 8)
    # let time12+=$(./main -f $wl_fname -t 12)
    # let time16+=$(./main -f $wl_fname -t 16)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 1)
    echo $result
    time1=$(echo "$time1 + $result" | bc)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 2)
    echo $result
    time2=$(echo "$time2 + $result" | bc)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 4)
    echo $result
    time4=$(echo "$time4 + $result" | bc)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 8)
    echo $result
    time8=$(echo "$time8 + $result" | bc)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 12)
    echo $result
    time12=$(echo "$time12 + $result" | bc)
    sleep 1s
    rm /mnt/pmem/tlbtree.pool
    ./preload
    result=$(./main -f $wl_fname -t 16)
    echo $result
    time16=$(echo "$time16 + $result" | bc)
    let i++
done

# let time1/=$iter
# let time2/=$iter
# let time4/=$iter
# let time8/=$iter
# let time12/=$iter
# let time16/=$iter

time1=$(echo "scale=6;$time1 / $iter" | bc)
time2=$(echo "scale=6;$time2 / $iter" | bc)
time4=$(echo "scale=6;$time4 / $iter" | bc)
time8=$(echo "scale=6;$time8 / $iter" | bc)
time12=$(echo "scale=6;$time12 / $iter" | bc)
time16=$(echo "scale=6;$time16 / $iter" | bc)

echo -e "$time1">./result.txt
echo -e "$time2">>./result.txt
echo -e "$time4">>./result.txt
echo -e "$time8">>./result.txt
echo -e "$time12">>./result.txt
echo -e "$time16">>./result.txt



# ./main -f $wl_fname -t 1
# ./main -f $wl_fname -t 2
# ./main -f $wl_fname -t 4
# ./main -f $wl_fname -t 8
# ./main -f $wl_fname -t 12
# ./main -f $wl_fname -t 16

# #!/bin/bash
# time1=1.37
# result=$(./main -f workload1.txt -t 1)
# time1=$(echo "$time1 + $result" | bc )
# echo $time1
# echo $result