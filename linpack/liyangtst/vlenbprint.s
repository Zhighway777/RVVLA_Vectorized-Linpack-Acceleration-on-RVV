.section .text
.globl vlenbprint
vlenbprint:
    csrr    t0, vlenb
    sw      a0, 0(t0)