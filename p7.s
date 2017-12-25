# Tyler Griffith
# 11/12/17
# ~/csc3410/p7/p7.s
# This program will merge sort a set of integers
.section	.data
.section	.text
	.globl	merge
  .globl  mergesort
	.type		merge,@function
  .type   mergesort,@function
mergesort:
  pushq %rbp
  movq %rsp, %rbp
  subq $32, %rsp
  movq %rdi, -24(%rbp)
  movl %esi, -28(%rbp)
  movl %edx, -32(%rbp) #setup
  movl -28(%rbp), %eax
  cmpl -32(%rbp), %eax
  jge done2 #if(left < right)
  movl -28(%rbp), %edx
  movl -32(%rbp), %eax
  addl %edx, %eax
  movl %eax, %edx
  shrl $31, %edx
  addl %edx, %eax
  sarl %eax
  movl %eax, -4(%rbp) #mid = (left+right/2)
  movl -4(%rbp), %edx
  movl -28(%rbp), %ecx
  movq -24(%rbp), %rax
  movl %ecx, %esi
  movq %rax, %rdi
  call mergesort  #mergesort(a,left,mid)
  movl -4(%rbp), %eax
  leal 1(%rax), %ecx
  movl -32(%rbp), %edx
  movq -24(%rbp), %rax
  movl %ecx, %esi
  movq %rax, %rdi
  call mergesort  #mergesort(a,mid+1,right)
  movl -4(%rbp), %eax
  leal 1(%rax), %ecx
  movl -32(%rbp), %edi
  movl -4(%rbp), %edx
  movl -28(%rbp), %esi
  movq -24(%rbp), %rax
  movl %edi, %r8d
  movq %rax, %rdi
  call merge  #merge(a,left,mid,mid+1,right)
done2:
  leave
  ret
  
merge:
  pushq %rbp
  movq %rsp, %rbp
  addq $-128, %rsp
  movq %rdi, -232(%rbp)
  movl %esi, -236(%rbp)
  movl %edx, -240(%rbp)
  movl %ecx, -244(%rbp)
	movl %r8d, -248(%rbp)	#all used to set up variables
	movl -236(%rbp), %eax	
	movl %eax, -4(%rbp)	#i = left1;
	movl -244(%rbp), %eax
	movl %eax, -8(%rbp)	#j = left2;
	movl -236(%rbp), %eax
	movl %eax, -12(%rbp)	#k = left1;
while:
	movl -4(%rbp), %eax
	cmpl -240(%rbp), %eax
	jg loop2
	movl -8(%rbp), %eax
	cmpl -248(%rbp), %eax
	jg loop2 	#while(i <= right1 && j <= right2)
	movl -4(%rbp), %eax
	cltq
	leaq 0(,%rax,4), %rdx
	movq -232(%rbp), %rax
	addq %rdx, %rax
	movl (%rax), %edx
	movl -8(%rbp), %eax
	cltq
	leaq 0(,%rax,4), %rcx
	movq -232(%rbp), %rax
	addq %rcx, %rax
	movl (%rax), %eax
	cmpl %eax, %edx
	jge inc2 	#if(a[i] < a[j])
	movl -4(%rbp), %eax
	leal 1(%rax), %edx
	movl %edx, -4(%rbp)
	cltq
	leaq 0(,%rax,4), %rdx
	movq -232(%rbp), %rax	
	leaq (%rdx,%rax), %rcx
	movl -12(%rbp), %eax
	leal 1(%rax), %edx
	movl %edx, -12(%rbp)
	movl (%rcx), %edx
	cltq
	movl %edx, -224(%rbp,%rax,4)
	jmp while 	#temp[k++] = a[i++]
inc:
	movl -8(%rbp), %eax
  leal 1(%rax), %edx
 	movl %edx, -8(%rbp)
  cltq
  leaq 0(,%rax,4), %rdx
  movq -232(%rbp), %rax
  leaq (%rdx,%rax), %rcx
  movl -12(%rbp), %eax
  leal 1(%rax), %edx
  movl %edx, -12(%rbp)
  movl (%rcx), %edx
  cltq
  movl %edx, -224(%rbp,%rax,4)
  jmp while	#temp[k++] = a[j++]
loop2:
  movl -4(%rbp), %eax
  cmpl -240(%rbp), %eax
  jg loop3 	#while(i <= right1)
  movl -4(%rbp), %eax
  leal 1(%rax), %edx
  movl %edx, -4(%rbp)
  cltq
  leaq 0(,%rax,4), %rdx
  movq -232(%rbp), %rax
  leaq (%rdx,%rax), %rcx
  movl -12(%rbp), %eax
  leal 1(%rax), %edx
  movl %edx, -12(%rbp)
  movl (%rcx), %edx
  cltq
  movl %edx, -224(%rbp,%rax,4)
  jmp loop2 	#temp[k++] = a[i++]
loop3:
  movl -8(%rbp), %eax
  cmpl -248(%rbp), %eax
  jg loop4 	#while(j <= right2)
  movl -8(%rbp), %eax
  leal 1(%rax), %edx
  movl %edx, -8(%rbp)
  cltq
  leaq 0(,%rax,4), %rdx
  movq -232(%rbp), %rax
  leaq (%rdx,%rax), %rcx
  movl -12(%rbp), %eax
  leal 1(%rax), %edx
  movl %edx, -12(%rbp)
	movl (%rcx), %edx
 	cltq
 	movl %edx, -224(%rbp,%rax,4)
 	jmp loop3 	#temp[k++]=a[j++]
loop4:
	movl -236(%rbp), %eax
 	movl %eax, -4(%rbp)
inc2:
 	movl -4(%rbp), %eax
 	cmpl -248(%rbp), %eax
 	jg done 	#for(i = left1; i<= )
 	movl -4(%rbp), %eax
 	cltq
 	leaq 0(,%rax,4), %rdx
 	movq -232(%rbp), %rax
 	addq %rax, %rdx
 	movl -4(%rbp), %eax
 	cltq
 	movl -224(%rbp,%rax,4), %eax
 	movl %eax, (%rdx)
 	addl $1, -4(%rbp)
 	jmp inc2
done:
	leave
 	ret