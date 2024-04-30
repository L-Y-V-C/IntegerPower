.text
.globl __start

__start:
addi $t0,$zero,11
addi $t1,$zero,22
addi $t2,$zero,33
addi $t3,$zero,44
pot:
la $a0,txtBase
li $v0,4
syscall
li $v0,5
syscall

#initiate stack
sw $fp,-4($sp)
addi $fp,$sp,0
addi $sp,$sp,-24
#sw $ra,-8($fp)

#1st element stack
sw $t0,-12($fp)

addi $t0,$v0,0
la $a0,txtExponent
li $v0,4
syscall
li $v0,5
syscall

#2nd element stack
sw $t1,-16($fp)

addi $t1,$v0,0
bltz $t0,error
bltz $t1,error
beq $t1,$zero,res1
bne $t1,$zero,continue

res1:
addi $t3,$zero,1
j end

continue:
#3rd element stack
sw $t2,-20($fp)

addi $t2,$zero,1

#4rd element stack
sw $t3,-24($fp)

addi $t3,$t0,0

loop:
blt $t3,$zero,excess
beq $t1,$t2,end
mul $t3,$t3,$t0
add $t2,$t2,1

j loop

j end

error:
la $a0,txtError
li $v0,4
syscall
li $v0,10
syscall

excess:
la $a0,txtExcess
li $v0,4
syscall
li $v0,10
syscall

end:

la $a0,txtResult
li $v0,4
syscall
addi $a0,$t3,0
li $v0,1
syscall

#return values from stack
lw $t3,-24($fp)
lw $t2,-20($fp)
lw $t1,-16($fp)
lw $t0,-12($fp)
lw $ra,-8($fp)
addi $sp,$fp,0
lw $fp,-4($sp)
#jr $ra

li $v0,10
syscall



.data
txtResult: .asciiz "Resultado: "
txtBase: .asciiz "Ingresar base: "
txtExponent: .asciiz "Ingresar exponente: "
txtError: .asciiz "Valores negativos ingresados"
txtExcess: .asciiz "Valor excesivo"
endl:    .asciiz "\n"
