# Vectorized-Linpack-Acceleration-on-RISC-V-Vector Extension
Our aim is to leverage RISC-V Vector Extension (RVV) to vectorize the Linpack Benchmark, achieving optimal performance on RISC-V SIMD architecture. By exploiting the vector processing capabilities of RVV, we aim to enhance computational efficiency and accelerate floating-point operations within high-performance computing environments.

## Introduction
We optimized the C source code of Linpack by applying post-compilation optimizations and rewriting key functions (dgesl, matgen, dgefa, etc.) using multithreading to handle multiple independent data streams simultaneously. The optimized Linpack benchmark, found in the Vlinpack folder as Vlinpack.c, calls dgefaV.s, matgenv.s, and dgesl_modify.s. The expected output after running the Vlinpack program is for vector b to contain all ones. Currently, automatic result verification is not supported, so manual checking of the output is required.


## Environment
RVVLA (RISC-V Vector Linpack Acceleration) is utilized to evaluate the performance on the RISC-V ISA architecture. In this project, we set VLEN=4096 and ELEN=64. You can modify VLEN to match your hardware specifications. We have tested RVVLA on the Spike simulator. To specify VLEN in Spike, you should add the parameter --varch=vlen:4096,elen:64. The RVV-optimized Linpack benchmark is located in the linpack/Vlinpack directory, while the original version is in the linpack/linpack directory.

## Test Results
We tested the program on the Spike simulator with the parameters --isa=RV64GCV --varch=vlen:4096,elen:64. The results show that with VLEN set to 4096, the performance of Vlinpack improved by 28.7 times compared to the original Linpack. Currently, the maximum VLEN supported by Spike is 4096, which limits further acceleration.
## Furture Work
In future updates, we plan to include vectorized versions of neural network (NN) and transformer benchmarks. Additionally, we aim to perform comprehensive simulations at the RTL level using hardware emulators to obtain more detailed performance metrics.
