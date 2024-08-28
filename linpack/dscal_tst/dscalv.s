#dscalvtst(int, double*, double*, int):   
.section .text                       
.globl dscalvtst
dscalvtst:
        li              t0, 32                  
        blez            a0, .LBB0_12                    
        vsetvli         a6, t0, e64, ta, ma
        mulw            t0, t0, a0
        add             a4, a2, t0
        mulw            a5, a0, a3
        li              t1, 1
        vle64.v         v0, (a1)
        bne             t1, a2, .LBB0_7
.LBB0_6:                                                     
        vle64.v         v1, (a2)                
        vfmul.vv        v1, v0, v1                                                     
        vse64.v         v1, (a2)
        add             a2, a2, a5
        blt             a2, a4, .LBB0_6  
        j               .LBB0_12
.LBB0_7:               
        vl1re64.v       v1, (a2)                
        vfmul.vv        v1, v0, v1                                                     
        vs1r.v          v1, (a2)
        add             a2, a2, a0
        blt             a2, a4, .LBB0_7  
        j               .LBB0_12
.LBB0_12:
        ret