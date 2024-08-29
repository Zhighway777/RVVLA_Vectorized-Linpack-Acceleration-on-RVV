.section .text
    .global matgen
    
.LCPI0_0:
        .quad   0x3f10000000000000
matgen:
#matgen(double*, int, int, double*, double*):
        blez    a2, .LBB0_18
        addi    sp, sp, -80
        sd      ra, 72(sp)
        sd      s0, 64(sp)
        sd      s1, 56(sp)
        sd      s2, 48(sp)
        sd      s3, 40(sp)
        sd      s4, 32(sp)
        sd      s5, 24(sp)
        sd      s6, 16(sp)
        sd      s7, 8(sp)
        mv      s2, a3
        mv      s5, a2
        mv      s3, a1
        mv      s7, a0
        li      a0, 0
        slli    s6, a1, 3
        slli    s4, a2, 3
        li      s0, 1325
.Lpcrel_hi0:
        auipc   a2, %pcrel_hi(.LCPI0_0)
        fld     fa5, %pcrel_lo(.Lpcrel_hi0)(a2)
        lui     a2, 1
        addi    a2, a2, -971
        lui     a3, 1048568
        mv      s1, s7
.LBB0_2:
        mul     a4, s6, a0
        add     a4, a4, s4
        add     a5, s7, a4
        mv      a4, s1
.LBB0_3:
        mul     a1, s0, a2
        slli    a1, a1, 48
        srli    s0, a1, 48
        add     a1, s0, a3
        fcvt.d.w        fa4, a1
        fmul.d  fa4, fa4, fa5
        fsd     fa4, 0(a4)
        addi    a4, a4, 8
        bne     a4, a5, .LBB0_3
        addi    a0, a0, 1
        add     s1, s1, s6
        bne     a0, s5, .LBB0_2
        blez    s5, .LBB0_17
        mv      a0, s2
        li      a1, 0
        mv      a2, s4
        call    memset
        slli    a2, s5, 3
        add     a2, a2, s2
        addi    a0, s5, -1
        mul     a0, a0, s3
        add     a0, a0, s5
        slli    a5, a0, 3
        csrr    s1, vlenb
        srli    a0, s1, 2
        li      a1, 128
        add     a5, a5, s7
        mv      a3, a0
        bltu    a1, a0, .LBB0_8
        li      a3, 128
.LBB0_8:
        li      a1, 0
        sltu    a4, s2, a5
        sltu    a2, s7, a2
        and     a2, a2, a4
        slti    a4, s3, 0
        sltu    a3, s5, a3
        or      a3, a3, a4
        slli    a4, s1, 1
        add     s4, s4, s2
        or      a3, a3, a2
        srli    s1, s1, 3
        slli    a2, s1, 1
        slli    s1, s1, 31
        sub     s1, s1, a2
        and     s1, s1, s5
        j       .LBB0_10
.LBB0_9:
        addi    a1, a1, 1
        add     s7, s7, s6
        beq     a1, s5, .LBB0_17
.LBB0_10:
        beqz    a3, .LBB0_12
        li      a2, 0
        j       .LBB0_15
.LBB0_12:
        vsetvli a2, zero, e64, m2, ta, ma
        mv      a5, s1
        mv      s0, s7
        mv      a2, s2
.LBB0_13:
        vl2re64.v       v8, (a2)
        vl2re64.v       v10, (s0)
        vfadd.vv        v8, v8, v10
        vs2r.v  v8, (a2)
        add     a2, a2, a4
        sub     a5, a5, a0
        add     s0, s0, a4
        bnez    a5, .LBB0_13
        mv      a2, s1
        beq     s1, s5, .LBB0_9
.LBB0_15:
        slli    a5, a2, 3
        add     a2, s7, a5
        add     a5, a5, s2
.LBB0_16:
        fld     fa5, 0(a5)
        fld     fa4, 0(a2)
        fadd.d  fa5, fa5, fa4
        fsd     fa5, 0(a5)
        addi    a5, a5, 8
        addi    a2, a2, 8
        bne     a5, s4, .LBB0_16
        j       .LBB0_9
.LBB0_17:
        ld      ra, 72(sp)
        ld      s0, 64(sp)
        ld      s1, 56(sp)
        ld      s2, 48(sp)
        ld      s3, 40(sp)
        ld      s4, 32(sp)
        ld      s5, 24(sp)
        ld      s6, 16(sp)
        ld      s7, 8(sp)
        addi    sp, sp, 80
.LBB0_18:
        ret
