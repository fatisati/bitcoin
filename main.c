#include <stdio.h>
#include <stdlib.h>
#include<string.h>
int binaryNum[64];
int padding_msg[1024];

void decToBinary(int n)
{
    // array to store binary number


    // counter for binary array
    int i;
    for(i=0; i<64; i++){
        binaryNum[i] = 0;
    }

    i=0;
    while (n > 0) {

        // storing remainder in binary array
        binaryNum[i] = n % 2;
        n = n / 2;
        i++;
    }
    // printing binary array in reverse order
}

char* padding(char* msg){

    int l = strlen(msg);
    int tmp = l % 512;
    int k;
    if(tmp<448){
        k = 448 - tmp -1;
    }
    else{
        tmp = tmp - 448;
        k = tmp + 511;
    }
    int i, j=0;

    for(j= 0; j<l; j++){

        int n = msg[j];
        decToBinary(n);
        for (i=0; i<8; i++){
            int x = 7-i;

            padding_msg[j*8+i] = binaryNum[x];
        }
    }

    padding_msg[l*8] = 1;
    for(i=0; i<k; i++){
        padding_msg[l*8+i+1] = 0;
    }
    decToBinary(l);
    for(i=0; i<64; i++){
        int x = 63-i;
        padding_msg[k+l*8+i] = binaryNum[x];
    }
    for(i=0; i<8*l+k+64; i++){
        printf("%d", padding_msg[i]);
    }
}
int main()
{

    padding("abc");

    return 0;
}
