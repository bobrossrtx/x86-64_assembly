;;; |Registers                  |
;;; |---------------------------|
;;; |8-bit |16-bit|32-bit|64-bit|
;;; |al    |ax    |eax   |rax   |
;;; |bl    |bx    |ebx   |rbx   |
;;; |cl    |cx    |ecx   |rcx   |
;;; |dl    |dx    |edx   |rdx   |
;;; |sil   |si    |esi   |rsi   |
;;; |dil   |di    |edi   |rdi   |
;;; |bpl   |bp    |ebp   |rbp   |
;;; |spl   |sp    |esp   |rsp   |
;;; |r8b   |r8w   |r8d   |r8    |
;;; |r9b   |r9w   |r9d   |r9    |
;;; |r10b  |r10w  |r10d  |r10   |
;;; |r11b  |r11w  |r11d  |r11   |
;;; |r12b  |r12w  |r12d  |r12   |
;;; |r13b  |r13w  |r13d  |r13   |
;;; |r14b  |r14w  |r14d  |r14   |
;;; |r15b  |r15w  |r15d  |r15   |
;;; |---------------------------|

section .data                   ; Data section:
                                ;   Where all data is defined
                                ;   before being assembled.
    ;; db - Define Byte
    ;; essentially meaning we are going
    ;; to define some raw bytes of data
    ;; to insert into our code.
    ;;
    ;; This is the data we are defining.
    ;; Each character of the string of
    ;; text is a single byte. The "10"
    ;; is a newline character, often
    ;; denoted as "\n".
    ;; >>>> |------------------|
    text db "Hello, World!", 10
    ;; ^ Name assigned to address in
    ;; memory that this data is located
    ;; at.
    ;; Whenever we use "text" later in
    ;; the code, the assembler will
    ;; determine the actual location
    ;; in memory of this data and
    ;; replace all future instances
    ;; of "text" with that memory
    ;; address.

section .text                   ; Text section:
                                ;   Where actual code goes.
    global _start

;;; SYS_WRITE
;;; [Argument type]     [Argument description]
;;; [File descriptor]   [0 (stdin)
;;;                      1 (stdout)
;;;                      2 (stderr)]
;;; [Buffer]            [Location of string to write]
;;; [Count]             [Length of string]
;;; -------------------------------------------------
;;; [Argument]          [Registers]
;;; ID                  rax
;;; 1                   rdi
;;; 2                   rsi
;;; 3                   rdx         < Stops here
;;; 4                   r10
;;; 5                   r8
;;; 6                   r9

_start:
    mov rax, 1                  ; Moving 1 into the rax register.
                                ; This tells the assembler that
                                ; we want to use the SYS_WRITE
                                ; syscall.
    mov rdi, 1                  ; Moving 1 into the rdi register.
                                ; This tells the assembler that
                                ; we want to use stdout as our
                                ; file descriptor for SYS_WRITE.
    mov rsi, text               ; Moving the text variable from
                                ; above into the rsi register
                                ; (buffer).
    mov rdx, 14                 ; Moving the size of the string
                                ; into the rdx register (count).
    syscall                     ; Calling the syscall.

    mov rax, 60                 ; 60 = exit syscall
    mov rdi, 0                  ; (error/return code) no error = 0
    syscall                     ; Calling the syscall
