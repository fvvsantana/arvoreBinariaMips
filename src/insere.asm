.data
	newline: .asciiz "\n"
.text
	.globl insere
	insere:#(int n)
		li $t0, 0 #i=0
		li $t1, 0 #j=0
		while:#(gMarcadores[i] != 0)
			lb $t2, gMarcadores($t0) #$t2 = gMarcadores[i]
			beqz $t2, then
			
			if: #(n < gArvore[j])
				lw $t3, gArvore($t1) #$t3 = gArvore[j]
				bge $a0, $t3, else
				
				#aponta i para o marcador do filho esquerdo
				sll $t4, $t0, 1 #$t4 = i * 2
				add $t0, $t4, 1 #i = i*2 + 1
				j then2
			else:
				#aponta i para o marcador do filho direito				
				sll $t4, $t0, 1 #$t4 = i * 2
				add $t0, $t4, 2 #i = i*2 + 2
			then2:
			#aponta j para o filho referente a i
			sll $t1, $t0, 2 #j = i * 4
			
			j while
		then:
		#agora gMarcadores[i] == 0 e podemos inserir o elemento na arvore
		sw $a0, gArvore($t1) #gArvore[j] = n
		
		#como inserimos, marcamos o no como ocupado
		li $t5, 1
		sb $t5, gMarcadores($t0) #gMarcadores[i] = 1
		
		jr $ra
		
	.globl testInsere
	testInsere:
		#salva o endereço de retorno 
		sub $sp, $sp, 4
		sw $ra, 0($sp)
		
		#insere elementos
		li $a0, 5
		jal insere
			
		li $a0, 3
		jal insere
		
		li $a0, 7
		jal insere
		
		li $a0, 2
		jal insere
		
		li $a0, 4
		jal insere
		
		li $a0, 6
		jal insere
		
		li $a0, 8
		jal insere
		
		#imprimir arvore:
		li $t0, 0 #i = 0
		while2: #(i<60)
			bge $t0, 60, then3
			
			#print(gArvore[i])
			li $v0, 1
			lw $a0, gArvore($t0)
			syscall
			
			add $t0, $t0, 4 #$t0 += 4
			j while2
		then3:
		
		#imprime newline
		li $v0, 4
		la $a0, newline
		syscall
		
		#imprime marcadores:
		li $t0, 0 #i = 0
		while3: #(i<15)
			bge $t0, 15, then4
			
			#print(gArvore[i])
			li $v0, 1
			lb $a0, gMarcadores($t0)
			syscall
			
			add $t0, $t0, 1 # i++
			j while3
		then4:
		
		#retorma endereco de retorno
		lw $ra, 0($sp)
		add $sp, $sp, 4
		
		jr $ra
		
		
		
		
		