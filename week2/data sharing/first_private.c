#include <omp.h>
#include <stdio.h>

// Initializes private copies with original value

int main() {
    int x = 5;
    
    #pragma omp parallel firstprivate(x)
    {
        printf("Thread %d starts with x = %d\n", omp_get_thread_num(), x);
        x += omp_get_thread_num();
        printf("Thread %d ends with x = %d\n", omp_get_thread_num(), x);
    }
    
    printf("Original x = %d\n", x); // Still 5
    return 0;
}