#ddot(int, double*, int, double*, int):                         # @ddot(int, double*, int, double*, int)

.section .text
    .global ddot_modify

ddot_modify:
        blez    a0, .LBB1_5
        li      a5, 1
        bne     a2, a5, .LBB1_6
        bne     a4, a5, .LBB1_6
        csrr    t0, vlenb
        srli    a7, t0, 2
        bgeu    a0, a7, .LBB1_19
        li      a6, 0
        fmv.d.x fa0, zero
        j       .LBB1_22
.LBB1_5:
        fmv.d.x fa0, zero
        ret
.LBB1_6:
        subw    a5, a5, a0
        mulw    a6, a5, a4
        srai    t0, a4, 31
        mulw    a7, a5, a2
        csrr    t2, vlenb
        srli    a5, t2, 2
        li      t1, 32
        srai    t3, a2, 31
        bltu    t1, a5, .LBB1_8
        li      a5, 32
.LBB1_8:
        and     t1, t0, a6
        and     t3, t3, a7
        fmv.d.x fa0, zero
        bgeu    a0, a5, .LBB1_14
        li      t0, 0
.LBB1_10:
        mv      a6, t3
        mv      a7, t1
.LBB1_11:#########modified###########
        slli    a6, a6, 3	#
        add     a1, a1, a6	#
        slli    a2, a2, 8	#  3-->8 2^(3)=8-->2^(8)=256
        slli    a7, a7, 3	#  
        add     a3, a3, a7	#
        slli    a4, a4, 3	#  3-->5 2^(3)=8-->2^(8)=256
        subw    a0, a0, t0	#
.LBB0_12:#########modified###########
    vle64.v   v5, (a1)        # 载入向量寄存器v5
    vle64.v   v4, (a3)        # 载入向量寄存器v4
    vfmacc.vf v5, fa0, v4     # fa0 = v4 * v5 + fa0
    add     a1, a1, a2      # 更新a3地址
    addiw   a0, a0, -1      # 递减a0
    add     a3, a3, a4      # 更新a1地址
    bnez    a0, .LBB0_12    # 如果a0不为零，则跳转回循环开始
        
        
.LBB1_13:
        ret
.LBB1_14:
        li      a5, 1
        li      t0, 0
        bne     a2, a5, .LBB1_10
        bne     a4, a5, .LBB1_10
        srli    t4, t2, 3
        slli    a6, t4, 1
        slli    a5, t4, 31
        sub     a5, a5, a6
        and     t0, a5, a0
        mul     a6, t0, a2
        add     a6, a6, t3
        mul     a7, t0, a4
        add     a7, a7, t1
        srli    t2, t2, 2
        slli    t3, t3, 3
        add     t3, t3, a1
        slli    t1, t1, 3
        add     t5, a3, t1
        mul     t1, a2, t4
        slli    t1, t1, 4
        mul     t4, a4, t4
        vsetvli a5, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        slli    t4, t4, 4
        mv      t6, t0
.LBB1_17:                               # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (t3)
        vl2re64.v       v12, (t5)
        vsetvli a5, zero, e64, m2, ta, ma
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        sub     t6, t6, t2
        add     t3, t3, t1
        add     t5, t5, t4
        bnez    t6, .LBB1_17
        vfmv.f.s        fa0, v8
        bne     t0, a0, .LBB1_11
        j       .LBB1_13
.LBB1_19:
        srli    a2, t0, 3
        slli    a4, a2, 1
        slli    a2, a2, 31
        sub     a2, a2, a4
        and     a6, a2, a0
        vsetvli a2, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        slli    t0, t0, 1
        mv      t1, a6
        mv      a5, a3
        mv      a4, a1
.LBB1_20:                               # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (a4)
        vl2re64.v       v12, (a5)
        vsetvli a2, zero, e64, m2, ta, ma
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        add     a4, a4, t0
        sub     t1, t1, a7
        add     a5, a5, t0
        bnez    t1, .LBB1_20
        vfmv.f.s        fa0, v8
        beq     a6, a0, .LBB1_13
.LBB1_22:
        slli    a6, a6, 3
        add     a2, a3, a6
        add     a1, a1, a6
        slli    a0, a0, 3
        add     a3, a3, a0
.LBB1_23:   #########modified###########    # =>This Inner Loop Header: Depth=1
    vle64.v   v5, (a1)        # 载入向量寄存器v5
    vle64.v   v4, (a2)        # 载入向量寄存器v4
    vfmacc.vf v5, fa0, v4   # fa0 = v4 * v5 + fa0
    add     a1, a1, 256      # 更新a3地址
    add     a3, a3,256      # 更新a1地址
    vfmv.f.s fa0, v5          # 确保将计算结果存储在 fa0
    ret                       # 返回

