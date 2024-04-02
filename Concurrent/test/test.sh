#!/bin/bash

iter=20
begin_write=0

for wl_fname in workload1.txt workload2.txt workload3.txt
do
    for thread in 1 2 4 8 12 16
    do
        i=1
        time1=0
        while(($i<=$iter))
        do
            while :
            do
                rm /mnt/pmem/tlbtree.pool
                ./preload
                result=$(./main -f $wl_fname -t $thread)
                if [ $? -eq 0 ]
                then
                    echo $result
                    time1=$(echo "$time1 + $result" | bc)
                    break
                fi
            done
            let i++
        done
        time1=$(echo "scale=6;$time1 / $iter" | bc)
        if [ $begin_write -eq 0 ]
        then
            echo -e "$time1">./result.txt
            begin_write=1
        else
            echo -e "$time1">>./result.txt
        fi
    done
done

# for wl_fname in workload4.txt
# do
#     for thread in 1 2 4 8 12 16
#     do
#         rm /mnt/pmem/tlbtree.pool
#         ./preload
#         i=1
#         time1=0
#         while(($i<=$iter))
#         do
#             while :
#             do
#                 # rm /mnt/pmem/tlbtree.pool
#                 # ./preload
#                 result=$(./main -f $wl_fname -t $thread)
#                 if [ $? -eq 0 ]
#                 then
#                     echo $result
#                     time1=$(echo "$time1 + $result" | bc)
#                     break
#                 fi
#             done
#             let i++
#         done
#         time1=$(echo "scale=6;$time1 / $iter" | bc)
#         if [ $begin_write -eq 0 ]
#         then
#             echo -e "$time1">./result.txt
#             begin_write=1
#         else
#             echo -e "$time1">>./result.txt
#         fi
#     done
# done

