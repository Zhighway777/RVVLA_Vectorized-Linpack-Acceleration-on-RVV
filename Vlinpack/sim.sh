#!/bin/bash

SSRC1="matgenv"
SSRC2="dgefaV"
SSRC3="dgesl_modify"

CSRC1="Vlinpack"
CSRC2="print_Vlinpack"

riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC1}.o  ${SSRC1}.s -v
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC2}.o  ${SSRC2}.s -v
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC3}.o  ${SSRC3}.s -v

riscv64-unknown-elf-gcc -c ${CSRC1}.c -o ${CSRC1}.o
riscv64-unknown-elf-gcc -c ${CSRC2}.c -o ${CSRC2}.o

riscv64-unknown-elf-gcc ${SSRC1}.o ${SSRC2}.o ${SSRC3}.o ${CSRC1}.o ${CSRC2}.o -o ${CSRC1}   
spike --isa=RV64GCV --varch=vlen:4096,elen:64 ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk ${CSRC1} > Vlinpack.txt 
