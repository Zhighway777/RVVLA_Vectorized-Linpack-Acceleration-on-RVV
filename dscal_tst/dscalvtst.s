#dscalvtst(int, double*, double*, int):   
.section .text                       
.globl dscalvtst
dscalvtst:                         
        vsetvli         t0, zero, e64, m1, ta, ma
        slli            a7, a0, 3
        add             a4, a2, a7
        slli            a5, t0, 3     
        vl4re64.v       v8, (a1)
.LBB0_6:                                                     
        vl4re64.v       v4, (a2)               
        vfmul.vv        v4, v8, v4                                                    
        vs4r.v          v4, (a2)
        add             a2, a2, a5
        blt             a2, a4, .LBB0_6  
.LBB0_12:
        ret