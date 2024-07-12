.eqv MONITOR_SCREEN 0x10010000 
.eqv BLACK 	0x00000000	
.eqv YELLOW 	0x00FFFF00
.eqv KEY_CODE	0xFFFF0004
.eqv KEY_READY	0xFFFF0000

.data
circle_point:		.word		# an array of coordinate of circle point

.text
initialization:
	# Center of the screen
 	li	$s0, 256		# x = 256
 	li	$s1, 256		# y = 256
 	# direction that the circle is moving
 	li	$s2, 0			# px = 0
	li	$s3, 0			# py = 0
	# radius
  	li	$s4, 16			# R = 16
  	# sleep time
	li	$a0, 30			# t = 30
	# create an array of coordinate of circle point
	jal	create_circle_point
  	
  	# set up previous key
  	li	$t8, 'p'
  
input:	
	li	$k0, KEY_READY
	lw	$t0, 0($k0)
	bne	$t0, 1, check_hit_edge
	li	$k0, KEY_CODE
	lw	$t0, 0($k0)
	

	beq	$t8, $t0, speed_up
	move	$t8, $t0

	
	beq	$t0, 'a', press_key_a
	beq	$t0, 'd', press_key_d
	beq	$t0, 's', press_key_s
	beq	$t0, 'w', press_key_w


press_key_a:
	li	$s2, -1		# px = -1	
	li	$s3, 0		# py = 0
	j	check_hit_edge
	
press_key_d:
	li	$s2, 1		# px = 1
	li	$s3, 0		# py = 0
	j	check_hit_edge
	
press_key_s:
	li 	$s3, 1		# py = 1
	li	$s2, 0		# px = 0	
	j	check_hit_edge

press_key_w:
	li 	$s3, -1		# py = -1
	li	$s2, 0		# px = 0	
	j	check_hit_edge

	
speed_up:
	beq	$a0, 5, check_hit_edge
	addi	$a0, $a0, -5	# t -= 5
	j	check_hit_edge

check_hit_edge:
	beq	$s2, 1, check_hit_right_edge
	beq	$s2, -1, check_hit_left_edge
	beq	$s3, -1, check_hit_top_edge
	beq	$s3, 1, check_hit_bottom_edge
	j	move_circle
	
check_hit_right_edge:	
	add	$t0, $s0, $s4	# Rightest point of the circle
	beq	$t0, 511, reverse
	j	move_circle

check_hit_left_edge:
	sub	$t0, $s0, $s4	# Leftest point of the circle
	beq	$t0, 1, reverse
	j	move_circle
	
check_hit_bottom_edge:
	add	$t0, $s1, $s4	# Lowest point of the circle
	bge	$t0, 511, reverse
	j	move_circle
	
check_hit_top_edge:
	sub	$t0, $s1, $s4	# Highest point of the circle
	ble	$t0, 1, reverse
	j	move_circle
	
reverse:
	sub	$s2, $0, $s2	# px = -px
	sub	$s3, $0, $s3	# py = -py
	case_a:
		bne	$t8, 'a', case_d
		li	$t8, 'd'
		j	move_circle
	case_d:
		bne	$t8, 'd', case_w
		li	$t8, 'a'
		j	move_circle
	case_w: 
		bne	$t8, 'w', case_s
		li	$t8, 's'
		j	move_circle
	case_s:
		li	$t8, 'w'

move_circle:
	li	$s5, BLACK	# Set color to black
	jal	draw_circle	# Erase the old circle
	
	add	$s0, $s0, $s2 	# Set the center of the new circle 
	add	$s1, $s1, $s3 
	
	li	$s5, YELLOW	# Set color to yellow
	jal	draw_circle	# Draw the new circle

loop:
	li $v0, 32	 	# Sleep
	syscall
	j	input		# Restart the cycle
	
draw_circle:
	add	$t9, $ra, $0	# Save $ra 
	la	$s6, circle_point	# pointer to the circle_point array
	
draw_loop:
	beq	$s6, $v1, draw_end	# Stop when $s6 = $v1 (pointer at the end of the array)
	lw	$a1, 0($s6)		# $a1 = px
	lw	$a2, 4($s6)		# $a2 = py
	jal	draw
	addi	$s6, $s6, 8		# Move the pointer
	j	draw_loop
	
draw_end:
	add	$ra, $t9, $zero
	jr	$ra										
					
draw:
	li	$t0, MONITOR_SCREEN
	add	$t1, $s0, $a1
	add	$t2, $s1, $a2	
	mul	$t2, $t2, 512	# Move to y coordinate
	add	$t2, $t2, $t1	# Move to x coordinate
	sll	$t2, $t2, 2	# Multiply by 4 for address
	add	$t0, $t0, $t2
	sw	$s5, 0($t0) 
	jr	$ra

#------------------------------------------------------------------------------------------	
create_circle_point:
	add	$t9, $ra, $0	# Save $ra
	la 	$s5, circle_point	# $s5 = pointer of the "circle_point" array
	mul	$a3, $s4, $s4	# $a3 = R*R	
	add	$s7, $0, $0	# px = 0
	
circle_cal_loop:
	bgt	$s7, $s4, create_circle_point_end
	mul	$t0, $s7, $s7	# $t0 = px^2
	sub	$a2, $a3, $t0	# $a2 = R^2 - px^2 = py^2
	beqz	$a2, cal_continue
	jal	sqrt		# $a2 = py
cal_continue:	
	move	$a1, $s7	# $a1 = px
	li	$s6, 0		

# Saving (px, py), (-px, py), (-px, -py), (px, -py)
save_circle_point:
	jal	save	#(px, py)
	sub	$a1, $0, $a1	
	jal	save	#(-px, py)
	sub	$a2, $0, $a2 
	jal	save	#(-px, -py)
	sub	$a1, $0, $a1	
	jal	save	#(px, -py)
# then save (-py, px), (py, px), (py, -px), (-py, -px)
	# Swap px and -py
	move	$t0, $a1	# tmp = px
	move	$a1, $a2	# $a1 = -py
	move	$a2, $t0	# $a2 = px
	
	addi	$s6, $s6, 1
	
	beq	$s6, 2, save_finish
	j	save_circle_point
save_finish:	
	addi	$s7, $s7, 1
	j	circle_cal_loop
	
save:
	sw	$a1, 0($s5)	# Store px
	sw	$a2, 4($s5)	# Store py
	addi	$s5, $s5, 8	# Move the pointer
	jr	$ra	
	
create_circle_point_end:
	move	$v1, $s5	# Save the end address of the "circle_point" array
	add	$ra, $t9, $zero
	jr	$ra
	
sqrt:
	mtc1 $a2, $f0    # $f0 = $a2 
	cvt.s.w $f0, $f0	 
	sqrt.s $f0, $f0
	cvt.w.s $f0, $f0 # 3 lines: $f0 = sqrt($f0) 
	mfc1 $a2, $f0    
	jr $ra
