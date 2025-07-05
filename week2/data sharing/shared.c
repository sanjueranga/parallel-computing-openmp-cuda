#include <omp.h>
#include <stdio.h>

// Variable is shared among all threads

int main() {
    int shared_counter = 0;
    
    #pragma omp parallel shared(shared_counter)
    {
        #pragma omp atomic
        shared_counter++;
        
        #pragma omp barrier
        if(omp_get_thread_num() == 0) {
            printf("Final counter value: %d\n", shared_counter);
        }
    }

    return 0;
}