#!/bin/bash

CSRC1="Cdgefa3dlite"

riscv64-unknown-elf-gcc -c ${CSRC1}.c -o ${CSRC1}.o

riscv64-unknown-elf-gcc ${CSRC1}.o  -o ${CSRC1}   

spike --isa=RV64GCV --varch=vlen:4096,elen:64 ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk ${CSRC1} > original_rst.txt
