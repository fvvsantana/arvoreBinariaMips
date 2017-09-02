.data
	gArvore: .space 400
	.globl gArvore
	
	gMarcadores: .byte 0:100
	.globl gMarcadores
	
.text
	.globl main
	main:
		
		jal testInsere
		
		#exit
		li $v0, 10
		syscall
		
