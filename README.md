# Vectorized-Linpack-Acceleration-on-RISC-V-Vector Extension
Our aim is to leverage RISC-V Vector Extension (RVV) to vectorize the Linpack Benchmark, achieving optimal performance on RISC-V SIMD architecture. By exploiting the vector processing capabilities of RVV, we aim to enhance computational efficiency and accelerate floating-point operations within high-performance computing environments.
For Linpack Benchmark, compared to the one that uses clang for auto-vectorization, our optimization has almost **30X** the performance improvement, and **3756X** compared orginal Benchmark.

## Introduction
We optimized the C source code of Linpack by applying post-compilation optimizations and rewriting key functions (dgesl, matgen, dgefa, etc.) using multithreading to handle multiple independent data streams simultaneously. The optimized Linpack benchmark, found in the Vlinpack folder as Vlinpack.c, calls dgefaV.s, matgenv.s, and dgesl_modify.s. The expected output after running the Vlinpack program is for vector b to contain all ones. Currently, automatic result verification is not supported, so manual checking of the output is required.


## Environment
RVVLA (RISC-V Vector Linpack Acceleration) is utilized to evaluate the performance on the RISC-V ISA architecture. In this project, we set VLEN=4096 and ELEN=64. You can modify VLEN to match your hardware specifications. We have tested RVVLA on the Spike simulator. To specify VLEN in Spike, you should add the parameter `--varch=vlen:4096,elen:64`. The RVV-optimized Linpack benchmark is located in the linpack/Vlinpack directory, while the original version is in the linpack/linpack directory.

## Test Results
Platform: Linux 22.04, AMD Ryzen 5 3550H with Radeon Vega Mobile Gfx

We performed post-compilation optimizations on Linpack with the hardware parameters set to VLEN=4096, ELEN=64, and PARALLEL=64. The output results were correct and matched those of the original test set, with a recorded execution time of 0.006227 seconds.

For comparison, we simulated the original Linpack which is auto-vectorized by LLVM Clang copiler, and using Spike with the hardware parameters VLEN=4096, ELEN=64, and Ntimes=64. The recorded execution time for this test was 0.178682 seconds.

Also, we simulated the original Linpack using Spike with the same hardware parameters, and Ntimes=64. The recorded execution time for this test was 23.44576 seconds.


These results demonstrate that with VLEN set to 4096, the performance of Vlinpack improved by **28.7X** compared to the llvm clang compiler auto vector Linpack. And improved by **3765.6X** compared to the orginal Linpack. Currently, the maximum VLEN supported by Spike is 4096, which limits further acceleration.

## Performance Table and Analysis

### Optimized Performance Table

| Optimization Level        | Simulator Parameters            | Execution Time (s) | Speedup | Data Size                                  |
|---------------------------|---------------------------------|--------------------|---------|---------------------------------------------|
| Non-Vectorized Extension  | VLEN = 4096 bit, ELEN = 64 bit  | 23.446             | 1X      | Matrix dimension N = 100, iteration count = 64 |
| LLVM Clang Auto-Vectorization | -                          | 0.179              | 131X    | Same as above                              |
| Post-Compilation Optimization | -                          | 0.006              | 3907X   | Same as above                              |

### Optimized Performance Analysis

In this performance analysis, we provide detailed calculations of the Linpack Benchmark's performance:

1. **Floating Point Operations (FLOPs) Calculation**:  
   For a single `matgen-dgefa-dgesl` matrix operation in the Linpack Benchmark, the total number of floating-point operations (FLOPs) is calculated as:

   $OPS = (2/3) * N^3 + 2 * N^2$

   Where N is the matrix dimension. In our trials, with N = 100 and 64 iterations, the total computational workload is:

   $OPS_{total} = 4 * ((2/3) * (100^3) + 2 * (100^2)) = 43.9 MFLOPs$

2. **Performance Calculation (GFLOPS)**:  
   With our post-compilation optimization version, the execution time on the Spike simulator is recorded as 0.006 seconds. The performance, measured in gigaflops per second (GFLOPS), is calculated as:

   $Performance = (43.9 * 10^6 FLOPs) / (0.006 s) ≈ 7.32 GFLOPS$

### Interpretation of Performance Analysis

- **Non-Vectorized Extension**: In the scalar mode without vectorization, the execution time using the RISC-V processor with RVV configuration was 23.446 seconds, serving as the baseline performance (1X).

- **LLVM Clang Auto-Vectorization**: By utilizing LLVM Clang's auto-vectorization feature without additional manual optimizations, the execution time improved to 0.179 seconds, resulting in a speedup of 131 times.

- **Post-Compilation Optimization**: Through further post-compilation optimizations—such as function rewriting, multithreading, and parallelization of data streams—the execution time was reduced to 0.006 seconds, achieving a performance improvement of 3907 times, equivalent to 7.32 GFLOPS.

## Furture Work
In future updates, we plan to include vectorized versions of neural network (NN) and transformer benchmarks. Additionally, we aim to perform comprehensive simulations at the RTL level using hardware emulators to obtain more detailed performance metric
