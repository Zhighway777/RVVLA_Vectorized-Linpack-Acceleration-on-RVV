#!/bin/bash

SSRC="daxpy_modify"
CSRC="daxpy_mdy"

riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC}.o  ${SSRC}.s -v
riscv64-unknown-elf-gcc -c ${CSRC}.c -o ${CSRC}.o
riscv64-unknown-elf-gcc ${SSRC}.o ${CSRC}.o -o ${CSRC}   
spike --isa=RV64GCV --varch=vlen:4096,elen:64 ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk ${CSRC}
