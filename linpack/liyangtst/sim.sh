#!/bin/bash
#SSRC1="matgenv"
#CSRC="matgenvbench_ofmine"

SSRC1="matgenv"
SSRC2="dgefaV"
CSRC="Vlinpack0825"

#SSRC1="idamaxv_ofmine"
#CSRC="idamaxvbench_ofmine"


riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC1}.o  ${SSRC1}.s -v
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o ${SSRC2}.o  ${SSRC2}.s -v
riscv64-unknown-elf-gcc -c ${CSRC}.c -o ${CSRC}.o
riscv64-unknown-elf-gcc ${SSRC1}.o ${SSRC2}.o  ${CSRC}.o -o ${CSRC}   
spike --isa=RV64GCV --varch=vlen:4096,elen:64 ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk ${CSRC}
