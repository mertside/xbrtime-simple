
./matmul_M.exe:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000011e4c <_start>:
; {
   11e4c: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   11e50: f6 57 81 42  	stp	c22, c21, [csp, #32]
   11e54: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   11e58: fd d3 c1 c2  	mov	c29, csp
; 	if (!has_dynamic_linker)
   11e5c: 62 05 00 b4  	cbz	x2, 0x11f08 <_start+0xbc>
   11e60: 33 d0 c1 c2  	mov	c19, c1
; 	if (!has_dynamic_linker)
   11e64: 33 05 00 b4  	cbz	x19, 0x11f08 <_start+0xbc>
; 	if (cheri_getdefault() != NULL)
   11e68: 21 41 9b c2  	mrs	c1, DDC
   11e6c: e1 04 00 b5  	cbnz	x1, 0x11f08 <_start+0xbc>
   11e70: f5 03 1f aa  	mov	x21, xzr
   11e74: f4 03 1f aa  	mov	x20, xzr
   11e78: f6 03 1f 2a  	mov	w22, wzr
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11e7c: 01 40 00 02  	add	c1, c0, #16             // =16
   11e80: 04 00 00 14  	b	0x11e90 <_start+0x44>
   11e84: c1 01 00 54  	b.ne	0x11ebc <_start+0x70>
; 			argc = auxp->a_un.a_val;
   11e88: 36 00 40 b9  	ldr	w22, [c1]
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11e8c: 21 80 00 02  	add	c1, c1, #32             // =32
   11e90: 28 00 5f f8  	ldur	x8, [c1, #-16]
   11e94: 1f 71 00 f1  	cmp	x8, #28                 // =28
   11e98: 6d ff ff 54  	b.le	0x11e84 <_start+0x38>
   11e9c: 1f 75 00 f1  	cmp	x8, #29                 // =29
   11ea0: a0 00 00 54  	b.eq	0x11eb4 <_start+0x68>
   11ea4: 1f 7d 00 f1  	cmp	x8, #31                 // =31
   11ea8: 21 ff ff 54  	b.ne	0x11e8c <_start+0x40>
; 			env = (char **)auxp->a_un.a_ptr;
   11eac: 34 24 40 a2  	ldr	c20, [c1], #32
   11eb0: f8 ff ff 17  	b	0x11e90 <_start+0x44>
; 			argv = (char **)auxp->a_un.a_ptr;
   11eb4: 35 24 40 a2  	ldr	c21, [c1], #32
   11eb8: f6 ff ff 17  	b	0x11e90 <_start+0x44>
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11ebc: 88 fe ff b5  	cbnz	x8, 0x11e8c <_start+0x40>
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11ec0: 81 00 80 d0  	adrp	c1, 0x23000 <_start+0xbc>
   11ec4: 21 fc 42 c2  	ldr	c1, [c1, #3056]
; 	handle_argv(argc, argv, env);
   11ec8: 82 d2 c1 c2  	mov	c2, c20
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11ecc: 20 00 00 c2  	str	c0, [c1, #0]
; 	handle_argv(argc, argv, env);
   11ed0: e0 03 16 2a  	mov	w0, w22
   11ed4: a1 d2 c1 c2  	mov	c1, c21
   11ed8: 0d 00 00 94  	bl	0x11f0c <handle_argv>
; 		atexit(cleanup);
   11edc: 60 d2 c1 c2  	mov	c0, c19
   11ee0: 7c 05 00 94  	bl	0x134d0 <xbrtime_api_asm.s+0x134d0>
; 	handle_static_init(argc, argv, env);
   11ee4: e0 03 16 2a  	mov	w0, w22
   11ee8: a1 d2 c1 c2  	mov	c1, c21
   11eec: 82 d2 c1 c2  	mov	c2, c20
   11ef0: 1c 00 00 94  	bl	0x11f60 <handle_static_init>
; 	exit(main(argc, argv, env));
   11ef4: e0 03 16 2a  	mov	w0, w22
   11ef8: a1 d2 c1 c2  	mov	c1, c21
   11efc: 82 d2 c1 c2  	mov	c2, c20
   11f00: 75 03 00 94  	bl	0x12cd4 <main>
   11f04: 77 05 00 94  	bl	0x134e0 <xbrtime_api_asm.s+0x134e0>
   11f08: 20 00 20 d4  	brk	#0x1

0000000000011f0c <handle_argv>:
; 	if (environ == NULL)
   11f0c: 83 00 80 d0  	adrp	c3, 0x23000 <handle_argv+0x48>
   11f10: 63 00 43 c2  	ldr	c3, [c3, #3072]
   11f14: 64 00 40 c2  	ldr	c4, [c3, #0]
   11f18: 84 00 00 b4  	cbz	x4, 0x11f28 <handle_argv+0x1c>
; 	if (argc > 0 && argv[0] != NULL) {
   11f1c: 1f 04 00 71  	cmp	w0, #1                  // =1
   11f20: aa 00 00 54  	b.ge	0x11f34 <handle_argv+0x28>
   11f24: 0e 00 00 14  	b	0x11f5c <handle_argv+0x50>
; 		environ = env;
   11f28: 62 00 00 c2  	str	c2, [c3, #0]
; 	if (argc > 0 && argv[0] != NULL) {
   11f2c: 1f 04 00 71  	cmp	w0, #1                  // =1
   11f30: 6b 01 00 54  	b.lt	0x11f5c <handle_argv+0x50>
   11f34: 21 00 40 c2  	ldr	c1, [c1, #0]
   11f38: 21 01 00 b4  	cbz	x1, 0x11f5c <handle_argv+0x50>
; 		__progname = argv[0];
   11f3c: 80 00 80 d0  	adrp	c0, 0x23000 <handle_static_init+0x24>
   11f40: 00 04 43 c2  	ldr	c0, [c0, #3088]
   11f44: 01 00 00 c2  	str	c1, [c0, #0]
   11f48: 21 04 00 02  	add	c1, c1, #1              // =1
; 		for (s = __progname; *s != '\0'; s++) {
   11f4c: 28 f0 5f 38  	ldurb	w8, [c1, #-1]
   11f50: 1f bd 00 71  	cmp	w8, #47                 // =47
   11f54: 80 ff ff 54  	b.eq	0x11f44 <handle_argv+0x38>
   11f58: 88 ff ff 35  	cbnz	w8, 0x11f48 <handle_argv+0x3c>
; }
   11f5c: c0 53 c2 c2  	ret	c30

0000000000011f60 <handle_static_init>:
; {
   11f60: fd fb bc 62  	stp	c29, c30, [csp, #-112]!
   11f64: f7 0b 00 c2  	str	c23, [csp, #32]
   11f68: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   11f6c: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   11f70: fd d3 c1 c2  	mov	c29, csp
   11f74: 34 d0 c1 c2  	mov	c20, c1
; 	if (&_DYNAMIC != NULL)
   11f78: 81 00 80 d0  	adrp	c1, 0x23000 <handle_static_init+0x60>
   11f7c: 21 08 43 c2  	ldr	c1, [c1, #3104]
   11f80: 61 07 00 b5  	cbnz	x1, 0x1206c <handle_static_init+0x10c>
   11f84: f5 03 00 2a  	mov	w21, w0
; 	atexit(finalizer);
   11f88: 00 00 80 b0  	adrp	c0, 0x12000 <handle_static_init+0x2c>
   11f8c: 00 04 02 02  	add	c0, c0, #129            // =129
   11f90: 00 30 c3 c2  	seal	c0, c0, rb
   11f94: 53 d0 c1 c2  	mov	c19, c2
   11f98: 4e 05 00 94  	bl	0x134d0 <xbrtime_api_asm.s+0x134d0>
; 	array_size = __preinit_array_end - __preinit_array_start;
   11f9c: 80 00 80 d0  	adrp	c0, 0x23000 <handle_static_init+0x84>
   11fa0: 00 0c 43 c2  	ldr	c0, [c0, #3120]
   11fa4: 81 00 80 d0  	adrp	c1, 0x23000 <handle_static_init+0x8c>
   11fa8: 21 10 43 c2  	ldr	c1, [c1, #3136]
   11fac: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   11fb0: a0 02 00 54  	b.eq	0x12004 <handle_static_init+0xa4>
   11fb4: 97 00 80 d0  	adrp	c23, 0x23000 <handle_static_init+0x9c>
   11fb8: f7 12 43 c2  	ldr	c23, [c23, #3136]
; 	array_size = __preinit_array_end - __preinit_array_start;
   11fbc: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   11fc0: 1f 05 00 f1  	cmp	x8, #1                  // =1
   11fc4: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   11fc8: 04 00 00 14  	b	0x11fd8 <handle_static_init+0x78>
   11fcc: d6 06 00 f1  	subs	x22, x22, #1            // =1
   11fd0: f7 42 00 02  	add	c23, c23, #16           // =16
   11fd4: 80 01 00 54  	b.eq	0x12004 <handle_static_init+0xa4>
; 		fn = __preinit_array_start[n];
   11fd8: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11fdc: 83 ff ff b4  	cbz	x3, 0x11fcc <handle_static_init+0x6c>
   11fe0: e0 03 1f aa  	mov	x0, xzr
   11fe4: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11fe8: 7f 00 00 eb  	cmp	x3, x0
   11fec: 00 ff ff 54  	b.eq	0x11fcc <handle_static_init+0x6c>
; 			fn(argc, argv, env);
   11ff0: e0 03 15 2a  	mov	w0, w21
   11ff4: 81 d2 c1 c2  	mov	c1, c20
   11ff8: 62 d2 c1 c2  	mov	c2, c19
   11ffc: 60 30 c2 c2  	blr	c3
   12000: f3 ff ff 17  	b	0x11fcc <handle_static_init+0x6c>
; 	array_size = __init_array_end - __init_array_start;
   12004: 80 00 80 b0  	adrp	c0, 0x23000 <handle_static_init+0xe8>
   12008: 00 14 43 c2  	ldr	c0, [c0, #3152]
   1200c: 81 00 80 b0  	adrp	c1, 0x23000 <handle_static_init+0xf0>
   12010: 21 18 43 c2  	ldr	c1, [c1, #3168]
   12014: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   12018: a0 02 00 54  	b.eq	0x1206c <handle_static_init+0x10c>
   1201c: 97 00 80 b0  	adrp	c23, 0x23000 <handle_static_init+0x100>
   12020: f7 1a 43 c2  	ldr	c23, [c23, #3168]
; 	array_size = __init_array_end - __init_array_start;
   12024: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   12028: 1f 05 00 f1  	cmp	x8, #1                  // =1
   1202c: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   12030: 04 00 00 14  	b	0x12040 <handle_static_init+0xe0>
   12034: d6 06 00 f1  	subs	x22, x22, #1            // =1
   12038: f7 42 00 02  	add	c23, c23, #16           // =16
   1203c: 80 01 00 54  	b.eq	0x1206c <handle_static_init+0x10c>
; 		fn = __init_array_start[n];
   12040: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   12044: 83 ff ff b4  	cbz	x3, 0x12034 <handle_static_init+0xd4>
   12048: e0 03 1f aa  	mov	x0, xzr
   1204c: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   12050: 7f 00 00 eb  	cmp	x3, x0
   12054: 00 ff ff 54  	b.eq	0x12034 <handle_static_init+0xd4>
; 			fn(argc, argv, env);
   12058: e0 03 15 2a  	mov	w0, w21
   1205c: 81 d2 c1 c2  	mov	c1, c20
   12060: 62 d2 c1 c2  	mov	c2, c19
   12064: 60 30 c2 c2  	blr	c3
   12068: f3 ff ff 17  	b	0x12034 <handle_static_init+0xd4>
; }
   1206c: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   12070: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   12074: f7 0b 40 c2  	ldr	c23, [csp, #32]
   12078: fd fb c3 22  	ldp	c29, c30, [csp], #112
   1207c: c0 53 c2 c2  	ret	c30

0000000000012080 <finalizer>:
; {
   12080: fd 7b be 62  	stp	c29, c30, [csp, #-64]!
   12084: f4 4f 81 42  	stp	c20, c19, [csp, #32]
   12088: fd d3 c1 c2  	mov	c29, csp
; 	array_size = __fini_array_end - __fini_array_start;
   1208c: 80 00 80 b0  	adrp	c0, 0x23000 <finalizer+0x50>
   12090: 00 1c 43 c2  	ldr	c0, [c0, #3184]
   12094: 93 00 80 b0  	adrp	c19, 0x23000 <finalizer+0x58>
   12098: 73 22 43 c2  	ldr	c19, [c19, #3200]
   1209c: 08 00 13 eb  	subs	x8, x0, x19
; 	for (n = array_size; n > 0; n--) {
   120a0: e0 01 00 54  	b.eq	0x120dc <finalizer+0x5c>
; 	array_size = __fini_array_end - __fini_array_start;
   120a4: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = array_size; n > 0; n--) {
   120a8: 14 05 00 d1  	sub	x20, x8, #1             // =1
   120ac: 04 00 00 14  	b	0x120bc <finalizer+0x3c>
   120b0: 94 06 00 d1  	sub	x20, x20, #1            // =1
   120b4: 9f 06 00 b1  	cmn	x20, #1                 // =1
   120b8: 20 01 00 54  	b.eq	0x120dc <finalizer+0x5c>
; 		fn = __fini_array_start[n - 1];
   120bc: 60 7a 74 a2  	ldr	c0, [c19, x20, lsl #4]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   120c0: 80 ff ff b4  	cbz	x0, 0x120b0 <finalizer+0x30>
   120c4: e1 03 1f aa  	mov	x1, xzr
   120c8: 21 04 00 02  	add	c1, c1, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   120cc: 1f 00 01 eb  	cmp	x0, x1
   120d0: 00 ff ff 54  	b.eq	0x120b0 <finalizer+0x30>
; 			(fn)();
   120d4: 00 30 c2 c2  	blr	c0
   120d8: f6 ff ff 17  	b	0x120b0 <finalizer+0x30>
; }
   120dc: f4 4f c1 42  	ldp	c20, c19, [csp, #32]
   120e0: fd 7b c2 22  	ldp	c29, c30, [csp], #64
   120e4: c0 53 c2 c2  	ret	c30

00000000000120e8 <run_cxa_finalize>:
; 	if (__cxa_finalize != NULL)
   120e8: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_malloc+0x18>
   120ec: 00 24 43 c2  	ldr	c0, [c0, #3216]
   120f0: 00 01 00 b4  	cbz	x0, 0x12110 <run_cxa_finalize+0x28>
   120f4: fd 7b bf 62  	stp	c29, c30, [csp, #-32]!
   120f8: fd d3 c1 c2  	mov	c29, csp
; 		__cxa_finalize(__dso_handle);
   120fc: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_malloc+0x2c>
   12100: 00 28 43 c2  	ldr	c0, [c0, #3232]
   12104: 00 00 40 c2  	ldr	c0, [c0, #0]
   12108: fa 04 00 94  	bl	0x134f0 <xbrtime_api_asm.s+0x134f0>
; }
   1210c: fd 7b c1 22  	ldp	c29, c30, [csp], #32
   12110: c0 53 c2 c2  	ret	c30

0000000000012114 <xbrtime_malloc>:
;   if( sz == 0 ){
   12114: 60 01 00 b4  	cbz	x0, 0x12140 <xbrtime_malloc+0x2c>
   12118: fd fb be 62  	stp	c29, c30, [csp, #-48]!
   1211c: f3 0b 00 c2  	str	c19, [csp, #32]
   12120: fd d3 c1 c2  	mov	c29, csp
;   ptr = malloc(sz);
   12124: f7 04 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   12128: 13 d0 c1 c2  	mov	c19, c0
;   __xbrtime_asm_quiet_fence();
   1212c: dc 04 00 94  	bl	0x1349c <__xbrtime_asm_quiet_fence>
; }
   12130: 60 d2 c1 c2  	mov	c0, c19
   12134: f3 0b 40 c2  	ldr	c19, [csp, #32]
   12138: fd fb c1 22  	ldp	c29, c30, [csp], #48
   1213c: c0 53 c2 c2  	ret	c30
   12140: e0 03 1f aa  	mov	x0, xzr
   12144: c0 53 c2 c2  	ret	c30

0000000000012148 <xbrtime_free>:
;   if( ptr == NULL ){
   12148: 40 00 00 b4  	cbz	x0, 0x12150 <xbrtime_free+0x8>
;   __xbrtime_asm_quiet_fence();
   1214c: d4 04 00 14  	b	0x1349c <__xbrtime_asm_quiet_fence>
; }
   12150: c0 53 c2 c2  	ret	c30

0000000000012154 <tpool_create>:
; {                                                                               
   12154: ff c3 81 02  	sub	csp, csp, #112          // =112
   12158: fd fb 80 42  	stp	c29, c30, [csp, #16]
   1215c: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   12160: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   12164: fd 43 00 02  	add	c29, csp, #16           // =16
;   if (num == 0)                                                                 
   12168: 1f 00 00 f1  	cmp	x0, #0                  // =0
   1216c: 48 00 80 52  	mov	w8, #2
   12170: 16 01 80 9a  	csel	x22, x8, x0, eq
;   wq              = calloc(1, sizeof(*wq));                                     
   12174: 20 00 80 52  	mov	w0, #1
   12178: 01 0e 80 52  	mov	w1, #112
   1217c: e5 04 00 94  	bl	0x13510 <xbrtime_api_asm.s+0x13510>
   12180: 13 d0 c1 c2  	mov	c19, c0
;   wq->num_threads = num;                                                        
   12184: 16 2c 00 f9  	str	x22, [c0, #88]
;   pthread_mutex_init(&(wq->work_mutex), NULL);                                  
   12188: 00 80 00 02  	add	c0, c0, #32             // =32
   1218c: e1 03 1f aa  	mov	x1, xzr
   12190: e4 04 00 94  	bl	0x13520 <xbrtime_api_asm.s+0x13520>
;   pthread_cond_init(&(wq->work_cond), NULL);                                    
   12194: 60 c2 00 02  	add	c0, c19, #48            // =48
   12198: e1 03 1f aa  	mov	x1, xzr
   1219c: e5 04 00 94  	bl	0x13530 <xbrtime_api_asm.s+0x13530>
;   pthread_cond_init(&(wq->working_cond), NULL);                                 
   121a0: 60 02 01 02  	add	c0, c19, #64            // =64
   121a4: e1 03 1f aa  	mov	x1, xzr
   121a8: e2 04 00 94  	bl	0x13530 <xbrtime_api_asm.s+0x13530>
   121ac: 01 00 80 90  	adrp	c1, 0x12000 <tpool_create+0x58>
   121b0: e0 d3 c1 c2  	mov	c0, csp
   121b4: 21 14 08 02  	add	c1, c1, #517            // =517
;   wq->work_tail = NULL;                                                         
   121b8: 00 e4 00 6f  	movi	v0.2d, #0000000000000000
   121bc: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   121c0: 35 30 c3 c2  	seal	c21, c1, rb
   121c4: 60 02 00 ad  	stp	q0, q0, [c19]
;     pthread_create(&thread, NULL, tpool_worker, wq);                            
   121c8: 80 d2 c1 c2  	mov	c0, c20
   121cc: e1 03 1f aa  	mov	x1, xzr
   121d0: a2 d2 c1 c2  	mov	c2, c21
   121d4: 63 d2 c1 c2  	mov	c3, c19
   121d8: da 04 00 94  	bl	0x13540 <xbrtime_api_asm.s+0x13540>
;     pthread_detach(thread);                                                     
   121dc: e0 03 40 c2  	ldr	c0, [csp, #0]
   121e0: dc 04 00 94  	bl	0x13550 <xbrtime_api_asm.s+0x13550>
;   for (i=0; i<num; i++) {                                                       
   121e4: d6 06 00 f1  	subs	x22, x22, #1            // =1
   121e8: 01 ff ff 54  	b.ne	0x121c8 <tpool_create+0x74>
;   return wq;                                                                    
   121ec: 60 d2 c1 c2  	mov	c0, c19
   121f0: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   121f4: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   121f8: fd fb c0 42  	ldp	c29, c30, [csp, #16]
   121fc: ff c3 01 02  	add	csp, csp, #112          // =112
   12200: c0 53 c2 c2  	ret	c30

0000000000012204 <tpool_worker>:
; {                                                                               
   12204: fd fb bc 62  	stp	c29, c30, [csp, #-112]!
   12208: f7 0b 00 c2  	str	c23, [csp, #32]
   1220c: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   12210: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   12214: fd d3 c1 c2  	mov	c29, csp
   12218: 14 d0 c1 c2  	mov	c20, c0
   1221c: 13 80 00 02  	add	c19, c0, #32            // =32
   12220: 16 c0 00 02  	add	c22, c0, #48            // =48
   12224: 15 00 01 02  	add	c21, c0, #64            // =64
   12228: 03 00 00 14  	b	0x12234 <tpool_worker+0x30>
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   1222c: 60 d2 c1 c2  	mov	c0, c19
   12230: cc 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   12234: 60 d2 c1 c2  	mov	c0, c19
   12238: ce 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
;     while (wq->work_head == NULL && !wq->stop)                                  
   1223c: 80 02 40 c2  	ldr	c0, [c20, #0]
   12240: 00 01 00 b5  	cbnz	x0, 0x12260 <tpool_worker+0x5c>
   12244: 88 82 41 39  	ldrb	w8, [c20, #96]
   12248: 48 05 00 35  	cbnz	w8, 0x122f0 <tpool_worker+0xec>
;       pthread_cond_wait(&(wq->work_cond), &(wq->work_mutex));                   
   1224c: c0 d2 c1 c2  	mov	c0, c22
   12250: 61 d2 c1 c2  	mov	c1, c19
   12254: cb 04 00 94  	bl	0x13580 <xbrtime_api_asm.s+0x13580>
;     while (wq->work_head == NULL && !wq->stop)                                  
   12258: 80 02 40 c2  	ldr	c0, [c20, #0]
   1225c: 40 ff ff b4  	cbz	x0, 0x12244 <tpool_worker+0x40>
;     if (wq->stop)                                                               
   12260: 88 82 41 39  	ldrb	w8, [c20, #96]
   12264: 68 04 00 35  	cbnz	w8, 0x122f0 <tpool_worker+0xec>
;   if (wq == NULL)                                                               
   12268: f4 00 00 b4  	cbz	x20, 0x12284 <tpool_worker+0x80>
;   work = wq->work_head;                                                         
   1226c: 97 02 40 c2  	ldr	c23, [c20, #0]
;   if (work == NULL)                                                             
   12270: b7 00 00 b4  	cbz	x23, 0x12284 <tpool_worker+0x80>
;   if (work->next == NULL) {                                                     
   12274: e0 0a 40 c2  	ldr	c0, [c23, #32]
   12278: a0 00 00 b4  	cbz	x0, 0x1228c <tpool_worker+0x88>
;     wq->work_head = work->next;                                                 
   1227c: 80 02 00 c2  	str	c0, [c20, #0]
   12280: 05 00 00 14  	b	0x12294 <tpool_worker+0x90>
   12284: f7 03 1f aa  	mov	x23, xzr
   12288: 03 00 00 14  	b	0x12294 <tpool_worker+0x90>
   1228c: 00 e4 00 6f  	movi	v0.2d, #0000000000000000
;     wq->work_tail = NULL;                                                       
   12290: 80 02 00 ad  	stp	q0, q0, [c20]
;     wq->working_cnt++;                                                          
   12294: 88 2a 40 f9  	ldr	x8, [c20, #80]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   12298: 60 d2 c1 c2  	mov	c0, c19
;     wq->working_cnt++;                                                          
   1229c: 08 05 00 91  	add	x8, x8, #1              // =1
   122a0: 88 2a 00 f9  	str	x8, [c20, #80]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   122a4: af 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;     if (work != NULL) {                                                         
   122a8: b7 00 00 b4  	cbz	x23, 0x122bc <tpool_worker+0xb8>
;       work->func(work->arg);                                                    
   122ac: e1 02 c0 42  	ldp	c1, c0, [c23, #0]
   122b0: 20 30 c2 c2  	blr	c1
;   free(work);                                                                   
   122b4: e0 d2 c1 c2  	mov	c0, c23
   122b8: b6 04 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   122bc: 60 d2 c1 c2  	mov	c0, c19
   122c0: ac 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
;     wq->working_cnt--;                                                          
   122c4: 88 2a 40 f9  	ldr	x8, [c20, #80]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   122c8: 89 82 41 39  	ldrb	w9, [c20, #96]
;     wq->working_cnt--;                                                          
   122cc: 08 05 00 d1  	sub	x8, x8, #1              // =1
   122d0: 88 2a 00 f9  	str	x8, [c20, #80]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   122d4: c9 fa ff 35  	cbnz	w9, 0x1222c <tpool_worker+0x28>
   122d8: a8 fa ff b5  	cbnz	x8, 0x1222c <tpool_worker+0x28>
   122dc: 80 02 40 c2  	ldr	c0, [c20, #0]
   122e0: 60 fa ff b5  	cbnz	x0, 0x1222c <tpool_worker+0x28>
;       pthread_cond_signal(&(wq->working_cond));                                 
   122e4: a0 d2 c1 c2  	mov	c0, c21
   122e8: ae 04 00 94  	bl	0x135a0 <xbrtime_api_asm.s+0x135a0>
   122ec: d0 ff ff 17  	b	0x1222c <tpool_worker+0x28>
;   wq->num_threads--;                                                            
   122f0: 88 2e 40 f9  	ldr	x8, [c20, #88]
;   pthread_cond_signal(&(wq->working_cond));                                     
   122f4: a0 d2 c1 c2  	mov	c0, c21
;   wq->num_threads--;                                                            
   122f8: 08 05 00 d1  	sub	x8, x8, #1              // =1
   122fc: 88 2e 00 f9  	str	x8, [c20, #88]
;   pthread_cond_signal(&(wq->working_cond));                                     
   12300: a8 04 00 94  	bl	0x135a0 <xbrtime_api_asm.s+0x135a0>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12304: 60 d2 c1 c2  	mov	c0, c19
   12308: 96 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;   return NULL;                                                                  
   1230c: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   12310: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   12314: f7 0b 40 c2  	ldr	c23, [csp, #32]
   12318: e0 03 1f aa  	mov	x0, xzr
   1231c: fd fb c3 22  	ldp	c29, c30, [csp], #112
   12320: c0 53 c2 c2  	ret	c30

0000000000012324 <tpool_destroy>:
; {                                                                               
   12324: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   12328: f6 57 81 42  	stp	c22, c21, [csp, #32]
   1232c: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   12330: fd d3 c1 c2  	mov	c29, csp
   12334: 13 d0 c1 c2  	mov	c19, c0
;   if (wq == NULL)                                                               
   12338: 73 05 00 b4  	cbz	x19, 0x123e4 <tpool_destroy+0xc0>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   1233c: 74 82 00 02  	add	c20, c19, #32           // =32
   12340: 80 d2 c1 c2  	mov	c0, c20
   12344: 8b 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
;   work = wq->work_head;                                                         
   12348: 60 02 40 c2  	ldr	c0, [c19, #0]
;   while (work != NULL) {                                                        
   1234c: a0 00 00 b4  	cbz	x0, 0x12360 <tpool_destroy+0x3c>
;     work2 = work->next;                                                         
   12350: 15 08 40 c2  	ldr	c21, [c0, #32]
;   free(work);                                                                   
   12354: 8f 04 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
   12358: a0 d2 c1 c2  	mov	c0, c21
;   while (work != NULL) {                                                        
   1235c: b5 ff ff b5  	cbnz	x21, 0x12350 <tpool_destroy+0x2c>
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   12360: 75 c2 00 02  	add	c21, c19, #48           // =48
   12364: 28 00 80 52  	mov	w8, #1
   12368: a0 d2 c1 c2  	mov	c0, c21
;   wq->stop = true;                                                              
   1236c: 68 82 01 39  	strb	w8, [c19, #96]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   12370: 90 04 00 94  	bl	0x135b0 <xbrtime_api_asm.s+0x135b0>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12374: 80 d2 c1 c2  	mov	c0, c20
   12378: 7a 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   1237c: 80 d2 c1 c2  	mov	c0, c20
   12380: 7c 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
   12384: 76 02 01 02  	add	c22, c19, #64           // =64
   12388: 06 00 00 14  	b	0x123a0 <tpool_destroy+0x7c>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   1238c: 68 2a 40 f9  	ldr	x8, [c19, #80]
   12390: 08 01 00 b4  	cbz	x8, 0x123b0 <tpool_destroy+0x8c>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   12394: c0 d2 c1 c2  	mov	c0, c22
   12398: 81 d2 c1 c2  	mov	c1, c20
   1239c: 79 04 00 94  	bl	0x13580 <xbrtime_api_asm.s+0x13580>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   123a0: 68 82 41 39  	ldrb	w8, [c19, #96]
   123a4: 48 ff ff 34  	cbz	w8, 0x1238c <tpool_destroy+0x68>
;         (wq->stop && wq->num_threads != 0)) {                                   
   123a8: 68 2e 40 f9  	ldr	x8, [c19, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   123ac: 48 ff ff b5  	cbnz	x8, 0x12394 <tpool_destroy+0x70>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   123b0: 80 d2 c1 c2  	mov	c0, c20
   123b4: 6b 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;   pthread_mutex_destroy(&(wq->work_mutex));                                     
   123b8: 80 d2 c1 c2  	mov	c0, c20
   123bc: 81 04 00 94  	bl	0x135c0 <xbrtime_api_asm.s+0x135c0>
;   pthread_cond_destroy(&(wq->work_cond));                                       
   123c0: a0 d2 c1 c2  	mov	c0, c21
   123c4: 83 04 00 94  	bl	0x135d0 <xbrtime_api_asm.s+0x135d0>
;   pthread_cond_destroy(&(wq->working_cond));                                    
   123c8: c0 d2 c1 c2  	mov	c0, c22
   123cc: 81 04 00 94  	bl	0x135d0 <xbrtime_api_asm.s+0x135d0>
;   free(wq);                                                                     
   123d0: 60 d2 c1 c2  	mov	c0, c19
   123d4: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   123d8: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   123dc: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   123e0: 6c 04 00 14  	b	0x13590 <xbrtime_api_asm.s+0x13590>
; }     
   123e4: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   123e8: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   123ec: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   123f0: c0 53 c2 c2  	ret	c30

00000000000123f4 <tpool_wait>:
; {                                                                               
   123f4: fd fb bd 62  	stp	c29, c30, [csp, #-80]!
   123f8: f5 0b 00 c2  	str	c21, [csp, #32]
   123fc: f4 cf 81 42  	stp	c20, c19, [csp, #48]
   12400: fd d3 c1 c2  	mov	c29, csp
   12404: 13 d0 c1 c2  	mov	c19, c0
;   if (wq == NULL) // Will only return when there is no work.                    
   12408: 93 02 00 b4  	cbz	x19, 0x12458 <tpool_wait+0x64>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   1240c: 74 82 00 02  	add	c20, c19, #32           // =32
   12410: 80 d2 c1 c2  	mov	c0, c20
   12414: 57 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
   12418: 75 02 01 02  	add	c21, c19, #64           // =64
   1241c: 06 00 00 14  	b	0x12434 <tpool_wait+0x40>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12420: 68 2a 40 f9  	ldr	x8, [c19, #80]
   12424: 08 01 00 b4  	cbz	x8, 0x12444 <tpool_wait+0x50>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   12428: a0 d2 c1 c2  	mov	c0, c21
   1242c: 81 d2 c1 c2  	mov	c1, c20
   12430: 54 04 00 94  	bl	0x13580 <xbrtime_api_asm.s+0x13580>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12434: 68 82 41 39  	ldrb	w8, [c19, #96]
   12438: 48 ff ff 34  	cbz	w8, 0x12420 <tpool_wait+0x2c>
;         (wq->stop && wq->num_threads != 0)) {                                   
   1243c: 68 2e 40 f9  	ldr	x8, [c19, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12440: 48 ff ff b5  	cbnz	x8, 0x12428 <tpool_wait+0x34>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12444: 80 d2 c1 c2  	mov	c0, c20
   12448: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   1244c: f5 0b 40 c2  	ldr	c21, [csp, #32]
   12450: fd fb c2 22  	ldp	c29, c30, [csp], #80
   12454: 43 04 00 14  	b	0x13560 <xbrtime_api_asm.s+0x13560>
; } 
   12458: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   1245c: f5 0b 40 c2  	ldr	c21, [csp, #32]
   12460: fd fb c2 22  	ldp	c29, c30, [csp], #80
   12464: c0 53 c2 c2  	ret	c30

0000000000012468 <tpool_add_work>:
; {    
   12468: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   1246c: f6 57 81 42  	stp	c22, c21, [csp, #32]
   12470: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   12474: fd d3 c1 c2  	mov	c29, csp
   12478: 13 d0 c1 c2  	mov	c19, c0
   1247c: e0 03 1f 2a  	mov	w0, wzr
;   if (wq == NULL)                                                               
   12480: b3 03 00 b4  	cbz	x19, 0x124f4 <tpool_add_work+0x8c>
   12484: 36 d0 c1 c2  	mov	c22, c1
;   if (wq == NULL)                                                               
   12488: 76 03 00 b4  	cbz	x22, 0x124f4 <tpool_add_work+0x8c>
;   work       = malloc(sizeof(*work));                                           
   1248c: 00 06 80 52  	mov	w0, #48
   12490: 55 d0 c1 c2  	mov	c21, c2
   12494: 1b 04 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   12498: 14 d0 c1 c2  	mov	c20, c0
;   work->func = func;                                                            
   1249c: 16 54 80 42  	stp	c22, c21, [c0, #0]
;   work->next = NULL;                                                            
   124a0: 1f 08 00 c2  	str	czr, [c0, #32]
;   if (work == NULL)                                                             
   124a4: 54 01 00 b4  	cbz	x20, 0x124cc <tpool_add_work+0x64>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   124a8: 75 82 00 02  	add	c21, c19, #32           // =32
   124ac: a0 d2 c1 c2  	mov	c0, c21
   124b0: 30 04 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
;   if (wq->work_head == NULL) {                                                  
   124b4: 60 02 40 c2  	ldr	c0, [c19, #0]
   124b8: e0 00 00 b4  	cbz	x0, 0x124d4 <tpool_add_work+0x6c>
;     wq->work_tail->next = work;                                                 
   124bc: 60 d2 c1 c2  	mov	c0, c19
   124c0: 01 1c 40 a2  	ldr	c1, [c0, #16]!
   124c4: 34 08 00 c2  	str	c20, [c1, #32]
   124c8: 05 00 00 14  	b	0x124dc <tpool_add_work+0x74>
   124cc: e0 03 1f 2a  	mov	w0, wzr
   124d0: 09 00 00 14  	b	0x124f4 <tpool_add_work+0x8c>
;     wq->work_head = work;                                                       
   124d4: 60 d2 c1 c2  	mov	c0, c19
   124d8: 14 14 00 a2  	str	c20, [c0], #16
   124dc: 14 00 00 c2  	str	c20, [c0, #0]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   124e0: 60 c2 00 02  	add	c0, c19, #48            // =48
   124e4: 33 04 00 94  	bl	0x135b0 <xbrtime_api_asm.s+0x135b0>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   124e8: a0 d2 c1 c2  	mov	c0, c21
   124ec: 1d 04 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
   124f0: 20 00 80 52  	mov	w0, #1
; }                                                                               
   124f4: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   124f8: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   124fc: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   12500: c0 53 c2 c2  	ret	c30

0000000000012504 <__xbrtime_ctor>:
; __attribute__((constructor)) void __xbrtime_ctor(){
   12504: ff c3 81 02  	sub	csp, csp, #112          // =112
   12508: fd fb 81 42  	stp	c29, c30, [csp, #48]
   1250c: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   12510: fd c3 00 02  	add	c29, csp, #48           // =48
;   printf("[M] Entered __xbrtime_ctor()\n");
   12514: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x54>
   12518: 00 2c 42 c2  	ldr	c0, [c0, #2224]
   1251c: 31 04 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   xb_barrier = malloc(sizeof(uint64_t)*2*10);	
   12520: 00 14 80 52  	mov	w0, #160
   12524: f7 03 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   12528: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0x68>
   1252c: 21 2c 43 c2  	ldr	c1, [c1, #3248]
   12530: 20 00 00 c2  	str	c0, [c1, #0]
;   char *str = getenv("NUM_OF_THREADS");
   12534: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x74>
   12538: 00 b4 41 c2  	ldr	c0, [c0, #1744]
   1253c: 2d 04 00 94  	bl	0x135f0 <xbrtime_api_asm.s+0x135f0>
;   if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
   12540: 40 02 00 b4  	cbz	x0, 0x12588 <__xbrtime_ctor+0x84>
   12544: 2f 04 00 94  	bl	0x13600 <xbrtime_api_asm.s+0x13600>
   12548: 08 04 00 51  	sub	w8, w0, #1              // =1
   1254c: 1f 3d 00 71  	cmp	w8, #15                 // =15
   12550: e9 04 00 54  	b.ls	0x125ec <__xbrtime_ctor+0xe8>
;       fprintf(stderr, "\nNUM_OF_THREADS should be between %d and %d\n",
   12554: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x94>
   12558: 00 30 43 c2  	ldr	c0, [c0, #3264]
   1255c: 08 02 80 52  	mov	w8, #16
   12560: e1 3b d0 c2  	scbnds	c1, csp, #32            // =32
   12564: e8 0b 00 f9  	str	x8, [csp, #16]
   12568: 00 00 40 c2  	ldr	c0, [c0, #0]
   1256c: 29 70 c6 c2  	clrperm	c9, c1, wx
   12570: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0xb0>
   12574: 21 bc 41 c2  	ldr	c1, [c1, #1776]
   12578: 2a 00 80 52  	mov	w10, #1
   1257c: ea 03 00 f9  	str	x10, [csp]
   12580: 24 04 00 94  	bl	0x13610 <xbrtime_api_asm.s+0x13610>
   12584: 09 00 00 14  	b	0x125a8 <__xbrtime_ctor+0xa4>
;       fprintf(stderr, "\nNUM_OF_THREADS not set; set environment first!\n");
   12588: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0xc8>
   1258c: 00 30 43 c2  	ldr	c0, [c0, #3264]
   12590: 01 06 80 52  	mov	w1, #48
   12594: 22 00 80 52  	mov	w2, #1
   12598: 03 00 40 c2  	ldr	c3, [c0, #0]
   1259c: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0xdc>
   125a0: 00 b8 41 c2  	ldr	c0, [c0, #1760]
   125a4: 1f 04 00 94  	bl	0x13620 <xbrtime_api_asm.s+0x13620>
   125a8: a0 33 80 02  	sub	c0, c29, #12            // =12
   125ac: 13 38 c5 c2  	scbnds	c19, c0, #10            // =10
;     char envValue[10] = "";
   125b0: 7f 12 00 79  	strh	wzr, [c19, #8]
   125b4: 7f 02 00 f9  	str	xzr, [c19]
;     sprintf(envValue, "%d", numOfThreads);
   125b8: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_ctor+0xf8>
   125bc: 21 c0 41 c2  	ldr	c1, [c1, #1792]
   125c0: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   125c4: 08 02 80 52  	mov	w8, #16
   125c8: 09 70 c6 c2  	clrperm	c9, c0, wx
   125cc: 60 d2 c1 c2  	mov	c0, c19
   125d0: e8 03 00 f9  	str	x8, [csp]
   125d4: 17 04 00 94  	bl	0x13630 <xbrtime_api_asm.s+0x13630>
;     setenv(envName, envValue, 1);
   125d8: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x118>
   125dc: 00 b4 41 c2  	ldr	c0, [c0, #1744]
   125e0: 22 00 80 52  	mov	w2, #1
   125e4: 61 d2 c1 c2  	mov	c1, c19
   125e8: 16 04 00 94  	bl	0x13640 <xbrtime_api_asm.s+0x13640>
;   numOfThreads = atoi(getenv("NUM_OF_THREADS"));
   125ec: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_ctor+0x12c>
   125f0: 00 b4 41 c2  	ldr	c0, [c0, #1744]
   125f4: ff 03 00 94  	bl	0x135f0 <xbrtime_api_asm.s+0x135f0>
   125f8: 02 04 00 94  	bl	0x13600 <xbrtime_api_asm.s+0x13600>
;   fprintf(stdout, "\nNumber of threads: %d\n", numOfThreads);
   125fc: 94 00 80 b0  	adrp	c20, 0x23000 <__xbrtime_ctor+0x13c>
   12600: 94 36 43 c2  	ldr	c20, [c20, #3280]
;   numOfThreads = atoi(getenv("NUM_OF_THREADS"));
   12604: f3 03 00 2a  	mov	w19, w0
;   fprintf(stdout, "\nNumber of threads: %d\n", numOfThreads);
   12608: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   1260c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12610: 82 02 40 c2  	ldr	c2, [c20, #0]
   12614: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_dtor+0x4>
   12618: 21 c4 41 c2  	ldr	c1, [c1, #1808]
   1261c: f3 03 00 f9  	str	x19, [csp]
   12620: 40 d0 c1 c2  	mov	c0, c2
   12624: fb 03 00 94  	bl	0x13610 <xbrtime_api_asm.s+0x13610>
;   fflush(stdout);
   12628: 80 02 40 c2  	ldr	c0, [c20, #0]
   1262c: 09 04 00 94  	bl	0x13650 <xbrtime_api_asm.s+0x13650>
;   pool = tpool_create(numOfThreads);
   12630: 60 7e 40 93  	sxtw	x0, w19
   12634: c8 fe ff 97  	bl	0x12154 <tpool_create>
   12638: 81 00 80 b0  	adrp	c1, 0x23000 <__xbrtime_dtor+0x28>
   1263c: 21 38 43 c2  	ldr	c1, [c1, #3296]
; }
   12640: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   12644: fd fb c1 42  	ldp	c29, c30, [csp, #48]
;   pool = tpool_create(numOfThreads);
   12648: 20 00 00 c2  	str	c0, [c1, #0]
; }
   1264c: ff c3 01 02  	add	csp, csp, #112          // =112
   12650: c0 53 c2 c2  	ret	c30

0000000000012654 <__xbrtime_dtor>:
; __attribute__((destructor)) void __xbrtime_dtor(){
   12654: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   12658: f6 57 81 42  	stp	c22, c21, [csp, #32]
   1265c: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   12660: fd d3 c1 c2  	mov	c29, csp
;   printf("[M] Entered __xbrtime_dtor()\n");
   12664: 80 00 80 b0  	adrp	c0, 0x23000 <__xbrtime_dtor+0x54>
   12668: 00 30 42 c2  	ldr	c0, [c0, #2240]
   1266c: dd 03 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   tpool_wait(pool);
   12670: 95 00 80 b0  	adrp	c21, 0x23000 <__xbrtime_dtor+0x60>
   12674: b5 3a 43 c2  	ldr	c21, [c21, #3296]
   12678: b6 02 40 c2  	ldr	c22, [c21, #0]
;   if (wq == NULL) // Will only return when there is no work.                    
   1267c: 36 02 00 b4  	cbz	x22, 0x126c0 <__xbrtime_dtor+0x6c>
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   12680: d3 82 00 02  	add	c19, c22, #32           // =32
   12684: 60 d2 c1 c2  	mov	c0, c19
   12688: ba 03 00 94  	bl	0x13570 <xbrtime_api_asm.s+0x13570>
   1268c: d4 02 01 02  	add	c20, c22, #64           // =64
   12690: 06 00 00 14  	b	0x126a8 <__xbrtime_dtor+0x54>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12694: c8 2a 40 f9  	ldr	x8, [c22, #80]
   12698: 08 01 00 b4  	cbz	x8, 0x126b8 <__xbrtime_dtor+0x64>
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   1269c: 80 d2 c1 c2  	mov	c0, c20
   126a0: 61 d2 c1 c2  	mov	c1, c19
   126a4: b7 03 00 94  	bl	0x13580 <xbrtime_api_asm.s+0x13580>
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   126a8: c8 82 41 39  	ldrb	w8, [c22, #96]
   126ac: 48 ff ff 34  	cbz	w8, 0x12694 <__xbrtime_dtor+0x40>
;         (wq->stop && wq->num_threads != 0)) {                                   
   126b0: c8 2e 40 f9  	ldr	x8, [c22, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   126b4: 48 ff ff b5  	cbnz	x8, 0x1269c <__xbrtime_dtor+0x48>
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   126b8: 60 d2 c1 c2  	mov	c0, c19
   126bc: a9 03 00 94  	bl	0x13560 <xbrtime_api_asm.s+0x13560>
;   tpool_destroy(pool); 
   126c0: a0 02 40 c2  	ldr	c0, [c21, #0]
   126c4: 18 ff ff 97  	bl	0x12324 <tpool_destroy>
;   free ((void*)xb_barrier); 	
   126c8: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_close+0x28>
   126cc: 00 2c 43 c2  	ldr	c0, [c0, #3248]
   126d0: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   126d4: f6 57 c1 42  	ldp	c22, c21, [csp, #32]
   126d8: 00 00 40 c2  	ldr	c0, [c0, #0]
   126dc: fd 7b c3 22  	ldp	c29, c30, [csp], #96
   126e0: ac 03 00 14  	b	0x13590 <xbrtime_api_asm.s+0x13590>

00000000000126e4 <xbrtime_close>:
; extern void xbrtime_close(){
   126e4: fd fb bd 62  	stp	c29, c30, [csp, #-80]!
   126e8: f5 0b 00 c2  	str	c21, [csp, #32]
   126ec: f4 cf 81 42  	stp	c20, c19, [csp, #48]
   126f0: fd d3 c1 c2  	mov	c29, csp
;   if( __XBRTIME_CONFIG != NULL ){
   126f4: 93 00 80 b0  	adrp	c19, 0x23000 <xbrtime_close+0x54>
   126f8: 73 3e 43 c2  	ldr	c19, [c19, #3312]
   126fc: 60 02 40 c2  	ldr	c0, [c19, #0]
   12700: 80 03 00 b4  	cbz	x0, 0x12770 <xbrtime_close+0x8c>
;     __xbrtime_asm_fence();
   12704: 63 03 00 94  	bl	0x13490 <__xbrtime_asm_fence>
   12708: 14 01 80 52  	mov	w20, #8
   1270c: 15 00 81 52  	mov	w21, #2048
   12710: 04 00 00 14  	b	0x12720 <xbrtime_close+0x3c>
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   12714: b5 06 00 f1  	subs	x21, x21, #1            // =1
   12718: 94 42 00 91  	add	x20, x20, #16           // =16
   1271c: 40 01 00 54  	b.eq	0x12744 <xbrtime_close+0x60>
;       if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
   12720: 60 02 40 c2  	ldr	c0, [c19, #0]
   12724: 00 0c 40 c2  	ldr	c0, [c0, #48]
   12728: 08 68 74 f8  	ldr	x8, [c0, x20]
   1272c: 48 ff ff b4  	cbz	x8, 0x12714 <xbrtime_close+0x30>
;         xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
   12730: 00 60 b4 c2  	add	c0, c0, x20, uxtx
   12734: 08 80 5f f8  	ldur	x8, [c0, #-8]
;   if( ptr == NULL ){
   12738: e8 fe ff b4  	cbz	x8, 0x12714 <xbrtime_close+0x30>
;   __xbrtime_asm_quiet_fence();
   1273c: 58 03 00 94  	bl	0x1349c <__xbrtime_asm_quiet_fence>
   12740: f5 ff ff 17  	b	0x12714 <xbrtime_close+0x30>
;     if( __XBRTIME_CONFIG->_MAP != NULL ){
   12744: 60 02 40 c2  	ldr	c0, [c19, #0]
   12748: 00 10 40 c2  	ldr	c0, [c0, #64]
   1274c: 80 00 00 b4  	cbz	x0, 0x1275c <xbrtime_close+0x78>
;       free( __XBRTIME_CONFIG->_MAP );
   12750: 90 03 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
;       __XBRTIME_CONFIG->_MAP = NULL;
   12754: 60 02 40 c2  	ldr	c0, [c19, #0]
   12758: 1f 10 00 c2  	str	czr, [c0, #64]
;     free( __XBRTIME_CONFIG );
   1275c: 60 02 40 c2  	ldr	c0, [c19, #0]
   12760: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   12764: f5 0b 40 c2  	ldr	c21, [csp, #32]
   12768: fd fb c2 22  	ldp	c29, c30, [csp], #80
   1276c: 89 03 00 14  	b	0x13590 <xbrtime_api_asm.s+0x13590>
; }
   12770: f4 cf c1 42  	ldp	c20, c19, [csp, #48]
   12774: f5 0b 40 c2  	ldr	c21, [csp, #32]
   12778: fd fb c2 22  	ldp	c29, c30, [csp], #80
   1277c: c0 53 c2 c2  	ret	c30

0000000000012780 <xbrtime_init>:
; extern int xbrtime_init(){
   12780: ff 83 81 02  	sub	csp, csp, #96           // =96
   12784: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   12788: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   1278c: fd 83 00 02  	add	c29, csp, #32           // =32
;   printf("[M] Entered xbrtime_init()\n");
   12790: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x54>
   12794: 00 34 42 c2  	ldr	c0, [c0, #2256]
   12798: 92 03 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __XBRTIME_CONFIG = malloc( sizeof( XBRTIME_DATA ) );
   1279c: 00 0a 80 52  	mov	w0, #80
   127a0: 58 03 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   127a4: 94 00 80 b0  	adrp	c20, 0x23000 <xbrtime_init+0x68>
   127a8: 94 3e 43 c2  	ldr	c20, [c20, #3312]
   127ac: 13 d0 c1 c2  	mov	c19, c0
   127b0: 80 02 00 c2  	str	c0, [c20, #0]
;   if( __XBRTIME_CONFIG == NULL ){
   127b4: b3 0a 00 b4  	cbz	x19, 0x12908 <xbrtime_init+0x188>
;   __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
   127b8: 00 00 90 52  	mov	w0, #32768
   127bc: 51 03 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   127c0: 08 20 a0 52  	mov	w8, #16777216
;   __XBRTIME_CONFIG->_SENSE      = 0x00ull;    // __xbrtime_asm_get_sense();
   127c4: 7f 7e 01 a9  	stp	xzr, xzr, [c19, #16]
;   __XBRTIME_CONFIG->_MEMSIZE    = 4096 * 4096;// __xbrtime_asm_get_memsize();
   127c8: 68 02 00 f9  	str	x8, [c19]
;   __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; // malloc(sizeof(uint64_t)*2*10);
   127cc: 81 00 80 b0  	adrp	c1, 0x23000 <xbrtime_init+0x90>
   127d0: 21 2c 43 c2  	ldr	c1, [c1, #3248]
   127d4: 09 01 80 52  	mov	w9, #8
;   __XBRTIME_CONFIG->_ID         = 0;          // __xbrtime_asm_get_id();
   127d8: 7f 26 01 29  	stp	wzr, w9, [c19, #8]
   127dc: 49 55 95 d2  	mov	x9, #43690
;   __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; // malloc(sizeof(uint64_t)*2*10);
   127e0: 21 00 40 c2  	ldr	c1, [c1, #0]
   127e4: 49 55 b5 f2  	movk	x9, #43690, lsl #16
   127e8: e8 8f 40 b2  	mov	x8, #68719476735
   127ec: 49 01 c0 f2  	movk	x9, #10, lsl #32
;   __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
   127f0: 61 02 81 42  	stp	c1, c0, [c19, #32]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127f4: 28 00 00 f9  	str	x8, [c1]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   127f8: 29 28 00 f9  	str	x9, [c1, #80]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   127fc: 28 04 00 f9  	str	x8, [c1, #8]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12800: 29 2c 00 f9  	str	x9, [c1, #88]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12804: 28 08 00 f9  	str	x8, [c1, #16]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12808: 29 30 00 f9  	str	x9, [c1, #96]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1280c: 28 0c 00 f9  	str	x8, [c1, #24]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12810: 29 34 00 f9  	str	x9, [c1, #104]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12814: 28 10 00 f9  	str	x8, [c1, #32]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12818: 29 38 00 f9  	str	x9, [c1, #112]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1281c: 28 14 00 f9  	str	x8, [c1, #40]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12820: 29 3c 00 f9  	str	x9, [c1, #120]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12824: 28 18 00 f9  	str	x8, [c1, #48]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12828: 29 40 00 f9  	str	x9, [c1, #128]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1282c: 28 1c 00 f9  	str	x8, [c1, #56]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12830: 29 44 00 f9  	str	x9, [c1, #136]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12834: 28 20 00 f9  	str	x8, [c1, #64]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12838: 29 48 00 f9  	str	x9, [c1, #144]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   1283c: 28 24 00 f9  	str	x8, [c1, #72]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12840: 29 4c 00 f9  	str	x9, [c1, #152]
; 	printf("PE:%d----BARRIER[O] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[0]);
   12844: 28 00 40 f9  	ldr	x8, [c1]
   12848: e0 3b d0 c2  	scbnds	c0, csp, #32            // =32
   1284c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12850: e8 0b 00 f9  	str	x8, [csp, #16]
   12854: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x118>
   12858: 00 c8 41 c2  	ldr	c0, [c0, #1824]
   1285c: ff 03 00 f9  	str	xzr, [csp]
   12860: 80 03 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[1]);
   12864: 80 02 40 c2  	ldr	c0, [c20, #0]
   12868: 01 08 40 c2  	ldr	c1, [c0, #32]
   1286c: 28 04 40 f9  	ldr	x8, [c1, #8]
   12870: 0a 08 40 b9  	ldr	w10, [c0, #8]
   12874: e0 3b d0 c2  	scbnds	c0, csp, #32            // =32
   12878: 09 70 c6 c2  	clrperm	c9, c0, wx
   1287c: e8 0b 00 f9  	str	x8, [csp, #16]
   12880: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x144>
   12884: 00 cc 41 c2  	ldr	c0, [c0, #1840]
   12888: ea 03 00 f9  	str	x10, [csp]
   1288c: 75 03 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   if( __XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE ){
   12890: 93 02 40 c2  	ldr	c19, [c20, #0]
   12894: 68 0e 80 b9  	ldrsw	x8, [c19, #12]
   12898: 1f 05 10 71  	cmp	w8, #1025               // =1025
   1289c: 2a 03 00 54  	b.ge	0x12900 <xbrtime_init+0x180>
;   __XBRTIME_CONFIG->_MAP = malloc( sizeof( XBRTIME_PE_MAP ) *
   128a0: 00 ed 7c d3  	lsl	x0, x8, #4
   128a4: 17 03 00 94  	bl	0x13500 <xbrtime_api_asm.s+0x13500>
   128a8: 60 12 00 c2  	str	c0, [c19, #64]
;   if( __XBRTIME_CONFIG->_MAP == NULL ){
   128ac: a0 02 00 b4  	cbz	x0, 0x12900 <xbrtime_init+0x180>
;   printf("[M] init the pe mapping block\n");
   128b0: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x174>
   128b4: 00 38 42 c2  	ldr	c0, [c0, #2272]
   128b8: 4a 03 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
   128bc: 80 02 40 c2  	ldr	c0, [c20, #0]
;     __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
   128c0: 02 00 90 52  	mov	w2, #32768
   128c4: e1 03 1f 2a  	mov	w1, wzr
   128c8: 00 0c 40 c2  	ldr	c0, [c0, #48]
   128cc: 69 03 00 94  	bl	0x13670 <xbrtime_api_asm.s+0x13670>
;   printf("[M] init the memory allocation slots\n");
   128d0: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_init+0x194>
   128d4: 00 3c 42 c2  	ldr	c0, [c0, #2288]
   128d8: 42 03 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
   128dc: 80 02 40 c2  	ldr	c0, [c20, #0]
   128e0: 08 0c 40 b9  	ldr	w8, [c0, #12]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128e4: 1f 05 00 71  	cmp	w8, #1                  // =1
   128e8: 2b 04 00 54  	b.lt	0x1296c <xbrtime_init+0x1ec>
   128ec: 00 10 40 c2  	ldr	c0, [c0, #64]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   128f0: 1f 05 00 71  	cmp	w8, #1                  // =1
   128f4: 41 01 00 54  	b.ne	0x1291c <xbrtime_init+0x19c>
   128f8: e9 03 1f aa  	mov	x9, xzr
   128fc: 14 00 00 14  	b	0x1294c <xbrtime_init+0x1cc>
   12900: 60 d2 c1 c2  	mov	c0, c19
   12904: 23 03 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
   12908: 00 00 80 12  	mov	w0, #-1
; }
   1290c: f4 4f c2 42  	ldp	c20, c19, [csp, #64]
   12910: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   12914: ff 83 01 02  	add	csp, csp, #96           // =96
   12918: c0 53 c2 c2  	ret	c30
   1291c: ea 03 1f aa  	mov	x10, xzr
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12920: 09 79 7f 92  	and	x9, x8, #0xfffffffe
   12924: 01 50 00 02  	add	c1, c0, #20             // =20
;     __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
   12928: 4b 05 00 11  	add	w11, w10, #1            // =1
   1292c: 2a ac 3d 29  	stp	w10, w11, [c1, #-20]
   12930: 4a 09 00 91  	add	x10, x10, #2            // =2
   12934: 2b a8 3f 29  	stp	w11, w10, [c1, #-4]
   12938: 3f 01 0a eb  	cmp	x9, x10
   1293c: 21 80 00 02  	add	c1, c1, #32             // =32
   12940: 41 ff ff 54  	b.ne	0x12928 <xbrtime_init+0x1a8>
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12944: 3f 01 08 eb  	cmp	x9, x8
   12948: 20 01 00 54  	b.eq	0x1296c <xbrtime_init+0x1ec>
   1294c: 8a 00 80 52  	mov	w10, #4
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12950: 2a 7d 7c b3  	bfi	x10, x9, #4, #32
   12954: 00 60 aa c2  	add	c0, c0, x10, uxtx
;     __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
   12958: 09 c0 1f b8  	stur	w9, [c0, #-4]
;     __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
   1295c: 29 05 00 91  	add	x9, x9, #1              // =1
   12960: 09 04 01 b8  	str	w9, [c0], #16
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12964: 1f 01 09 eb  	cmp	x8, x9
   12968: 81 ff ff 54  	b.ne	0x12958 <xbrtime_init+0x1d8>
;   printf("[M] init the PE mapping structure\n");
   1296c: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_num_pes+0x10>
   12970: 00 40 42 c2  	ldr	c0, [c0, #2304]
   12974: 1b 03 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
   12978: e0 03 1f 2a  	mov	w0, wzr
   1297c: e4 ff ff 17  	b	0x1290c <xbrtime_init+0x18c>

0000000000012980 <xbrtime_mype>:
;   if( __XBRTIME_CONFIG == NULL ){
   12980: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x4>
   12984: 00 3c 43 c2  	ldr	c0, [c0, #3312]
   12988: 00 00 40 c2  	ldr	c0, [c0, #0]
   1298c: 60 00 00 b4  	cbz	x0, 0x12998 <xbrtime_mype+0x18>
;   return __XBRTIME_CONFIG->_ID;
   12990: 00 08 40 b9  	ldr	w0, [c0, #8]
; }
   12994: c0 53 c2 c2  	ret	c30
   12998: 00 00 80 12  	mov	w0, #-1
; }
   1299c: c0 53 c2 c2  	ret	c30

00000000000129a0 <xbrtime_num_pes>:
;   if( __XBRTIME_CONFIG == NULL ){
   129a0: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x24>
   129a4: 00 3c 43 c2  	ldr	c0, [c0, #3312]
   129a8: 00 00 40 c2  	ldr	c0, [c0, #0]
   129ac: 60 00 00 b4  	cbz	x0, 0x129b8 <xbrtime_num_pes+0x18>
;   return __XBRTIME_CONFIG->_NPES;
   129b0: 00 0c 40 b9  	ldr	w0, [c0, #12]
; }
   129b4: c0 53 c2 c2  	ret	c30
   129b8: 00 00 80 12  	mov	w0, #-1
; }
   129bc: c0 53 c2 c2  	ret	c30

00000000000129c0 <xbrtime_ulonglong_get>:
;                            size_t nelems, int stride, int pe){
   129c0: ff 83 82 02  	sub	csp, csp, #160          // =160
   129c4: fd fb 82 42  	stp	c29, c30, [csp, #80]
   129c8: f5 1f 00 c2  	str	c21, [csp, #112]
   129cc: f4 4f 84 42  	stp	c20, c19, [csp, #128]
   129d0: fd 43 01 02  	add	c29, csp, #80           // =80
   129d4: 13 d0 c1 c2  	mov	c19, c0
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   129d8: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x5c>
   129dc: 00 44 42 c2  	ldr	c0, [c0, #2320]
   129e0: f5 03 02 aa  	mov	x21, x2
   129e4: 34 d0 c1 c2  	mov	c20, c1
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   129e8: fe 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   printf("\n========================\n");
   129ec: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x70>
   129f0: 00 48 42 c2  	ldr	c0, [c0, #2336]
   129f4: fb 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   129f8: 6c 92 c0 c2  	gctag	x12, c19
   129fc: 9f 01 00 f1  	cmp	x12, #0                 // =0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12a00: 69 32 c0 c2  	gclen	x9, c19
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   12a04: 6a 72 c0 c2  	gcoff	x10, c19
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   12a08: 6b d2 c0 c2  	gcperm	x11, c19
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12a0c: ec 07 9f 1a  	cset	w12, ne
;   printf("  DEST:\n"
   12a10: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12a14: ec 23 00 f9  	str	x12, [csp, #64]
   12a18: eb 1b 00 f9  	str	x11, [csp, #48]
   12a1c: ea 13 00 f9  	str	x10, [csp, #32]
   12a20: e9 0b 00 f9  	str	x9, [csp, #16]
   12a24: 09 70 c6 c2  	clrperm	c9, c0, wx
   12a28: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0xac>
   12a2c: 00 d0 41 c2  	ldr	c0, [c0, #1856]
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12a30: 68 12 c0 c2  	gcbase	x8, c19
;   printf("  DEST:\n"
   12a34: e8 03 00 f9  	str	x8, [csp]
   12a38: 0a 03 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("========================\n");
   12a3c: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0xc0>
   12a40: 00 4c 42 c2  	ldr	c0, [c0, #2352]
   12a44: e7 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12a48: 8c 92 c0 c2  	gctag	x12, c20
   12a4c: 9f 01 00 f1  	cmp	x12, #0                 // =0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12a50: 89 32 c0 c2  	gclen	x9, c20
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   12a54: 8a 72 c0 c2  	gcoff	x10, c20
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   12a58: 8b d2 c0 c2  	gcperm	x11, c20
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12a5c: ec 07 9f 1a  	cset	w12, ne
;   printf("  SRC:\n"
   12a60: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12a64: ec 23 00 f9  	str	x12, [csp, #64]
   12a68: eb 1b 00 f9  	str	x11, [csp, #48]
   12a6c: ea 13 00 f9  	str	x10, [csp, #32]
   12a70: e9 0b 00 f9  	str	x9, [csp, #16]
   12a74: 09 70 c6 c2  	clrperm	c9, c0, wx
   12a78: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0xfc>
   12a7c: 00 d4 41 c2  	ldr	c0, [c0, #1872]
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12a80: 88 12 c0 c2  	gcbase	x8, c20
;   printf("  SRC:\n"
   12a84: e8 03 00 f9  	str	x8, [csp]
   12a88: f6 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;     printf("========================\n\n");
   12a8c: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_ulonglong_get+0x110>
   12a90: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12a94: d3 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   if(nelems == 0){
   12a98: 75 01 00 b4  	cbz	x21, 0x12ac4 <xbrtime_ulonglong_get+0x104>
;     *dest = *src;
   12a9c: 88 02 40 f9  	ldr	x8, [c20]
   12aa0: 68 02 00 f9  	str	x8, [c19]
;   __xbrtime_asm_fence();
   12aa4: 7b 02 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   printf("[M] Exiting xbrtime_ulonglong_get()\n");
   12aa8: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x14>
   12aac: 00 54 42 c2  	ldr	c0, [c0, #2384]
   12ab0: f4 4f c4 42  	ldp	c20, c19, [csp, #128]
   12ab4: f5 1f 40 c2  	ldr	c21, [csp, #112]
   12ab8: fd fb c2 42  	ldp	c29, c30, [csp, #80]
   12abc: ff 83 02 02  	add	csp, csp, #160          // =160
   12ac0: c8 02 00 14  	b	0x135e0 <xbrtime_api_asm.s+0x135e0>
; }
   12ac4: f4 4f c4 42  	ldp	c20, c19, [csp, #128]
   12ac8: f5 1f 40 c2  	ldr	c21, [csp, #112]
   12acc: fd fb c2 42  	ldp	c29, c30, [csp, #80]
   12ad0: ff 83 02 02  	add	csp, csp, #160          // =160
   12ad4: c0 53 c2 c2  	ret	c30

0000000000012ad8 <xbrtime_barrier>:
; extern void xbrtime_barrier(){
   12ad8: ff c3 80 02  	sub	csp, csp, #48           // =48
   12adc: fd fb 80 42  	stp	c29, c30, [csp, #16]
   12ae0: fd 43 00 02  	add	c29, csp, #16           // =16
;   printf("[M] Entered xbrtime_barrier()\n");
   12ae4: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x50>
   12ae8: 00 58 42 c2  	ldr	c0, [c0, #2400]
   12aec: bd 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12af0: 68 02 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12af4: 80 00 80 b0  	adrp	c0, 0x23000 <xbrtime_barrier+0x60>
   12af8: 00 3c 43 c2  	ldr	c0, [c0, #3312]
   12afc: 00 00 40 c2  	ldr	c0, [c0, #0]
   12b00: 60 00 00 b4  	cbz	x0, 0x12b0c <xbrtime_barrier+0x34>
;   return __XBRTIME_CONFIG->_ID;
   12b04: 08 08 40 b9  	ldr	w8, [c0, #8]
   12b08: 02 00 00 14  	b	0x12b10 <xbrtime_barrier+0x38>
   12b0c: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12b10: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12b14: 09 70 c6 c2  	clrperm	c9, c0, wx
   12b18: 80 00 80 b0  	adrp	c0, 0x23000 <mysecond+0x20>
   12b1c: 00 d8 41 c2  	ldr	c0, [c0, #1888]
   12b20: e8 03 00 f9  	str	x8, [csp]
   12b24: cf 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12b28: 80 00 80 b0  	adrp	c0, 0x23000 <mysecond+0x30>
   12b2c: 00 5c 42 c2  	ldr	c0, [c0, #2416]
   12b30: fd fb c0 42  	ldp	c29, c30, [csp, #16]
   12b34: ff c3 00 02  	add	csp, csp, #48           // =48
   12b38: aa 02 00 14  	b	0x135e0 <xbrtime_api_asm.s+0x135e0>

0000000000012b3c <mysecond>:
; double mysecond() {
   12b3c: ff 03 81 02  	sub	csp, csp, #64           // =64
   12b40: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   12b44: fd 83 00 02  	add	c29, csp, #32           // =32
   12b48: e0 43 00 02  	add	c0, csp, #16            // =16
   12b4c: e1 23 00 02  	add	c1, csp, #8             // =8
   12b50: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12b54: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   12b58: ca 02 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12b5c: e0 07 41 6d  	ldp	d0, d1, [csp, #16]
   12b60: 60 ff ff f0  	adrp	c0, 0x1000 <xbrtime_barrier+0x44>
   12b64: 02 3c 45 fd  	ldr	d2, [c0, #2680]
   12b68: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   12b6c: 21 d8 61 5e  	scvtf	d1, d1
   12b70: 00 d8 61 5e  	scvtf	d0, d0
   12b74: 21 08 62 1e  	fmul	d1, d1, d2
   12b78: 20 28 60 1e  	fadd	d0, d1, d0
   12b7c: ff 03 01 02  	add	csp, csp, #64           // =64
   12b80: c0 53 c2 c2  	ret	c30

0000000000012b84 <PRINT>:
; void PRINT(double local, double remote, double t_init, double t_mem){
   12b84: ff 03 82 02  	sub	csp, csp, #128          // =128
   12b88: eb 2b 01 6d  	stp	d11, d10, [csp, #16]
   12b8c: e9 23 02 6d  	stp	d9, d8, [csp, #32]
   12b90: fd fb 81 42  	stp	c29, c30, [csp, #48]
   12b94: f5 17 00 c2  	str	c21, [csp, #80]
   12b98: f4 4f 83 42  	stp	c20, c19, [csp, #96]
   12b9c: fd c3 00 02  	add	c29, csp, #48           // =48
; 	printf("Time.init       = %f sec\n", t_init);	
   12ba0: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12ba4: 09 70 c6 c2  	clrperm	c9, c0, wx
   12ba8: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0x68>
   12bac: 00 dc 41 c2  	ldr	c0, [c0, #1904]
   12bb0: 28 0b e8 d2  	mov	x8, #4636737291354636288
   12bb4: 0a 01 67 9e  	fmov	d10, x8
; 	percent = (int64_t)(100*remote/ne);
   12bb8: 2b 08 6a 1e  	fmul	d11, d1, d10
   12bbc: 68 1c a3 4e  	mov	v8.16b, v3.16b
   12bc0: 09 1c a0 4e  	mov	v9.16b, v0.16b
; 	percent = (int64_t)(100*remote/ne);
   12bc4: 74 01 78 9e  	fcvtzs	x20, d11
; 	printf("Time.init       = %f sec\n", t_init);	
   12bc8: e2 03 00 fd  	str	d2, [csp]
   12bcc: a5 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("Time.transfer   = %f sec\n", t_mem);
   12bd0: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12bd4: 09 70 c6 c2  	clrperm	c9, c0, wx
   12bd8: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0x98>
   12bdc: 00 e0 41 c2  	ldr	c0, [c0, #1920]
   12be0: e8 03 00 fd  	str	d8, [csp]
   12be4: 9f 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("Remote Access   = " BRED "%.3f%%  " RESET, 100*remote/ne);
   12be8: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12bec: 09 70 c6 c2  	clrperm	c9, c0, wx
   12bf0: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xb0>
   12bf4: 00 e4 41 c2  	ldr	c0, [c0, #1936]
   12bf8: eb 03 00 fd  	str	d11, [csp]
   12bfc: 99 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("\n");
   12c00: 40 01 80 52  	mov	w0, #10
   12c04: a3 02 00 94  	bl	0x13690 <xbrtime_api_asm.s+0x13690>
; 	printf("Local  Access   = " BGRN "%.3f%%  " RESET, 100*local/ne);
   12c08: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12c0c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12c10: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xd0>
   12c14: 00 e8 41 c2  	ldr	c0, [c0, #1952]
   12c18: 20 09 6a 1e  	fmul	d0, d9, d10
   12c1c: e0 03 00 fd  	str	d0, [csp]
   12c20: 90 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("\n");
   12c24: 40 01 80 52  	mov	w0, #10
   12c28: 9a 02 00 94  	bl	0x13690 <xbrtime_api_asm.s+0x13690>
; 	printf("------------------------------------------\n");
   12c2c: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xec>
   12c30: 00 60 42 c2  	ldr	c0, [c0, #2432]
   12c34: 6b 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 	printf("Request Distribution:  [");
   12c38: 80 00 80 b0  	adrp	c0, 0x23000 <PRINT+0xf8>
   12c3c: 00 ec 41 c2  	ldr	c0, [c0, #1968]
   12c40: e9 03 1f aa  	mov	x9, xzr
   12c44: 87 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	for(i = 0; i < percent; i++)
   12c48: 9f 06 00 f1  	cmp	x20, #1                 // =1
   12c4c: 6b 01 00 54  	b.lt	0x12c78 <PRINT+0xf4>
   12c50: 93 00 80 b0  	adrp	c19, 0x23000 <PRINT+0x110>
   12c54: 73 f2 41 c2  	ldr	c19, [c19, #1984]
   12c58: f5 03 14 aa  	mov	x21, x20
; 		printf(BRED "|" RESET);
   12c5c: 60 d2 c1 c2  	mov	c0, c19
   12c60: e9 03 1f aa  	mov	x9, xzr
   12c64: 7f 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	for(i = 0; i < percent; i++)
   12c68: b5 06 00 f1  	subs	x21, x21, #1            // =1
   12c6c: 81 ff ff 54  	b.ne	0x12c5c <PRINT+0xd8>
; 	for(i = 0; i < 100 - percent; i++)
   12c70: 9f 8e 01 f1  	cmp	x20, #99                // =99
   12c74: 8c 01 00 54  	b.gt	0x12ca4 <PRINT+0x120>
   12c78: 93 00 80 b0  	adrp	c19, 0x23000 <PRINT+0x138>
   12c7c: 88 0c 80 52  	mov	w8, #100
   12c80: 73 f6 41 c2  	ldr	c19, [c19, #2000]
; 	for(i = 0; i < 100 - percent; i++)
   12c84: 08 01 14 cb  	sub	x8, x8, x20
   12c88: 1f 05 00 f1  	cmp	x8, #1                  // =1
   12c8c: 14 c5 9f 9a  	csinc	x20, x8, xzr, gt
; 		printf(BGRN "|" RESET);
   12c90: 60 d2 c1 c2  	mov	c0, c19
   12c94: e9 03 1f aa  	mov	x9, xzr
   12c98: 72 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	for(i = 0; i < 100 - percent; i++)
   12c9c: 94 06 00 f1  	subs	x20, x20, #1            // =1
   12ca0: 81 ff ff 54  	b.ne	0x12c90 <PRINT+0x10c>
; 	printf("]\n");
   12ca4: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x14>
   12ca8: 00 64 42 c2  	ldr	c0, [c0, #2448]
   12cac: 4d 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 	printf("------------------------------------------\n");
   12cb0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x20>
   12cb4: 00 68 42 c2  	ldr	c0, [c0, #2464]
   12cb8: f4 4f c3 42  	ldp	c20, c19, [csp, #96]
   12cbc: f5 17 40 c2  	ldr	c21, [csp, #80]
   12cc0: fd fb c1 42  	ldp	c29, c30, [csp, #48]
   12cc4: e9 23 42 6d  	ldp	d9, d8, [csp, #32]
   12cc8: eb 2b 41 6d  	ldp	d11, d10, [csp, #16]
   12ccc: ff 03 02 02  	add	csp, csp, #128          // =128
   12cd0: 44 02 00 14  	b	0x135e0 <xbrtime_api_asm.s+0x135e0>

0000000000012cd4 <main>:
; int main( int argc, char **argv ){
   12cd4: ff 03 85 02  	sub	csp, csp, #320          // =320
   12cd8: e9 23 08 6d  	stp	d9, d8, [csp, #128]
   12cdc: fd fb 84 42  	stp	c29, c30, [csp, #144]
   12ce0: fc 2f 00 c2  	str	c28, [csp, #176]
   12ce4: fa 67 86 42  	stp	c26, c25, [csp, #192]
   12ce8: f8 5f 87 42  	stp	c24, c23, [csp, #224]
   12cec: f6 57 88 42  	stp	c22, c21, [csp, #256]
   12cf0: f4 4f 89 42  	stp	c20, c19, [csp, #288]
   12cf4: fd 43 02 02  	add	c29, csp, #144          // =144
; 	printf("[M]"GRN " Entered Main matmul...\n"RESET);
   12cf8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x68>
   12cfc: 00 f8 41 c2  	ldr	c0, [c0, #2016]
   12d00: e9 03 1f aa  	mov	x9, xzr
   12d04: 57 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
   12d08: a0 c3 80 02  	sub	c0, c29, #48            // =48
   12d0c: 68 01 80 52  	mov	w8, #11
   12d10: c9 02 80 52  	mov	w9, #22
   12d14: 00 38 c4 c2  	scbnds	c0, c0, #8              // =8
;   unsigned long long x = 11;
   12d18: a9 a3 3c a9  	stp	x9, x8, [c29, #-56]
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12d1c: 08 90 c0 c2  	gctag	x8, c0
   12d20: 1f 01 00 f1  	cmp	x8, #0                  // =0
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12d24: 14 10 c0 c2  	gcbase	x20, c0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12d28: 15 30 c0 c2  	gclen	x21, c0
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   12d2c: 17 70 c0 c2  	gcoff	x23, c0
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   12d30: 18 d0 c0 c2  	gcperm	x24, c0
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12d34: f9 07 9f 1a  	cset	w25, ne
;   printf("  X:\n"
   12d38: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12d3c: f9 23 00 f9  	str	x25, [csp, #64]
   12d40: f8 1b 00 f9  	str	x24, [csp, #48]
   12d44: f7 13 00 f9  	str	x23, [csp, #32]
   12d48: f5 0b 00 f9  	str	x21, [csp, #16]
   12d4c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12d50: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xc0>
   12d54: 00 fc 41 c2  	ldr	c0, [c0, #2032]
   12d58: f4 03 00 f9  	str	x20, [csp]
   12d5c: 41 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("[M]"GRN " Passed vars\n"RESET);
   12d60: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xd0>
   12d64: 00 00 42 c2  	ldr	c0, [c0, #2048]
   12d68: e9 03 1f aa  	mov	x9, xzr
   12d6c: 3d 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("[M]"GRN " Passed malloc\n"RESET);
   12d70: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xe0>
   12d74: 00 04 42 c2  	ldr	c0, [c0, #2064]
   12d78: e9 03 1f aa  	mov	x9, xzr
   12d7c: 39 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   rtn = xbrtime_init();
   12d80: 80 fe ff 97  	bl	0x12780 <xbrtime_init>
   12d84: f3 03 00 2a  	mov	w19, w0
; 	printf("[M]"GRN " Passed xbrtime_init()\n"RESET); 
   12d88: 80 00 80 b0  	adrp	c0, 0x23000 <main+0xf8>
   12d8c: 00 08 42 c2  	ldr	c0, [c0, #2080]
   12d90: e9 03 1f aa  	mov	x9, xzr
   12d94: 33 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   __xbrtime_asm_quiet_fence();
   12d98: c1 01 00 94  	bl	0x1349c <__xbrtime_asm_quiet_fence>
; 	printf("[M]"GRN " Passed xbrtime_malloc()\n"RESET); 
   12d9c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x10c>
   12da0: 00 0c 42 c2  	ldr	c0, [c0, #2096]
   12da4: e9 03 1f aa  	mov	x9, xzr
   12da8: 2e 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 	printf("[M]"GRN " Passed shared[] & private[] init\n"RESET);
   12dac: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x11c>
   12db0: 00 10 42 c2  	ldr	c0, [c0, #2112]
   12db4: e9 03 1f aa  	mov	x9, xzr
   12db8: 2a 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("[M] Entered xbrtime_barrier()\n");
   12dbc: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x12c>
   12dc0: 00 58 42 c2  	ldr	c0, [c0, #2400]
   12dc4: 07 02 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12dc8: b2 01 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12dcc: 96 00 80 b0  	adrp	c22, 0x23000 <main+0x13c>
   12dd0: d6 3e 43 c2  	ldr	c22, [c22, #3312]
   12dd4: c0 02 40 c2  	ldr	c0, [c22, #0]
   12dd8: 60 00 00 b4  	cbz	x0, 0x12de4 <main+0x110>
;   return __XBRTIME_CONFIG->_ID;
   12ddc: 08 08 40 b9  	ldr	w8, [c0, #8]
   12de0: 02 00 00 14  	b	0x12de8 <main+0x114>
   12de4: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12de8: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12dec: 09 70 c6 c2  	clrperm	c9, c0, wx
   12df0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x160>
   12df4: 00 d8 41 c2  	ldr	c0, [c0, #1888]
   12df8: e8 03 00 f9  	str	x8, [csp]
   12dfc: 19 02 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("[M] Exiting xbrtime_barrier()\n");
   12e00: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x170>
   12e04: 00 5c 42 c2  	ldr	c0, [c0, #2416]
   12e08: f6 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   if( __XBRTIME_CONFIG == NULL ){
   12e0c: c0 02 40 c2  	ldr	c0, [c22, #0]
   12e10: 40 04 00 b4  	cbz	x0, 0x12e98 <main+0x1c4>
;   return __XBRTIME_CONFIG->_ID;
   12e14: 08 08 40 b9  	ldr	w8, [c0, #8]
   12e18: 08 e4 00 2f  	movi	d8, #0000000000000000
; 	if(xbrtime_mype() == 0){
   12e1c: e8 06 00 35  	cbnz	w8, 0x12ef8 <main+0x224>
; 		printf("========================\n");
   12e20: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x190>
   12e24: 00 80 42 c2  	ldr	c0, [c0, #2560]
   12e28: ee 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		printf(" xBGAS Matmul Benchmark\n");
   12e2c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x19c>
   12e30: 00 84 42 c2  	ldr	c0, [c0, #2576]
   12e34: eb 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		printf("========================\n");
   12e38: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1a8>
   12e3c: 00 88 42 c2  	ldr	c0, [c0, #2592]
   12e40: e8 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		printf(" Data type: uint64_t\n");
   12e44: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1b4>
   12e48: 00 8c 42 c2  	ldr	c0, [c0, #2608]
   12e4c: e5 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		printf(" Element #: %lu\n", ne);
   12e50: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12e54: 09 70 c6 c2  	clrperm	c9, c0, wx
   12e58: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1c8>
   12e5c: 00 14 42 c2  	ldr	c0, [c0, #2128]
   12e60: 08 01 80 52  	mov	w8, #8
   12e64: e8 03 00 f9  	str	x8, [csp]
   12e68: fe 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   	printf(" Data size: %lu bytes\n",  (int)(sz) * (int)(ne) );
   12e6c: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12e70: 09 70 c6 c2  	clrperm	c9, c0, wx
   12e74: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x1e4>
   12e78: 00 18 42 c2  	ldr	c0, [c0, #2144]
   12e7c: 08 08 80 52  	mov	w8, #64
   12e80: e8 03 00 f9  	str	x8, [csp]
   12e84: f7 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   if( __XBRTIME_CONFIG == NULL ){
   12e88: c0 02 40 c2  	ldr	c0, [c22, #0]
   12e8c: a0 00 00 b4  	cbz	x0, 0x12ea0 <main+0x1cc>
;   return __XBRTIME_CONFIG->_NPES;
   12e90: 08 0c 40 b9  	ldr	w8, [c0, #12]
   12e94: 04 00 00 14  	b	0x12ea4 <main+0x1d0>
   12e98: 08 e4 00 2f  	movi	d8, #0000000000000000
   12e9c: 4d 00 00 14  	b	0x12fd0 <main+0x2fc>
   12ea0: 08 00 80 12  	mov	w8, #-1
; 		printf(" PE #     : %d\n", xbrtime_num_pes());
   12ea4: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12ea8: 09 70 c6 c2  	clrperm	c9, c0, wx
   12eac: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x21c>
   12eb0: 00 1c 42 c2  	ldr	c0, [c0, #2160]
   12eb4: e8 03 00 f9  	str	x8, [csp]
   12eb8: ea 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;     printf("========================\n");
   12ebc: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x22c>
   12ec0: 00 90 42 c2  	ldr	c0, [c0, #2624]
   12ec4: c7 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
   12ec8: a0 83 80 02  	sub	c0, c29, #32            // =32
   12ecc: a1 a3 80 02  	sub	c1, c29, #40            // =40
   12ed0: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12ed4: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   12ed8: ea 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   12edc: a0 07 7e 6d  	ldp	d0, d1, [c29, #-32]
   12ee0: 60 ff ff f0  	adrp	c0, 0x1000 <main+0x1c8>
   12ee4: 02 3c 45 fd  	ldr	d2, [c0, #2680]
   12ee8: 21 d8 61 5e  	scvtf	d1, d1
   12eec: 00 d8 61 5e  	scvtf	d0, d0
   12ef0: 21 08 62 1e  	fmul	d1, d1, d2
   12ef4: 28 28 60 1e  	fadd	d8, d1, d0
;   if( __XBRTIME_CONFIG == NULL ){
   12ef8: c0 02 40 c2  	ldr	c0, [c22, #0]
   12efc: a0 06 00 b4  	cbz	x0, 0x12fd0 <main+0x2fc>
;   return __XBRTIME_CONFIG->_ID;
   12f00: 08 08 40 b9  	ldr	w8, [c0, #8]
;   if(xbrtime_mype() == 0){
   12f04: 68 06 00 35  	cbnz	w8, 0x12fd0 <main+0x2fc>
   12f08: a0 e3 80 02  	sub	c0, c29, #56            // =56
   12f0c: 1a 38 c4 c2  	scbnds	c26, c0, #8             // =8
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   12f10: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x280>
   12f14: 00 44 42 c2  	ldr	c0, [c0, #2320]
   12f18: b2 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   printf("\n========================\n");
   12f1c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x28c>
   12f20: 00 48 42 c2  	ldr	c0, [c0, #2336]
   12f24: af 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   printf("  DEST:\n"
   12f28: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12f2c: f9 23 00 f9  	str	x25, [csp, #64]
   12f30: f8 1b 00 f9  	str	x24, [csp, #48]
   12f34: f7 13 00 f9  	str	x23, [csp, #32]
   12f38: f5 0b 00 f9  	str	x21, [csp, #16]
   12f3c: 09 70 c6 c2  	clrperm	c9, c0, wx
   12f40: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2b0>
   12f44: 00 d0 41 c2  	ldr	c0, [c0, #1856]
   12f48: f4 03 00 f9  	str	x20, [csp]
   12f4c: c5 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("========================\n");
   12f50: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2c0>
   12f54: 00 4c 42 c2  	ldr	c0, [c0, #2352]
   12f58: a2 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12f5c: 4c 93 c0 c2  	gctag	x12, c26
   12f60: 9f 01 00 f1  	cmp	x12, #0                 // =0
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12f64: 49 33 c0 c2  	gclen	x9, c26
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   12f68: 4a 73 c0 c2  	gcoff	x10, c26
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   12f6c: 4b d3 c0 c2  	gcperm	x11, c26
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   12f70: ec 07 9f 1a  	cset	w12, ne
;   printf("  SRC:\n"
   12f74: e0 fb c2 c2  	scbnds	c0, csp, #5, lsl #4     // =80
   12f78: ec 23 00 f9  	str	x12, [csp, #64]
   12f7c: eb 1b 00 f9  	str	x11, [csp, #48]
   12f80: ea 13 00 f9  	str	x10, [csp, #32]
   12f84: e9 0b 00 f9  	str	x9, [csp, #16]
   12f88: 09 70 c6 c2  	clrperm	c9, c0, wx
   12f8c: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x2fc>
   12f90: 00 d4 41 c2  	ldr	c0, [c0, #1872]
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   12f94: 48 13 c0 c2  	gcbase	x8, c26
;   printf("  SRC:\n"
   12f98: e8 03 00 f9  	str	x8, [csp]
   12f9c: b1 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;     printf("========================\n\n");
   12fa0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x310>
   12fa4: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12fa8: 8e 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;     *dest = *src;
   12fac: a8 83 5c f8  	ldur	x8, [c29, #-56]
   12fb0: a8 03 1d f8  	stur	x8, [c29, #-48]
;   __xbrtime_asm_fence();
   12fb4: 37 01 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   printf("[M] Exiting xbrtime_ulonglong_get()\n");
   12fb8: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x328>
   12fbc: 00 54 42 c2  	ldr	c0, [c0, #2384]
   12fc0: 88 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;     printf("  Completed\n");
   12fc4: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x334>
   12fc8: 00 7c 42 c2  	ldr	c0, [c0, #2544]
   12fcc: 85 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   printf("[M] Entered xbrtime_barrier()\n");
   12fd0: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x340>
   12fd4: 00 58 42 c2  	ldr	c0, [c0, #2400]
   12fd8: 82 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   12fdc: 2d 01 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   12fe0: c0 02 40 c2  	ldr	c0, [c22, #0]
   12fe4: 60 00 00 b4  	cbz	x0, 0x12ff0 <main+0x31c>
;   return __XBRTIME_CONFIG->_ID;
   12fe8: 08 08 40 b9  	ldr	w8, [c0, #8]
   12fec: 02 00 00 14  	b	0x12ff4 <main+0x320>
   12ff0: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   12ff4: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   12ff8: 09 70 c6 c2  	clrperm	c9, c0, wx
   12ffc: 80 00 80 b0  	adrp	c0, 0x23000 <main+0x36c>
   13000: 00 d8 41 c2  	ldr	c0, [c0, #1888]
   13004: e8 03 00 f9  	str	x8, [csp]
   13008: 96 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("[M] Exiting xbrtime_barrier()\n");
   1300c: 80 00 80 90  	adrp	c0, 0x23000 <main+0x378>
   13010: 00 5c 42 c2  	ldr	c0, [c0, #2416]
   13014: 73 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   if( __XBRTIME_CONFIG == NULL ){
   13018: c0 02 40 c2  	ldr	c0, [c22, #0]
   1301c: c0 04 00 b4  	cbz	x0, 0x130b4 <main+0x3e0>
;   return __XBRTIME_CONFIG->_ID;
   13020: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   13024: 88 04 00 35  	cbnz	w8, 0x130b4 <main+0x3e0>
   13028: a0 83 80 02  	sub	c0, c29, #32            // =32
   1302c: a1 a3 80 02  	sub	c1, c29, #40            // =40
   13030: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   13034: 35 38 c4 c2  	scbnds	c21, c1, #8             // =8
; 		i = gettimeofday( &tp, &tzp );
   13038: 80 d2 c1 c2  	mov	c0, c20
   1303c: a1 d2 c1 c2  	mov	c1, c21
   13040: 90 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13044: a0 07 7e 6d  	ldp	d0, d1, [c29, #-32]
   13048: 60 ff ff d0  	adrp	c0, 0x1000 <main+0x32c>
   1304c: 09 3c 45 fd  	ldr	d9, [c0, #2680]
; 		printf("--------------------------------------------\n");
   13050: 80 00 80 90  	adrp	c0, 0x23000 <main+0x3bc>
   13054: 00 74 42 c2  	ldr	c0, [c0, #2512]
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13058: 21 d8 61 5e  	scvtf	d1, d1
   1305c: 00 d8 61 5e  	scvtf	d0, d0
   13060: 21 08 69 1e  	fmul	d1, d1, d9
   13064: 20 28 60 1e  	fadd	d0, d1, d0
; 		t_mem = t_end - t_start;
   13068: 08 38 68 1e  	fsub	d8, d0, d8
; 		printf("--------------------------------------------\n");
   1306c: 5d 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		printf("Time cost"BRED	" (raw transactions):       %f\n"RESET, t_mem);
   13070: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   13074: 09 70 c6 c2  	clrperm	c9, c0, wx
   13078: 80 00 80 90  	adrp	c0, 0x23000 <main+0x3e4>
   1307c: 00 20 42 c2  	ldr	c0, [c0, #2176]
   13080: e8 03 00 fd  	str	d8, [csp]
   13084: 77 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 		printf("--------------------------------------------\n");
   13088: 80 00 80 90  	adrp	c0, 0x23000 <main+0x3f4>
   1308c: 00 78 42 c2  	ldr	c0, [c0, #2528]
   13090: 54 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		i = gettimeofday( &tp, &tzp );
   13094: 80 d2 c1 c2  	mov	c0, c20
   13098: a1 d2 c1 c2  	mov	c1, c21
   1309c: 79 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   130a0: a0 07 7e 6d  	ldp	d0, d1, [c29, #-32]
   130a4: 21 d8 61 5e  	scvtf	d1, d1
   130a8: 00 d8 61 5e  	scvtf	d0, d0
   130ac: 21 08 69 1e  	fmul	d1, d1, d9
   130b0: 28 28 60 1e  	fadd	d8, d1, d0
;   printf("[M] Entered xbrtime_barrier()\n");
   130b4: 80 00 80 90  	adrp	c0, 0x23000 <main+0x420>
   130b8: 00 58 42 c2  	ldr	c0, [c0, #2400]
   130bc: 49 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   130c0: f4 00 00 94  	bl	0x13490 <__xbrtime_asm_fence>
;   if( __XBRTIME_CONFIG == NULL ){
   130c4: c0 02 40 c2  	ldr	c0, [c22, #0]
   130c8: 60 00 00 b4  	cbz	x0, 0x130d4 <main+0x400>
;   return __XBRTIME_CONFIG->_ID;
   130cc: 08 08 40 b9  	ldr	w8, [c0, #8]
   130d0: 02 00 00 14  	b	0x130d8 <main+0x404>
   130d4: 08 00 80 12  	mov	w8, #-1
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   130d8: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   130dc: 09 70 c6 c2  	clrperm	c9, c0, wx
   130e0: 80 00 80 90  	adrp	c0, 0x23000 <main+0x44c>
   130e4: 00 d8 41 c2  	ldr	c0, [c0, #1888]
   130e8: e8 03 00 f9  	str	x8, [csp]
   130ec: 5d 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   printf("[M] Exiting xbrtime_barrier()\n");
   130f0: 80 00 80 90  	adrp	c0, 0x23000 <main+0x45c>
   130f4: 00 5c 42 c2  	ldr	c0, [c0, #2416]
   130f8: 3a 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   if( __XBRTIME_CONFIG == NULL ){
   130fc: c0 02 40 c2  	ldr	c0, [c22, #0]
   13100: 20 06 00 b4  	cbz	x0, 0x131c4 <main+0x4f0>
;   return __XBRTIME_CONFIG->_ID;
   13104: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   13108: a8 02 00 35  	cbnz	w8, 0x1315c <main+0x488>
   1310c: a0 83 80 02  	sub	c0, c29, #32            // =32
   13110: a1 a3 80 02  	sub	c1, c29, #40            // =40
   13114: 14 38 c8 c2  	scbnds	c20, c0, #16            // =16
   13118: 35 38 c4 c2  	scbnds	c21, c1, #8             // =8
; 		i = gettimeofday( &tp, &tzp );
   1311c: 80 d2 c1 c2  	mov	c0, c20
   13120: a1 d2 c1 c2  	mov	c1, c21
   13124: 57 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		printf("--------------------------------------------\n");
   13128: 80 00 80 90  	adrp	c0, 0x23000 <main+0x494>
   1312c: 00 70 42 c2  	ldr	c0, [c0, #2496]
   13130: 2c 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
; 		i = gettimeofday( &tp, &tzp );
   13134: 80 d2 c1 c2  	mov	c0, c20
   13138: a1 d2 c1 c2  	mov	c1, c21
   1313c: 51 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13140: a0 07 7e 6d  	ldp	d0, d1, [c29, #-32]
   13144: 60 ff ff d0  	adrp	c0, 0x1000 <main+0x428>
   13148: 02 3c 45 fd  	ldr	d2, [c0, #2680]
   1314c: 21 d8 61 5e  	scvtf	d1, d1
   13150: 00 d8 61 5e  	scvtf	d0, d0
   13154: 21 08 62 1e  	fmul	d1, d1, d2
   13158: 28 28 60 1e  	fadd	d8, d1, d0
;   if( __XBRTIME_CONFIG == NULL ){
   1315c: c0 02 40 c2  	ldr	c0, [c22, #0]
   13160: 20 03 00 b4  	cbz	x0, 0x131c4 <main+0x4f0>
;   return __XBRTIME_CONFIG->_ID;
   13164: 08 08 40 b9  	ldr	w8, [c0, #8]
; 	if(xbrtime_mype() == 0){
   13168: e8 02 00 35  	cbnz	w8, 0x131c4 <main+0x4f0>
   1316c: a0 83 80 02  	sub	c0, c29, #32            // =32
   13170: a1 a3 80 02  	sub	c1, c29, #40            // =40
   13174: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13178: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
; 		i = gettimeofday( &tp, &tzp );
   1317c: 41 01 00 94  	bl	0x13680 <xbrtime_api_asm.s+0x13680>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13180: a0 07 7e 6d  	ldp	d0, d1, [c29, #-32]
   13184: 60 ff ff d0  	adrp	c0, 0x1000 <main+0x468>
   13188: 02 3c 45 fd  	ldr	d2, [c0, #2680]
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   1318c: e0 3b c8 c2  	scbnds	c0, csp, #16            // =16
   13190: 09 70 c6 c2  	clrperm	c9, c0, wx
   13194: 80 00 80 90  	adrp	c0, 0x23000 <main+0x500>
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13198: 21 d8 61 5e  	scvtf	d1, d1
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   1319c: 00 24 42 c2  	ldr	c0, [c0, #2192]
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   131a0: 00 d8 61 5e  	scvtf	d0, d0
   131a4: 21 08 62 1e  	fmul	d1, d1, d2
   131a8: 20 28 60 1e  	fadd	d0, d1, d0
; 		t_mem = t_end - t_start;
   131ac: 00 38 68 1e  	fsub	d0, d0, d8
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   131b0: e0 03 00 fd  	str	d0, [csp]
   131b4: 2b 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
; 		printf("--------------------------------------------\n");
   131b8: 80 00 80 90  	adrp	c0, 0x23000 <main+0x524>
   131bc: 00 6c 42 c2  	ldr	c0, [c0, #2480]
   131c0: 08 01 00 94  	bl	0x135e0 <xbrtime_api_asm.s+0x135e0>
;   __xbrtime_asm_quiet_fence();
   131c4: b6 00 00 94  	bl	0x1349c <__xbrtime_asm_quiet_fence>
;   if( __XBRTIME_CONFIG != NULL ){
   131c8: c0 02 40 c2  	ldr	c0, [c22, #0]
   131cc: 20 03 00 b4  	cbz	x0, 0x13230 <main+0x55c>
;     __xbrtime_asm_fence();
   131d0: b0 00 00 94  	bl	0x13490 <__xbrtime_asm_fence>
   131d4: 14 00 81 52  	mov	w20, #2048
   131d8: 15 01 80 52  	mov	w21, #8
   131dc: 04 00 00 14  	b	0x131ec <main+0x518>
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   131e0: 94 06 00 f1  	subs	x20, x20, #1            // =1
   131e4: b5 42 00 91  	add	x21, x21, #16           // =16
   131e8: 40 01 00 54  	b.eq	0x13210 <main+0x53c>
;       if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
   131ec: c0 02 40 c2  	ldr	c0, [c22, #0]
   131f0: 00 0c 40 c2  	ldr	c0, [c0, #48]
   131f4: 08 68 75 f8  	ldr	x8, [c0, x21]
   131f8: 48 ff ff b4  	cbz	x8, 0x131e0 <main+0x50c>
;         xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
   131fc: 00 60 b5 c2  	add	c0, c0, x21, uxtx
   13200: 08 80 5f f8  	ldur	x8, [c0, #-8]
;   if( ptr == NULL ){
   13204: e8 fe ff b4  	cbz	x8, 0x131e0 <main+0x50c>
;   __xbrtime_asm_quiet_fence();
   13208: a5 00 00 94  	bl	0x1349c <__xbrtime_asm_quiet_fence>
   1320c: f5 ff ff 17  	b	0x131e0 <main+0x50c>
;     if( __XBRTIME_CONFIG->_MAP != NULL ){
   13210: c0 02 40 c2  	ldr	c0, [c22, #0]
   13214: 00 10 40 c2  	ldr	c0, [c0, #64]
   13218: 80 00 00 b4  	cbz	x0, 0x13228 <main+0x554>
;       free( __XBRTIME_CONFIG->_MAP );
   1321c: dd 00 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
;       __XBRTIME_CONFIG->_MAP = NULL;
   13220: c0 02 40 c2  	ldr	c0, [c22, #0]
   13224: 1f 10 00 c2  	str	czr, [c0, #64]
;     free( __XBRTIME_CONFIG );
   13228: c0 02 40 c2  	ldr	c0, [c22, #0]
   1322c: d9 00 00 94  	bl	0x13590 <xbrtime_api_asm.s+0x13590>
; 	printf("[M]"GRN " Returning Main matmul...\n"RESET);
   13230: 80 00 80 90  	adrp	c0, 0x23000 <.get_u1_seq+0x4>
   13234: 00 28 42 c2  	ldr	c0, [c0, #2208]
   13238: e9 03 1f aa  	mov	x9, xzr
   1323c: 09 01 00 94  	bl	0x13660 <xbrtime_api_asm.s+0x13660>
;   return rtn;
   13240: e0 03 13 2a  	mov	w0, w19
   13244: f4 4f c9 42  	ldp	c20, c19, [csp, #288]
   13248: f6 57 c8 42  	ldp	c22, c21, [csp, #256]
   1324c: f8 5f c7 42  	ldp	c24, c23, [csp, #224]
   13250: fa 67 c6 42  	ldp	c26, c25, [csp, #192]
   13254: fc 2f 40 c2  	ldr	c28, [csp, #176]
   13258: fd fb c4 42  	ldp	c29, c30, [csp, #144]
   1325c: e9 23 48 6d  	ldp	d9, d8, [csp, #128]
   13260: ff 03 05 02  	add	csp, csp, #320          // =320
   13264: c0 53 c2 c2  	ret	c30

0000000000013268 <__xbrtime_get_u1_seq>:
;   MOV X12, XZR
   13268: ec 03 1f aa  	mov	x12, xzr

000000000001326c <.get_u1_seq>:
;   LDRB W10, [X0]
   1326c: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13270: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13274: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13278: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   1327c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13280: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u1_seq
   13284: 41 ff ff 54  	b.ne	0x1326c <.get_u1_seq>
;   RET
   13288: c0 53 c2 c2  	ret	c30

000000000001328c <__xbrtime_put_u1_seq>:
;   MOV X12, XZR
   1328c: ec 03 1f aa  	mov	x12, xzr

0000000000013290 <.put_u1_seq>:
;   LDRB W10, [X0]
   13290: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13294: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13298: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   1329c: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   132a0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132a4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u1_seq
   132a8: 41 ff ff 54  	b.ne	0x13290 <.put_u1_seq>
;   RET
   132ac: c0 53 c2 c2  	ret	c30

00000000000132b0 <__xbrtime_get_s1_seq>:
;   MOV X12, XZR
   132b0: ec 03 1f aa  	mov	x12, xzr

00000000000132b4 <.get_s1_seq>:
;   LDRB W10, [X0]
   132b4: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   132b8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   132bc: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   132c0: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   132c4: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132c8: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s1_seq
   132cc: 41 ff ff 54  	b.ne	0x132b4 <.get_s1_seq>
;   RET
   132d0: c0 53 c2 c2  	ret	c30

00000000000132d4 <__xbrtime_put_s1_seq>:
;   MOV X12, XZR
   132d4: ec 03 1f aa  	mov	x12, xzr

00000000000132d8 <.put_s1_seq>:
;   LDRB W10, [X0]
   132d8: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   132dc: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   132e0: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   132e4: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   132e8: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   132ec: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s1_seq
   132f0: 41 ff ff 54  	b.ne	0x132d8 <.put_s1_seq>
;   RET
   132f4: c0 53 c2 c2  	ret	c30

00000000000132f8 <__xbrtime_get_u2_seq>:
;   MOV X12, XZR
   132f8: ec 03 1f aa  	mov	x12, xzr

00000000000132fc <.get_u2_seq>:
;   LDRH W10, [X0]
   132fc: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   13300: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13304: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   13308: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   1330c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13310: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u2_seq
   13314: 41 ff ff 54  	b.ne	0x132fc <.get_u2_seq>
;   RET
   13318: c0 53 c2 c2  	ret	c30

000000000001331c <__xbrtime_put_u2_seq>:
;   MOV X12, XZR
   1331c: ec 03 1f aa  	mov	x12, xzr

0000000000013320 <.put_u2_seq>:
;   LDRH W10, [X0]
   13320: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   13324: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13328: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   1332c: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   13330: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13334: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u2_seq
   13338: 41 ff ff 54  	b.ne	0x13320 <.put_u2_seq>
;   RET
   1333c: c0 53 c2 c2  	ret	c30

0000000000013340 <__xbrtime_get_s2_seq>:
;   MOV X12, XZR
   13340: ec 03 1f aa  	mov	x12, xzr

0000000000013344 <.get_s2_seq>:
;   LDRH W10, [X0]
   13344: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   13348: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1334c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   13350: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   13354: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13358: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s2_seq
   1335c: 41 ff ff 54  	b.ne	0x13344 <.get_s2_seq>
;   RET
   13360: c0 53 c2 c2  	ret	c30

0000000000013364 <__xbrtime_put_s2_seq>:
;   MOV X12, XZR
   13364: ec 03 1f aa  	mov	x12, xzr

0000000000013368 <.put_s2_seq>:
;   LDRH W10, [X0]
   13368: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   1336c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13370: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   13374: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   13378: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1337c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s2_seq
   13380: 41 ff ff 54  	b.ne	0x13368 <.put_s2_seq>
;   RET
   13384: c0 53 c2 c2  	ret	c30

0000000000013388 <__xbrtime_get_u4_seq>:
;   MOV X12, XZR
   13388: ec 03 1f aa  	mov	x12, xzr

000000000001338c <.get_u4_seq>:
;   LDR W10, [X0]
   1338c: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   13390: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13394: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   13398: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   1339c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   133a0: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u4_seq
   133a4: 41 ff ff 54  	b.ne	0x1338c <.get_u4_seq>
;   RET
   133a8: c0 53 c2 c2  	ret	c30

00000000000133ac <__xbrtime_put_u4_seq>:
;   MOV X12, XZR
   133ac: ec 03 1f aa  	mov	x12, xzr

00000000000133b0 <.put_u4_seq>:
;   LDR W10, [X0]
   133b0: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   133b4: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   133b8: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   133bc: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   133c0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   133c4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u4_seq
   133c8: 41 ff ff 54  	b.ne	0x133b0 <.put_u4_seq>
;   RET
   133cc: c0 53 c2 c2  	ret	c30

00000000000133d0 <__xbrtime_get_s4_seq>:
;   MOV X12, XZR
   133d0: ec 03 1f aa  	mov	x12, xzr

00000000000133d4 <.get_s4_seq>:
;   LDR W10, [X0]
   133d4: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   133d8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   133dc: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   133e0: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   133e4: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   133e8: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s4_seq
   133ec: 41 ff ff 54  	b.ne	0x133d4 <.get_s4_seq>
;   RET
   133f0: c0 53 c2 c2  	ret	c30

00000000000133f4 <__xbrtime_put_s4_seq>:
;   MOV X12, XZR
   133f4: ec 03 1f aa  	mov	x12, xzr

00000000000133f8 <.put_s4_seq>:
;   LDR W10, [X0]
   133f8: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   133fc: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13400: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   13404: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   13408: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1340c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s4_seq
   13410: 41 ff ff 54  	b.ne	0x133f8 <.put_s4_seq>
;   RET
   13414: c0 53 c2 c2  	ret	c30

0000000000013418 <__xbrtime_get_u8_seq>:
;   MOV X12, XZR
   13418: ec 03 1f aa  	mov	x12, xzr

000000000001341c <.get_u8_seq>:
;   LDR c10, [c0]
   1341c: 0a 00 40 c2  	ldr	c10, [c0, #0]
;   RET
   13420: c0 53 c2 c2  	ret	c30

0000000000013424 <__xbrtime_put_u8_seq>:
;   MOV X12, XZR
   13424: ec 03 1f aa  	mov	x12, xzr

0000000000013428 <.put_u8_seq>:
;   LDR X10, [X0]
   13428: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   1342c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13430: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   13434: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   13438: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1343c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u8_seq
   13440: 41 ff ff 54  	b.ne	0x13428 <.put_u8_seq>
;   RET
   13444: c0 53 c2 c2  	ret	c30

0000000000013448 <__xbrtime_get_s8_seq>:
;   MOV X12, XZR
   13448: ec 03 1f aa  	mov	x12, xzr

000000000001344c <.get_s8_seq>:
;   LDR X10, [X0]
   1344c: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   13450: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13454: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   13458: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   1345c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13460: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s8_seq
   13464: 41 ff ff 54  	b.ne	0x1344c <.get_s8_seq>
;   RET
   13468: c0 53 c2 c2  	ret	c30

000000000001346c <__xbrtime_put_s8_seq>:
;   MOV X12, XZR
   1346c: ec 03 1f aa  	mov	x12, xzr

0000000000013470 <.put_s8_seq>:
;   LDR X10, [X0]
   13470: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   13474: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13478: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   1347c: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   13480: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13484: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s8_seq
   13488: 41 ff ff 54  	b.ne	0x13470 <.put_s8_seq>
;   RET
   1348c: c0 53 c2 c2  	ret	c30

0000000000013490 <__xbrtime_asm_fence>:
;   DSB SY
   13490: 9f 3f 03 d5  	dsb	sy
;   ISB
   13494: df 3f 03 d5  	isb
;   RET
   13498: c0 53 c2 c2  	ret	c30

000000000001349c <__xbrtime_asm_quiet_fence>:
;   DMB SY
   1349c: bf 3f 03 d5  	dmb	sy
;   RET
   134a0: c0 53 c2 c2  	ret	c30

Disassembly of section .plt:

00000000000134b0 <.plt>:
   134b0: f0 7b bf 62  	stp	c16, c30, [csp, #-32]!
   134b4: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x84>
   134b8: 11 52 43 c2  	ldr	c17, [c16, #3392]
   134bc: 10 02 35 02  	add	c16, c16, #3392         // =3392
   134c0: 20 12 c2 c2  	br	c17
   134c4: 1f 20 03 d5  	nop
   134c8: 1f 20 03 d5  	nop
   134cc: 1f 20 03 d5  	nop
   134d0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xa0>
   134d4: 10 42 35 02  	add	c16, c16, #3408         // =3408
   134d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134dc: 20 12 c2 c2  	br	c17
   134e0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xb0>
   134e4: 10 82 35 02  	add	c16, c16, #3424         // =3424
   134e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134ec: 20 12 c2 c2  	br	c17
   134f0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xc0>
   134f4: 10 c2 35 02  	add	c16, c16, #3440         // =3440
   134f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   134fc: 20 12 c2 c2  	br	c17
   13500: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xd0>
   13504: 10 02 36 02  	add	c16, c16, #3456         // =3456
   13508: 11 02 40 c2  	ldr	c17, [c16, #0]
   1350c: 20 12 c2 c2  	br	c17
   13510: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xe0>
   13514: 10 42 36 02  	add	c16, c16, #3472         // =3472
   13518: 11 02 40 c2  	ldr	c17, [c16, #0]
   1351c: 20 12 c2 c2  	br	c17
   13520: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0xf0>
   13524: 10 82 36 02  	add	c16, c16, #3488         // =3488
   13528: 11 02 40 c2  	ldr	c17, [c16, #0]
   1352c: 20 12 c2 c2  	br	c17
   13530: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x100>
   13534: 10 c2 36 02  	add	c16, c16, #3504         // =3504
   13538: 11 02 40 c2  	ldr	c17, [c16, #0]
   1353c: 20 12 c2 c2  	br	c17
   13540: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x110>
   13544: 10 02 37 02  	add	c16, c16, #3520         // =3520
   13548: 11 02 40 c2  	ldr	c17, [c16, #0]
   1354c: 20 12 c2 c2  	br	c17
   13550: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x120>
   13554: 10 42 37 02  	add	c16, c16, #3536         // =3536
   13558: 11 02 40 c2  	ldr	c17, [c16, #0]
   1355c: 20 12 c2 c2  	br	c17
   13560: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x130>
   13564: 10 82 37 02  	add	c16, c16, #3552         // =3552
   13568: 11 02 40 c2  	ldr	c17, [c16, #0]
   1356c: 20 12 c2 c2  	br	c17
   13570: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x140>
   13574: 10 c2 37 02  	add	c16, c16, #3568         // =3568
   13578: 11 02 40 c2  	ldr	c17, [c16, #0]
   1357c: 20 12 c2 c2  	br	c17
   13580: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x150>
   13584: 10 02 38 02  	add	c16, c16, #3584         // =3584
   13588: 11 02 40 c2  	ldr	c17, [c16, #0]
   1358c: 20 12 c2 c2  	br	c17
   13590: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x160>
   13594: 10 42 38 02  	add	c16, c16, #3600         // =3600
   13598: 11 02 40 c2  	ldr	c17, [c16, #0]
   1359c: 20 12 c2 c2  	br	c17
   135a0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x170>
   135a4: 10 82 38 02  	add	c16, c16, #3616         // =3616
   135a8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135ac: 20 12 c2 c2  	br	c17
   135b0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x180>
   135b4: 10 c2 38 02  	add	c16, c16, #3632         // =3632
   135b8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135bc: 20 12 c2 c2  	br	c17
   135c0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x190>
   135c4: 10 02 39 02  	add	c16, c16, #3648         // =3648
   135c8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135cc: 20 12 c2 c2  	br	c17
   135d0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1a0>
   135d4: 10 42 39 02  	add	c16, c16, #3664         // =3664
   135d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135dc: 20 12 c2 c2  	br	c17
   135e0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1b0>
   135e4: 10 82 39 02  	add	c16, c16, #3680         // =3680
   135e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135ec: 20 12 c2 c2  	br	c17
   135f0: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1c0>
   135f4: 10 c2 39 02  	add	c16, c16, #3696         // =3696
   135f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   135fc: 20 12 c2 c2  	br	c17
   13600: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1d0>
   13604: 10 02 3a 02  	add	c16, c16, #3712         // =3712
   13608: 11 02 40 c2  	ldr	c17, [c16, #0]
   1360c: 20 12 c2 c2  	br	c17
   13610: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1e0>
   13614: 10 42 3a 02  	add	c16, c16, #3728         // =3728
   13618: 11 02 40 c2  	ldr	c17, [c16, #0]
   1361c: 20 12 c2 c2  	br	c17
   13620: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x1f0>
   13624: 10 82 3a 02  	add	c16, c16, #3744         // =3744
   13628: 11 02 40 c2  	ldr	c17, [c16, #0]
   1362c: 20 12 c2 c2  	br	c17
   13630: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x200>
   13634: 10 c2 3a 02  	add	c16, c16, #3760         // =3760
   13638: 11 02 40 c2  	ldr	c17, [c16, #0]
   1363c: 20 12 c2 c2  	br	c17
   13640: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x210>
   13644: 10 02 3b 02  	add	c16, c16, #3776         // =3776
   13648: 11 02 40 c2  	ldr	c17, [c16, #0]
   1364c: 20 12 c2 c2  	br	c17
   13650: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x220>
   13654: 10 42 3b 02  	add	c16, c16, #3792         // =3792
   13658: 11 02 40 c2  	ldr	c17, [c16, #0]
   1365c: 20 12 c2 c2  	br	c17
   13660: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x230>
   13664: 10 82 3b 02  	add	c16, c16, #3808         // =3808
   13668: 11 02 40 c2  	ldr	c17, [c16, #0]
   1366c: 20 12 c2 c2  	br	c17
   13670: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x240>
   13674: 10 c2 3b 02  	add	c16, c16, #3824         // =3824
   13678: 11 02 40 c2  	ldr	c17, [c16, #0]
   1367c: 20 12 c2 c2  	br	c17
   13680: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x250>
   13684: 10 02 3c 02  	add	c16, c16, #3840         // =3840
   13688: 11 02 40 c2  	ldr	c17, [c16, #0]
   1368c: 20 12 c2 c2  	br	c17
   13690: 10 01 80 90  	adrp	c16, 0x33000 <.plt+0x260>
   13694: 10 42 3c 02  	add	c16, c16, #3856         // =3856
   13698: 11 02 40 c2  	ldr	c17, [c16, #0]
   1369c: 20 12 c2 c2  	br	c17
