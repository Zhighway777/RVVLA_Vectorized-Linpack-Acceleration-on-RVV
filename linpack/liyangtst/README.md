steps to run spike in this di:
1. compile the assemble files(.s) to link files(.o)i
riscv64-unknown-elf-as -march=rv64gcv --mabi=lp64d -o vsettst0812.o  vsettst0812.s -v

2. compile the CSRC files(.s) to link files(.o)
riscv64-unknown-elf-gcc -c vsettst0812.c -o vsettst0812_main.o  

3. link them and generate the ELF file
riscv64-unknown-elf-gcc vsettst0812_main.o vsettst0812.o -o vsettst0812_main

4. run ELF file on spike sim
spike --isa=RV64GCV ../../../../RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk vsettst0812_main > rst0812.txt
