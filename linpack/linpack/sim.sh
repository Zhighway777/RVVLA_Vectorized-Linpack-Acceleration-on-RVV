#!/bin/bash

SSRC1="matgen"
SSRC2="dgefa"
SSRC3="dgesl"

CSRC1="main"


riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC1}.o  ${SSRC1}.s -v
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC2}.o  ${SSRC2}.s -v
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC3}.o  ${SSRC3}.s -v

riscv64-unknown-elf-gcc -c ${CSRC1}.c -o ${CSRC1}.o


riscv64-unknown-elf-gcc ${SSRC1}.o ${SSRC2}.o ${SSRC3}.o ${CSRC1}.o  -o ${CSRC1}   
spike --isa=RV64GCV --varch=vlen:4096,elen:64 ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk ${CSRC1}
