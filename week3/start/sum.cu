#include <cstdio>
#include <vector>
#include <cuda_runtime.h>

__global__ void sum_naive(const int* __restrict__ a, long long* sum, int N){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(i < N){
        // RACE: multiple threads write to *sum concurrently
        *sum += a[i];
    }
}

int main(){
    const int N = 1<<20; // bitwise left shift -> 2^20 = 1048576

    std::vector<int> h_a(N, 1); // dynamic resizable array of elements (no. of elements, value to initialize eacch element with)

    int *d_a; long long *d_sum; long long zero=0;
    
    // Memory allocation
    cudaMalloc(&d_a, N*sizeof(int));
    cudaMalloc(&d_sum, sizeof(long long));

    // Data transfer: src, dest, count, direction
    cudaMemcpy(d_a, h_a.data(), N*sizeof(int), cudaMemcpyHostToDevice); // copy data from CPU to GPU
    cudaMemcpy(d_sum, &zero, sizeof(long long), cudaMemcpyHostToDevice);

    // dim3 is a data structure that can hold 3 unsigned integers
    dim3 block(256); dim3 grid((N+block.x-1)/block.x);

    // gridDim = (N + blockDim − 1​) / blockDim
    // (1048576 + 256 − 1) / 256 = 1048831 / 256 = 4096.996 ~= 4096
    // 4096 * 256 = 1048576

    sum_naive<<<grid, block>>>(d_a, d_sum, N);
    cudaDeviceSynchronize();

    long long h_sum; cudaMemcpy(&h_sum, d_sum, sizeof(long long), cudaMemcpyDeviceToHost); // copy data from GPU to CPU
    printf("Naive GPU sum (RACE) = %lld (expect %d)\n", h_sum, N);
    cudaFree(d_a); cudaFree(d_sum);
    return 0;
}