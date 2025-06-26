# Parallel Computing: OpenMP & CUDA

Coursework for the Parallel Processing module. The programs here started as
practicals we worked through in the lab sessions, and were then extended with
extra hands-on exercises on my own.

## Contents

| Folder | Topic |
| ------ | ----- |
| `week1/` | Setup and first programs: C, OpenMP and CUDA "hello world", parallel loops, private variables, reduction-style sums |
| `week2/` | OpenMP in depth: work sharing (static/dynamic schedules, sections, tasks), loop dependencies (ordered, collapse, wavefront, load balancing), synchronization (critical, atomic, barrier, master, single), data sharing (shared, private, firstprivate, lastprivate, threadprivate), plus a practice task |
| `week3/` | Introduction to CUDA: kernels, thread/block indexing, and a naive parallel sum that demonstrates a race condition |

## Building

OpenMP (needs `gcc` with OpenMP support):

```sh
gcc -fopenmp file.c -o out/file && ./out/file
```

CUDA (needs the NVIDIA CUDA toolkit and a GPU):

```sh
nvcc file.cu -o out/file && ./out/file
```

Compiled binaries go in `out/` directories, which are git-ignored.
