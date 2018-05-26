#include <stdio.h>
#include <stdlib.h>
#include<string.h>
#include<math.h>
int binaryNum[64];
int padding_msg[1024];
long A, B,C,D,E,F,G,H;
long k[64];
int p =100;
long H0[100]; //ne andaeye tedad 512 taii ha
long H1[100];
long H2[100];
long H3[100];
long H4[100];
long H5[100];
long H6[100];
long H7[100];

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
    int tmp = l*8 % 512;
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

void perm(int inp[], int res[]){
    int i;
    for(i=0; i<16; i++){
        res[31-i] = inp[i];
    }
    for(i=16; i<24; i++){
        res[i] = inp[i];
    }
    for(i=24; i<32; i++){
        res[31-i] = inp[i];
    }
}

void init(){
    A = 0x6a09e667;
    B = 0xbb67ae85;
    C = 0x3c6ef372;
    D = 0xa54ff53a;
    E = 0x510e527f;
    F = 0x9b05688c;
    G = 0x1f83d9ab;
    H = 0x5be0cd19;

    H0[0] = A;
    H1[0] = B;
    H2[0] = C;
    H3[0] = D;
    H4[0] = E;
    H5[0] = F;
    H6[0] = G;
    H7[0] = H;
}

long lxor(long a, long b){
    return ((~a) & b) | ((~b) & a);
}

long rotr(long value, int shift) {
    if ((shift &= sizeof(value)*8 - 1) == 0)
      return value;
    return (value >> shift) | (value << (sizeof(value)*8 - shift));
}

long ch(long x, long y, long z){
    long a = x & y;
    long b = ~y & z;
    long c = ~x & z;
    a = lxor(a, b);
    return lxor(a, c);
}

long maj(long x, long y, long z){
    long a = x & z;
    long b = x & y;
    long c = y & z;
    a = lxor(a, b);
    return lxor(a, c);
}

long SIGMA0(long x){
    long a = rotr(x, 2);
    long b = rotr(x, 13);
    long c = rotr(x, 22);
    long d = x>>7;
    a = lxor(a, b);
    a = lxor(a, c);
    return lxor(a, d);
}

long SIGMA1(long x){
    long a = rotr(x, 6);
    long b = rotr(x, 11);
    long c = rotr(x, 25);
    a = lxor(a, b);
    return lxor(a, c);
}

long SIGMA2(long x){
    long a = rotr(x, 2);
    long b = rotr(x, 3);
    long c = rotr(x, 15);
    long d = x>>5;
    a = lxor(a, b);
    a = lxor(a, c);
    return lxor(a, d);
}

void  hash(long w, long k){
    long t2 = H + SIGMA1(E) + ch(E, F, G) + k + w;
    long t1 = SIGMA0(A) + maj(A, B, C) + SIGMA2(C+D);
    H = G;
    F = E;
    D = C;
    B = A;
    G = F;
    E = D + t1;
    C = B;
    A = 3*t1 - t2;
}

void concat(int res[]){

}

void long_to_binary(long x, int res[32]){
    int i;
    for(i=0; i<32; i++){
        res[i] = x%2;
        x/=2;
    }
}

void compute(int i, int res[], int m, int n, int w[m][n]){
        int t, j;
        for(t=0; t<64; t++){
            //printf("%d", t);
            long wx = 0;
            for(j=0; j<32; j++){
                //printf("%d", j);
                //printf("$d,%d,%d",t, j,w[t][j]);
                wx += pow(2, j)*w[t][j];
            }
            //printf("%d", wx);
            hash(wx, k[t]);
        }
        H0[i] = A + H0[i-1];
        H1[i] = B + H1[i-1];
        H2[i] = C + H2[i-1];
        H3[i] = D + H3[i-1];
        H4[i] = E + H4[i-1];
        H5[i] = F + H5[i-1];
        H6[i] = G + H6[i-1];
        H7[i] = H + H7[i-1];
        for(i=0; i<8; i++){
            //printf("%d\n", 32*i);
            long_to_binary(H0[i], res+32*i);
        }
}

int main()
{
    int w[64][32];
    //padding("abc");
    int res[32];
    int block[512];
    int i,j;
    block[0]=1;
    block[200]=1;
    block[510]=1;
    //printf("%d\n", w[0][0]);
    //parsing
    expansion(block,64, 32, w);
    //permutation
    for(j=0; j<64; j++){

        perm(w[j], w[j]);
        for (i=0; i<32; i++){
            printf("%d",w[j][i]);
        }

        printf("\n");

    }
    //init
    init();
    //hash
    int hash_values[p][256];
    int t;
    for(i=1; i<p; i++){
        compute(i, hash_values[i],64, 32, w);

    }
    return 0;
}
