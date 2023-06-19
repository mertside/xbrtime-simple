
./matmul_M.exe:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000011dcc <_start>:
; {
   11dcc: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   11dd0: f6 57 81 42  	stp	c22, c21, [csp, #32]
   11dd4: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   11dd8: fd d3 c1 c2  	mov	c29, csp
; 	if (!has_dynamic_linker)
   11ddc: 62 05 00 b4  	cbz	x2, 0x11e88 <_start+0xbc>
   11de0: 33 d0 c1 c2  	mov	c19, c1
; 	if (!has_dynamic_linker)
   11de4: 33 05 00 b4  	cbz	x19, 0x11e88 <_start+0xbc>
; 	if (cheri_getdefault() != NULL)
   11de8: 21 41 9b c2  	mrs	c1, DDC
   11dec: e1 04 00 b5  	cbnz	x1, 0x11e88 <_start+0xbc>
   11df0: f5 03 1f aa  	mov	x21, xzr
   11df4: f4 03 1f aa  	mov	x20, xzr
   11df8: f6 03 1f 2a  	mov	w22, wzr
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11dfc: 01 40 00 02  	add	c1, c0, #16             // =16
   11e00: 04 00 00 14  	b	0x11e10 <_start+0x44>
   11e04: c1 01 00 54  	b.ne	0x11e3c <_start+0x70>
; 			argc = auxp->a_un.a_val;
   11e08: 36 00 40 b9  	ldr	w22, [c1]
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11e0c: 21 80 00 02  	add	c1, c1, #32             // =32
   11e10: 28 00 5f f8  	ldur	x8, [c1, #-16]
   11e14: 1f 71 00 f1  	cmp	x8, #28                 // =28
   11e18: 6d ff ff 54  	b.le	0x11e04 <_start+0x38>
   11e1c: 1f 75 00 f1  	cmp	x8, #29                 // =29
   11e20: a0 00 00 54  	b.eq	0x11e34 <_start+0x68>
   11e24: 1f 7d 00 f1  	cmp	x8, #31                 // =31
   11e28: 21 ff ff 54  	b.ne	0x11e0c <_start+0x40>
; 			env = (char **)auxp->a_un.a_ptr;
   11e2c: 34 24 40 a2  	ldr	c20, [c1], #32
   11e30: f8 ff ff 17  	b	0x11e10 <_start+0x44>
; 			argv = (char **)auxp->a_un.a_ptr;
   11e34: 35 24 40 a2  	ldr	c21, [c1], #32
   11e38: f6 ff ff 17  	b	0x11e10 <_start+0x44>
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11e3c: 88 fe ff b5  	cbnz	x8, 0x11e0c <_start+0x40>
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11e40: 81 00 80 d0  	adrp	c1, 0x23000 <_start+0xbc>
   11e44: 21 98 42 c2  	ldr	c1, [c1, #2656]
; 	handle_argv(argc, argv, env);
   11e48: 82 d2 c1 c2  	mov	c2, c20
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11e4c: 20 00 00 c2  	str	c0, [c1, #0]
; 	handle_argv(argc, argv, env);
   11e50: e0 03 16 2a  	mov	w0, w22
   11e54: a1 d2 c1 c2  	mov	c1, c21
   11e58: 0d 00 00 94  	bl	0x11e8c <handle_argv>
; 		atexit(cleanup);
   11e5c: 60 d2 c1 c2  	mov	c0, c19
   11e60: 3c 05 00 94  	bl	0x13350 <xbrtime_api_asm.s+0x13350>
; 	handle_static_init(argc, argv, env);
   11e64: e0 03 16 2a  	mov	w0, w22
   11e68: a1 d2 c1 c2  	mov	c1, c21
   11e6c: 82 d2 c1 c2  	mov	c2, c20
   11e70: 1c 00 00 94  	bl	0x11ee0 <handle_static_init>
; 	exit(main(argc, argv, env));
   11e74: e0 03 16 2a  	mov	w0, w22
   11e78: a1 d2 c1 c2  	mov	c1, c21
   11e7c: 82 d2 c1 c2  	mov	c2, c20
   11e80: 79 03 00 94  	bl	0x12c64 <main>
   11e84: 37 05 00 94  	bl	0x13360 <xbrtime_api_asm.s+0x13360>
   11e88: 20 00 20 d4  	brk	#0x1

0000000000011e8c <handle_argv>:
; 	if (environ == NULL)
   11e8c: 83 00 80 d0  	adrp	c3, 0x23000 <handle_argv+0x48>
   11e90: 63 9c 42 c2  	ldr	c3, [c3, #2672]
   11e94: 64 00 40 c2  	ldr	c4, [c3, #0]
   11e98: 84 00 00 b4  	cbz	x4, 0x11ea8 <handle_argv+0x1c>
; 	if (argc > 0 && argv[0] != NULL) {
   11e9c: 1f 04 00 71  	cmp	w0, #1                  // =1
   11ea0: aa 00 00 54  	b.ge	0x11eb4 <handle_argv+0x28>
   11ea4: 0e 00 00 14  	b	0x11edc <handle_argv+0x50>
; 		environ = env;
   11ea8: 62 00 00 c2  	str	c2, [c3, #0]
; 	if (argc > 0 && argv[0] != NULL) {
   11eac: 1f 04 00 71  	cmp	w0, #1                  // =1
   11eb0: 6b 01 00 54  	b.lt	0x11edc <handle_argv+0x50>
   11eb4: 21 00 40 c2  	ldr	c1, [c1, #0]
   11eb8: 21 01 00 b4  	cbz	x1, 0x11edc <handle_argv+0x50>
; 		__progname = argv[0];
   11ebc: 80 00 80 d0  	adrp	c0, 0x23000 <handle_static_init+0x24>
   11ec0: 00 a0 42 c2  	ldr	c0, [c0, #2688]
   11ec4: 01 00 00 c2  	str	c1, [c0, #0]
   11ec8: 21 04 00 02  	add	c1, c1, #1              // =1
; 		for (s = __progname; *s != '\0'; s++) {
   11ecc: 28 f0 5f 38  	ldurb	w8, [c1, #-1]
   11ed0: 1f bd 00 71  	cmp	w8, #47                 // =47
   11ed4: 80 ff ff 54  	b.eq	0x11ec4 <handle_argv+0x38>
   11ed8: 88 ff ff 35  	cbnz	w8, 0x11ec8 <handle_argv+0x3c>
; }
   11edc: c0 53 c2 c2  	ret	c30

0000000000011ee0 <handle_static_init>:
; {
   11ee0: fd fb bc 62  	stp	c29, c30, [csp, #-112]!
   11ee4: f7 0b 00 c2  	str	c23, [csp, #32]
   11ee8: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   11eec: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   11ef0: fd d3 c1 c2  	mov	c29, csp
   11ef4: 34 d0 c1 c2  	mov	c20, c1
; 	if (&_DYNAMIC != NULL)
   11ef8: 81 00 80 d0  	adrp	c1, 0x23000 <handle_static_init+0x60>
   11efc: 21 a4 42 c2  	ldr	c1, [c1, #2704]
   11f00: 61 07 00 b5  	cbnz	x1, 0x11fec <handle_static_init+0x10c>
   11f04: f5 03 00 2a  	mov	w21, w0
; 	atexit(finalizer);
   11f08: 00 00 80 b0  	adrp	c0, 0x12000 <handle_static_init+0x2c>
   11f0c: 00 04 00 02  	add	c0, c0, #1              // =1
   11f10: 00 30 c3 c2  	seal	c0, c0, rb
   11f14: 53 d0 c1 c2  	mov	c19, c2
   11f18: 0e 05 00 94  	bl	0x13350 <xbrtime_api_asm.s+0x13350>
; 	array_size = __preinit_array_end - __preinit_array_start;
   11f1c: 80 00 80 d0  	adrp	c0, 0x23000 <handle_static_init+0x84>
   11f20: 00 a8 42 c2  	ldr	c0, [c0, #2720]
   11f24: 81 00 80 d0  	adrp	c1, 0x23000 <handle_static_init+0x8c>
   11f28: 21 ac 42 c2  	ldr	c1, [c1, #2736]
   11f2c: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   11f30: a0 02 00 54  	b.eq	0x11f84 <handle_static_init+0xa4>
   11f34: 97 00 80 d0  	adrp	c23, 0x23000 <handle_static_init+0x9c>
   11f38: f7 ae 42 c2  	ldr	c23, [c23, #2736]
; 	array_size = __preinit_array_end - __preinit_array_start;
   11f3c: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   11f40: 1f 05 00 f1  	cmp	x8, #1                  // =1
   11f44: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   11f48: 04 00 00 14  	b	0x11f58 <handle_static_init+0x78>
   11f4c: d6 06 00 f1  	subs	x22, x22, #1            // =1
   11f50: f7 42 00 02  	add	c23, c23, #16           // =16
   11f54: 80 01 00 54  	b.eq	0x11f84 <handle_static_init+0xa4>
; 		fn = __preinit_array_start[n];
   11f58: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f5c: 83 ff ff b4  	cbz	x3, 0x11f4c <handle_static_init+0x6c>
   11f60: e0 03 1f aa  	mov	x0, xzr
   11f64: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f68: 7f 00 00 eb  	cmp	x3, x0
   11f6c: 00 ff ff 54  	b.eq	0x11f4c <handle_static_init+0x6c>
; 			fn(argc, argv, env);
   11f70: e0 03 15 2a  	mov	w0, w21
   11f74: 81 d2 c1 c2  	mov	c1, c20
   11f78: 62 d2 c1 c2  	mov	c2, c19
   11f7c: 60 30 c2 c2  	blr	c3
   11f80: f3 ff ff 17  	b	0x11f4c <handle_static_init+0x6c>
; 	array_size = __init_array_end - __init_array_start;
   11f84: 80 00 80 d0  	adrp	c0, 0x23000 <handle_static_init+0xec>
   11f88: 00 b0 42 c2  	ldr	c0, [c0, #2752]
   11f8c: 81 00 80 d0  	adrp	c1, 0x23000 <handle_static_init+0xf4>
   11f90: 21 b4 42 c2  	ldr	c1, [c1, #2768]
   11f94: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   11f98: a0 02 00 54  	b.eq	0x11fec <handle_static_init+0x10c>
   11f9c: 97 00 80 d0  	adrp	c23, 0x23000 <handle_static_init+0x104>
   11fa0: f7 b6 42 c2  	ldr	c23, [c23, #2768]
; 	array_size = __init_array_end - __init_array_start;
   11fa4: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   11fa8: 1f 05 00 f1  	cmp	x8, #1                  // =1
   11fac: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   11fb0: 04 00 00 14  	b	0x11fc0 <handle_static_init+0xe0>
   11fb4: d6 06 00 f1  	subs	x22, x22, #1            // =1
   11fb8: f7 42 00 02  	add	c23, c23, #16           // =16
   11fbc: 80 01 00 54  	b.eq	0x11fec <handle_static_init+0x10c>
; 		fn = __init_array_start[n];
   11fc0: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11fc4: 83 ff ff b4  	cbz	x3, 0x11fb4 <handle_static_init+0xd4>
   11fc8: e0 03 1f aa  	mov	x0, xzr
   11fcc: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11fd0: 7f 00 00 eb  	cmp	x3, x0
   11fd4: 00 ff ff 54  	b.eq	0x11fb4 <handle_static_init+0xd4>
; 			fn(argc, argv, env);
   11fd8: e0 03 15 2a  	mov	w0, w21
   11fdc: 81 d2 c1 c2  	mov	c1, c20
   11fe0: 62 d2 c1 c2  	mov	c2, c19
   11fe4: 60 30 c2 c2  	blr	c3
   11fe8: f3 ff ff 17  	b	0x11fb4 <handle_static_init+0xd4>
; }
   11fec: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   11ff0: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   11ff4: f7 0b 40 c2  	ldr	c23, [csp, #32]
   11ff8: fd fb c3 22  	ldp	c29, c30, [csp], #112
   11ffc: c0 53 c2 c2  	ret	c30

0000000000012000 <finalizer>:
; {
   12000: fd 7b be 62  	stp	c29, c30, [csp, #-64]!
   12004: f4 4f 81 42  	stp	c20, c19, [csp, #32]
   12008: fd d3 c1 c2  	mov	c29, csp
; 	array_size = __fini_array_end - __fini_array_start;
   1200c: 80 00 80 b0  	adrp	c0, 0x23000 <finalizer+0x50>
   12010: 00 b8 42 c2  	ldr	c0, [c0, #2784]
   12014: 93 00 80 b0  	adrp	c19, 0x23000 <finalizer+0x58>
   12018: 73 be 42 c2  	ldr	c19, [c19, #2800]
   1201c: 08 00 13 eb  	subs	x8, x0, x19
; 	for (n = array_size; n > 0; n--) {
   12020: e0 01 00 54  	b.eq	0x1205c <finalizer+0x5c>
; 	array_size = __fini_array_end - __fini_array_start;
   12024: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = array_size; n > 0; n--) {
   12028: 14 05 00 d1  	sub	x20, x8, #1             // =1
   1202c: 04 00 00 14  	b	0x1203c <finalizer+0x3c>
   12030: 94 06 00 d1  	sub	x20, x20, #1            // =1
   12034: 9f 06 00 b1  	cmn	x20, #1                 // =1
   12038: 20 01 00 54  	b.eq	0x1205c <finalizer+0x5c>
; 		fn = __fini_array_start[n - 1];
   1203c: 60 7a 74 a2  	ldr	c0, [c19, x20, lsl #4]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   12040: 80 ff ff b4  	cbz	x0, 0x12030 <finalizer+0x30>
   12044: e1 03 1f aa  	mov	x1, xzr
   12048: 21 04 00 02  	add	c1, c1, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   1204c: 1f 00 01 eb  	cmp	x0, x1
   12050: 00 ff ff 54  	b.eq	0x12030 <finalizer+0x30>
; 			(fn)();
   12054: 00 30 c2 c2  	blr	c0
   12058: f6 ff ff 17  	b	0x12030 <finalizer+0x30>
; }
   1205c: f4 4f c1 42  	ldp	c20, c19, [csp, #32]
   12060: fd 7b c2 22  	ldp	c29, c30, [csp], #64
   12064: c0 53 c2 c2  	ret	c30

0000000000012068 <run_cxa_finalize>:
; 	if (__cxa_finalize != NULL)
   12068: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_malloc+0x18>
   1206c: 00 c0 42 c2  	ldr	c0, [c0, #2816]
   12070: 00 01 00 b4  	cbz	x0, 0x12090 <run_cxa_finalize+0x28>
   12074: fd 7b bf 62  	stp	c29, c30, [csp, #-32]!
   12078: fd d3 c1 c2  	mov	c29, csp
; 		__cxa_finalize(__dso_handle);
   1207c: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_malloc+0x2c>
   12080: 00 c4 42 c2  	ldr	c0, [c0, #2832]
   12084: 00 00 40 c2  	ldr	c0, [c0, #0]
   12088: ba 04 00 94  	bl	0x13370 <xbrtime_api_asm.s+0x13370>
; }
   1208c: fd 7b c1 22  	ldp	c29, c30, [csp], #32
   12090: c0 53 c2 c2  	ret	c30

0000000000012094 <xbrtime_malloc>:
;   if( sz == 0 ){
   12094: 60 01 00 b4  	cbz	x0, 0x120c0 <xbrtime_malloc+0x2c>
   12098: fd fb be 62  	stp	c29, c30, [csp, #-48]!
   1209c: f3 0b 00 c2  	str	c19, [csp, #32]
   120a0: fd d3 c1 c2  	mov	c29, csp
;   ptr = malloc(sz);
   120a4: b7 04 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   120a8: 13 d0 c1 c2  	mov	c19, c0
;   __xbrtime_asm_quiet_fence();
   120ac: 9f 04 00 94  	bl	0x13328 <__xbrtime_asm_quiet_fence>
; }
   120b0: 60 d2 c1 c2  	mov	c0, c19
   120b4: f3 0b 40 c2  	ldr	c19, [csp, #32]
   120b8: fd fb c1 22  	ldp	c29, c30, [csp], #48
   120bc: c0 53 c2 c2  	ret	c30
   120c0: e0 03 1f aa  	mov	x0, xzr
   120c4: c0 53 c2 c2  	ret	c30

00000000000120c8 <xbrtime_free>:
;   if( ptr == NULL ){
   120c8: 40 00 00 b4  	cbz	x0, 0x120d0 <xbrtime_free+0x8>
;   __xbrtime_asm_quiet_fence();
   120cc: 97 04 00 14  	b	0x13328 <__xbrtime_asm_quiet_fence>
; }
   120d0: c0 53 c2 c2  	ret	c30

00000000000120d4 <tpool_create>:
; {                                                                               
   120d4: ff c3 81 02  	sub	csp, csp, #112          // =112
   120d8: fd fb 80 42  	stp	c29, c30, [csp, #16]
   120dc: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   120e0: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   120e4: fd 43 00 02  	add	c29, csp, #16           // =16
;   if (num == 0)                                                                 
   120e8: 1f 00 00 f1  	cmp	x0, #0                  // =0
   120ec: 48 00 80 52  	mov	w8, #2
   120f0: 16 01 80 9a  	csel	x22, x8, x0, eq
;   wq              = calloc(1, sizeof(*wq));                                     
   120f4: 20 00 80 52  	mov	w0, #1
   120f8: 01 0e 80 52  	mov	w1, #112
   120fc: a5 04 00 94  	bl	0x13390 <xbrtime_api_asm.s+0x13390>
   12100: 13 d0 c1 c2  	mov	c19, c0
;   wq->num_threads = num;                                                        
   12104: 16 2c 00 f9  	str	x22, [c0, #88]
;   pthread_mutex_init(&(wq->work_mutex), NULL);                                  
   12108: 00 80 00 02  	add	c0, c0, #32             // =32
   1210c: e1 03 1f aa  	mov	x1, xzr
   12110: a4 04 00 94  	bl	0x133a0 <xbrtime_api_asm.s+0x133a0>
;   pthread_cond_init(&(wq->work_cond), NULL);                                    
   12114: 60 c2 00 02  	add	c0, c19, #48            // =48
   12118: e1 03 1f aa  	mov	x1, xzr
   1211c: a5 04 00 94  	bl	0x133b0 <xbrtime_api_asm.s+0x133b0>
;   pthread_cond_init(&(wq->working_cond), NULL);                                 
   12120: 60 02 01 02  	add	c0, c19, #64            // =64
   12124: e1 03 1f aa  	mov	x1, xzr
   12128: a2 04 00 94  	bl	0x133b0 <xbrtime_api_asm.s+0x133b0>
   1212c: 01 00 80 90  	adrp	c1, 0x12000 <tpool_create+0x58>
   12130: e0 d3 c1 c2  	mov	c0, csp
   12134: 21 14 06 02  	add	c1, c1, #389            // =389
;   wq->work_tail = NULL;                                                         
   12138: 00 e4 00 6f  	movi	v0.2d, #0000000000000000
   1213c: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   12140: 35 30 c3 c2  	seal	c21, c1, rb
   12144: 60 02 00 ad  	stp	q0, q0, [c19]
;     pthread_create(&thread, NULL, tpool_worker, wq);                            
   12148: 80 d2 c1 c2  	mov	c0, c20
   1214c: e1 03 1f aa  	mov	x1, xzr
   12150: a2 d2 c1 c2  	mov	c2, c21
   12154: 63 d2 c1 c2  	mov	c3, c19
   12158: 9a 04 00 94  	bl	0x133c0 <xbrtime_api_asm.s+0x133c0>
;     pthread_detach(thread);                                                     
   1215c: e0 03 40 c2  	ldr	c0, [csp, #0]
   12160: 9c 04 00 94  	bl	0x133d0 <xbrtime_api_asm.s+0x133d0>
;   for (i=0; i<num; i++) {                                                       
   12164: d6 06 00 f1  	subs	x22, x22, #1            // =1
   12168: 01 ff ff 54  	b.ne	0x12148 <tpool_create+0x74>
;   return wq;                                                                    
   1216c: 60 d2 c1 c2  	mov	c0, c19
   12170: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   12174: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   12178: fd fb c0 42  	ldp	c29, c30, [csp, #16]
   1217c: ff c3 01 02  	add	csp, csp, #112          // =112
   12180: c0 53 c2 c2  	ret	c30

0000000000012184 <tpool_worker>:
; {                                                                               
   12184: fd fb bc 62  	stp	c29, c30, [csp, #-112]!
   12188: f7 0b 00 c2  	str	c23, [csp, #32]
   1218c: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   12190: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   12194: fd d3 c1 c2  	mov	c29, csp
   12198: 14 d0 c1 c2  	mov	c20, c0
   1219c: 13 80 00 02  	add	c19, c0, #32            // =32
   121a0: 16 c0 00 02  	add	c22, c0, #48            // =48
   121a4: 15 00 01 02  	add	c21, c0, #64            // =64
   121a8: 03 00 00 14  	b	0x121b4 <tpool_worker+0x30>
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   121ac: 60 d2 c1 c2  	mov	c0, c19
   121b0: 8c 04 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   121b4: 60 d2 c1 c2  	mov	c0, c19
   121b8: 8e 04 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
;     while (wq->work_head == NULL && !wq->stop)                                  
   121bc: 80 02 40 c2  	ldr	c0, [c20, #0]
   121c0: 00 01 00 b5  	cbnz	x0, 0x121e0 <tpool_worker+0x5c>
   121c4: 88 82 41 39  	ldrb	w8, [c20, #96]
   121c8: 48 05 00 35  	cbnz	w8, 0x12270 <tpool_worker+0xec>
;       pthread_cond_wait(&(wq->work_cond), &(wq->work_mutex));                   
   121cc: c0 d2 c1 c2  	mov	c0, c22
   121d0: 61 d2 c1 c2  	mov	c1, c19
   121d4: 8b 04 00 94  	bl	0x13400 <xbrtime_api_asm.s+0x13400>
;     while (wq->work_head == NULL && !wq->stop)                                  
   121d8: 80 02 40 c2  	ldr	c0, [c20, #0]
   121dc: 40 ff ff b4  	cbz	x0, 0x121c4 <tpool_worker+0x40>
;     if (wq->stop)                                                               
   121e0: 88 82 41 39  	ldrb	w8, [c20, #96]
   121e4: 68 04 00 35  	cbnz	w8, 0x12270 <tpool_worker+0xec>
;   if (wq == NULL)                                                               
   121e8: f4 00 00 b4  	cbz	x20, 0x12204 <tpool_worker+0x80>
;   work = wq->work_head;                                                         
   121ec: 97 02 40 c2  	ldr	c23, [c20, #0]
;   if (work == NULL)                                                             
   121f0: b7 00 00 b4  	cbz	x23, 0x12204 <tpool_worker+0x80>
;   if (work->next == NULL) {                                                     
   121f4: e0 0a 40 c2  	ldr	c0, [c23, #32]
   121f8: a0 00 00 b4  	cbz	x0, 0x1220c <tpool_worker+0x88>
;     wq->work_head = work->next;                                                 
   121fc: 80 02 00 c2  	str	c0, [c20, #0]
   12200: 05 00 00 14  	b	0x12214 <tpool_worker+0x90>
   12204: f7 03 1f aa  	mov	x23, xzr
   12208: 03 00 00 14  	b	0x12214 <tpool_worker+0x90>
   1220c: 00 e4 00 6f  	movi	v0.2d, #0000000000000000
;     wq->work_tail = NULL;                                                       
   12210: 80 02 00 ad  	stp	q0, q0, [c20]
;     wq->working_cnt++;                                                          
   12214: 88 2a 40 f9  	ldr	x8, [c20, #80]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   12218: 60 d2 c1 c2  	mov	c0, c19
;     wq->working_cnt++;                                                          
   1221c: 08 05 00 91  	add	x8, x8, #1              // =1
   12220: 88 2a 00 f9  	str	x8, [c20, #80]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   12224: 6f 04 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;     if (work != NULL) {                                                         
   12228: b7 00 00 b4  	cbz	x23, 0x1223c <tpool_worker+0xb8>
;       work->func(work->arg);                                                    
   1222c: e1 02 c0 42  	ldp	c1, c0, [c23, #0]
   12230: 20 30 c2 c2  	blr	c1
;   free(work);                                                                   
   12234: e0 d2 c1 c2  	mov	c0, c23
   12238: 76 04 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   1223c: 60 d2 c1 c2  	mov	c0, c19
   12240: 6c 04 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
;     wq->working_cnt--;                                                          
   12244: 88 2a 40 f9  	ldr	x8, [c20, #80]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   12248: 89 82 41 39  	ldrb	w9, [c20, #96]
;     wq->working_cnt--;                                                          
   1224c: 08 05 00 d1  	sub	x8, x8, #1              // =1
   12250: 88 2a 00 f9  	str	x8, [c20, #80]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   12254: c9 fa ff 35  	cbnz	w9, 0x121ac <tpool_worker+0x28>
   12258: a8 fa ff b5  	cbnz	x8, 0x121ac <tpool_worker+0x28>
   1225c: 80 02 40 c2  	ldr	c0, [c20, #0]
   12260: 60 fa ff b5  	cbnz	x0, 0x121ac <tpool_worker+0x28>
;       pthread_cond_signal(&(wq->working_cond));                                 
   12264: a0 d2 c1 c2  	mov	c0, c21
   12268: 6e 04 00 94  	bl	0x13420 <xbrtime_api_asm.s+0x13420>
   1226c: d0 ff ff 17  	b	0x121ac <tpool_worker+0x28>
;   wq->num_threads--;                                                            
   12270: 88 2e 40 f9  	ldr	x8, [c20, #88]
;   pthread_cond_signal(&(wq->working_cond));                                     
   12274: a0 d2 c1 c2  	mov	c0, c21
;   wq->num_threads--;                                                            
   12278: 08 05 00 d1  	sub	x8, x8, #1              // =1
   1227c: 88 2e 00 f9  	str	x8, [c20, #88]
;   pthread_cond_signal(&(wq->working_cond));                                     
   12280: 68 04 00 94  	bl	0x13420 <xbrtime_api_asm.s+0x13420>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12284: 60 d2 c1 c2  	mov	c0, c19
   12288: 56 04 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;   return NULL;                                                                  
   1228c: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   12290: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   12294: f7 0b 40 c2  	ldr	c23, [csp, #32]
   12298: e0 03 1f aa  	mov	x0, xzr
   1229c: fd fb c3 22  	ldp	c29, c30, [csp], #112
   122a0: c0 53 c2 c2  	ret	c30

00000000000122a4 <tpool_destroy>:
; {                                                                               
   122a4: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   122a8: f6 57 81 42  	stp	c22, c21, [csp, #32]
   122ac: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   122b0: fd d3 c1 c2  	mov	c29, csp
   122b4: 13 d0 c1 c2  	mov	c19, c0
;   if (wq == NULL)                                                               
   122b8: 73 05 00 b4  	cbz	x19, 0x12364 <tpool_destroy+0xc0>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   122bc: 74 82 00 02  	add	c20, c19, #32           // =32
   122c0: 80 d2 c1 c2  	mov	c0, c20
   122c4: 4b 04 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
;   work = wq->work_head;                                                         
   122c8: 60 02 40 c2  	ldr	c0, [c19, #0]
;   while (work != NULL) {                                                        
   122cc: a0 00 00 b4  	cbz	x0, 0x122e0 <tpool_destroy+0x3c>
;     work2 = work->next;                                                         
   122d0: 15 08 40 c2  	ldr	c21, [c0, #32]
;   free(work);                                                                   
   122d4: 4f 04 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
   122d8: a0 d2 c1 c2  	mov	c0, c21
;   while (work != NULL) {                                                        
   122dc: b5 ff ff b5  	cbnz	x21, 0x122d0 <tpool_destroy+0x2c>
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   122e0: 75 c2 00 02  	add	c21, c19, #48           // =48
   122e4: 28 00 80 52  	mov	w8, #1
   122e8: a0 d2 c1 c2  	mov	c0, c21
;   wq->stop = true;                                                              
   122ec: 68 82 01 39  	strb	w8, [c19, #96]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   122f0: 50 04 00 94  	bl	0x13430 <xbrtime_api_asm.s+0x13430>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   122f4: 80 d2 c1 c2  	mov	c0, c20
   122f8: 3a 04 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   122fc: 80 d2 c1 c2  	mov	c0, c20
   12300: 3c 04 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
   12304: 76 02 01 02  	add	c22, c19, #64           // =64
   12308: 06 00 00 14  	b	0x12320 <tpool_destroy+0x7c>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   1230c: 68 2a 40 f9  	ldr	x8, [c19, #80]
   12310: 08 01 00 b4  	cbz	x8, 0x12330 <tpool_destroy+0x8c>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   12314: c0 d2 c1 c2  	mov	c0, c22
   12318: 81 d2 c1 c2  	mov	c1, c20
   1231c: 39 04 00 94  	bl	0x13400 <xbrtime_api_asm.s+0x13400>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12320: 68 82 41 39  	ldrb	w8, [c19, #96]
   12324: 48 ff ff 34  	cbz	w8, 0x1230c <tpool_destroy+0x68>
;         (wq->stop && wq->num_threads != 0)) {                                   
   12328: 68 2e 40 f9  	ldr	x8, [c19, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   1232c: 48 ff ff b5  	cbnz	x8, 0x12314 <tpool_destroy+0x70>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12330: 80 d2 c1 c2  	mov	c0, c20
   12334: 2b 04 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;   pthread_mutex_destroy(&(wq->work_mutex));                                     
   12338: 80 d2 c1 c2  	mov	c0, c20
   1233c: 41 04 00 94  	bl	0x13440 <xbrtime_api_asm.s+0x13440>
;   pthread_cond_destroy(&(wq->work_cond));                                       
   12340: a0 d2 c1 c2  	mov	c0, c21
   12344: 43 04 00 94  	bl	0x13450 <xbrtime_api_asm.s+0x13450>
;   pthread_cond_destroy(&(wq->working_cond));                                    
   12348: c0 d2 c1 c2  	mov	c0, c22
   1234c: 41 04 00 94  	bl	0x13450 <xbrtime_api_asm.s+0x13450>
;   free(wq);                                                                     
   12350: 60 d2 c1 c2  	mov	c0, c19
   12354: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12358: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   1235c: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   12360: 2c 04 00 14  	b	0x13410 <xbrtime_api_asm.s+0x13410>
; }     
   12364: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12368: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   1236c: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   12370: c0 53 c2 c2  	ret	c30

0000000000012374 <tpool_wait>:
; {                                                                               
   12374: fd fb bd 62  	stp	c29, c30, [csp, #-80]!
   12378: f5 0b 00 c2  	str	c21, [csp, #32]
   1237c: f4 cf 81 42  	stp	c20, c19, [csp, #48]
   12380: fd d3 c1 c2  	mov	c29, csp
   12384: 13 d0 c1 c2  	mov	c19, c0
;   if (wq == NULL) // Will only return when there is no work.                    
   12388: 93 02 00 b4  	cbz	x19, 0x123d8 <tpool_wait+0x64>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   1238c: 74 82 00 02  	add	c20, c19, #32           // =32
   12390: 80 d2 c1 c2  	mov	c0, c20
   12394: 17 04 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
   12398: 75 02 01 02  	add	c21, c19, #64           // =64
   1239c: 06 00 00 14  	b	0x123b4 <tpool_wait+0x40>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   123a0: 68 2a 40 f9  	ldr	x8, [c19, #80]
   123a4: 08 01 00 b4  	cbz	x8, 0x123c4 <tpool_wait+0x50>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   123a8: a0 d2 c1 c2  	mov	c0, c21
   123ac: 81 d2 c1 c2  	mov	c1, c20
   123b0: 14 04 00 94  	bl	0x13400 <xbrtime_api_asm.s+0x13400>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   123b4: 68 82 41 39  	ldrb	w8, [c19, #96]
   123b8: 48 ff ff 34  	cbz	w8, 0x123a0 <tpool_wait+0x2c>
;         (wq->stop && wq->num_threads != 0)) {                                   
   123bc: 68 2e 40 f9  	ldr	x8, [c19, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   123c0: 48 ff ff b5  	cbnz	x8, 0x123a8 <tpool_wait+0x34>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   123c4: 80 d2 c1 c2  	mov	c0, c20
   123c8: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   123cc: f5 0b 40 c2  	ldr	c21, [csp, #32]
   123d0: fd fb c2 22  	ldp	c29, c30, [csp], #80
   123d4: 03 04 00 14  	b	0x133e0 <xbrtime_api_asm.s+0x133e0>
; } 
   123d8: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   123dc: f5 0b 40 c2  	ldr	c21, [csp, #32]
   123e0: fd fb c2 22  	ldp	c29, c30, [csp], #80
   123e4: c0 53 c2 c2  	ret	c30

00000000000123e8 <tpool_add_work>:
; {    
   123e8: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   123ec: f6 57 81 42  	stp	c22, c21, [csp, #32]
   123f0: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   123f4: fd d3 c1 c2  	mov	c29, csp
   123f8: 13 d0 c1 c2  	mov	c19, c0
   123fc: e0 03 1f 2a  	mov	w0, wzr
;   if (wq == NULL)                                                               
   12400: b3 03 00 b4  	cbz	x19, 0x12474 <tpool_add_work+0x8c>
   12404: 36 d0 c1 c2  	mov	c22, c1
;   if (wq == NULL)                                                               
   12408: 76 03 00 b4  	cbz	x22, 0x12474 <tpool_add_work+0x8c>
;   work       = malloc(sizeof(*work));                                           
   1240c: 00 06 80 52  	mov	w0, #48
   12410: 55 d0 c1 c2  	mov	c21, c2
   12414: db 03 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   12418: 14 d0 c1 c2  	mov	c20, c0
;   work->func = func;                                                            
   1241c: 16 54 80 42  	stp	c22, c21, [c0, #0]
;   work->next = NULL;                                                            
   12420: 1f 08 00 c2  	str	czr, [c0, #32]
;   if (work == NULL)                                                             
   12424: 54 01 00 b4  	cbz	x20, 0x1244c <tpool_add_work+0x64>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   12428: 75 82 00 02  	add	c21, c19, #32           // =32
   1242c: a0 d2 c1 c2  	mov	c0, c21
   12430: f0 03 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
;   if (wq->work_head == NULL) {                                                  
   12434: 60 02 40 c2  	ldr	c0, [c19, #0]
   12438: e0 00 00 b4  	cbz	x0, 0x12454 <tpool_add_work+0x6c>
;     wq->work_tail->next = work;                                                 
   1243c: 60 d2 c1 c2  	mov	c0, c19
   12440: 01 1c 40 a2  	ldr	c1, [c0, #16]!
   12444: 34 08 00 c2  	str	c20, [c1, #32]
   12448: 05 00 00 14  	b	0x1245c <tpool_add_work+0x74>
   1244c: e0 03 1f 2a  	mov	w0, wzr
   12450: 09 00 00 14  	b	0x12474 <tpool_add_work+0x8c>
;     wq->work_head = work;                                                       
   12454: 60 d2 c1 c2  	mov	c0, c19
   12458: 14 14 00 a2  	str	c20, [c0], #16
   1245c: 14 00 00 c2  	str	c20, [c0, #0]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   12460: 60 c2 00 02  	add	c0, c19, #48            // =48
   12464: f3 03 00 94  	bl	0x13430 <xbrtime_api_asm.s+0x13430>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12468: a0 d2 c1 c2  	mov	c0, c21
   1246c: dd 03 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
   12470: 20 00 80 52  	mov	w0, #1
; }                                                                               
   12474: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12478: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   1247c: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   12480: c0 53 c2 c2  	ret	c30

0000000000012484 <__xbrtime_ctor>:
; __attribute__((constructor)) void __xbrtime_ctor(){
   12484: ff c3 81 02  	sub	csp, csp, #112          // =112
   12488: fd fb 81 42  	stp	c29, c30, [csp, #48]
   1248c: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   12490: fd c3 00 02  	add	c29, csp, #48           // =48
;   printf("[M] Entered __xbrtime_ctor()\n");
   12494: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x54>
   12498: 00 c8 41 c2  	ldr	c0, [c0, #1824]
   1249c: f1 03 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   xb_barrier = malloc(sizeof(uint64_t)*2*10);	
   124a0: 00 14 80 52  	mov	w0, #160
   124a4: b7 03 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   124a8: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0x68>
   124ac: 21 c8 42 c2  	ldr	c1, [c1, #2848]
   124b0: 20 00 00 c2  	str	c0, [c1, #0]
;   char *str = getenv("NUM_OF_THREADS");
   124b4: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x74>
   124b8: 00 54 41 c2  	ldr	c0, [c0, #1360]
   124bc: ed 03 00 94  	bl	0x13470 <xbrtime_api_asm.s+0x13470>
;   if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
   124c0: 40 02 00 b4  	cbz	x0, 0x12508 <__xbrtime_ctor+0x84>
   124c4: ef 03 00 94  	bl	0x13480 <xbrtime_api_asm.s+0x13480>
   124c8: 08 04 00 51  	sub	w8, w0, #1              // =1
   124cc: 1f 3d 00 71  	cmp	w8, #15                 // =15
   124d0: e9 04 00 54  	b.ls	0x1256c <__xbrtime_ctor+0xe8>
;       fprintf(stderr, "\nNUM_OF_THREADS should be between %d and %d\n",
   124d4: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x94>
   124d8: 00 cc 42 c2  	ldr	c0, [c0, #2864]
   124dc: 08 02 80 52  	mov	w8, #16
   124e0: e1 3b d0 c2  	scbnds	c1, csp, #32            // =32
   124e4: e8 0b 00 f9  	str	x8, [csp, #16]
   124e8: 00 00 40 c2  	ldr	c0, [c0, #0]
   124ec: 29 70 c6 c2  	clrperm	c9, c1, wx
   124f0: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0xb0>
   124f4: 21 5c 41 c2  	ldr	c1, [c1, #1392]
   124f8: 2a 00 80 52  	mov	w10, #1
   124fc: ea 03 00 f9  	str	x10, [csp]
   12500: e4 03 00 94  	bl	0x13490 <xbrtime_api_asm.s+0x13490>
   12504: 09 00 00 14  	b	0x12528 <__xbrtime_ctor+0xa4>
;       fprintf(stderr, "\nNUM_OF_THREADS not set; set environment first!\n");
   12508: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0xc8>
   1250c: 00 cc 42 c2  	ldr	c0, [c0, #2864]
   12510: 01 06 80 52  	mov	w1, #48
   12514: 22 00 80 52  	mov	w2, #1
   12518: 03 00 40 c2  	ldr	c3, [c0, #0]
   1251c: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0xdc>
   12520: 00 58 41 c2  	ldr	c0, [c0, #1376]
   12524: df 03 00 94  	bl	0x134a0 <xbrtime_api_asm.s+0x134a0>
   12528: a0 33 80 02  	sub	c0, c29, #12            // =12
   1252c: 13 38 c5 c2  	scbnds	c19, c0, #10            // =10
;     char envValue[10] = "";
   12530: 7f 12 00 79  	strh	wzr, [c19, #8]
   12534: 7f 02 00 f9  	str	xzr, [c19]
;     sprintf(envValue, "%d", numOfThreads);
   12538: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0xf8>
   1253c: 21 60 41 c2  	ldr	c1, [c1, #1408]
   12540: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12544: 08 02 80 52  	mov	w8, #16
   12548: 09 70 c6 c2  	clrperm	c9, c0, wx
   1254c: 60 d2 c1 c2  	mov	c0, c19
   12550: e8 03 00 f9  	str	x8, [csp]
   12554: d7 03 00 94  	bl	0x134b0 <xbrtime_api_asm.s+0x134b0>
;     setenv(envName, envValue, 1);
   12558: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x118>
   1255c: 00 54 41 c2  	ldr	c0, [c0, #1360]
   12560: 22 00 80 52  	mov	w2, #1
   12564: 61 d2 c1 c2  	mov	c1, c19
   12568: d6 03 00 94  	bl	0x134c0 <xbrtime_api_asm.s+0x134c0>
;   numOfThreads = atoi(getenv("NUM_OF_THREADS"));
   1256c: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x12c>
   12570: 00 54 41 c2  	ldr	c0, [c0, #1360]
   12574: bf 03 00 94  	bl	0x13470 <xbrtime_api_asm.s+0x13470>
   12578: c2 03 00 94  	bl	0x13480 <xbrtime_api_asm.s+0x13480>
;   fprintf(stdout, "\nNumber of threads: %d\n", numOfThreads);
   1257c: 94 00 80 b0  	adrp	c20, 0x23000 <__xbrtime_ctor+0x13c>
   12580: 94 d2 42 c2  	ldr	c20, [c20, #2880]
;   numOfThreads = atoi(getenv("NUM_OF_THREADS"));
   12584: f3 03 00 2a  	mov	w19, w0
;   fprintf(stdout, "\nNumber of threads: %d\n", numOfThreads);
   12588: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   1258c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12590: 82 02 40 c2  	ldr	c2, [c20, #0]
   12594: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_dtor+0x4>
   12598: 21 64 41 c2  	ldr	c1, [c1, #1424]
   1259c: f3 03 00 f9  	str	x19, [csp]
   125a0: 40 d0 c1 c2  	mov	c0, c2
   125a4: bb 03 00 94  	bl	0x13490 <xbrtime_api_asm.s+0x13490>
;   fflush(stdout);
   125a8: 80 02 40 c2  	ldr	c0, [c20, #0]
   125ac: c9 03 00 94  	bl	0x134d0 <xbrtime_api_asm.s+0x134d0>
;   pool = tpool_create(numOfThreads);
   125b0: 60 7e 40 93  	sxtw	x0, w19
   125b4: c8 fe ff 97  	bl	0x120d4 <tpool_create>
   125b8: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_dtor+0x28>
   125bc: 21 d4 42 c2  	ldr	c1, [c1, #2896]
; }
   125c0: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   125c4: fd fb c1 42  	ldp	c29, c30, [csp, #48]
;   pool = tpool_create(numOfThreads);
   125c8: 20 00 00 c2  	str	c0, [c1, #0]
; }
   125cc: ff c3 01 02  	add	csp, csp, #112          // =112
   125d0: c0 53 c2 c2  	ret	c30

00000000000125d4 <__xbrtime_dtor>:
; __attribute__((destructor)) void __xbrtime_dtor(){
   125d4: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   125d8: f6 57 81 42  	stp	c22, c21, [csp, #32]
   125dc: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   125e0: fd d3 c1 c2  	mov	c29, csp
;   printf("[M] Entered __xbrtime_dtor()\n");
   125e4: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_dtor+0x54>
   125e8: 00 cc 41 c2  	ldr	c0, [c0, #1840]
   125ec: 9d 03 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   tpool_wait(pool);
   125f0: 95 00 80 b0  	adrp	c21, 0x23000 <__xbrtime_dtor+0x60>
   125f4: b5 d6 42 c2  	ldr	c21, [c21, #2896]
   125f8: b6 02 40 c2  	ldr	c22, [c21, #0]
;   if (wq == NULL) // Will only return when there is no work.                    
   125fc: 36 02 00 b4  	cbz	x22, 0x12640 <__xbrtime_dtor+0x6c>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   12600: d3 82 00 02  	add	c19, c22, #32           // =32
   12604: 60 d2 c1 c2  	mov	c0, c19
   12608: 7a 03 00 94  	bl	0x133f0 <xbrtime_api_asm.s+0x133f0>
   1260c: d4 02 01 02  	add	c20, c22, #64           // =64
   12610: 06 00 00 14  	b	0x12628 <__xbrtime_dtor+0x54>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12614: c8 2a 40 f9  	ldr	x8, [c22, #80]
   12618: 08 01 00 b4  	cbz	x8, 0x12638 <__xbrtime_dtor+0x64>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   1261c: 80 d2 c1 c2  	mov	c0, c20
   12620: 61 d2 c1 c2  	mov	c1, c19
   12624: 77 03 00 94  	bl	0x13400 <xbrtime_api_asm.s+0x13400>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12628: c8 82 41 39  	ldrb	w8, [c22, #96]
   1262c: 48 ff ff 34  	cbz	w8, 0x12614 <__xbrtime_dtor+0x40>
;         (wq->stop && wq->num_threads != 0)) {                                   
   12630: c8 2e 40 f9  	ldr	x8, [c22, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12634: 48 ff ff b5  	cbnz	x8, 0x1261c <__xbrtime_dtor+0x48>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12638: 60 d2 c1 c2  	mov	c0, c19
   1263c: 69 03 00 94  	bl	0x133e0 <xbrtime_api_asm.s+0x133e0>
;   tpool_destroy(pool); 
   12640: a0 02 40 c2  	ldr	c0, [c21, #0]
   12644: 18 ff ff 97  	bl	0x122a4 <tpool_destroy>
;   free ((void*)xb_barrier); 	
   12648: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_close+0x28>
   1264c: 00 c8 42 c2  	ldr	c0, [c0, #2848]
   12650: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12654: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   12658: 00 00 40 c2  	ldr	c0, [c0, #0]
   1265c: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   12660: 6c 03 00 14  	b	0x13410 <xbrtime_api_asm.s+0x13410>

0000000000012664 <xbrtime_close>:
; extern void xbrtime_close(){
   12664: fd fb bd 62  	stp	c29, c30, [csp, #-80]!
   12668: f5 0b 00 c2  	str	c21, [csp, #32]
   1266c: f4 cf 81 42  	stp	c20, c19, [csp, #48]
   12670: fd d3 c1 c2  	mov	c29, csp
;   if( __XBRTIME_CONFIG != NULL ){
   12674: 93 00 80 b0  	adrp	c19, 0x23000 <xbrtime_close+0x54>
   12678: 73 da 42 c2  	ldr	c19, [c19, #2912]
   1267c: 60 02 40 c2  	ldr	c0, [c19, #0]
   12680: 80 03 00 b4  	cbz	x0, 0x126f0 <xbrtime_close+0x8c>
;     __xbrtime_asm_fence();
   12684: 26 03 00 94  	bl	0x1331c <__xbrtime_asm_fence>
   12688: 14 01 80 52  	mov	w20, #8
   1268c: 15 00 81 52  	mov	w21, #2048
   12690: 04 00 00 14  	b	0x126a0 <xbrtime_close+0x3c>
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   12694: b5 06 00 f1  	subs	x21, x21, #1            // =1
   12698: 94 42 00 91  	add	x20, x20, #16           // =16
   1269c: 40 01 00 54  	b.eq	0x126c4 <xbrtime_close+0x60>
;       if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
   126a0: 60 02 40 c2  	ldr	c0, [c19, #0]
   126a4: 00 0c 40 c2  	ldr	c0, [c0, #48]
   126a8: 08 68 74 f8  	ldr	x8, [c0, x20]
   126ac: 48 ff ff b4  	cbz	x8, 0x12694 <xbrtime_close+0x30>
;         xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
   126b0: 00 60 b4 c2  	add	c0, c0, x20, uxtx
   126b4: 08 80 5f f8  	ldur	x8, [c0, #-8]
;   if( ptr == NULL ){
   126b8: e8 fe ff b4  	cbz	x8, 0x12694 <xbrtime_close+0x30>
;   __xbrtime_asm_quiet_fence();
   126bc: 1b 03 00 94  	bl	0x13328 <__xbrtime_asm_quiet_fence>
   126c0: f5 ff ff 17  	b	0x12694 <xbrtime_close+0x30>
;     if( __XBRTIME_CONFIG->_MAP != NULL ){
   126c4: 60 02 40 c2  	ldr	c0, [c19, #0]
   126c8: 00 10 40 c2  	ldr	c0, [c0, #64]
   126cc: 80 00 00 b4  	cbz	x0, 0x126dc <xbrtime_close+0x78>
;       free( __XBRTIME_CONFIG->_MAP );
   126d0: 50 03 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
;       __XBRTIME_CONFIG->_MAP = NULL;
   126d4: 60 02 40 c2  	ldr	c0, [c19, #0]
   126d8: 1f 10 00 c2  	str	czr, [c0, #64]
;     free( __XBRTIME_CONFIG );
   126dc: 60 02 40 c2  	ldr	c0, [c19, #0]
   126e0: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   126e4: f5 0b 40 c2  	ldr	c21, [csp, #32]
   126e8: fd fb c2 22  	ldp	c29, c30, [csp], #80
   126ec: 49 03 00 14  	b	0x13410 <xbrtime_api_asm.s+0x13410>
; }
   126f0: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   126f4: f5 0b 40 c2  	ldr	c21, [csp, #32]
   126f8: fd fb c2 22  	ldp	c29, c30, [csp], #80
   126fc: c0 53 c2 c2  	ret	c30

0000000000012700 <xbrtime_init>:
; extern int xbrtime_init(){
   12700: ff 83 81 02  	sub	csp, csp, #96           // =96
   12704: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   12708: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   1270c: fd 83 00 02  	add	c29, csp, #32           // =32
;   printf("[M] Entered xbrtime_init()\n");
   12710: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x54>
   12714: 00 d0 41 c2  	ldr	c0, [c0, #1856]
   12718: 52 03 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __XBRTIME_CONFIG = malloc( sizeof( XBRTIME_DATA ) );
   1271c: 00 0a 80 52  	mov	w0, #80
   12720: 18 03 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   12724: 94 00 80 b0  	adrp	c20, 0x23000 <xbrtime_init+0x68>
   12728: 94 da 42 c2  	ldr	c20, [c20, #2912]
   1272c: 13 d0 c1 c2  	mov	c19, c0
   12730: 80 02 00 c2  	str	c0, [c20, #0]
;   if( __XBRTIME_CONFIG == NULL ){
   12734: b3 0a 00 b4  	cbz	x19, 0x12888 <xbrtime_init+0x188>
;   __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
   12738: 00 00 90 52  	mov	w0, #32768
   1273c: 11 03 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   12740: 08 20 a0 52  	mov	w8, #16777216
;   __XBRTIME_CONFIG->_SENSE      = 0x00ull;    // __xbrtime_asm_get_sense();
   12744: 7f 7e 01 a9  	stp	xzr, xzr, [c19, #16]
;   __XBRTIME_CONFIG->_MEMSIZE    = 4096 * 4096;// __xbrtime_asm_get_memsize();
   12748: 68 02 00 f9  	str	x8, [c19]
;   __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; // malloc(sizeof(uint64_t)*2*10);
   1274c: 81 00 80 b0  	adrp	c1, 0x23000 <xbrtime_init+0x90>
   12750: 21 c8 42 c2  	ldr	c1, [c1, #2848]
   12754: 09 01 80 52  	mov	w9, #8
;   __XBRTIME_CONFIG->_ID         = 0;          // __xbrtime_asm_get_id();
   12758: 7f 26 01 29  	stp	wzr, w9, [c19, #8]
   1275c: 49 55 95 d2  	mov	x9, #43690
;   __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; // malloc(sizeof(uint64_t)*2*10);
   12760: 21 00 40 c2  	ldr	c1, [c1, #0]
   12764: 49 55 b5 f2  	movk	x9, #43690, lsl #16
   12768: e8 8f 40 b2  	mov	x8, #68719476735
   1276c: 49 01 c0 f2  	movk	x9, #10, lsl #32
;   __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
   12770: 61 02 81 42  	stp	c1, c0, [c19, #32]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12774: 28 00 00 f9  	str	x8, [c1]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12778: 29 28 00 f9  	str	x9, [c1, #80]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1277c: 28 04 00 f9  	str	x8, [c1, #8]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12780: 29 2c 00 f9  	str	x9, [c1, #88]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12784: 28 08 00 f9  	str	x8, [c1, #16]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12788: 29 30 00 f9  	str	x9, [c1, #96]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1278c: 28 0c 00 f9  	str	x8, [c1, #24]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12790: 29 34 00 f9  	str	x9, [c1, #104]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12794: 28 10 00 f9  	str	x8, [c1, #32]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12798: 29 38 00 f9  	str	x9, [c1, #112]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1279c: 28 14 00 f9  	str	x8, [c1, #40]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127a0: 29 3c 00 f9  	str	x9, [c1, #120]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127a4: 28 18 00 f9  	str	x8, [c1, #48]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127a8: 29 40 00 f9  	str	x9, [c1, #128]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127ac: 28 1c 00 f9  	str	x8, [c1, #56]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127b0: 29 44 00 f9  	str	x9, [c1, #136]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127b4: 28 20 00 f9  	str	x8, [c1, #64]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127b8: 29 48 00 f9  	str	x9, [c1, #144]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127bc: 28 24 00 f9  	str	x8, [c1, #72]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127c0: 29 4c 00 f9  	str	x9, [c1, #152]
; 	printf("PE:%d----BARRIER[O] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[0]);
   127c4: 28 00 40 f9  	ldr	x8, [c1]
   127c8: e0 3b d0 c2  	scbnds	c0, csp, #32            // =32
   127cc: 09 70 c6 c2  	clrperm	c9, c0, wx
   127d0: e8 0b 00 f9  	str	x8, [csp, #16]
   127d4: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x118>
   127d8: 00 68 41 c2  	ldr	c0, [c0, #1440]
   127dc: ff 03 00 f9  	str	xzr, [csp]
   127e0: 40 03 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[1]);
   127e4: 80 02 40 c2  	ldr	c0, [c20, #0]
   127e8: 01 08 40 c2  	ldr	c1, [c0, #32]
   127ec: 28 04 40 f9  	ldr	x8, [c1, #8]
   127f0: 0a 08 40 b9  	ldr	w10, [c0, #8]
   127f4: e0 3b d0 c2  	scbnds	c0, csp, #32            // =32
   127f8: 09 70 c6 c2  	clrperm	c9, c0, wx
   127fc: e8 0b 00 f9  	str	x8, [csp, #16]
   12800: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x144>
   12804: 00 6c 41 c2  	ldr	c0, [c0, #1456]
   12808: ea 03 00 f9  	str	x10, [csp]
   1280c: 35 03 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   if( __XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE ){
   12810: 93 02 40 c2  	ldr	c19, [c20, #0]
   12814: 68 0e 80 b9  	ldrsw	x8, [c19, #12]
   12818: 1f 05 10 71  	cmp	w8, #1025               // =1025
   1281c: 2a 03 00 54  	b.ge	0x12880 <xbrtime_init+0x180>
;   __XBRTIME_CONFIG->_MAP = malloc( sizeof( XBRTIME_PE_MAP ) *
   12820: 00 ed 7c d3  	lsl	x0, x8, #4
   12824: d7 02 00 94  	bl	0x13380 <xbrtime_api_asm.s+0x13380>
   12828: 60 12 00 c2  	str	c0, [c19, #64]
;   if( __XBRTIME_CONFIG->_MAP == NULL ){
   1282c: a0 02 00 b4  	cbz	x0, 0x12880 <xbrtime_init+0x180>
;   printf("[M] init the pe mapping block\n");
   12830: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x174>
   12834: 00 d4 41 c2  	ldr	c0, [c0, #1872]
   12838: 0a 03 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
   1283c: 80 02 40 c2  	ldr	c0, [c20, #0]
;     __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
   12840: 02 00 90 52  	mov	w2, #32768
   12844: e1 03 1f 2a  	mov	w1, wzr
   12848: 00 0c 40 c2  	ldr	c0, [c0, #48]
   1284c: 29 03 00 94  	bl	0x134f0 <xbrtime_api_asm.s+0x134f0>
;   printf("[M] init the memory allocation slots\n");
   12850: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x194>
   12854: 00 d8 41 c2  	ldr	c0, [c0, #1888]
   12858: 02 03 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
   1285c: 80 02 40 c2  	ldr	c0, [c20, #0]
   12860: 08 0c 40 b9  	ldr	w8, [c0, #12]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12864: 1f 05 00 71  	cmp	w8, #1                  // =1
   12868: 2b 04 00 54  	b.lt	0x128ec <xbrtime_init+0x1ec>
   1286c: 00 10 40 c2  	ldr	c0, [c0, #64]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12870: 1f 05 00 71  	cmp	w8, #1                  // =1
   12874: 41 01 00 54  	b.ne	0x1289c <xbrtime_init+0x19c>
   12878: e9 03 1f aa  	mov	x9, xzr
   1287c: 14 00 00 14  	b	0x128cc <xbrtime_init+0x1cc>
   12880: 60 d2 c1 c2  	mov	c0, c19
   12884: e3 02 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
   12888: 00 00 80 12  	mov	w0, #-1
; }
   1288c: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12890: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   12894: ff 83 01 02  	add	csp, csp, #96           // =96
   12898: c0 53 c2 c2  	ret	c30
   1289c: ea 03 1f aa  	mov	x10, xzr
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128a0: 09 79 7f 92  	and	x9, x8, #0xfffffffe
   128a4: 01 50 00 02  	add	c1, c0, #20             // =20
;     __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
   128a8: 4b 05 00 11  	add	w11, w10, #1            // =1
   128ac: 2a ac 3d 29  	stp	w10, w11, [c1, #-20]
   128b0: 4a 09 00 91  	add	x10, x10, #2            // =2
   128b4: 2b a8 3f 29  	stp	w11, w10, [c1, #-4]
   128b8: 3f 01 0a eb  	cmp	x9, x10
   128bc: 21 80 00 02  	add	c1, c1, #32             // =32
   128c0: 41 ff ff 54  	b.ne	0x128a8 <xbrtime_init+0x1a8>
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128c4: 3f 01 08 eb  	cmp	x9, x8
   128c8: 20 01 00 54  	b.eq	0x128ec <xbrtime_init+0x1ec>
   128cc: 8a 00 80 52  	mov	w10, #4
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128d0: 2a 7d 7c b3  	bfi	x10, x9, #4, #32
   128d4: 00 60 aa c2  	add	c0, c0, x10, uxtx
;     __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
   128d8: 09 c0 1f b8  	stur	w9, [c0, #-4]
;     __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
   128dc: 29 05 00 91  	add	x9, x9, #1              // =1
   128e0: 09 04 01 b8  	str	w9, [c0], #16
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128e4: 1f 01 09 eb  	cmp	x8, x9
   128e8: 81 ff ff 54  	b.ne	0x128d8 <xbrtime_init+0x1d8>
;   printf("[M] init the PE mapping structure\n");
   128ec: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_num_pes+0x10>
   128f0: 00 dc 41 c2  	ldr	c0, [c0, #1904]
   128f4: db 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
   128f8: e0 03 1f 2a  	mov	w0, wzr
   128fc: e4 ff ff 17  	b	0x1288c <xbrtime_init+0x18c>

0000000000012900 <xbrtime_mype>:
;   if( __XBRTIME_CONFIG == NULL ){
   12900: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x4>
   12904: 00 d8 42 c2  	ldr	c0, [c0, #2912]
   12908: 00 00 40 c2  	ldr	c0, [c0, #0]
   1290c: 60 00 00 b4  	cbz	x0, 0x12918 <xbrtime_mype+0x18>
;   return __XBRTIME_CONFIG->_ID;
   12910: 00 08 40 b9  	ldr	w0, [c0, #8]
; }
   12914: c0 53 c2 c2  	ret	c30
   12918: 00 00 80 12  	mov	w0, #-1
; }
   1291c: c0 53 c2 c2  	ret	c30

0000000000012920 <xbrtime_num_pes>:
;   if( __XBRTIME_CONFIG == NULL ){
   12920: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x24>
   12924: 00 d8 42 c2  	ldr	c0, [c0, #2912]
   12928: 00 00 40 c2  	ldr	c0, [c0, #0]
   1292c: 60 00 00 b4  	cbz	x0, 0x12938 <xbrtime_num_pes+0x18>
;   return __XBRTIME_CONFIG->_NPES;
   12930: 00 0c 40 b9  	ldr	w0, [c0, #12]
; }
   12934: c0 53 c2 c2  	ret	c30
   12938: 00 00 80 12  	mov	w0, #-1
; }
   1293c: c0 53 c2 c2  	ret	c30

0000000000012940 <xbrtime_ulonglong_get>:
;                            size_t nelems, int stride, int pe){
   12940: ff c3 82 02  	sub	csp, csp, #176          // =176
   12944: fd fb 82 42  	stp	c29, c30, [csp, #80]
   12948: f6 d7 83 42  	stp	c22, c21, [csp, #112]
   1294c: f4 cf 84 42  	stp	c20, c19, [csp, #144]
   12950: fd 43 01 02  	add	c29, csp, #80           // =80
   12954: 15 d0 c1 c2  	mov	c21, c0
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   12958: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x5c>
   1295c: 00 e0 41 c2  	ldr	c0, [c0, #1920]
   12960: f4 03 03 2a  	mov	w20, w3
   12964: f3 03 02 aa  	mov	x19, x2
   12968: 36 d0 c1 c2  	mov	c22, c1
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   1296c: bd 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   printf("\n========================\n");
   12970: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x74>
   12974: 00 e4 41 c2  	ldr	c0, [c0, #1936]
   12978: ba 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   1297c: ac 92 c0 c2  	gctag	x12, c21
   12980: 9f 01 00 f1  	cmp	x12, #0                 // =0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12984: a9 32 c0 c2  	gclen	x9, c21
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   12988: aa 72 c0 c2  	gcoff	x10, c21
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   1298c: ab d2 c0 c2  	gcperm	x11, c21
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12990: ec 07 9f 1a  	cset	w12, ne
;   printf("  DEST:\n"
   12994: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12998: ec 23 00 f9  	str	x12, [csp, #64]
   1299c: eb 1b 00 f9  	str	x11, [csp, #48]
   129a0: ea 13 00 f9  	str	x10, [csp, #32]
   129a4: e9 0b 00 f9  	str	x9, [csp, #16]
   129a8: 09 70 c6 c2  	clrperm	c9, c0, wx
   129ac: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0xb0>
   129b0: 00 70 41 c2  	ldr	c0, [c0, #1472]
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   129b4: a8 12 c0 c2  	gcbase	x8, c21
;   printf("  DEST:\n"
   129b8: e8 03 00 f9  	str	x8, [csp]
   129bc: c9 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("========================\n");
   129c0: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0xc4>
   129c4: 00 e8 41 c2  	ldr	c0, [c0, #1952]
   129c8: a6 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   129cc: cc 92 c0 c2  	gctag	x12, c22
   129d0: 9f 01 00 f1  	cmp	x12, #0                 // =0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   129d4: c9 32 c0 c2  	gclen	x9, c22
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   129d8: ca 72 c0 c2  	gcoff	x10, c22
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   129dc: cb d2 c0 c2  	gcperm	x11, c22
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   129e0: ec 07 9f 1a  	cset	w12, ne
;   printf("  SRC:\n"
   129e4: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   129e8: ec 23 00 f9  	str	x12, [csp, #64]
   129ec: eb 1b 00 f9  	str	x11, [csp, #48]
   129f0: ea 13 00 f9  	str	x10, [csp, #32]
   129f4: e9 0b 00 f9  	str	x9, [csp, #16]
   129f8: 09 70 c6 c2  	clrperm	c9, c0, wx
   129fc: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x100>
   12a00: 00 74 41 c2  	ldr	c0, [c0, #1488]
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12a04: c8 12 c0 c2  	gcbase	x8, c22
;   printf("  SRC:\n"
   12a08: e8 03 00 f9  	str	x8, [csp]
   12a0c: b5 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;     printf("========================\n\n");
   12a10: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x114>
   12a14: 00 ec 41 c2  	ldr	c0, [c0, #1968]
   12a18: 92 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   if(nelems == 0){
   12a1c: d3 01 00 b4  	cbz	x19, 0x12a54 <xbrtime_ulonglong_get+0x114>
;     __xbrtime_get_u8_seq((uint64_t)src,//__xbrtime_ltor((uint64_t)(src),pe),
   12a20: c0 52 c0 c2  	gcvalue	x0, c22
;                          (uint64_t)(dest),
   12a24: a1 52 c0 c2  	gcvalue	x1, c21
;                          (uint32_t)(stride*sizeof(unsigned long long)));
   12a28: 83 72 1d 53  	lsl	w3, w20, #3
;     __xbrtime_get_u8_seq((uint64_t)src,//__xbrtime_ltor((uint64_t)(src),pe),
   12a2c: e2 03 13 2a  	mov	w2, w19
   12a30: 19 02 00 94  	bl	0x13294 <__xbrtime_get_u8_seq>
;   __xbrtime_asm_fence();
   12a34: 3a 02 00 94  	bl	0x1331c <__xbrtime_asm_fence>
;   printf("[M] Exiting xbrtime_ulonglong_get()\n");
   12a38: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x14>
   12a3c: 00 f0 41 c2  	ldr	c0, [c0, #1984]
   12a40: f4 cf c4 42  	ldp	c20, c19, [csp, #144]
   12a44: f6 d7 c3 42  	ldp	c22, c21, [csp, #112]
   12a48: fd fb c2 42  	ldp	c29, c30, [csp, #80]
   12a4c: ff c3 02 02  	add	csp, csp, #176          // =176
   12a50: 84 02 00 14  	b	0x13460 <xbrtime_api_asm.s+0x13460>
; }
   12a54: f4 cf c4 42  	ldp	c20, c19, [csp, #144]
   12a58: f6 d7 c3 42  	ldp	c22, c21, [csp, #112]
   12a5c: fd fb c2 42  	ldp	c29, c30, [csp, #80]
   12a60: ff c3 02 02  	add	csp, csp, #176          // =176
   12a64: c0 53 c2 c2  	ret	c30

0000000000012a68 <xbrtime_barrier>:
; extern void xbrtime_barrier(){
   12a68: ff c3 80 02  	sub	csp, csp, #48           // =48
   12a6c: fd fb 80 42  	stp	c29, c30, [csp, #16]
   12a70: fd 43 00 02  	add	c29, csp, #16           // =16
;   printf("[M] Entered xbrtime_barrier()\n");
   12a74: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x50>
   12a78: 00 f4 41 c2  	ldr	c0, [c0, #2000]
   12a7c: 79 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12a80: 27 02 00 94  	bl	0x1331c <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12a84: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x60>
   12a88: 00 d8 42 c2  	ldr	c0, [c0, #2912]
   12a8c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12a90: 60 00 00 b4  	cbz	x0, 0x12a9c <xbrtime_barrier+0x34>
;   return __XBRTIME_CONFIG->_ID;
   12a94: 08 08 40 b9  	ldr	w8, [c0, #8]
   12a98: 02 00 00 14  	b	0x12aa0 <xbrtime_barrier+0x38>
   12a9c: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12aa0: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12aa4: 09 70 c6 c2  	clrperm	c9, c0, wx
   12aa8: 80 00 80 b0  	adrp	c0, 0x23000 <mysecond+0x20>
   12aac: 00 78 41 c2  	ldr	c0, [c0, #1504]
   12ab0: e8 03 00 f9  	str	x8, [csp]
   12ab4: 8b 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12ab8: 80 00 80 b0  	adrp	c0, 0x23000 <mysecond+0x30>
   12abc: 00 f8 41 c2  	ldr	c0, [c0, #2016]
   12ac0: fd fb c0 42  	ldp	c29, c30, [csp, #16]
   12ac4: ff c3 00 02  	add	csp, csp, #48           // =48
   12ac8: 66 02 00 14  	b	0x13460 <xbrtime_api_asm.s+0x13460>

0000000000012acc <mysecond>:
; double mysecond() {
   12acc: ff 03 81 02  	sub	csp, csp, #64           // =64
   12ad0: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   12ad4: fd 83 00 02  	add	c29, csp, #32           // =32
   12ad8: e0 43 00 02  	add	c0, csp, #16            // =16
   12adc: e1 23 00 02  	add	c1, csp, #8             // =8
   12ae0: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12ae4: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   12ae8: 86 02 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12aec: e0 07 41 6d  	ldp	d0, d1, [csp, #16]
   12af0: 60 ff ff f0  	adrp	c0, 0x1000 <xbrtime_barrier+0x44>
   12af4: 02 08 45 fd  	ldr	d2, [c0, #2576]
   12af8: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   12afc: 21 d8 61 5e  	scvtf	d1, d1
   12b00: 00 d8 61 5e  	scvtf	d0, d0
   12b04: 21 08 62 1e  	fmul	d1, d1, d2
   12b08: 20 28 60 1e  	fadd	d0, d1, d0
   12b0c: ff 03 01 02  	add	csp, csp, #64           // =64
   12b10: c0 53 c2 c2  	ret	c30

0000000000012b14 <PRINT>:
; void PRINT(double local, double remote, double t_init, double t_mem){
   12b14: ff 03 82 02  	sub	csp, csp, #128          // =128
   12b18: eb 2b 01 6d  	stp	d11, d10, [csp, #16]
   12b1c: e9 23 02 6d  	stp	d9, d8, [csp, #32]
   12b20: fd fb 81 42  	stp	c29, c30, [csp, #48]
   12b24: f5 17 00 c2  	str	c21, [csp, #80]
   12b28: f4 4f 83 42  	stp	c20, c19, [csp, #96]
   12b2c: fd c3 00 02  	add	c29, csp, #48           // =48
; 	printf("Time.init       = %f sec\n", t_init);	
   12b30: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12b34: 09 70 c6 c2  	clrperm	c9, c0, wx
   12b38: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0x68>
   12b3c: 00 7c 41 c2  	ldr	c0, [c0, #1520]
   12b40: 28 0b e8 d2  	mov	x8, #4636737291354636288
   12b44: 0a 01 67 9e  	fmov	d10, x8
; 	percent = (int64_t)(100*remote/ne);
   12b48: 2b 08 6a 1e  	fmul	d11, d1, d10
   12b4c: 68 1c a3 4e  	mov	v8.16b, v3.16b
   12b50: 09 1c a0 4e  	mov	v9.16b, v0.16b
; 	percent = (int64_t)(100*remote/ne);
   12b54: 74 01 78 9e  	fcvtzs	x20, d11
; 	printf("Time.init       = %f sec\n", t_init);	
   12b58: e2 03 00 fd  	str	d2, [csp]
   12b5c: 61 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("Time.transfer   = %f sec\n", t_mem);
   12b60: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12b64: 09 70 c6 c2  	clrperm	c9, c0, wx
   12b68: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0x98>
   12b6c: 00 80 41 c2  	ldr	c0, [c0, #1536]
   12b70: e8 03 00 fd  	str	d8, [csp]
   12b74: 5b 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("Remote Access   = " BRED "%.3f%%  " RESET, 100*remote/ne);
   12b78: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12b7c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12b80: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xb0>
   12b84: 00 84 41 c2  	ldr	c0, [c0, #1552]
   12b88: eb 03 00 fd  	str	d11, [csp]
   12b8c: 55 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("\n");
   12b90: 40 01 80 52  	mov	w0, #10
   12b94: 5f 02 00 94  	bl	0x13510 <xbrtime_api_asm.s+0x13510>
; 	printf("Local  Access   = " BGRN "%.3f%%  " RESET, 100*local/ne);
   12b98: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12b9c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12ba0: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xd0>
   12ba4: 00 88 41 c2  	ldr	c0, [c0, #1568]
   12ba8: 20 09 6a 1e  	fmul	d0, d9, d10
   12bac: e0 03 00 fd  	str	d0, [csp]
   12bb0: 4c 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("\n");
   12bb4: 40 01 80 52  	mov	w0, #10
   12bb8: 56 02 00 94  	bl	0x13510 <xbrtime_api_asm.s+0x13510>
; 	printf("------------------------------------------\n");
   12bbc: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xec>
   12bc0: 00 fc 41 c2  	ldr	c0, [c0, #2032]
   12bc4: 27 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 	printf("Request Distribution:  [");
   12bc8: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xf8>
   12bcc: 00 8c 41 c2  	ldr	c0, [c0, #1584]
   12bd0: e9 03 1f aa  	mov	x9, xzr
   12bd4: 43 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	for(i = 0; i < percent; i++)
   12bd8: 9f 06 00 f1  	cmp	x20, #1                 // =1
   12bdc: 6b 01 00 54  	b.lt	0x12c08 <PRINT+0xf4>
   12be0: 93 00 80 b0  	adrp	c19, 0x23000 <PRINT+0x110>
   12be4: 73 92 41 c2  	ldr	c19, [c19, #1600]
   12be8: f5 03 14 aa  	mov	x21, x20
; 		printf(BRED "|" RESET);
   12bec: 60 d2 c1 c2  	mov	c0, c19
   12bf0: e9 03 1f aa  	mov	x9, xzr
   12bf4: 3b 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	for(i = 0; i < percent; i++)
   12bf8: b5 06 00 f1  	subs	x21, x21, #1            // =1
   12bfc: 81 ff ff 54  	b.ne	0x12bec <PRINT+0xd8>
; 	for(i = 0; i < 100 - percent; i++)
   12c00: 9f 8e 01 f1  	cmp	x20, #99                // =99
   12c04: 8c 01 00 54  	b.gt	0x12c34 <PRINT+0x120>
   12c08: 93 00 80 b0  	adrp	c19, 0x23000 <PRINT+0x138>
   12c0c: 88 0c 80 52  	mov	w8, #100
   12c10: 73 96 41 c2  	ldr	c19, [c19, #1616]
; 	for(i = 0; i < 100 - percent; i++)
   12c14: 08 01 14 cb  	sub	x8, x8, x20
   12c18: 1f 05 00 f1  	cmp	x8, #1                  // =1
   12c1c: 14 c5 9f 9a  	csinc	x20, x8, xzr, gt
; 		printf(BGRN "|" RESET);
   12c20: 60 d2 c1 c2  	mov	c0, c19
   12c24: e9 03 1f aa  	mov	x9, xzr
   12c28: 2e 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	for(i = 0; i < 100 - percent; i++)
   12c2c: 94 06 00 f1  	subs	x20, x20, #1            // =1
   12c30: 81 ff ff 54  	b.ne	0x12c20 <PRINT+0x10c>
; 	printf("]\n");
   12c34: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x14>
   12c38: 00 00 42 c2  	ldr	c0, [c0, #2048]
   12c3c: 09 02 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 	printf("------------------------------------------\n");
   12c40: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x20>
   12c44: 00 04 42 c2  	ldr	c0, [c0, #2064]
   12c48: f4 4f c3 42  	ldp	c20, c19, [csp, #96]
   12c4c: f5 17 40 c2  	ldr	c21, [csp, #80]
   12c50: fd fb c1 42  	ldp	c29, c30, [csp, #48]
   12c54: e9 23 42 6d  	ldp	d9, d8, [csp, #32]
   12c58: eb 2b 41 6d  	ldp	d11, d10, [csp, #16]
   12c5c: ff 03 02 02  	add	csp, csp, #128          // =128
   12c60: 00 02 00 14  	b	0x13460 <xbrtime_api_asm.s+0x13460>

0000000000012c64 <main>:
; int main( int argc, char **argv ){
   12c64: ff 83 82 02  	sub	csp, csp, #160          // =160
   12c68: e9 23 03 6d  	stp	d9, d8, [csp, #48]
   12c6c: fd 7b 82 42  	stp	c29, c30, [csp, #64]
   12c70: f6 57 83 42  	stp	c22, c21, [csp, #96]
   12c74: f4 4f 84 42  	stp	c20, c19, [csp, #128]
   12c78: fd 03 01 02  	add	c29, csp, #64           // =64
; 	printf("[M]"GRN " Entered Main matmul...\n"RESET);
   12c7c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x5c>
   12c80: 00 98 41 c2  	ldr	c0, [c0, #1632]
   12c84: e9 03 1f aa  	mov	x9, xzr
   12c88: 16 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("[M]"GRN " Passed vars\n"RESET);
   12c8c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x6c>
   12c90: 00 9c 41 c2  	ldr	c0, [c0, #1648]
   12c94: e9 03 1f aa  	mov	x9, xzr
   12c98: 12 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("[M]"GRN " Passed malloc\n"RESET);
   12c9c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x7c>
   12ca0: 00 a0 41 c2  	ldr	c0, [c0, #1664]
   12ca4: e9 03 1f aa  	mov	x9, xzr
   12ca8: 0e 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   rtn = xbrtime_init();
   12cac: 95 fe ff 97  	bl	0x12700 <xbrtime_init>
   12cb0: f3 03 00 2a  	mov	w19, w0
; 	printf("[M]"GRN " Passed xbrtime_init()\n"RESET); 
   12cb4: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x94>
   12cb8: 00 a4 41 c2  	ldr	c0, [c0, #1680]
   12cbc: e9 03 1f aa  	mov	x9, xzr
   12cc0: 08 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   __xbrtime_asm_quiet_fence();
   12cc4: 99 01 00 94  	bl	0x13328 <__xbrtime_asm_quiet_fence>
; 	printf("[M]"GRN " Passed xbrtime_malloc()\n"RESET); 
   12cc8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xa8>
   12ccc: 00 a8 41 c2  	ldr	c0, [c0, #1696]
   12cd0: e9 03 1f aa  	mov	x9, xzr
   12cd4: 03 02 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 	printf("[M]"GRN " Passed shared[] & private[] init\n"RESET);
   12cd8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xb8>
   12cdc: 00 ac 41 c2  	ldr	c0, [c0, #1712]
   12ce0: e9 03 1f aa  	mov	x9, xzr
   12ce4: ff 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("[M] Entered xbrtime_barrier()\n");
   12ce8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xc8>
   12cec: 00 f4 41 c2  	ldr	c0, [c0, #2000]
   12cf0: dc 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12cf4: 8a 01 00 94  	bl	0x1331c <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12cf8: 96 00 80 b0  	adrp	c22, 0x23000 <main+0xd8>
   12cfc: d6 da 42 c2  	ldr	c22, [c22, #2912]
   12d00: c0 02 40 c2  	ldr	c0, [c22, #0]
   12d04: 60 00 00 b4  	cbz	x0, 0x12d10 <main+0xac>
;   return __XBRTIME_CONFIG->_ID;
   12d08: 08 08 40 b9  	ldr	w8, [c0, #8]
   12d0c: 02 00 00 14  	b	0x12d14 <main+0xb0>
   12d10: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12d14: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12d18: 09 70 c6 c2  	clrperm	c9, c0, wx
   12d1c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xfc>
   12d20: 00 78 41 c2  	ldr	c0, [c0, #1504]
   12d24: e8 03 00 f9  	str	x8, [csp]
   12d28: ee 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12d2c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x10c>
   12d30: 00 f8 41 c2  	ldr	c0, [c0, #2016]
   12d34: cb 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   if( __XBRTIME_CONFIG == NULL ){
   12d38: c0 02 40 c2  	ldr	c0, [c22, #0]
   12d3c: 40 04 00 b4  	cbz	x0, 0x12dc4 <main+0x160>
;   return __XBRTIME_CONFIG->_ID;
   12d40: 08 08 40 b9  	ldr	w8, [c0, #8]
   12d44: 08 e4 00 2f  	movi	d8, #0000000000000000
; 	if(xbrtime_mype() == 0){
   12d48: e8 06 00 35  	cbnz	w8, 0x12e24 <main+0x1c0>
; 		printf("========================\n");
   12d4c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x12c>
   12d50: 00 1c 42 c2  	ldr	c0, [c0, #2160]
   12d54: c3 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		printf(" xBGAS Matmul Benchmark\n");
   12d58: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x138>
   12d5c: 00 20 42 c2  	ldr	c0, [c0, #2176]
   12d60: c0 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		printf("========================\n");
   12d64: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x144>
   12d68: 00 24 42 c2  	ldr	c0, [c0, #2192]
   12d6c: bd 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		printf(" Data type: uint64_t\n");
   12d70: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x150>
   12d74: 00 28 42 c2  	ldr	c0, [c0, #2208]
   12d78: ba 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		printf(" Element #: %lu\n", ne);
   12d7c: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12d80: 09 70 c6 c2  	clrperm	c9, c0, wx
   12d84: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x164>
   12d88: 00 b0 41 c2  	ldr	c0, [c0, #1728]
   12d8c: 08 01 80 52  	mov	w8, #8
   12d90: e8 03 00 f9  	str	x8, [csp]
   12d94: d3 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   	printf(" Data size: %lu bytes\n",  (int)(sz) * (int)(ne) );
   12d98: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12d9c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12da0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x180>
   12da4: 00 b4 41 c2  	ldr	c0, [c0, #1744]
   12da8: 08 08 80 52  	mov	w8, #64
   12dac: e8 03 00 f9  	str	x8, [csp]
   12db0: cc 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   if( __XBRTIME_CONFIG == NULL ){
   12db4: c0 02 40 c2  	ldr	c0, [c22, #0]
   12db8: a0 00 00 b4  	cbz	x0, 0x12dcc <main+0x168>
;   return __XBRTIME_CONFIG->_NPES;
   12dbc: 08 0c 40 b9  	ldr	w8, [c0, #12]
   12dc0: 04 00 00 14  	b	0x12dd0 <main+0x16c>
   12dc4: 08 e4 00 2f  	movi	d8, #0000000000000000
   12dc8: 24 00 00 14  	b	0x12e58 <main+0x1f4>
   12dcc: 08 00 80 12  	mov	w8, #-1
; 		printf(" PE #     : %d\n", xbrtime_num_pes());
   12dd0: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12dd4: 09 70 c6 c2  	clrperm	c9, c0, wx
   12dd8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1b8>
   12ddc: 00 b8 41 c2  	ldr	c0, [c0, #1760]
   12de0: e8 03 00 f9  	str	x8, [csp]
   12de4: bf 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;     printf("========================\n");
   12de8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1c8>
   12dec: 00 2c 42 c2  	ldr	c0, [c0, #2224]
   12df0: 9c 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
   12df4: e0 83 00 02  	add	c0, csp, #32            // =32
   12df8: e1 63 00 02  	add	c1, csp, #24            // =24
   12dfc: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12e00: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   12e04: bf 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12e08: e0 07 42 6d  	ldp	d0, d1, [csp, #32]
   12e0c: 60 ff ff f0  	adrp	c0, 0x1000 <main+0x164>
   12e10: 02 08 45 fd  	ldr	d2, [c0, #2576]
   12e14: 21 d8 61 5e  	scvtf	d1, d1
   12e18: 00 d8 61 5e  	scvtf	d0, d0
   12e1c: 21 08 62 1e  	fmul	d1, d1, d2
   12e20: 28 28 60 1e  	fadd	d8, d1, d0
;   if( __XBRTIME_CONFIG == NULL ){
   12e24: c0 02 40 c2  	ldr	c0, [c22, #0]
   12e28: 80 01 00 b4  	cbz	x0, 0x12e58 <main+0x1f4>
;   return __XBRTIME_CONFIG->_ID;
   12e2c: 08 08 40 b9  	ldr	w8, [c0, #8]
;   if(xbrtime_mype() == 0){
   12e30: 48 01 00 35  	cbnz	w8, 0x12e58 <main+0x1f4>
;     xbrtime_ulonglong_get(x,y,1,1,1);
   12e34: e1 03 1f aa  	mov	x1, xzr
   12e38: 20 2c 00 02  	add	c0, c1, #11             // =11
   12e3c: 21 58 00 02  	add	c1, c1, #22             // =22
   12e40: 22 00 80 52  	mov	w2, #1
   12e44: 23 00 80 52  	mov	w3, #1
   12e48: be fe ff 97  	bl	0x12940 <xbrtime_ulonglong_get>
;     printf("  Completed\n");
   12e4c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x22c>
   12e50: 00 18 42 c2  	ldr	c0, [c0, #2144]
   12e54: 83 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   printf("[M] Entered xbrtime_barrier()\n");
   12e58: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x238>
   12e5c: 00 f4 41 c2  	ldr	c0, [c0, #2000]
   12e60: 80 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12e64: 2e 01 00 94  	bl	0x1331c <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12e68: c0 02 40 c2  	ldr	c0, [c22, #0]
   12e6c: 60 00 00 b4  	cbz	x0, 0x12e78 <main+0x214>
;   return __XBRTIME_CONFIG->_ID;
   12e70: 08 08 40 b9  	ldr	w8, [c0, #8]
   12e74: 02 00 00 14  	b	0x12e7c <main+0x218>
   12e78: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12e7c: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12e80: 09 70 c6 c2  	clrperm	c9, c0, wx
   12e84: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x264>
   12e88: 00 78 41 c2  	ldr	c0, [c0, #1504]
   12e8c: e8 03 00 f9  	str	x8, [csp]
   12e90: 94 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12e94: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x274>
   12e98: 00 f8 41 c2  	ldr	c0, [c0, #2016]
   12e9c: 71 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   if( __XBRTIME_CONFIG == NULL ){
   12ea0: c0 02 40 c2  	ldr	c0, [c22, #0]
   12ea4: c0 04 00 b4  	cbz	x0, 0x12f3c <main+0x2d8>
;   return __XBRTIME_CONFIG->_ID;
   12ea8: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   12eac: 88 04 00 35  	cbnz	w8, 0x12f3c <main+0x2d8>
   12eb0: e0 83 00 02  	add	c0, csp, #32            // =32
   12eb4: e1 63 00 02  	add	c1, csp, #24            // =24
   12eb8: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   12ebc: 35 38 c4 c2  	scbnds	c21, c1, #8             // =8
; 		i = gettimeofday( &tp, &tzp );
   12ec0: 80 d2 c1 c2  	mov	c0, c20
   12ec4: a1 d2 c1 c2  	mov	c1, c21
   12ec8: 8e 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12ecc: e0 07 42 6d  	ldp	d0, d1, [csp, #32]
   12ed0: 60 ff ff f0  	adrp	c0, 0x1000 <main+0x228>
   12ed4: 09 08 45 fd  	ldr	d9, [c0, #2576]
; 		printf("--------------------------------------------\n");
   12ed8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2b8>
   12edc: 00 10 42 c2  	ldr	c0, [c0, #2112]
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12ee0: 21 d8 61 5e  	scvtf	d1, d1
   12ee4: 00 d8 61 5e  	scvtf	d0, d0
   12ee8: 21 08 69 1e  	fmul	d1, d1, d9
   12eec: 20 28 60 1e  	fadd	d0, d1, d0
; 		t_mem = t_end - t_start;
   12ef0: 08 38 68 1e  	fsub	d8, d0, d8
; 		printf("--------------------------------------------\n");
   12ef4: 5b 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		printf("Time cost"BRED	" (raw transactions):       %f\n"RESET, t_mem);
   12ef8: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12efc: 09 70 c6 c2  	clrperm	c9, c0, wx
   12f00: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2e0>
   12f04: 00 bc 41 c2  	ldr	c0, [c0, #1776]
   12f08: e8 03 00 fd  	str	d8, [csp]
   12f0c: 75 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 		printf("--------------------------------------------\n");
   12f10: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2f0>
   12f14: 00 14 42 c2  	ldr	c0, [c0, #2128]
   12f18: 52 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		i = gettimeofday( &tp, &tzp );
   12f1c: 80 d2 c1 c2  	mov	c0, c20
   12f20: a1 d2 c1 c2  	mov	c1, c21
   12f24: 77 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12f28: e0 07 42 6d  	ldp	d0, d1, [csp, #32]
   12f2c: 21 d8 61 5e  	scvtf	d1, d1
   12f30: 00 d8 61 5e  	scvtf	d0, d0
   12f34: 21 08 69 1e  	fmul	d1, d1, d9
   12f38: 28 28 60 1e  	fadd	d8, d1, d0
;   printf("[M] Entered xbrtime_barrier()\n");
   12f3c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x31c>
   12f40: 00 f4 41 c2  	ldr	c0, [c0, #2000]
   12f44: 47 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12f48: f5 00 00 94  	bl	0x1331c <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12f4c: c0 02 40 c2  	ldr	c0, [c22, #0]
   12f50: 60 00 00 b4  	cbz	x0, 0x12f5c <main+0x2f8>
;   return __XBRTIME_CONFIG->_ID;
   12f54: 08 08 40 b9  	ldr	w8, [c0, #8]
   12f58: 02 00 00 14  	b	0x12f60 <main+0x2fc>
   12f5c: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12f60: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12f64: 09 70 c6 c2  	clrperm	c9, c0, wx
   12f68: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x348>
   12f6c: 00 78 41 c2  	ldr	c0, [c0, #1504]
   12f70: e8 03 00 f9  	str	x8, [csp]
   12f74: 5b 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12f78: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x358>
   12f7c: 00 f8 41 c2  	ldr	c0, [c0, #2016]
   12f80: 38 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   if( __XBRTIME_CONFIG == NULL ){
   12f84: c0 02 40 c2  	ldr	c0, [c22, #0]
   12f88: 20 06 00 b4  	cbz	x0, 0x1304c <main+0x3e8>
;   return __XBRTIME_CONFIG->_ID;
   12f8c: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   12f90: a8 02 00 35  	cbnz	w8, 0x12fe4 <main+0x380>
   12f94: e0 83 00 02  	add	c0, csp, #32            // =32
   12f98: e1 63 00 02  	add	c1, csp, #24            // =24
   12f9c: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   12fa0: 35 38 c4 c2  	scbnds	c21, c1, #8             // =8
; 		i = gettimeofday( &tp, &tzp );
   12fa4: 80 d2 c1 c2  	mov	c0, c20
   12fa8: a1 d2 c1 c2  	mov	c1, c21
   12fac: 55 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		printf("--------------------------------------------\n");
   12fb0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x390>
   12fb4: 00 0c 42 c2  	ldr	c0, [c0, #2096]
   12fb8: 2a 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
; 		i = gettimeofday( &tp, &tzp );
   12fbc: 80 d2 c1 c2  	mov	c0, c20
   12fc0: a1 d2 c1 c2  	mov	c1, c21
   12fc4: 4f 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12fc8: e0 07 42 6d  	ldp	d0, d1, [csp, #32]
   12fcc: 60 ff ff f0  	adrp	c0, 0x1000 <main+0x324>
   12fd0: 02 08 45 fd  	ldr	d2, [c0, #2576]
   12fd4: 21 d8 61 5e  	scvtf	d1, d1
   12fd8: 00 d8 61 5e  	scvtf	d0, d0
   12fdc: 21 08 62 1e  	fmul	d1, d1, d2
   12fe0: 28 28 60 1e  	fadd	d8, d1, d0
;   if( __XBRTIME_CONFIG == NULL ){
   12fe4: c0 02 40 c2  	ldr	c0, [c22, #0]
   12fe8: 20 03 00 b4  	cbz	x0, 0x1304c <main+0x3e8>
;   return __XBRTIME_CONFIG->_ID;
   12fec: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   12ff0: e8 02 00 35  	cbnz	w8, 0x1304c <main+0x3e8>
   12ff4: e0 83 00 02  	add	c0, csp, #32            // =32
   12ff8: e1 63 00 02  	add	c1, csp, #24            // =24
   12ffc: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13000: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   13004: 3f 01 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13008: e0 07 42 6d  	ldp	d0, d1, [csp, #32]
   1300c: 60 ff ff d0  	adrp	c0, 0x1000 <main+0x360>
   13010: 02 08 45 fd  	ldr	d2, [c0, #2576]
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   13014: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   13018: 09 70 c6 c2  	clrperm	c9, c0, wx
   1301c: 80 00 80 90  	adrp	c0, 0x23000 <main+0x3f8>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13020: 21 d8 61 5e  	scvtf	d1, d1
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   13024: 00 c0 41 c2  	ldr	c0, [c0, #1792]
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13028: 00 d8 61 5e  	scvtf	d0, d0
   1302c: 21 08 62 1e  	fmul	d1, d1, d2
   13030: 20 28 60 1e  	fadd	d0, d1, d0
; 		t_mem = t_end - t_start;
   13034: 00 38 68 1e  	fsub	d0, d0, d8
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   13038: e0 03 00 fd  	str	d0, [csp]
   1303c: 29 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
; 		printf("--------------------------------------------\n");
   13040: 80 00 80 90  	adrp	c0, 0x23000 <main+0x41c>
   13044: 00 08 42 c2  	ldr	c0, [c0, #2080]
   13048: 06 01 00 94  	bl	0x13460 <xbrtime_api_asm.s+0x13460>
;   __xbrtime_asm_quiet_fence();
   1304c: b7 00 00 94  	bl	0x13328 <__xbrtime_asm_quiet_fence>
;   if( __XBRTIME_CONFIG != NULL ){
   13050: c0 02 40 c2  	ldr	c0, [c22, #0]
   13054: 20 03 00 b4  	cbz	x0, 0x130b8 <main+0x454>
;     __xbrtime_asm_fence();
   13058: b1 00 00 94  	bl	0x1331c <__xbrtime_asm_fence>
   1305c: 14 00 81 52  	mov	w20, #2048
   13060: 15 01 80 52  	mov	w21, #8
   13064: 04 00 00 14  	b	0x13074 <main+0x410>
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   13068: 94 06 00 f1  	subs	x20, x20, #1            // =1
   1306c: b5 42 00 91  	add	x21, x21, #16           // =16
   13070: 40 01 00 54  	b.eq	0x13098 <main+0x434>
;       if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
   13074: c0 02 40 c2  	ldr	c0, [c22, #0]
   13078: 00 0c 40 c2  	ldr	c0, [c0, #48]
   1307c: 08 68 75 f8  	ldr	x8, [c0, x21]
   13080: 48 ff ff b4  	cbz	x8, 0x13068 <main+0x404>
;         xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
   13084: 00 60 b5 c2  	add	c0, c0, x21, uxtx
   13088: 08 80 5f f8  	ldur	x8, [c0, #-8]
;   if( ptr == NULL ){
   1308c: e8 fe ff b4  	cbz	x8, 0x13068 <main+0x404>
;   __xbrtime_asm_quiet_fence();
   13090: a6 00 00 94  	bl	0x13328 <__xbrtime_asm_quiet_fence>
   13094: f5 ff ff 17  	b	0x13068 <main+0x404>
;     if( __XBRTIME_CONFIG->_MAP != NULL ){
   13098: c0 02 40 c2  	ldr	c0, [c22, #0]
   1309c: 00 10 40 c2  	ldr	c0, [c0, #64]
   130a0: 80 00 00 b4  	cbz	x0, 0x130b0 <main+0x44c>
;       free( __XBRTIME_CONFIG->_MAP );
   130a4: db 00 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
;       __XBRTIME_CONFIG->_MAP = NULL;
   130a8: c0 02 40 c2  	ldr	c0, [c22, #0]
   130ac: 1f 10 00 c2  	str	czr, [c0, #64]
;     free( __XBRTIME_CONFIG );
   130b0: c0 02 40 c2  	ldr	c0, [c22, #0]
   130b4: d7 00 00 94  	bl	0x13410 <xbrtime_api_asm.s+0x13410>
; 	printf("[M]"GRN " Returning Main matmul...\n"RESET);
   130b8: 80 00 80 90  	adrp	c0, 0x23000 <.get_u1_seq+0x10>
   130bc: 00 c4 41 c2  	ldr	c0, [c0, #1808]
   130c0: e9 03 1f aa  	mov	x9, xzr
   130c4: 07 01 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
;   return rtn;
   130c8: e0 03 13 2a  	mov	w0, w19
   130cc: f4 4f c4 42  	ldp	c20, c19, [csp, #128]
   130d0: f6 57 c3 42  	ldp	c22, c21, [csp, #96]
   130d4: fd 7b c2 42  	ldp	c29, c30, [csp, #64]
   130d8: e9 23 43 6d  	ldp	d9, d8, [csp, #48]
   130dc: ff 83 02 02  	add	csp, csp, #160          // =160
   130e0: c0 53 c2 c2  	ret	c30

00000000000130e4 <__xbrtime_get_u1_seq>:
;   MOV X12, XZR
   130e4: ec 03 1f aa  	mov	x12, xzr

00000000000130e8 <.get_u1_seq>:
;   LDRB W10, [X0]
   130e8: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   130ec: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   130f0: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   130f4: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   130f8: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   130fc: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u1_seq
   13100: 41 ff ff 54  	b.ne	0x130e8 <.get_u1_seq>
;   RET
   13104: c0 53 c2 c2  	ret	c30

0000000000013108 <__xbrtime_put_u1_seq>:
;   MOV X12, XZR
   13108: ec 03 1f aa  	mov	x12, xzr

000000000001310c <.put_u1_seq>:
;   LDRB W10, [X0]
   1310c: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13110: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13114: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13118: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   1311c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13120: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u1_seq
   13124: 41 ff ff 54  	b.ne	0x1310c <.put_u1_seq>
;   RET
   13128: c0 53 c2 c2  	ret	c30

000000000001312c <__xbrtime_get_s1_seq>:
;   MOV X12, XZR
   1312c: ec 03 1f aa  	mov	x12, xzr

0000000000013130 <.get_s1_seq>:
;   LDRB W10, [X0]
   13130: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13134: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13138: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   1313c: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13140: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13144: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s1_seq
   13148: 41 ff ff 54  	b.ne	0x13130 <.get_s1_seq>
;   RET
   1314c: c0 53 c2 c2  	ret	c30

0000000000013150 <__xbrtime_put_s1_seq>:
;   MOV X12, XZR
   13150: ec 03 1f aa  	mov	x12, xzr

0000000000013154 <.put_s1_seq>:
;   LDRB W10, [X0]
   13154: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13158: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1315c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13160: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13164: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13168: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s1_seq
   1316c: 41 ff ff 54  	b.ne	0x13154 <.put_s1_seq>
;   RET
   13170: c0 53 c2 c2  	ret	c30

0000000000013174 <__xbrtime_get_u2_seq>:
;   MOV X12, XZR
   13174: ec 03 1f aa  	mov	x12, xzr

0000000000013178 <.get_u2_seq>:
;   LDRH W10, [X0]
   13178: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   1317c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13180: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   13184: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   13188: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1318c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u2_seq
   13190: 41 ff ff 54  	b.ne	0x13178 <.get_u2_seq>
;   RET
   13194: c0 53 c2 c2  	ret	c30

0000000000013198 <__xbrtime_put_u2_seq>:
;   MOV X12, XZR
   13198: ec 03 1f aa  	mov	x12, xzr

000000000001319c <.put_u2_seq>:
;   LDRH W10, [X0]
   1319c: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   131a0: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   131a4: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   131a8: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   131ac: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   131b0: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u2_seq
   131b4: 41 ff ff 54  	b.ne	0x1319c <.put_u2_seq>
;   RET
   131b8: c0 53 c2 c2  	ret	c30

00000000000131bc <__xbrtime_get_s2_seq>:
;   MOV X12, XZR
   131bc: ec 03 1f aa  	mov	x12, xzr

00000000000131c0 <.get_s2_seq>:
;   LDRH W10, [X0]
   131c0: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   131c4: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   131c8: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   131cc: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   131d0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   131d4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s2_seq
   131d8: 41 ff ff 54  	b.ne	0x131c0 <.get_s2_seq>
;   RET
   131dc: c0 53 c2 c2  	ret	c30

00000000000131e0 <__xbrtime_put_s2_seq>:
;   MOV X12, XZR
   131e0: ec 03 1f aa  	mov	x12, xzr

00000000000131e4 <.put_s2_seq>:
;   LDRH W10, [X0]
   131e4: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   131e8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   131ec: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   131f0: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   131f4: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   131f8: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s2_seq
   131fc: 41 ff ff 54  	b.ne	0x131e4 <.put_s2_seq>
;   RET
   13200: c0 53 c2 c2  	ret	c30

0000000000013204 <__xbrtime_get_u4_seq>:
;   MOV X12, XZR
   13204: ec 03 1f aa  	mov	x12, xzr

0000000000013208 <.get_u4_seq>:
;   LDR W10, [X0]
   13208: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   1320c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13210: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   13214: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   13218: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1321c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u4_seq
   13220: 41 ff ff 54  	b.ne	0x13208 <.get_u4_seq>
;   RET
   13224: c0 53 c2 c2  	ret	c30

0000000000013228 <__xbrtime_put_u4_seq>:
;   MOV X12, XZR
   13228: ec 03 1f aa  	mov	x12, xzr

000000000001322c <.put_u4_seq>:
;   LDR W10, [X0]
   1322c: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   13230: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13234: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   13238: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   1323c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13240: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u4_seq
   13244: 41 ff ff 54  	b.ne	0x1322c <.put_u4_seq>
;   RET
   13248: c0 53 c2 c2  	ret	c30

000000000001324c <__xbrtime_get_s4_seq>:
;   MOV X12, XZR
   1324c: ec 03 1f aa  	mov	x12, xzr

0000000000013250 <.get_s4_seq>:
;   LDR W10, [X0]
   13250: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   13254: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13258: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   1325c: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   13260: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13264: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s4_seq
   13268: 41 ff ff 54  	b.ne	0x13250 <.get_s4_seq>
;   RET
   1326c: c0 53 c2 c2  	ret	c30

0000000000013270 <__xbrtime_put_s4_seq>:
;   MOV X12, XZR
   13270: ec 03 1f aa  	mov	x12, xzr

0000000000013274 <.put_s4_seq>:
;   LDR W10, [X0]
   13274: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   13278: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1327c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   13280: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   13284: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13288: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s4_seq
   1328c: 41 ff ff 54  	b.ne	0x13274 <.put_s4_seq>
;   RET
   13290: c0 53 c2 c2  	ret	c30

0000000000013294 <__xbrtime_get_u8_seq>:
;   MOV X12, XZR
   13294: ec 03 1f aa  	mov	x12, xzr

0000000000013298 <.get_u8_seq>:
;   ADD X0, X0, X3
   13298: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1329c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   ADD X1, X1, X3
   132a0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132a4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u8_seq
   132a8: 81 ff ff 54  	b.ne	0x13298 <.get_u8_seq>
;   RET
   132ac: c0 53 c2 c2  	ret	c30

00000000000132b0 <__xbrtime_put_u8_seq>:
;   MOV X12, XZR
   132b0: ec 03 1f aa  	mov	x12, xzr

00000000000132b4 <.put_u8_seq>:
;   LDR X10, [X0]
   132b4: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   132b8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   132bc: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   132c0: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   132c4: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132c8: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u8_seq
   132cc: 41 ff ff 54  	b.ne	0x132b4 <.put_u8_seq>
;   RET
   132d0: c0 53 c2 c2  	ret	c30

00000000000132d4 <__xbrtime_get_s8_seq>:
;   MOV X12, XZR
   132d4: ec 03 1f aa  	mov	x12, xzr

00000000000132d8 <.get_s8_seq>:
;   LDR X10, [X0]
   132d8: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   132dc: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   132e0: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   132e4: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   132e8: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132ec: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s8_seq
   132f0: 41 ff ff 54  	b.ne	0x132d8 <.get_s8_seq>
;   RET
   132f4: c0 53 c2 c2  	ret	c30

00000000000132f8 <__xbrtime_put_s8_seq>:
;   MOV X12, XZR
   132f8: ec 03 1f aa  	mov	x12, xzr

00000000000132fc <.put_s8_seq>:
;   LDR X10, [X0]
   132fc: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   13300: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13304: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   13308: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   1330c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13310: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s8_seq
   13314: 41 ff ff 54  	b.ne	0x132fc <.put_s8_seq>
;   RET
   13318: c0 53 c2 c2  	ret	c30

000000000001331c <__xbrtime_asm_fence>:
;   DSB SY
   1331c: 9f 3f 03 d5  	dsb	sy
;   ISB
   13320: df 3f 03 d5  	isb
;   RET
   13324: c0 53 c2 c2  	ret	c30

0000000000013328 <__xbrtime_asm_quiet_fence>:
;   DMB SY
   13328: bf 3f 03 d5  	dmb	sy
;   RET
   1332c: c0 53 c2 c2  	ret	c30

Disassembly of section .plt:

0000000000013330 <.plt>:
   13330: f0 7b bf 62  	stp	c16, c30, [csp, #-32]!
   13334: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x84>
   13338: 11 ee 42 c2  	ldr	c17, [c16, #2992]
   1333c: 10 c2 2e 02  	add	c16, c16, #2992         // =2992
   13340: 20 12 c2 c2  	br	c17
   13344: 1f 20 03 d5  	nop
   13348: 1f 20 03 d5  	nop
   1334c: 1f 20 03 d5  	nop
   13350: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xa0>
   13354: 10 02 2f 02  	add	c16, c16, #3008         // =3008
   13358: 11 02 40 c2  	ldr	c17, [c16, #0]
   1335c: 20 12 c2 c2  	br	c17
   13360: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xb0>
   13364: 10 42 2f 02  	add	c16, c16, #3024         // =3024
   13368: 11 02 40 c2  	ldr	c17, [c16, #0]
   1336c: 20 12 c2 c2  	br	c17
   13370: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xc0>
   13374: 10 82 2f 02  	add	c16, c16, #3040         // =3040
   13378: 11 02 40 c2  	ldr	c17, [c16, #0]
   1337c: 20 12 c2 c2  	br	c17
   13380: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xd0>
   13384: 10 c2 2f 02  	add	c16, c16, #3056         // =3056
   13388: 11 02 40 c2  	ldr	c17, [c16, #0]
   1338c: 20 12 c2 c2  	br	c17
   13390: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xe0>
   13394: 10 02 30 02  	add	c16, c16, #3072         // =3072
   13398: 11 02 40 c2  	ldr	c17, [c16, #0]
   1339c: 20 12 c2 c2  	br	c17
   133a0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xf0>
   133a4: 10 42 30 02  	add	c16, c16, #3088         // =3088
   133a8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133ac: 20 12 c2 c2  	br	c17
   133b0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x100>
   133b4: 10 82 30 02  	add	c16, c16, #3104         // =3104
   133b8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133bc: 20 12 c2 c2  	br	c17
   133c0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x110>
   133c4: 10 c2 30 02  	add	c16, c16, #3120         // =3120
   133c8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133cc: 20 12 c2 c2  	br	c17
   133d0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x120>
   133d4: 10 02 31 02  	add	c16, c16, #3136         // =3136
   133d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133dc: 20 12 c2 c2  	br	c17
   133e0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x130>
   133e4: 10 42 31 02  	add	c16, c16, #3152         // =3152
   133e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133ec: 20 12 c2 c2  	br	c17
   133f0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x140>
   133f4: 10 82 31 02  	add	c16, c16, #3168         // =3168
   133f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   133fc: 20 12 c2 c2  	br	c17
   13400: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x150>
   13404: 10 c2 31 02  	add	c16, c16, #3184         // =3184
   13408: 11 02 40 c2  	ldr	c17, [c16, #0]
   1340c: 20 12 c2 c2  	br	c17
   13410: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x160>
   13414: 10 02 32 02  	add	c16, c16, #3200         // =3200
   13418: 11 02 40 c2  	ldr	c17, [c16, #0]
   1341c: 20 12 c2 c2  	br	c17
   13420: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x170>
   13424: 10 42 32 02  	add	c16, c16, #3216         // =3216
   13428: 11 02 40 c2  	ldr	c17, [c16, #0]
   1342c: 20 12 c2 c2  	br	c17
   13430: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x180>
   13434: 10 82 32 02  	add	c16, c16, #3232         // =3232
   13438: 11 02 40 c2  	ldr	c17, [c16, #0]
   1343c: 20 12 c2 c2  	br	c17
   13440: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x190>
   13444: 10 c2 32 02  	add	c16, c16, #3248         // =3248
   13448: 11 02 40 c2  	ldr	c17, [c16, #0]
   1344c: 20 12 c2 c2  	br	c17
   13450: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1a0>
   13454: 10 02 33 02  	add	c16, c16, #3264         // =3264
   13458: 11 02 40 c2  	ldr	c17, [c16, #0]
   1345c: 20 12 c2 c2  	br	c17
   13460: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1b0>
   13464: 10 42 33 02  	add	c16, c16, #3280         // =3280
   13468: 11 02 40 c2  	ldr	c17, [c16, #0]
   1346c: 20 12 c2 c2  	br	c17
   13470: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1c0>
   13474: 10 82 33 02  	add	c16, c16, #3296         // =3296
   13478: 11 02 40 c2  	ldr	c17, [c16, #0]
   1347c: 20 12 c2 c2  	br	c17
   13480: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1d0>
   13484: 10 c2 33 02  	add	c16, c16, #3312         // =3312
   13488: 11 02 40 c2  	ldr	c17, [c16, #0]
   1348c: 20 12 c2 c2  	br	c17
   13490: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1e0>
   13494: 10 02 34 02  	add	c16, c16, #3328         // =3328
   13498: 11 02 40 c2  	ldr	c17, [c16, #0]
   1349c: 20 12 c2 c2  	br	c17
   134a0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1f0>
   134a4: 10 42 34 02  	add	c16, c16, #3344         // =3344
   134a8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134ac: 20 12 c2 c2  	br	c17
   134b0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x200>
   134b4: 10 82 34 02  	add	c16, c16, #3360         // =3360
   134b8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134bc: 20 12 c2 c2  	br	c17
   134c0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x210>
   134c4: 10 c2 34 02  	add	c16, c16, #3376         // =3376
   134c8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134cc: 20 12 c2 c2  	br	c17
   134d0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x220>
   134d4: 10 02 35 02  	add	c16, c16, #3392         // =3392
   134d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134dc: 20 12 c2 c2  	br	c17
   134e0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x230>
   134e4: 10 42 35 02  	add	c16, c16, #3408         // =3408
   134e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134ec: 20 12 c2 c2  	br	c17
   134f0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x240>
   134f4: 10 82 35 02  	add	c16, c16, #3424         // =3424
   134f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134fc: 20 12 c2 c2  	br	c17
   13500: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x250>
   13504: 10 c2 35 02  	add	c16, c16, #3440         // =3440
   13508: 11 02 40 c2  	ldr	c17, [c16, #0]
   1350c: 20 12 c2 c2  	br	c17
   13510: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x260>
   13514: 10 02 36 02  	add	c16, c16, #3456         // =3456
   13518: 11 02 40 c2  	ldr	c17, [c16, #0]
   1351c: 20 12 c2 c2  	br	c17
