.text
addi t0, x0, 25
addi t1, x0, 12
addi t2, x0, 37
addi t3, x0, 3
addi t4, x0, 10
sw t0, 0(x0)
sw t1, 4(x0)
sw t2, 8(x0)
sw t3, 12(x0)
sw t4, 16(x0)
addi t0, x0, 23
addi t1, x0, 1
addi t2, x0, 48
addi t3, x0, 15
addi t4, x0, 100
sw t0, 20(x0)
sw t1, 24(x0)
sw t2, 28(x0)
sw t3, 32(x0)
sw t4, 36(x0)

# burbuja
addi s2, x0, 10 	# limite N
addi s0, x0, 0		# i = 0

for_i:
addi, s1, x0, 0		# j = 0
blt s0, s2, for_j 	# i < n
jal x0, fin		# rompemos

for_j:
blt s1, s2, offset	# j < n
jal x0, incremento_i	

offset:
slli t0, s0, 2		# offset de i
slli t1, s1, 2		# offset de j
lw t2, 0(t0)		# a[i]
lw t3, 0(t1)		# a[j]
blt t3, t2, ordena
jal x0, incrementa_j

ordena:
sw t3, 0(t0)
sw t2, 0(t1)

incrementa_j: 
addi s1, s1, 1
jal x0, for_j

incremento_i:
addi s0, s0, 1
jal x0, for_i

fin:
