#!/bin/bash

function test() 
{
    g++ test.cpp -o test

    events=page-faults,cache-references,cache-misses,L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses
    #events=cache-misses,cache-references
    perf stat -e $events ./test 1
    perf stat -e $events ./test 2
    perf stat -e $events ./test 16
    perf stat -e $events ./test 32
}

function cacheline1() 
{

    g++ cacheline1.cpp -o cacheline1

    time ./cacheline1 1
    time ./cacheline1 2
    time ./cacheline1 16
}

function cachesize() 
{

    g++ cachesize.cpp -o cachesize

    for ((i=1024; i<=128*1024*1024; i*=2))
    do
        ./cachesize $i
    done

    for ((i=0;i<4;i++)) 
    do
       cachetype=$(cat /sys/devices/system/cpu/cpu0/cache/index${i}/type)
       cachesize=$(cat /sys/devices/system/cpu/cpu0/cache/index${i}/size)
       echo "cache: $cachetype $cachesize"
       #sudo dmidecode -t cache | grep Associativity
    done
}

cachesize
#for((i=1; i < 20; i++))
#do
#    perf stat -e cache-misses,cache-references ./test $i
#done
