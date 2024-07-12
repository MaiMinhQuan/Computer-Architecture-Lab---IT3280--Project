#+++++++++++Assembly Language and Computer Architecture Lab+++++++++++
# 			Vu Minh Quan - 20225910    		    #
# Student of ICT, SOICT, Hanoi University of Science and Technology  #
#  		     Task 3: Postscript CNC Marsbot     	           #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.eqv HEADING 0xffff8010 # Integer: An angle between 0 and 359
.eqv MOVING 0xffff8050 # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 # Boolean (0 or non-0): whether or not to leave a track
.eqv WHEREX 0xffff8030 # Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040 # Integer: Current y-location of MarsBot
#Key Matrix
.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014

.data 
# postscript when 0 is pressed: DCE (46 cuts)
postscript0: .word 90,1500,0, 180,1500,0, 180,2900,1, 80,250,1 ,70,250,1 ,60,250,1 ,50,250,1, 40,250,1, 30,250,1, 20,250,1, 10,250,1 ,0,250,1, 350,250,1 ,340,250,1 ,330,250,1 ,320,250,1 ,310,250,1 ,300,250,1 ,290,250,1 ,280,250,1, #letter D 
90,3500,0, 270,250,1 ,260,250,1 ,250,250,1 ,240,250,1 ,230,250,1 ,220,250,1 ,210,250,1 ,200,250,1 ,190,250,1 ,180,250,1 ,170,250,1 ,160,250,1 ,150,250,1 ,140,250,1 ,130,250,1 ,120,250,1 ,110,250,1 ,100,250,1 ,90,250,1, #letter C 
90,2500,0, 270,1500,1, 0,2900,1, 90,1500,1, 180,1450,0, 270,1500,1, 27,3310,0 #letter E
end0: .word 
# Big font size 90,0,3000,180,0,3000,180,1,5800,80,1,500,70,1,500,60,1,500,50,1,500,40,1,500,30,1,500,20,1,500,10,1,500,0,1,500,350,1,500,340,1,500,330,1,500,320,1,500,310,1,500,300,1,500,290,1,500,280,1,500,90,0,7000,270,1,500,260,1,500,250,1,500,240,1,500,230,1,500,220,1,500,210,1,500,200,1,500,190,1,500,180,1,500,170,1,500,160,1,500,150,1,500,140,1,500,130,1,500,120,1,500,110,1,500,100,1,500,90,1,500,90,0,5000,270,1,3000,0,1,5800,90,1,3000,180,0,2900,270,1,3000,27,0,6620

# postscript when 4 is pressed: SoICT (66 cuts)
postscript4: .word 90,3000,0, 180,2100,0, 340,250,1, 320,250,1, 300,250,1, 280,250,1, 260,250,1, 240,250,1, 220,250,1, 200,250,1, 180,250,1, 175,125,1, 170,125,1,150,250,1,130,250,1,110,250,1,90,250,1, 100,125,1, 110,150,1,130,250,1,150,250,1,170,250,1,190,250,1,210,250,1,230,250,1,250,250,1,270,250,1,290,250,1,310,250,1,330,250,1,350,250,1, #letter S
0,700,0, 90,3000,0, 270,250,1, 250,250,1, 230,250,1, 210,250,1, 190,250,1, 170,250,1, 150,250,1, 130,250,1, 110,250,1, 90,250,1, 70,250,1, 50,250,1, 30,250,1, 10,250,1, 350,250,1, 330,250,1, 310,250,1, 290,250,1, 270,250,1, #letter o 
40,2000,0, 90,1000,1, 270,500,0, 180,3000,1, 270,500,0, 90,1000,1, #letter I
90,2000,0, 270,250,1, 280,250,1, 290,250,1, 300,250,1, 310,250,1, 320,250,1, 330,250,1, 340,250,1, 350,250,1, 360,250,1, 10,250,1, 20,250,1, 30,250,1, 40,250,1, 50,250,1, 60,250,1, 70,250,1, 80,250,1, 90,250,1, #letter C
90,700,0, 90,2000,1 270,1000,0, 180,3000,1, #letter T 
45,6500,0 #return start position
end4: .word 
# postscript when 8 is pressed: Heart Shape (75 cuts)
postscript8: .word  
90,4000,0, 180,2100,0, 10,250,1, 20,250,1, 30,250,1, 40,250,1, 50,250,1, 60,250,1, 70,250,1, 80,250,1, 90,250,1, # u?n gi?a 
95,60,1, 100,60,1, 105,60,1, 110,60,1, 115,60,1, 120,60,1, 125,60,1, 130,60,1, 135,60,1, 140,60,1, 145,60,1, 150,60,1, 155,60,1, 160,60,1, 165,60,1, 170,60,1, 175,60,1, 180,60,1, # vòng cung trên
185,250,1, 190,250,1, 195,250,1, 200,250,1, 205,250,1, 210,250,1, 215,250,1, 220,250,1, 225,1950,1, # canh day
315,1950,1, 320,250,1, 325,250,1, 330,250,1, 335,250,1, 340,250,1, 345,250,1, 350,250,1, 355,250,1, # canh dáy
360,60,1 ,5,60,1, 10,60,1, 15,60,1, 20,60,1, 25,60,1, 30,60,1, 35,60,1, 40,60,1, 45,60,1, 50,60,1, 55,60,1, 60,60,1, 65,60,1, 70,60,1, 75,60,1, 80,60,1, 85,60,1, 90,60,1, # vòng cung trên
100,250,1, 110,250,1, 120,250,1, 130,250,1, 140,250,1, 150,250,1, 160,250,1, 170,250,1, 180,100,1, # u?n gi?a
55,3500,0 # return start position
end8: .word  

