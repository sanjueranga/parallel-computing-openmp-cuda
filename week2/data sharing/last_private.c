#include <omp.h>
#include <stdio.h>

// Final value is copied back to original variable

int main() {
    int i, x;
    
    #pragma omp parallel for lastprivate(x)
    for(i = 0; i < 5; i++) {
        x = i * 2;
        printf("Thread %d sets x to %d\n", omp_get_thread_num(), x);
    }
    
    printf("Final value of x = %d\n", x); // Will be 8 (last iteration)
    return 0;
}