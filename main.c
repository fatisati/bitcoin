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
    /*for(i=0; i<8*l+k+64; i++){
        printf("%d", padding_msg[i]);
    }*/
}
void Rotate(int arr[], int d, int n, int ans[])
{
  int i;
  for (i = 0; i < d; i++)
    RotatebyOne(arr, n, ans);
}

void RotatebyOne(int arr[], int n, int ans[])
{
  int i, temp;
  temp = arr[n-1];
  for (i = 1; i < n; i++)
     ans[i] = arr[i-1];
  ans[0] = temp;
}
void shift(int arr[], int d, int n, int ans[]){
  int i;
  for (i = 0; i < d; i++)
    shiftbyOne(arr, n, ans);
}

void shiftbyOne(int arr[], int n,int ans[])
{
  int i;
  for (i = 1; i < n; i++)
     ans[i] = arr[i-1];
  ans[0] = 0;
}
void arr_xor(int arr1[], int arr2[], int res[],int n){
    int i = 0;
    for (i=0; i<n; i++){
        if (arr1[i] == arr2[i])
        res[i] = 0;
        else
        res[i] = 1;
    }
    }

void sigma0(int* w, int* res){
    int r1[32];
    int r2[32];
    int s0[32];
    int tmp[32];

    Rotate(w, 17, 32,r1);
    Rotate(w, 14,32,r2);
    shift(w, 12,32,s0);
    arr_xor(r1, r2, tmp, 32);
    arr_xor(tmp,s0,res,32);
}
void sigma1(int* w, int* res){
    int r1[32];
    int r2[32];
    int s0[32];
    int tmp[32];

    Rotate(w, 9, 32,r1);
    Rotate(w, 19,32,r2);
    shift(w, 9,32,s0);
    arr_xor(r1, r2, tmp, 32);
    arr_xor(tmp,s0,res,32);
}
void expansion(int block[],int m, int n, int w[m][n]){
    int i =0;
    int j=0;
    int k =0;
    //printf("%d\n", w[0][0]);
    for (i=0; i<16; i++){

        for (j=0; j<32; j++){
            w[i][j] = block[i*32+j];
        }
    }
    for (k = 16; k<64; k++){
        int s0[32];
        int s1[32];
        sigma1(w[k-1],s1);
        sigma0(w[k-12],s0);
        for (i = 0; i<32; i++){
            //printf("%d", s1[i]);
            w[k][i] = (s1[i]+ w[k-6][i]+ s0[i]+ w[k-16][i])%2;
        }
        //printf("\n");

    }
}

int main()
{

    //padding("abc");
    int w[64][32];
    int res[32];
    int block[512];
    int i,j;
    block[0]=1;
    block[200]=1;
    block[510]=1;
    //printf("%d\n", w[0][0]);
    expansion(block,64, 32, w);
    for(j=0; j<64; j++){
        for (i=0; i<32; i++){
            printf("%d",w[j][i]);
        }
        printf("\n");
    }
    return 0;
}