error:	.asciiz "Select nubmer 0,4,8 to print."
notification: .asciiz "You want to continue?"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
#---------------------------------------------------------
# Enable interrupts you expect
#---------------------------------------------------------
# Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x80 # bit 7 = 1 to enable
	sb $t3, 0($t1)
#---------------------------------------------------------
# No-end loop
#---------------------------------------------------------
Loop: 
	nop
	nop
	addi $v0, $zero, 32
	li $a0, 200
	syscall
	nop
	nop
	b Loop # Wait for interrupt
	end_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180
#-------------------------------------------------------
# SAVE the current REG FILE to stack
#-------------------------------------------------------
IntSR: 
	addi $sp,$sp,4 # Save $at because we may change it later
	sw $at,0($sp)
	addi $sp,$sp,4 # Save $sp because we may change it later
	sw $v0,0($sp)
	addi $sp,$sp,4 # Save $a0 because we may change it later
	sw $a0,0($sp)
	addi $sp,$sp,4 # Save $t1 because we may change it later
	sw $t1,0($sp)
	addi $sp,$sp,4 # Save $t3 because we may change it later
	sw $t3,0($sp)
#--------------------------------------------------------
# Processing
#--------------------------------------------------------
get_key:
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x81 # check row 1 and re-enable bit 7
	sb $t3, 0($t1) # must reassign expected row
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb $a0, 0($t1)
	bne $a0, 0x0, key_pressed

	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x82 # check row 2 and re-enable bit 7
	sb $t3, 0($t1) # must reassign expected row
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb $a0, 0($t1)
	bne $a0, 0x0, key_pressed

	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x84 # check row 3 and re-enable bit 7
	sb $t3, 0($t1) # must reassign expected row
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb $a0, 0($t1)
	bne $a0, 0x0, key_pressed

	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t3, 0x88 # check row 3 and re-enable bit 7
	sb $t3, 0($t1) # must reassign expected row
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb $a0, 0($t1)
	bne $a0, 0x0, key_pressed
key_pressed:
	bne $a0, 0x11, else1 # 0 is pressed
	j key_0
else1:	
	bne $a0, 0x12, else2 # 4 is pressed
	j key_4
else2:
	bne $a0, 0x14, end1 # 8 is pressed
	j key_8

key_0:
	la $a2, postscript0 # start address of postscript
	la $a1, end0 # end address of postscript
	j MarsBot_Draw
key_4:
	la $a2, postscript4 # start address of postscript
	la $a1, end4 # end address of postscript
	j MarsBot_Draw
key_8:
	la $a2, postscript8 # start address of postscript
	la $a1, end8 # end address of postscript
	j MarsBot_Draw

	
MarsBot_Draw: # draw mars bot
read_script: # read postscript
	beq $a2, $a1, end_script
read_angle:
	lw $a0, 0($a2) # load angle to $a0
	jal ROTATE 
	addi $a2, $a2, 4 # go to next parameter of postscript
	
read_duration: 
	lw $a0, 0($a2) # load duration to $a0
	addi $a2, $a2, 4 # go to next parameter of postscript

read_cut_uncut: # cut if 1, uncut if 0
	lw $s0, 0($a2)
	beq $s0, $0, untrack
	jal TRACK # track if parameter is 1
untrack:
	jal GO
	addi $v0,$zero,32 # Keep running by sleeping 
	syscall
	jal UNTRACK 
	addi $a2, $a2, 4 # go to next parameter of postscript
	j read_script # jump back to loop
end_script:
	jal STOP
#--------------------------------------------------------
# Evaluate the return address of main routine
# epc <= epc + 4
#--------------------------------------------------------
next_pc:
	mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
	addi $at, $at, 4 # $at = $at + 4 (next instruction)
	mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
#--------------------------------------------------------
# RESTORE the REG FILE from STACK
#--------------------------------------------------------
restore:
	lw $t3, 0($sp) # Restore the registers from stack
	addi $sp,$sp,-4
	lw $t1, 0($sp) # Restore the registers from stack
	addi $sp,$sp,-4
	lw $a0, 0($sp) # Restore the registers from stack
	addi $sp,$sp,-4
	lw $v0, 0($sp) # Restore the registers from stack
	addi $sp,$sp,-4
	lw $at, 0($sp) # Restore the registers from stack
	addi $sp,$sp,-4
return: eret # Return from exception

GO: 
	li $at, MOVING # change MOVING port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start running
	nop
	jr $ra
	nop
	
STOP: 
	li $at, MOVING # change MOVING port to 0
	sb $zero, 0($at) # to stop
	nop
	jr $ra
	nop
	
TRACK: 
	li $at, LEAVETRACK # change LEAVETRACK port
	addi $k0, $zero,1 # to logic 1,
	sb $k0, 0($at) # to start tracking
	jr $ra
	
UNTRACK:
	li $at, LEAVETRACK # change LEAVETRACK port to 0
	sb $zero, 0($at) # to stop drawing tail
	jr $ra

ROTATE: 
	li $at, HEADING # change HEADING port
	sw $a0, 0($at) # to rotate robot
	nop
	jr $ra
	nop
# Send the mess error for scaner
end1:
	li $v0,55
	la $a0, error
	syscall
	nop
	j end_script
