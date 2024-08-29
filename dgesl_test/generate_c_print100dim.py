# Python script to generate C code for pointers and printf statements
def generate_c_print100dim():
    base_address = 0x27c4020
    increment = 8  # Each double is 8 bytes
    groups = 100  # p0, p1, p2, ...p99
    group_size = 64  # 64 pointers per group

    c_code = "#include <stdio.h>\n\nvoid print_100dimtst() {\n"

    # Generate address and pointer declarations
    for group in range(groups):
        for i in range(group_size):
            address = base_address + (group * group_size + i) * increment
            c_code += f"    unsigned long addressb{group}_{i} = 0x{address:x};\n"

    c_code += "\n"

    # Generate pointer initializations
    for group in range(groups):
        for i in range(group_size):
            c_code += f"    double *p{group}_{i} = (double *)addressb{group}_{i};\n"

    c_code += "\n"

    # Generate printf statements
    for group in range(groups):
        for i in range(group_size):
            index = group * group_size + i
            c_code += f"    printf(\"b[{index}]\tDEC value:%.4f\\t \\n\", *(p{group}_{i}));\n"

    c_code += "\n    ;\n}\n"

    return c_code

# Call the function and print the generated C code
generated_code = generate_c_print100dim()
print(generated_code)
