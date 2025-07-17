#include <cstdio>
#include <cuda_runtime.h>

__global__ void hello_kernel() {
    printf("Hello from GPU thread (%d,%d) in block (%d,%d)\n", threadIdx.x, threadIdx.y, blockIdx.x, blockIdx.y);
}

int main() {
    int nDevices = 0; cudaGetDeviceCount(&nDevices);
    printf("CUDA devices: %d\n", nDevices);

    /**
     * SM : Streaming Multiprocessors (Contains CUDA Cores for Parallel Computing)    
     * CC : Compute Capability (Architecture of the GPU)
     */

    for (int d = 0; d < nDevices; ++d) {
        cudaDeviceProp p; cudaGetDeviceProperties(&p, d);
        printf("[%d] %s, SMs=%d, CC=%d.%d, GlobalMem=%.2f GB\n", d, p.name, p.multiProcessorCount, p.major, p.minor, p.totalGlobalMem/1e9);
    }

    /**
     * grid(2,1) : 2 blocks in X-dim, 1 block in Y-dim : Total No. of blocks = 2    
     * block(4,1) : each block has 4 threads in X-dim, 1 thread in Y-dim: Total No. of Threads per block = 4
     */
    
    dim3 grid(2,1), block(4,1);
    
    hello_kernel<<<grid, block>>>();
    
    // Forces the CPU to wait until all preceding GPU work is complete
    cudaDeviceSynchronize();
    return 0;
}