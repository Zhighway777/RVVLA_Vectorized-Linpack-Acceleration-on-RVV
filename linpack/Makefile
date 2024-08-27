# 定义编译器和汇编器
AS = riscv64-unknown-elf-as
CC = riscv64-unknown-elf-gcc
SPIKE = spike
PK = ~/work/RISCV-V/riscv-gnu-toolchain/opt-riscv-rv64/newlib/riscv64-unknown-elf/bin/pk

# 定义编译选项
ASFLAGS = -march=rv64gcv --mabi=lp64d
CFLAGS = -g -c

# 定义目标文件
TARGET = main
OBJECTS = main.o daxpy/daxpy_modify.o ddot/ddot_modify.o # dgesl/dgesl.o

# 默认目标
all: $(TARGET)

# 生成目标文件
daxpy/daxpy_modify.o: daxpy/daxpy_modify.s
	$(AS) $(ASFLAGS) -o daxpy/daxpy_modify.o daxpy/daxpy_modify.s

ddot/ddot_modify.o: ddot/ddot_modify.s
	$(AS) $(ASFLAGS) -o ddot/ddot_modify.o ddot/ddot_modify.s

#dgesl/dgesl.o: dgesl/dgesl.s
#	$(CC) $(CFLAGS) dgesl/dgesl.c -o dgesl/dgesl.o 

main.o: main.c
	$(CC) $(CFLAGS) main.c -o main.o

# 链接生成可执行文件
$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET)

# 运行模拟器
sim: $(TARGET)
	$(SPIKE) --isa=RV64GCV $(PK) ./$(TARGET)

# 清理生成文件
clean:
	rm -f $(OBJECTS) $(TARGET)

.PHONY: all clean sim
