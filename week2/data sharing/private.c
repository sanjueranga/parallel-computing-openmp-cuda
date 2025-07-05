#include <omp.h>
#include <stdio.h>

// Variables are private to each thread

int main() {
    int i = 100;
    
    #pragma omp parallel private(i)
    {
        i = omp_get_thread_num(); // Each thread gets its own copy
        printf("Thread %d has i = %d\n", omp_get_thread_num(), i);
    }
    
    printf("After parallel region, i = %d\n", i); // Original value preserved
    return 0;
}