#include<stdio.h>
#include<string.h>
#include<sys/time.h>
#include<stdlib.h>

long getCurrentTime() {
    timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_usec + 1000000*tv.tv_sec;
}

// http://coolshell.cn/articles/10249.html, 示例3, l1,l2,l3 缓存大小 
int test(int size) {
    //const long size = 64l*1024l*1024l;
    int8_t *arr = new int8_t[size];
    
    long t1 = getCurrentTime();

    // Arbitrary number of steps
    int lengthMod = size - 1;
    for (int i = 0; i < size; i++)
    {
        arr[(i << 6) & lengthMod]++; // (x & lengthMod) is equal to (x % arr.Length)
    }

    long t2 = getCurrentTime();
    printf("size=%dk, timeuse=%ld\n", size/1024, t2 - t1);
    return 0;
}

int main(int argc, char **args)
{
    int size = 1;
    if (argc >= 2) {
        size = atoi(args[1]);
    }
    test(size);
}
