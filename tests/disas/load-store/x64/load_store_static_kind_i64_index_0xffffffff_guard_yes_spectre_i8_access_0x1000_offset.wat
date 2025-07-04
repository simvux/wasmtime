;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -W memory64 -O static-memory-forced -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0x1000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load8_u offset=0x1000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r11, %r11
;;       movq    0x38(%rdi), %rsi
;;       leaq    0x1000(%rsi, %rdx), %r10
;;       cmpq    0xe(%rip), %rdx
;;       cmovaq  %r11, %r10
;;       movb    %cl, (%r10)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   26: addb    %al, (%rax)
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r11, %r11
;;       movq    0x38(%rdi), %rsi
;;       leaq    0x1000(%rsi, %rdx), %r10
;;       cmpq    0xe(%rip), %rdx
;;       cmovaq  %r11, %r10
;;       movzbq  (%r10), %rax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   67: addb    %bh, %bh
;;   69: outl    %eax, %dx
