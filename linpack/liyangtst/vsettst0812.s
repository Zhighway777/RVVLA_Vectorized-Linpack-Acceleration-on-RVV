#vsettst0812(int n, double *a, double* b):
.section .text
.globl vsettst0812
vsettst0812:
        blez    a0, .LBB0_8
        csrr    a3, vlenb
        srli    a4, a3, 2
        li      a5, 16
        bltu    a5, a4, .LBB0_3
        li      a4, 16
.LBB0_3:
        bltu    a0, a4, .LBB0_5
        slli    t0, a3, 1
        sub     a4, a1, a2
        bgeu    a4, t0, .LBB0_9
.LBB0_5:
        li      a6, 0
.LBB0_6:
        slli    a6, a6, 3
        add     a3, a1, a6
        add     a2, a2, a6
        slli    a0, a0, 3
        add     a1, a1, a0
.LBB0_7:
        fld     fa5, 0(a2)
        fsd     fa5, 0(a3)
        addi    a3, a3, 8
        addi    a2, a2, 8
        bne     a3, a1, .LBB0_7
.LBB0_8:
        ret
.LBB0_9:
        srli    a4, a3, 3
        slli    a5, a4, 1
        slli    a4, a4, 31
        sub     a4, a4, a5
        and     a6, a4, a0
        srli    a7, a3, 2
        mv      a3, a6
        mv      a4, a1
        mv      a5, a2
.LBB0_10:
        vl2re64.v       v8, (a5)
        vs2r.v  v8, (a4)
        add     a5, a5, t0
        sub     a3, a3, a7
        add     a4, a4, t0
        bnez    a3, .LBB0_10
        beq     a6, a0, .LBB0_8
        j       .LBB0_6
