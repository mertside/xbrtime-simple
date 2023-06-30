
./matmul_M.exe:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000011d1c <_start>:
; {
   11d1c: fd 7b bd 62  	stp	c29, c30, [csp, #-96]!
   11d20: f6 57 81 42  	stp	c22, c21, [csp, #32]
   11d24: f4 4f 82 42  	stp	c20, c19, [csp, #64]
   11d28: fd d3 c1 c2  	mov	c29, csp
; 	if (!has_dynamic_linker)
   11d2c: 62 05 00 b4  	cbz	x2, 0x11dd8 <_start+0xbc>
   11d30: 33 d0 c1 c2  	mov	c19, c1
; 	if (!has_dynamic_linker)
   11d34: 33 05 00 b4  	cbz	x19, 0x11dd8 <_start+0xbc>
; 	if (cheri_getdefault() != NULL)
   11d38: 21 41 9b c2  	mrs	c1, DDC
   11d3c: e1 04 00 b5  	cbnz	x1, 0x11dd8 <_start+0xbc>
   11d40: f5 03 1f aa  	mov	x21, xzr
   11d44: f4 03 1f aa  	mov	x20, xzr
   11d48: f6 03 1f 2a  	mov	w22, wzr
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11d4c: 01 40 00 02  	add	c1, c0, #16             // =16
   11d50: 04 00 00 14  	b	0x11d60 <_start+0x44>
   11d54: c1 01 00 54  	b.ne	0x11d8c <_start+0x70>
; 			argc = auxp->a_un.a_val;
   11d58: 36 00 40 b9  	ldr	w22, [c1]
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11d5c: 21 80 00 02  	add	c1, c1, #32             // =32
   11d60: 28 00 5f f8  	ldur	x8, [c1, #-16]
   11d64: 1f 71 00 f1  	cmp	x8, #28                 // =28
   11d68: 6d ff ff 54  	b.le	0x11d54 <_start+0x38>
   11d6c: 1f 75 00 f1  	cmp	x8, #29                 // =29
   11d70: a0 00 00 54  	b.eq	0x11d84 <_start+0x68>
   11d74: 1f 7d 00 f1  	cmp	x8, #31                 // =31
   11d78: 21 ff ff 54  	b.ne	0x11d5c <_start+0x40>
; 			env = (char **)auxp->a_un.a_ptr;
   11d7c: 34 24 40 a2  	ldr	c20, [c1], #32
   11d80: f8 ff ff 17  	b	0x11d60 <_start+0x44>
; 			argv = (char **)auxp->a_un.a_ptr;
   11d84: 35 24 40 a2  	ldr	c21, [c1], #32
   11d88: f6 ff ff 17  	b	0x11d60 <_start+0x44>
; 	for (Elf_Auxinfo *auxp = auxv; auxp->a_type != AT_NULL;  auxp++) {
   11d8c: 88 fe ff b5  	cbnz	x8, 0x11d5c <_start+0x40>
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11d90: 81 00 80 f0  	adrp	c1, 0x24000 <handle_argv>
   11d94: 21 10 42 c2  	ldr	c1, [c1, #2112]
; 	handle_argv(argc, argv, env);
   11d98: 82 d2 c1 c2  	mov	c2, c20
; 	__auxargs = auxv; /* Store the global auxargs pointer */
   11d9c: 20 00 00 c2  	str	c0, [c1, #0]
; 	handle_argv(argc, argv, env);
   11da0: e0 03 16 2a  	mov	w0, w22
   11da4: a1 d2 c1 c2  	mov	c1, c21
   11da8: 0d 00 00 94  	bl	0x11ddc <handle_argv>
; 		atexit(cleanup);
   11dac: 60 d2 c1 c2  	mov	c0, c19
   11db0: 04 09 00 94  	bl	0x141c0 <xbrtime_api_asm.s+0x141c0>
; 	handle_static_init(argc, argv, env);
   11db4: e0 03 16 2a  	mov	w0, w22
   11db8: a1 d2 c1 c2  	mov	c1, c21
   11dbc: 82 d2 c1 c2  	mov	c2, c20
   11dc0: 1c 00 00 94  	bl	0x11e30 <handle_static_init>
; 	exit(main(argc, argv, env));
   11dc4: e0 03 16 2a  	mov	w0, w22
   11dc8: a1 d2 c1 c2  	mov	c1, c21
   11dcc: 82 d2 c1 c2  	mov	c2, c20
   11dd0: 97 06 00 94  	bl	0x1382c <main>
   11dd4: ff 08 00 94  	bl	0x141d0 <xbrtime_api_asm.s+0x141d0>
   11dd8: 20 00 20 d4  	brk	#0x1

0000000000011ddc <handle_argv>:
; 	if (environ == NULL)
   11ddc: 83 00 80 f0  	adrp	c3, 0x24000 <handle_argv+0x4c>
   11de0: 63 14 42 c2  	ldr	c3, [c3, #2128]
   11de4: 64 00 40 c2  	ldr	c4, [c3, #0]
   11de8: 84 00 00 b4  	cbz	x4, 0x11df8 <handle_argv+0x1c>
; 	if (argc > 0 && argv[0] != NULL) {
   11dec: 1f 04 00 71  	cmp	w0, #1                  // =1
   11df0: aa 00 00 54  	b.ge	0x11e04 <handle_argv+0x28>
   11df4: 0e 00 00 14  	b	0x11e2c <handle_argv+0x50>
; 		environ = env;
   11df8: 62 00 00 c2  	str	c2, [c3, #0]
; 	if (argc > 0 && argv[0] != NULL) {
   11dfc: 1f 04 00 71  	cmp	w0, #1                  // =1
   11e00: 6b 01 00 54  	b.lt	0x11e2c <handle_argv+0x50>
   11e04: 21 00 40 c2  	ldr	c1, [c1, #0]
   11e08: 21 01 00 b4  	cbz	x1, 0x11e2c <handle_argv+0x50>
; 		__progname = argv[0];
   11e0c: 80 00 80 f0  	adrp	c0, 0x24000 <handle_static_init+0x28>
   11e10: 00 18 42 c2  	ldr	c0, [c0, #2144]
   11e14: 01 00 00 c2  	str	c1, [c0, #0]
   11e18: 21 04 00 02  	add	c1, c1, #1              // =1
; 		for (s = __progname; *s != '\0'; s++) {
   11e1c: 28 f0 5f 38  	ldurb	w8, [c1, #-1]
   11e20: 1f bd 00 71  	cmp	w8, #47                 // =47
   11e24: 80 ff ff 54  	b.eq	0x11e14 <handle_argv+0x38>
   11e28: 88 ff ff 35  	cbnz	w8, 0x11e18 <handle_argv+0x3c>
; }
   11e2c: c0 53 c2 c2  	ret	c30

0000000000011e30 <handle_static_init>:
; {
   11e30: fd fb bc 62  	stp	c29, c30, [csp, #-112]!
   11e34: f7 0b 00 c2  	str	c23, [csp, #32]
   11e38: f6 d7 81 42  	stp	c22, c21, [csp, #48]
   11e3c: f4 cf 82 42  	stp	c20, c19, [csp, #80]
   11e40: fd d3 c1 c2  	mov	c29, csp
   11e44: 34 d0 c1 c2  	mov	c20, c1
; 	if (&_DYNAMIC != NULL)
   11e48: 81 00 80 f0  	adrp	c1, 0x24000 <handle_static_init+0x64>
   11e4c: 21 1c 42 c2  	ldr	c1, [c1, #2160]
   11e50: 61 07 00 b5  	cbnz	x1, 0x11f3c <handle_static_init+0x10c>
   11e54: f5 03 00 2a  	mov	w21, w0
; 	atexit(finalizer);
   11e58: 00 00 80 90  	adrp	c0, 0x11000 <handle_static_init+0x28>
   11e5c: 00 44 3d 02  	add	c0, c0, #3921           // =3921
   11e60: 00 30 c3 c2  	seal	c0, c0, rb
   11e64: 53 d0 c1 c2  	mov	c19, c2
   11e68: d6 08 00 94  	bl	0x141c0 <xbrtime_api_asm.s+0x141c0>
; 	array_size = __preinit_array_end - __preinit_array_start;
   11e6c: 80 00 80 f0  	adrp	c0, 0x24000 <handle_static_init+0x88>
   11e70: 00 20 42 c2  	ldr	c0, [c0, #2176]
   11e74: 81 00 80 f0  	adrp	c1, 0x24000 <handle_static_init+0x90>
   11e78: 21 24 42 c2  	ldr	c1, [c1, #2192]
   11e7c: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   11e80: a0 02 00 54  	b.eq	0x11ed4 <handle_static_init+0xa4>
   11e84: 97 00 80 f0  	adrp	c23, 0x24000 <handle_static_init+0xa0>
   11e88: f7 26 42 c2  	ldr	c23, [c23, #2192]
; 	array_size = __preinit_array_end - __preinit_array_start;
   11e8c: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   11e90: 1f 05 00 f1  	cmp	x8, #1                  // =1
   11e94: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   11e98: 04 00 00 14  	b	0x11ea8 <handle_static_init+0x78>
   11e9c: d6 06 00 f1  	subs	x22, x22, #1            // =1
   11ea0: f7 42 00 02  	add	c23, c23, #16           // =16
   11ea4: 80 01 00 54  	b.eq	0x11ed4 <handle_static_init+0xa4>
; 		fn = __preinit_array_start[n];
   11ea8: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11eac: 83 ff ff b4  	cbz	x3, 0x11e9c <handle_static_init+0x6c>
   11eb0: e0 03 1f aa  	mov	x0, xzr
   11eb4: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11eb8: 7f 00 00 eb  	cmp	x3, x0
   11ebc: 00 ff ff 54  	b.eq	0x11e9c <handle_static_init+0x6c>
; 			fn(argc, argv, env);
   11ec0: e0 03 15 2a  	mov	w0, w21
   11ec4: 81 d2 c1 c2  	mov	c1, c20
   11ec8: 62 d2 c1 c2  	mov	c2, c19
   11ecc: 60 30 c2 c2  	blr	c3
   11ed0: f3 ff ff 17  	b	0x11e9c <handle_static_init+0x6c>
; 	array_size = __init_array_end - __init_array_start;
   11ed4: 80 00 80 f0  	adrp	c0, 0x24000 <handle_static_init+0xf0>
   11ed8: 00 28 42 c2  	ldr	c0, [c0, #2208]
   11edc: 81 00 80 f0  	adrp	c1, 0x24000 <handle_static_init+0xf8>
   11ee0: 21 2c 42 c2  	ldr	c1, [c1, #2224]
   11ee4: 08 00 01 eb  	subs	x8, x0, x1
; 	for (n = 0; n < array_size; n++) {
   11ee8: a0 02 00 54  	b.eq	0x11f3c <handle_static_init+0x10c>
   11eec: 97 00 80 f0  	adrp	c23, 0x24000 <handle_static_init+0x108>
   11ef0: f7 2e 42 c2  	ldr	c23, [c23, #2224]
; 	array_size = __init_array_end - __init_array_start;
   11ef4: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = 0; n < array_size; n++) {
   11ef8: 1f 05 00 f1  	cmp	x8, #1                  // =1
   11efc: 16 85 9f 9a  	csinc	x22, x8, xzr, hi
   11f00: 04 00 00 14  	b	0x11f10 <handle_static_init+0xe0>
   11f04: d6 06 00 f1  	subs	x22, x22, #1            // =1
   11f08: f7 42 00 02  	add	c23, c23, #16           // =16
   11f0c: 80 01 00 54  	b.eq	0x11f3c <handle_static_init+0x10c>
; 		fn = __init_array_start[n];
   11f10: e3 02 40 c2  	ldr	c3, [c23, #0]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f14: 83 ff ff b4  	cbz	x3, 0x11f04 <handle_static_init+0xd4>
   11f18: e0 03 1f aa  	mov	x0, xzr
   11f1c: 00 04 00 02  	add	c0, c0, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f20: 7f 00 00 eb  	cmp	x3, x0
   11f24: 00 ff ff 54  	b.eq	0x11f04 <handle_static_init+0xd4>
; 			fn(argc, argv, env);
   11f28: e0 03 15 2a  	mov	w0, w21
   11f2c: 81 d2 c1 c2  	mov	c1, c20
   11f30: 62 d2 c1 c2  	mov	c2, c19
   11f34: 60 30 c2 c2  	blr	c3
   11f38: f3 ff ff 17  	b	0x11f04 <handle_static_init+0xd4>
; }
   11f3c: f4 cf c2 42  	ldp	c20, c19, [csp, #80]
   11f40: f6 d7 c1 42  	ldp	c22, c21, [csp, #48]
   11f44: f7 0b 40 c2  	ldr	c23, [csp, #32]
   11f48: fd fb c3 22  	ldp	c29, c30, [csp], #112
   11f4c: c0 53 c2 c2  	ret	c30

0000000000011f50 <finalizer>:
; {
   11f50: fd 7b be 62  	stp	c29, c30, [csp, #-64]!
   11f54: f4 4f 81 42  	stp	c20, c19, [csp, #32]
   11f58: fd d3 c1 c2  	mov	c29, csp
; 	array_size = __fini_array_end - __fini_array_start;
   11f5c: 80 00 80 f0  	adrp	c0, 0x24000 <finalizer+0x58>
   11f60: 00 30 42 c2  	ldr	c0, [c0, #2240]
   11f64: 93 00 80 f0  	adrp	c19, 0x24000 <finalizer+0x60>
   11f68: 73 36 42 c2  	ldr	c19, [c19, #2256]
   11f6c: 08 00 13 eb  	subs	x8, x0, x19
; 	for (n = array_size; n > 0; n--) {
   11f70: e0 01 00 54  	b.eq	0x11fac <finalizer+0x5c>
; 	array_size = __fini_array_end - __fini_array_start;
   11f74: 08 fd 44 93  	asr	x8, x8, #4
; 	for (n = array_size; n > 0; n--) {
   11f78: 14 05 00 d1  	sub	x20, x8, #1             // =1
   11f7c: 04 00 00 14  	b	0x11f8c <finalizer+0x3c>
   11f80: 94 06 00 d1  	sub	x20, x20, #1            // =1
   11f84: 9f 06 00 b1  	cmn	x20, #1                 // =1
   11f88: 20 01 00 54  	b.eq	0x11fac <finalizer+0x5c>
; 		fn = __fini_array_start[n - 1];
   11f8c: 60 7a 74 a2  	ldr	c0, [c19, x20, lsl #4]
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f90: 80 ff ff b4  	cbz	x0, 0x11f80 <finalizer+0x30>
   11f94: e1 03 1f aa  	mov	x1, xzr
   11f98: 21 04 00 02  	add	c1, c1, #1              // =1
; 		if ((uintptr_t)fn != 0 && (uintptr_t)fn != 1)
   11f9c: 1f 00 01 eb  	cmp	x0, x1
   11fa0: 00 ff ff 54  	b.eq	0x11f80 <finalizer+0x30>
; 			(fn)();
   11fa4: 00 30 c2 c2  	blr	c0
   11fa8: f6 ff ff 17  	b	0x11f80 <finalizer+0x30>
; }
   11fac: f4 4f c1 42  	ldp	c20, c19, [csp, #32]
   11fb0: fd 7b c2 22  	ldp	c29, c30, [csp], #64
   11fb4: c0 53 c2 c2  	ret	c30

0000000000011fb8 <run_cxa_finalize>:
; 	if (__cxa_finalize != NULL)
   11fb8: 80 00 80 f0  	adrp	c0, 0x24000 <xbrtime_malloc+0x20>
   11fbc: 00 38 42 c2  	ldr	c0, [c0, #2272]
   11fc0: 00 01 00 b4  	cbz	x0, 0x11fe0 <run_cxa_finalize+0x28>
   11fc4: fd 7b bf 62  	stp	c29, c30, [csp, #-32]!
   11fc8: fd d3 c1 c2  	mov	c29, csp
; 		__cxa_finalize(__dso_handle);
   11fcc: 80 00 80 f0  	adrp	c0, 0x24000 <xbrtime_malloc+0x34>
   11fd0: 00 3c 42 c2  	ldr	c0, [c0, #2288]
   11fd4: 00 00 40 c2  	ldr	c0, [c0, #0]
   11fd8: 82 08 00 94  	bl	0x141e0 <xbrtime_api_asm.s+0x141e0>
; }
   11fdc: fd 7b c1 22  	ldp	c29, c30, [csp], #32
   11fe0: c0 53 c2 c2  	ret	c30

0000000000011fe4 <xbrtime_malloc>:
; extern void *xbrtime_malloc( size_t sz ){
   11fe4: ff 03 82 02  	sub	csp, csp, #128          // =128
   11fe8: fd 7b 83 42  	stp	c29, c30, [csp, #96]
   11fec: fd 83 01 02  	add	c29, csp, #96           // =96
   11ff0: e8 03 00 aa  	mov	x8, x0
   11ff4: a0 43 80 02  	sub	c0, c29, #16            // =16
   11ff8: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   11ffc: e0 03 00 c2  	str	c0, [csp, #0]
   12000: a0 63 80 02  	sub	c0, c29, #24            // =24
   12004: 00 38 c4 c2  	scbnds	c0, c0, #8              // =8
   12008: 01 d0 c1 c2  	mov	c1, c0
   1200c: e1 07 00 c2  	str	c1, [csp, #16]
   12010: e1 c3 00 02  	add	c1, csp, #48            // =48
   12014: 22 38 c8 c2  	scbnds	c2, c1, #16             // =16
   12018: 41 d0 c1 c2  	mov	c1, c2
   1201c: e1 0b 00 c2  	str	c1, [csp, #32]
   12020: 08 00 00 f9  	str	x8, [c0]
;   void *ptr = NULL;
   12024: e1 03 1f aa  	mov	x1, xzr
   12028: 41 00 00 c2  	str	c1, [c2, #0]
;   if( sz == 0 ){
   1202c: 08 00 40 f9  	ldr	x8, [c0]
   12030: c8 00 00 b5  	cbnz	x8, 0x12048 <xbrtime_malloc+0x64>
   12034: 01 00 00 14  	b	0x12038 <xbrtime_malloc+0x54>
   12038: e1 03 40 c2  	ldr	c1, [csp, #0]
;     return NULL;
   1203c: e0 03 1f aa  	mov	x0, xzr
   12040: 20 00 00 c2  	str	c0, [c1, #0]
   12044: 0c 00 00 14  	b	0x12074 <xbrtime_malloc+0x90>
   12048: e0 07 40 c2  	ldr	c0, [csp, #16]
;   ptr = malloc(sz);
   1204c: 00 00 40 f9  	ldr	x0, [c0]
   12050: 68 08 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   12054: e1 0b 40 c2  	ldr	c1, [csp, #32]
   12058: 20 00 00 c2  	str	c0, [c1, #0]
;   __xbrtime_asm_quiet_fence();
   1205c: 4e 08 00 94  	bl	0x14194 <__xbrtime_asm_quiet_fence>
   12060: e0 0b 40 c2  	ldr	c0, [csp, #32]
   12064: e1 03 40 c2  	ldr	c1, [csp, #0]
;   return ptr;
   12068: 00 00 40 c2  	ldr	c0, [c0, #0]
   1206c: 20 00 00 c2  	str	c0, [c1, #0]
   12070: 01 00 00 14  	b	0x12074 <xbrtime_malloc+0x90>
   12074: e0 03 40 c2  	ldr	c0, [csp, #0]
; }
   12078: 00 00 40 c2  	ldr	c0, [c0, #0]
   1207c: fd 7b c3 42  	ldp	c29, c30, [csp, #96]
   12080: ff 03 02 02  	add	csp, csp, #128          // =128
   12084: c0 53 c2 c2  	ret	c30

0000000000012088 <xbrtime_free>:
; extern void xbrtime_free( void *ptr ){
   12088: ff c3 80 02  	sub	csp, csp, #48           // =48
   1208c: fd fb 80 42  	stp	c29, c30, [csp, #16]
   12090: fd 43 00 02  	add	c29, csp, #16           // =16
   12094: 01 d0 c1 c2  	mov	c1, c0
   12098: e0 d3 c1 c2  	mov	c0, csp
   1209c: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   120a0: 01 00 00 c2  	str	c1, [c0, #0]
;   if( ptr == NULL ){
   120a4: 00 00 40 c2  	ldr	c0, [c0, #0]
   120a8: e8 03 00 aa  	mov	x8, x0
   120ac: 68 00 00 b5  	cbnz	x8, 0x120b8 <xbrtime_free+0x30>
   120b0: 01 00 00 14  	b	0x120b4 <xbrtime_free+0x2c>
;     return ;
   120b4: 03 00 00 14  	b	0x120c0 <xbrtime_free+0x38>
;   __xbrtime_asm_quiet_fence();
   120b8: 37 08 00 94  	bl	0x14194 <__xbrtime_asm_quiet_fence>
; }
   120bc: 01 00 00 14  	b	0x120c0 <xbrtime_free+0x38>
   120c0: fd fb c0 42  	ldp	c29, c30, [csp, #16]
   120c4: ff c3 00 02  	add	csp, csp, #48           // =48
   120c8: c0 53 c2 c2  	ret	c30

00000000000120cc <tpool_create>:
; {                                                                               
   120cc: ff c3 82 02  	sub	csp, csp, #176          // =176
   120d0: fd fb 84 42  	stp	c29, c30, [csp, #144]
   120d4: fd 43 02 02  	add	c29, csp, #144          // =144
   120d8: e8 03 00 aa  	mov	x8, x0
   120dc: a0 23 80 02  	sub	c0, c29, #8             // =8
   120e0: 00 38 c4 c2  	scbnds	c0, c0, #8              // =8
   120e4: 01 d0 c1 c2  	mov	c1, c0
   120e8: e1 07 00 c2  	str	c1, [csp, #16]
   120ec: a1 83 80 02  	sub	c1, c29, #32            // =32
   120f0: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   120f4: e1 0b 00 c2  	str	c1, [csp, #32]
   120f8: a1 c3 80 02  	sub	c1, c29, #48            // =48
   120fc: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   12100: e1 0f 00 c2  	str	c1, [csp, #48]
   12104: a1 e3 80 02  	sub	c1, c29, #56            // =56
   12108: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
   1210c: e1 13 00 c2  	str	c1, [csp, #64]
   12110: 08 00 00 f9  	str	x8, [c0]
;   if (num == 0)                                                                 
   12114: 08 00 40 f9  	ldr	x8, [c0]
   12118: c8 00 00 b5  	cbnz	x8, 0x12130 <tpool_create+0x64>
   1211c: 01 00 00 14  	b	0x12120 <tpool_create+0x54>
   12120: e0 07 40 c2  	ldr	c0, [csp, #16]
   12124: 48 00 80 52  	mov	w8, #2
;     num = 2;                                                                    
   12128: 08 00 00 f9  	str	x8, [c0]
   1212c: 01 00 00 14  	b	0x12130 <tpool_create+0x64>
   12130: 28 00 80 52  	mov	w8, #1
   12134: e0 03 08 2a  	mov	w0, w8
   12138: 08 0e 80 52  	mov	w8, #112
   1213c: e1 03 08 2a  	mov	w1, w8
;   wq              = calloc(1, sizeof(*wq));                                     
   12140: 30 08 00 94  	bl	0x14200 <xbrtime_api_asm.s+0x14200>
   12144: e1 07 40 c2  	ldr	c1, [csp, #16]
   12148: 02 d0 c1 c2  	mov	c2, c0
   1214c: e0 0b 40 c2  	ldr	c0, [csp, #32]
   12150: 02 00 00 c2  	str	c2, [c0, #0]
;   wq->num_threads = num;                                                        
   12154: 28 00 40 f9  	ldr	x8, [c1]
   12158: 01 00 40 c2  	ldr	c1, [c0, #0]
   1215c: 28 2c 00 f9  	str	x8, [c1, #88]
;   pthread_mutex_init(&(wq->work_mutex), NULL);                                  
   12160: 00 00 40 c2  	ldr	c0, [c0, #0]
   12164: 00 80 00 02  	add	c0, c0, #32             // =32
   12168: e1 03 1f aa  	mov	x1, xzr
   1216c: e1 03 00 c2  	str	c1, [csp, #0]
   12170: 28 08 00 94  	bl	0x14210 <xbrtime_api_asm.s+0x14210>
   12174: e1 03 40 c2  	ldr	c1, [csp, #0]
   12178: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   pthread_cond_init(&(wq->work_cond), NULL);                                    
   1217c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12180: 00 c0 00 02  	add	c0, c0, #48             // =48
   12184: 27 08 00 94  	bl	0x14220 <xbrtime_api_asm.s+0x14220>
   12188: e1 03 40 c2  	ldr	c1, [csp, #0]
   1218c: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   pthread_cond_init(&(wq->working_cond), NULL);                                 
   12190: 00 00 40 c2  	ldr	c0, [c0, #0]
   12194: 00 00 01 02  	add	c0, c0, #64             // =64
   12198: 22 08 00 94  	bl	0x14220 <xbrtime_api_asm.s+0x14220>
   1219c: e2 0b 40 c2  	ldr	c2, [csp, #32]
   121a0: e1 03 40 c2  	ldr	c1, [csp, #0]
   121a4: e0 13 40 c2  	ldr	c0, [csp, #64]
;   wq->work_head = NULL;                                                         
   121a8: 43 00 40 c2  	ldr	c3, [c2, #0]
   121ac: 61 00 00 c2  	str	c1, [c3, #0]
;   wq->work_tail = NULL;                                                         
   121b0: 42 00 40 c2  	ldr	c2, [c2, #0]
   121b4: 41 04 00 c2  	str	c1, [c2, #16]
   121b8: e8 03 1f aa  	mov	x8, xzr
;   for (i=0; i<num; i++) {                                                       
   121bc: 08 00 00 f9  	str	x8, [c0]
   121c0: 01 00 00 14  	b	0x121c4 <tpool_create+0xf8>
   121c4: e0 07 40 c2  	ldr	c0, [csp, #16]
   121c8: e1 13 40 c2  	ldr	c1, [csp, #64]
;   for (i=0; i<num; i++) {                                                       
   121cc: 28 00 40 f9  	ldr	x8, [c1]
   121d0: 09 00 40 f9  	ldr	x9, [c0]
   121d4: 08 01 09 eb  	subs	x8, x8, x9
   121d8: 62 02 00 54  	b.hs	0x12224 <tpool_create+0x158>
   121dc: 01 00 00 14  	b	0x121e0 <tpool_create+0x114>
   121e0: e0 0f 40 c2  	ldr	c0, [csp, #48]
   121e4: e1 0b 40 c2  	ldr	c1, [csp, #32]
;     pthread_create(&thread, NULL, tpool_worker, wq);                            
   121e8: 23 00 40 c2  	ldr	c3, [c1, #0]
   121ec: 01 00 80 90  	adrp	c1, 0x12000 <tpool_create+0x120>
   121f0: 21 e4 08 02  	add	c1, c1, #569            // =569
   121f4: 22 30 c3 c2  	seal	c2, c1, rb
   121f8: e1 03 1f aa  	mov	x1, xzr
   121fc: 0d 08 00 94  	bl	0x14230 <xbrtime_api_asm.s+0x14230>
   12200: e0 0f 40 c2  	ldr	c0, [csp, #48]
;     pthread_detach(thread);                                                     
   12204: 00 00 40 c2  	ldr	c0, [c0, #0]
   12208: 0e 08 00 94  	bl	0x14240 <xbrtime_api_asm.s+0x14240>
;   }                                                                             
   1220c: 01 00 00 14  	b	0x12210 <tpool_create+0x144>
   12210: e0 13 40 c2  	ldr	c0, [csp, #64]
;   for (i=0; i<num; i++) {                                                       
   12214: 08 00 40 f9  	ldr	x8, [c0]
   12218: 08 05 00 91  	add	x8, x8, #1              // =1
   1221c: 08 00 00 f9  	str	x8, [c0]
   12220: e9 ff ff 17  	b	0x121c4 <tpool_create+0xf8>
   12224: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   return wq;                                                                    
   12228: 00 00 40 c2  	ldr	c0, [c0, #0]
   1222c: fd fb c4 42  	ldp	c29, c30, [csp, #144]
   12230: ff c3 02 02  	add	csp, csp, #176          // =176
   12234: c0 53 c2 c2  	ret	c30

0000000000012238 <tpool_worker>:
; {                                                                               
   12238: ff 03 82 02  	sub	csp, csp, #128          // =128
   1223c: fd 7b 83 42  	stp	c29, c30, [csp, #96]
   12240: fd 83 01 02  	add	c29, csp, #96           // =96
   12244: 02 d0 c1 c2  	mov	c2, c0
   12248: a0 43 80 02  	sub	c0, c29, #16            // =16
   1224c: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12250: a1 83 80 02  	sub	c1, c29, #32            // =32
   12254: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   12258: 23 d0 c1 c2  	mov	c3, c1
   1225c: e3 07 00 c2  	str	c3, [csp, #16]
   12260: e3 c3 00 02  	add	c3, csp, #48            // =48
   12264: 63 38 c8 c2  	scbnds	c3, c3, #16             // =16
   12268: e3 0b 00 c2  	str	c3, [csp, #32]
   1226c: 02 00 00 c2  	str	c2, [c0, #0]
;   tpool_work_queue_t  *wq = arg;                                                       
   12270: 00 00 40 c2  	ldr	c0, [c0, #0]
   12274: 20 00 00 c2  	str	c0, [c1, #0]
;   while (1) {                                                                   
   12278: 01 00 00 14  	b	0x1227c <tpool_worker+0x44>
   1227c: e0 07 40 c2  	ldr	c0, [csp, #16]
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   12280: 00 00 40 c2  	ldr	c0, [c0, #0]
   12284: 00 80 00 02  	add	c0, c0, #32             // =32
   12288: f2 07 00 94  	bl	0x14250 <xbrtime_api_asm.s+0x14250>
;     while (wq->work_head == NULL && !wq->stop)                                  
   1228c: 01 00 00 14  	b	0x12290 <tpool_worker+0x58>
   12290: e0 07 40 c2  	ldr	c0, [csp, #16]
;     while (wq->work_head == NULL && !wq->stop)                                  
   12294: 00 00 40 c2  	ldr	c0, [c0, #0]
   12298: 00 00 40 c2  	ldr	c0, [c0, #0]
   1229c: e9 03 1f 2a  	mov	w9, wzr
   122a0: e8 03 00 aa  	mov	x8, x0
   122a4: e9 0f 00 b9  	str	w9, [csp, #12]
   122a8: 08 01 00 b5  	cbnz	x8, 0x122c8 <tpool_worker+0x90>
   122ac: 01 00 00 14  	b	0x122b0 <tpool_worker+0x78>
   122b0: e0 07 40 c2  	ldr	c0, [csp, #16]
;     while (wq->work_head == NULL && !wq->stop)                                  
   122b4: 00 00 40 c2  	ldr	c0, [c0, #0]
   122b8: 08 80 41 39  	ldrb	w8, [c0, #96]
   122bc: 08 01 00 52  	eor	w8, w8, #0x1
   122c0: e8 0f 00 b9  	str	w8, [csp, #12]
   122c4: 01 00 00 14  	b	0x122c8 <tpool_worker+0x90>
   122c8: e8 0f 40 b9  	ldr	w8, [csp, #12]
;     while (wq->work_head == NULL && !wq->stop)                                  
   122cc: 08 01 00 36  	tbz	w8, #0, 0x122ec <tpool_worker+0xb4>
   122d0: 01 00 00 14  	b	0x122d4 <tpool_worker+0x9c>
   122d4: e0 07 40 c2  	ldr	c0, [csp, #16]
;       pthread_cond_wait(&(wq->work_cond), &(wq->work_mutex));                   
   122d8: 01 00 40 c2  	ldr	c1, [c0, #0]
   122dc: 20 c0 00 02  	add	c0, c1, #48             // =48
   122e0: 21 80 00 02  	add	c1, c1, #32             // =32
   122e4: df 07 00 94  	bl	0x14260 <xbrtime_api_asm.s+0x14260>
;     while (wq->work_head == NULL && !wq->stop)                                  
   122e8: ea ff ff 17  	b	0x12290 <tpool_worker+0x58>
   122ec: e0 07 40 c2  	ldr	c0, [csp, #16]
;     if (wq->stop)                                                               
   122f0: 00 00 40 c2  	ldr	c0, [c0, #0]
   122f4: 08 80 41 39  	ldrb	w8, [c0, #96]
   122f8: 68 00 00 36  	tbz	w8, #0, 0x12304 <tpool_worker+0xcc>
   122fc: 01 00 00 14  	b	0x12300 <tpool_worker+0xc8>
;       break;                                                                    
   12300: 3f 00 00 14  	b	0x123fc <tpool_worker+0x1c4>
   12304: e0 07 40 c2  	ldr	c0, [csp, #16]
;     work = tpool_work_unit_get(wq);                                                  
   12308: 00 00 40 c2  	ldr	c0, [c0, #0]
   1230c: d7 06 00 94  	bl	0x13e68 <tpool_work_unit_get>
   12310: e2 0b 40 c2  	ldr	c2, [csp, #32]
   12314: 01 d0 c1 c2  	mov	c1, c0
   12318: e0 07 40 c2  	ldr	c0, [csp, #16]
   1231c: 41 00 00 c2  	str	c1, [c2, #0]
;     wq->working_cnt++;                                                          
   12320: 01 00 40 c2  	ldr	c1, [c0, #0]
   12324: 28 28 40 f9  	ldr	x8, [c1, #80]
   12328: 08 05 00 91  	add	x8, x8, #1              // =1
   1232c: 28 28 00 f9  	str	x8, [c1, #80]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   12330: 00 00 40 c2  	ldr	c0, [c0, #0]
   12334: 00 80 00 02  	add	c0, c0, #32             // =32
   12338: ce 07 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
   1233c: e0 0b 40 c2  	ldr	c0, [csp, #32]
;     if (work != NULL) {                                                         
   12340: 00 00 40 c2  	ldr	c0, [c0, #0]
   12344: e8 03 00 aa  	mov	x8, x0
   12348: 68 01 00 b4  	cbz	x8, 0x12374 <tpool_worker+0x13c>
   1234c: 01 00 00 14  	b	0x12350 <tpool_worker+0x118>
   12350: e0 0b 40 c2  	ldr	c0, [csp, #32]
;       work->func(work->arg);                                                    
   12354: 00 00 40 c2  	ldr	c0, [c0, #0]
   12358: 01 00 40 c2  	ldr	c1, [c0, #0]
   1235c: 00 04 40 c2  	ldr	c0, [c0, #16]
   12360: 20 30 c2 c2  	blr	c1
   12364: e0 0b 40 c2  	ldr	c0, [csp, #32]
;       tpool_work_unit_destroy(work);                                                 
   12368: 00 00 40 c2  	ldr	c0, [c0, #0]
   1236c: 84 00 00 94  	bl	0x1257c <tpool_work_unit_destroy>
;     }                                                                           
   12370: 01 00 00 14  	b	0x12374 <tpool_worker+0x13c>
   12374: e0 07 40 c2  	ldr	c0, [csp, #16]
;     pthread_mutex_lock(&(wq->work_mutex));                                      
   12378: 00 00 40 c2  	ldr	c0, [c0, #0]
   1237c: 00 80 00 02  	add	c0, c0, #32             // =32
   12380: b4 07 00 94  	bl	0x14250 <xbrtime_api_asm.s+0x14250>
   12384: e0 07 40 c2  	ldr	c0, [csp, #16]
;     wq->working_cnt--;                                                          
   12388: 01 00 40 c2  	ldr	c1, [c0, #0]
   1238c: 28 28 40 f9  	ldr	x8, [c1, #80]
   12390: 08 05 00 f1  	subs	x8, x8, #1              // =1
   12394: 28 28 00 f9  	str	x8, [c1, #80]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   12398: 00 00 40 c2  	ldr	c0, [c0, #0]
   1239c: 08 80 41 39  	ldrb	w8, [c0, #96]
   123a0: 48 02 00 37  	tbnz	w8, #0, 0x123e8 <tpool_worker+0x1b0>
   123a4: 01 00 00 14  	b	0x123a8 <tpool_worker+0x170>
   123a8: e0 07 40 c2  	ldr	c0, [csp, #16]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   123ac: 00 00 40 c2  	ldr	c0, [c0, #0]
   123b0: 08 28 40 f9  	ldr	x8, [c0, #80]
   123b4: a8 01 00 b5  	cbnz	x8, 0x123e8 <tpool_worker+0x1b0>
   123b8: 01 00 00 14  	b	0x123bc <tpool_worker+0x184>
   123bc: e0 07 40 c2  	ldr	c0, [csp, #16]
;     if (!wq->stop && wq->working_cnt == 0 && wq->work_head == NULL)             
   123c0: 00 00 40 c2  	ldr	c0, [c0, #0]
   123c4: 00 00 40 c2  	ldr	c0, [c0, #0]
   123c8: e8 03 00 aa  	mov	x8, x0
   123cc: e8 00 00 b5  	cbnz	x8, 0x123e8 <tpool_worker+0x1b0>
   123d0: 01 00 00 14  	b	0x123d4 <tpool_worker+0x19c>
   123d4: e0 07 40 c2  	ldr	c0, [csp, #16]
;       pthread_cond_signal(&(wq->working_cond));                                 
   123d8: 00 00 40 c2  	ldr	c0, [c0, #0]
   123dc: 00 00 01 02  	add	c0, c0, #64             // =64
   123e0: a8 07 00 94  	bl	0x14280 <xbrtime_api_asm.s+0x14280>
   123e4: 01 00 00 14  	b	0x123e8 <tpool_worker+0x1b0>
   123e8: e0 07 40 c2  	ldr	c0, [csp, #16]
;     pthread_mutex_unlock(&(wq->work_mutex));                                    
   123ec: 00 00 40 c2  	ldr	c0, [c0, #0]
   123f0: 00 80 00 02  	add	c0, c0, #32             // =32
   123f4: 9f 07 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
;   while (1) {                                                                   
   123f8: a1 ff ff 17  	b	0x1227c <tpool_worker+0x44>
   123fc: e0 07 40 c2  	ldr	c0, [csp, #16]
;   wq->num_threads--;                                                            
   12400: 01 00 40 c2  	ldr	c1, [c0, #0]
   12404: 28 2c 40 f9  	ldr	x8, [c1, #88]
   12408: 08 05 00 f1  	subs	x8, x8, #1              // =1
   1240c: 28 2c 00 f9  	str	x8, [c1, #88]
;   pthread_cond_signal(&(wq->working_cond));                                     
   12410: 00 00 40 c2  	ldr	c0, [c0, #0]
   12414: 00 00 01 02  	add	c0, c0, #64             // =64
   12418: 9a 07 00 94  	bl	0x14280 <xbrtime_api_asm.s+0x14280>
   1241c: e0 07 40 c2  	ldr	c0, [csp, #16]
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12420: 00 00 40 c2  	ldr	c0, [c0, #0]
   12424: 00 80 00 02  	add	c0, c0, #32             // =32
   12428: 92 07 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
;   return NULL;                                                                  
   1242c: e0 03 1f aa  	mov	x0, xzr
   12430: fd 7b c3 42  	ldp	c29, c30, [csp, #96]
   12434: ff 03 02 02  	add	csp, csp, #128          // =128
   12438: c0 53 c2 c2  	ret	c30

000000000001243c <tpool_destroy>:
; {                                                                               
   1243c: ff 03 82 02  	sub	csp, csp, #128          // =128
   12440: fd 7b 83 42  	stp	c29, c30, [csp, #96]
   12444: fd 83 01 02  	add	c29, csp, #96           // =96
   12448: 01 d0 c1 c2  	mov	c1, c0
   1244c: a0 43 80 02  	sub	c0, c29, #16            // =16
   12450: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12454: 02 d0 c1 c2  	mov	c2, c0
   12458: e2 03 00 c2  	str	c2, [csp, #0]
   1245c: a2 83 80 02  	sub	c2, c29, #32            // =32
   12460: 42 38 c8 c2  	scbnds	c2, c2, #16             // =16
   12464: e2 07 00 c2  	str	c2, [csp, #16]
   12468: e2 c3 00 02  	add	c2, csp, #48            // =48
   1246c: 42 38 c8 c2  	scbnds	c2, c2, #16             // =16
   12470: e2 0b 00 c2  	str	c2, [csp, #32]
   12474: 01 00 00 c2  	str	c1, [c0, #0]
;   if (wq == NULL)                                                               
   12478: 00 00 40 c2  	ldr	c0, [c0, #0]
   1247c: e8 03 00 aa  	mov	x8, x0
   12480: 68 00 00 b5  	cbnz	x8, 0x1248c <tpool_destroy+0x50>
   12484: 01 00 00 14  	b	0x12488 <tpool_destroy+0x4c>
;     return;                                                                     
   12488: 3a 00 00 14  	b	0x12570 <tpool_destroy+0x134>
   1248c: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   12490: 00 00 40 c2  	ldr	c0, [c0, #0]
   12494: 00 80 00 02  	add	c0, c0, #32             // =32
   12498: 6e 07 00 94  	bl	0x14250 <xbrtime_api_asm.s+0x14250>
   1249c: e1 07 40 c2  	ldr	c1, [csp, #16]
   124a0: e0 03 40 c2  	ldr	c0, [csp, #0]
;   work = wq->work_head;                                                         
   124a4: 00 00 40 c2  	ldr	c0, [c0, #0]
   124a8: 00 00 40 c2  	ldr	c0, [c0, #0]
   124ac: 20 00 00 c2  	str	c0, [c1, #0]
;   while (work != NULL) {                                                        
   124b0: 01 00 00 14  	b	0x124b4 <tpool_destroy+0x78>
   124b4: e0 07 40 c2  	ldr	c0, [csp, #16]
;   while (work != NULL) {                                                        
   124b8: 00 00 40 c2  	ldr	c0, [c0, #0]
   124bc: e8 03 00 aa  	mov	x8, x0
   124c0: c8 01 00 b4  	cbz	x8, 0x124f8 <tpool_destroy+0xbc>
   124c4: 01 00 00 14  	b	0x124c8 <tpool_destroy+0x8c>
   124c8: e0 07 40 c2  	ldr	c0, [csp, #16]
   124cc: e2 0b 40 c2  	ldr	c2, [csp, #32]
;     work2 = work->next;                                                         
   124d0: 01 00 40 c2  	ldr	c1, [c0, #0]
   124d4: 21 08 40 c2  	ldr	c1, [c1, #32]
   124d8: 41 00 00 c2  	str	c1, [c2, #0]
;     tpool_work_unit_destroy(work);                                                   
   124dc: 00 00 40 c2  	ldr	c0, [c0, #0]
   124e0: 27 00 00 94  	bl	0x1257c <tpool_work_unit_destroy>
   124e4: e0 0b 40 c2  	ldr	c0, [csp, #32]
   124e8: e1 07 40 c2  	ldr	c1, [csp, #16]
;     work = work2;                                                               
   124ec: 00 00 40 c2  	ldr	c0, [c0, #0]
   124f0: 20 00 00 c2  	str	c0, [c1, #0]
;   while (work != NULL) {                                                        
   124f4: f0 ff ff 17  	b	0x124b4 <tpool_destroy+0x78>
   124f8: e0 03 40 c2  	ldr	c0, [csp, #0]
;   wq->stop = true;                                                              
   124fc: 01 00 40 c2  	ldr	c1, [c0, #0]
   12500: 28 00 80 52  	mov	w8, #1
   12504: 28 80 01 39  	strb	w8, [c1, #96]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   12508: 00 00 40 c2  	ldr	c0, [c0, #0]
   1250c: 00 c0 00 02  	add	c0, c0, #48             // =48
   12510: 60 07 00 94  	bl	0x14290 <xbrtime_api_asm.s+0x14290>
   12514: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12518: 00 00 40 c2  	ldr	c0, [c0, #0]
   1251c: 00 80 00 02  	add	c0, c0, #32             // =32
   12520: 54 07 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
   12524: e0 03 40 c2  	ldr	c0, [csp, #0]
;   tpool_wait(wq);                                                               
   12528: 00 00 40 c2  	ldr	c0, [c0, #0]
   1252c: 29 00 00 94  	bl	0x125d0 <tpool_wait>
   12530: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_mutex_destroy(&(wq->work_mutex));                                     
   12534: 00 00 40 c2  	ldr	c0, [c0, #0]
   12538: 00 80 00 02  	add	c0, c0, #32             // =32
   1253c: 59 07 00 94  	bl	0x142a0 <xbrtime_api_asm.s+0x142a0>
   12540: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_cond_destroy(&(wq->work_cond));                                       
   12544: 00 00 40 c2  	ldr	c0, [c0, #0]
   12548: 00 c0 00 02  	add	c0, c0, #48             // =48
   1254c: 59 07 00 94  	bl	0x142b0 <xbrtime_api_asm.s+0x142b0>
   12550: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_cond_destroy(&(wq->working_cond));                                    
   12554: 00 00 40 c2  	ldr	c0, [c0, #0]
   12558: 00 00 01 02  	add	c0, c0, #64             // =64
   1255c: 55 07 00 94  	bl	0x142b0 <xbrtime_api_asm.s+0x142b0>
   12560: e0 03 40 c2  	ldr	c0, [csp, #0]
;   free(wq);                                                                     
   12564: 00 00 40 c2  	ldr	c0, [c0, #0]
   12568: 56 07 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
; }     
   1256c: 01 00 00 14  	b	0x12570 <tpool_destroy+0x134>
   12570: fd 7b c3 42  	ldp	c29, c30, [csp, #96]
   12574: ff 03 02 02  	add	csp, csp, #128          // =128
   12578: c0 53 c2 c2  	ret	c30

000000000001257c <tpool_work_unit_destroy>:
; {                                                                               
   1257c: ff 03 81 02  	sub	csp, csp, #64           // =64
   12580: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   12584: fd 83 00 02  	add	c29, csp, #32           // =32
   12588: 01 d0 c1 c2  	mov	c1, c0
   1258c: e0 43 00 02  	add	c0, csp, #16            // =16
   12590: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12594: 02 d0 c1 c2  	mov	c2, c0
   12598: e2 03 00 c2  	str	c2, [csp, #0]
   1259c: 01 00 00 c2  	str	c1, [c0, #0]
;   if (work == NULL)                                                             
   125a0: 00 00 40 c2  	ldr	c0, [c0, #0]
   125a4: e8 03 00 aa  	mov	x8, x0
   125a8: 68 00 00 b5  	cbnz	x8, 0x125b4 <tpool_work_unit_destroy+0x38>
   125ac: 01 00 00 14  	b	0x125b0 <tpool_work_unit_destroy+0x34>
;     return;                                                                     
   125b0: 05 00 00 14  	b	0x125c4 <tpool_work_unit_destroy+0x48>
   125b4: e0 03 40 c2  	ldr	c0, [csp, #0]
;   free(work);                                                                   
   125b8: 00 00 40 c2  	ldr	c0, [c0, #0]
   125bc: 41 07 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
; }                                                 
   125c0: 01 00 00 14  	b	0x125c4 <tpool_work_unit_destroy+0x48>
   125c4: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   125c8: ff 03 01 02  	add	csp, csp, #64           // =64
   125cc: c0 53 c2 c2  	ret	c30

00000000000125d0 <tpool_wait>:
; {                                                                               
   125d0: ff 03 81 02  	sub	csp, csp, #64           // =64
   125d4: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   125d8: fd 83 00 02  	add	c29, csp, #32           // =32
   125dc: 01 d0 c1 c2  	mov	c1, c0
   125e0: e0 43 00 02  	add	c0, csp, #16            // =16
   125e4: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   125e8: 02 d0 c1 c2  	mov	c2, c0
   125ec: e2 03 00 c2  	str	c2, [csp, #0]
   125f0: 01 00 00 c2  	str	c1, [c0, #0]
;   if (wq == NULL) // Will only return when there is no work.                    
   125f4: 00 00 40 c2  	ldr	c0, [c0, #0]
   125f8: e8 03 00 aa  	mov	x8, x0
   125fc: 68 00 00 b5  	cbnz	x8, 0x12608 <tpool_wait+0x38>
   12600: 01 00 00 14  	b	0x12604 <tpool_wait+0x34>
;     return;                                                                     
   12604: 27 00 00 14  	b	0x126a0 <tpool_wait+0xd0>
   12608: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   1260c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12610: 00 80 00 02  	add	c0, c0, #32             // =32
   12614: 0f 07 00 94  	bl	0x14250 <xbrtime_api_asm.s+0x14250>
;   while (1) {                                                                   
   12618: 01 00 00 14  	b	0x1261c <tpool_wait+0x4c>
   1261c: e0 03 40 c2  	ldr	c0, [csp, #0]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12620: 00 00 40 c2  	ldr	c0, [c0, #0]
   12624: 08 80 41 39  	ldrb	w8, [c0, #96]
   12628: e8 00 00 37  	tbnz	w8, #0, 0x12644 <tpool_wait+0x74>
   1262c: 01 00 00 14  	b	0x12630 <tpool_wait+0x60>
   12630: e0 03 40 c2  	ldr	c0, [csp, #0]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12634: 00 00 40 c2  	ldr	c0, [c0, #0]
   12638: 08 28 40 f9  	ldr	x8, [c0, #80]
   1263c: 88 01 00 b5  	cbnz	x8, 0x1266c <tpool_wait+0x9c>
   12640: 01 00 00 14  	b	0x12644 <tpool_wait+0x74>
   12644: e0 03 40 c2  	ldr	c0, [csp, #0]
;         (wq->stop && wq->num_threads != 0)) {                                   
   12648: 00 00 40 c2  	ldr	c0, [c0, #0]
   1264c: 08 80 41 39  	ldrb	w8, [c0, #96]
   12650: a8 01 00 36  	tbz	w8, #0, 0x12684 <tpool_wait+0xb4>
   12654: 01 00 00 14  	b	0x12658 <tpool_wait+0x88>
   12658: e0 03 40 c2  	ldr	c0, [csp, #0]
;         (wq->stop && wq->num_threads != 0)) {                                   
   1265c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12660: 08 2c 40 f9  	ldr	x8, [c0, #88]
;     if ((!wq->stop && wq->working_cnt != 0) ||                                  
   12664: 08 01 00 b4  	cbz	x8, 0x12684 <tpool_wait+0xb4>
   12668: 01 00 00 14  	b	0x1266c <tpool_wait+0x9c>
   1266c: e0 03 40 c2  	ldr	c0, [csp, #0]
;       pthread_cond_wait(&(wq->working_cond), &(wq->work_mutex));                
   12670: 01 00 40 c2  	ldr	c1, [c0, #0]
   12674: 20 00 01 02  	add	c0, c1, #64             // =64
   12678: 21 80 00 02  	add	c1, c1, #32             // =32
   1267c: f9 06 00 94  	bl	0x14260 <xbrtime_api_asm.s+0x14260>
;     } else {                                                                    
   12680: 02 00 00 14  	b	0x12688 <tpool_wait+0xb8>
;       break;                                                                    
   12684: 02 00 00 14  	b	0x1268c <tpool_wait+0xbc>
;   while (1) {                                                                   
   12688: e5 ff ff 17  	b	0x1261c <tpool_wait+0x4c>
   1268c: e0 03 40 c2  	ldr	c0, [csp, #0]
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   12690: 00 00 40 c2  	ldr	c0, [c0, #0]
   12694: 00 80 00 02  	add	c0, c0, #32             // =32
   12698: f6 06 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
; } 
   1269c: 01 00 00 14  	b	0x126a0 <tpool_wait+0xd0>
   126a0: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   126a4: ff 03 01 02  	add	csp, csp, #64           // =64
   126a8: c0 53 c2 c2  	ret	c30

00000000000126ac <tpool_add_work>:
; {    
   126ac: ff 03 83 02  	sub	csp, csp, #192          // =192
   126b0: fd 7b 85 42  	stp	c29, c30, [csp, #160]
   126b4: fd 83 02 02  	add	c29, csp, #160          // =160
   126b8: 23 d0 c1 c2  	mov	c3, c1
   126bc: 05 d0 c1 c2  	mov	c5, c0
   126c0: a0 07 80 02  	sub	c0, c29, #1             // =1
   126c4: 00 b8 c0 c2  	scbnds	c0, c0, #1              // =1
   126c8: e0 03 00 c2  	str	c0, [csp, #0]
   126cc: a0 83 80 02  	sub	c0, c29, #32            // =32
   126d0: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   126d4: 01 d0 c1 c2  	mov	c1, c0
   126d8: e1 07 00 c2  	str	c1, [csp, #16]
   126dc: a1 c3 80 02  	sub	c1, c29, #48            // =48
   126e0: 24 38 c8 c2  	scbnds	c4, c1, #16             // =16
   126e4: 81 d0 c1 c2  	mov	c1, c4
   126e8: e1 0b 00 c2  	str	c1, [csp, #32]
   126ec: a1 03 81 02  	sub	c1, c29, #64            // =64
   126f0: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   126f4: 26 d0 c1 c2  	mov	c6, c1
   126f8: e6 0f 00 c2  	str	c6, [csp, #48]
   126fc: e6 43 01 02  	add	c6, csp, #80            // =80
   12700: c6 38 c8 c2  	scbnds	c6, c6, #16             // =16
   12704: e6 13 00 c2  	str	c6, [csp, #64]
   12708: 05 00 00 c2  	str	c5, [c0, #0]
   1270c: 83 00 00 c2  	str	c3, [c4, #0]
   12710: 22 00 00 c2  	str	c2, [c1, #0]
;   if (wq == NULL)                                                               
   12714: 00 00 40 c2  	ldr	c0, [c0, #0]
   12718: e8 03 00 aa  	mov	x8, x0
   1271c: c8 00 00 b5  	cbnz	x8, 0x12734 <tpool_add_work+0x88>
   12720: 01 00 00 14  	b	0x12724 <tpool_add_work+0x78>
   12724: e0 03 40 c2  	ldr	c0, [csp, #0]
   12728: e8 03 1f 2a  	mov	w8, wzr
;     return false;                                                               
   1272c: 08 00 00 39  	strb	w8, [c0]
   12730: 3a 00 00 14  	b	0x12818 <tpool_add_work+0x16c>
   12734: e1 0f 40 c2  	ldr	c1, [csp, #48]
   12738: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   work = tpool_work_unit_create(func, arg);                                          
   1273c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12740: 21 00 40 c2  	ldr	c1, [c1, #0]
   12744: 3a 00 00 94  	bl	0x1282c <tpool_work_unit_create>
   12748: 01 d0 c1 c2  	mov	c1, c0
   1274c: e0 13 40 c2  	ldr	c0, [csp, #64]
   12750: 01 00 00 c2  	str	c1, [c0, #0]
;   if (work == NULL)                                                             
   12754: 00 00 40 c2  	ldr	c0, [c0, #0]
   12758: e8 03 00 aa  	mov	x8, x0
   1275c: c8 00 00 b5  	cbnz	x8, 0x12774 <tpool_add_work+0xc8>
   12760: 01 00 00 14  	b	0x12764 <tpool_add_work+0xb8>
   12764: e0 03 40 c2  	ldr	c0, [csp, #0]
   12768: e8 03 1f 2a  	mov	w8, wzr
;     return false;                                                               
   1276c: 08 00 00 39  	strb	w8, [c0]
   12770: 2a 00 00 14  	b	0x12818 <tpool_add_work+0x16c>
   12774: e0 07 40 c2  	ldr	c0, [csp, #16]
;   pthread_mutex_lock(&(wq->work_mutex));                                        
   12778: 00 00 40 c2  	ldr	c0, [c0, #0]
   1277c: 00 80 00 02  	add	c0, c0, #32             // =32
   12780: b4 06 00 94  	bl	0x14250 <xbrtime_api_asm.s+0x14250>
   12784: e0 07 40 c2  	ldr	c0, [csp, #16]
;   if (wq->work_head == NULL) {                                                  
   12788: 00 00 40 c2  	ldr	c0, [c0, #0]
   1278c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12790: e8 03 00 aa  	mov	x8, x0
   12794: 68 01 00 b5  	cbnz	x8, 0x127c0 <tpool_add_work+0x114>
   12798: 01 00 00 14  	b	0x1279c <tpool_add_work+0xf0>
   1279c: e0 07 40 c2  	ldr	c0, [csp, #16]
   127a0: e1 13 40 c2  	ldr	c1, [csp, #64]
;     wq->work_head = work;                                                       
   127a4: 21 00 40 c2  	ldr	c1, [c1, #0]
   127a8: 02 00 40 c2  	ldr	c2, [c0, #0]
   127ac: 41 00 00 c2  	str	c1, [c2, #0]
;     wq->work_tail = wq->work_head;                                              
   127b0: 01 00 40 c2  	ldr	c1, [c0, #0]
   127b4: 20 00 40 c2  	ldr	c0, [c1, #0]
   127b8: 20 04 00 c2  	str	c0, [c1, #16]
;   } else {                                                                      
   127bc: 0b 00 00 14  	b	0x127e8 <tpool_add_work+0x13c>
   127c0: e1 07 40 c2  	ldr	c1, [csp, #16]
   127c4: e0 13 40 c2  	ldr	c0, [csp, #64]
;     wq->work_tail->next = work;                                                 
   127c8: 02 00 40 c2  	ldr	c2, [c0, #0]
   127cc: 23 00 40 c2  	ldr	c3, [c1, #0]
   127d0: 63 04 40 c2  	ldr	c3, [c3, #16]
   127d4: 62 08 00 c2  	str	c2, [c3, #32]
;     wq->work_tail       = work;                                                 
   127d8: 00 00 40 c2  	ldr	c0, [c0, #0]
   127dc: 21 00 40 c2  	ldr	c1, [c1, #0]
   127e0: 20 04 00 c2  	str	c0, [c1, #16]
   127e4: 01 00 00 14  	b	0x127e8 <tpool_add_work+0x13c>
   127e8: e0 07 40 c2  	ldr	c0, [csp, #16]
;   pthread_cond_broadcast(&(wq->work_cond));                                     
   127ec: 00 00 40 c2  	ldr	c0, [c0, #0]
   127f0: 00 c0 00 02  	add	c0, c0, #48             // =48
   127f4: a7 06 00 94  	bl	0x14290 <xbrtime_api_asm.s+0x14290>
   127f8: e0 07 40 c2  	ldr	c0, [csp, #16]
;   pthread_mutex_unlock(&(wq->work_mutex));                                      
   127fc: 00 00 40 c2  	ldr	c0, [c0, #0]
   12800: 00 80 00 02  	add	c0, c0, #32             // =32
   12804: 9b 06 00 94  	bl	0x14270 <xbrtime_api_asm.s+0x14270>
   12808: e0 03 40 c2  	ldr	c0, [csp, #0]
   1280c: 28 00 80 52  	mov	w8, #1
;   return true;                                                                  
   12810: 08 00 00 39  	strb	w8, [c0]
   12814: 01 00 00 14  	b	0x12818 <tpool_add_work+0x16c>
   12818: e0 03 40 c2  	ldr	c0, [csp, #0]
; }                                                                               
   1281c: 00 00 40 39  	ldrb	w0, [c0]
   12820: fd 7b c5 42  	ldp	c29, c30, [csp, #160]
   12824: ff 03 03 02  	add	csp, csp, #192          // =192
   12828: c0 53 c2 c2  	ret	c30

000000000001282c <tpool_work_unit_create>:
; {                                                                               
   1282c: ff 83 82 02  	sub	csp, csp, #160          // =160
   12830: fd 7b 84 42  	stp	c29, c30, [csp, #128]
   12834: fd 03 02 02  	add	c29, csp, #128          // =128
   12838: 03 d0 c1 c2  	mov	c3, c0
   1283c: a0 43 80 02  	sub	c0, c29, #16            // =16
   12840: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12844: e0 03 00 c2  	str	c0, [csp, #0]
   12848: a0 83 80 02  	sub	c0, c29, #32            // =32
   1284c: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12850: 02 d0 c1 c2  	mov	c2, c0
   12854: e2 07 00 c2  	str	c2, [csp, #16]
   12858: a2 c3 80 02  	sub	c2, c29, #48            // =48
   1285c: 42 38 c8 c2  	scbnds	c2, c2, #16             // =16
   12860: 44 d0 c1 c2  	mov	c4, c2
   12864: e4 0b 00 c2  	str	c4, [csp, #32]
   12868: e4 03 01 02  	add	c4, csp, #64            // =64
   1286c: 84 38 c8 c2  	scbnds	c4, c4, #16             // =16
   12870: e4 0f 00 c2  	str	c4, [csp, #48]
   12874: 03 00 00 c2  	str	c3, [c0, #0]
   12878: 41 00 00 c2  	str	c1, [c2, #0]
;   if (func == NULL)                                                             
   1287c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12880: e8 03 00 aa  	mov	x8, x0
   12884: c8 00 00 b5  	cbnz	x8, 0x1289c <tpool_work_unit_create+0x70>
   12888: 01 00 00 14  	b	0x1288c <tpool_work_unit_create+0x60>
   1288c: e1 03 40 c2  	ldr	c1, [csp, #0]
;     return NULL;                                                                
   12890: e0 03 1f aa  	mov	x0, xzr
   12894: 20 00 00 c2  	str	c0, [c1, #0]
   12898: 16 00 00 14  	b	0x128f0 <tpool_work_unit_create+0xc4>
   1289c: 08 06 80 52  	mov	w8, #48
   128a0: e0 03 08 2a  	mov	w0, w8
;   work       = malloc(sizeof(*work));                                           
   128a4: 53 06 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   128a8: e3 07 40 c2  	ldr	c3, [csp, #16]
   128ac: e2 0b 40 c2  	ldr	c2, [csp, #32]
   128b0: e1 03 40 c2  	ldr	c1, [csp, #0]
   128b4: 04 d0 c1 c2  	mov	c4, c0
   128b8: e0 0f 40 c2  	ldr	c0, [csp, #48]
   128bc: 04 00 00 c2  	str	c4, [c0, #0]
;   work->func = func;                                                            
   128c0: 63 00 40 c2  	ldr	c3, [c3, #0]
   128c4: 04 00 40 c2  	ldr	c4, [c0, #0]
   128c8: 83 00 00 c2  	str	c3, [c4, #0]
;   work->arg  = arg;                                                             
   128cc: 42 00 40 c2  	ldr	c2, [c2, #0]
   128d0: 03 00 40 c2  	ldr	c3, [c0, #0]
   128d4: 62 04 00 c2  	str	c2, [c3, #16]
;   work->next = NULL;                                                            
   128d8: 03 00 40 c2  	ldr	c3, [c0, #0]
   128dc: e2 03 1f aa  	mov	x2, xzr
   128e0: 62 08 00 c2  	str	c2, [c3, #32]
;   return work;                                                                  
   128e4: 00 00 40 c2  	ldr	c0, [c0, #0]
   128e8: 20 00 00 c2  	str	c0, [c1, #0]
   128ec: 01 00 00 14  	b	0x128f0 <tpool_work_unit_create+0xc4>
   128f0: e0 03 40 c2  	ldr	c0, [csp, #0]
; }                                                                               
   128f4: 00 00 40 c2  	ldr	c0, [c0, #0]
   128f8: fd 7b c4 42  	ldp	c29, c30, [csp, #128]
   128fc: ff 83 02 02  	add	csp, csp, #160          // =160
   12900: c0 53 c2 c2  	ret	c30

0000000000012904 <__xbrtime_ctor>:
; __attribute__((constructor)) void __xbrtime_ctor(){
   12904: ff 03 84 02  	sub	csp, csp, #256          // =256
   12908: fd 7b 87 42  	stp	c29, c30, [csp, #224]
   1290c: fd 83 03 02  	add	c29, csp, #224          // =224
   12910: a0 13 80 02  	sub	c0, c29, #4             // =4
   12914: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   12918: e0 1f 00 c2  	str	c0, [csp, #112]
   1291c: a0 23 80 02  	sub	c0, c29, #8             // =8
   12920: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   12924: a0 03 1a a2  	stur	c0, [c29, #-96]
   12928: e0 0f 00 c2  	str	c0, [csp, #48]
   1292c: a0 83 80 02  	sub	c0, c29, #32            // =32
   12930: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12934: a0 03 1b a2  	stur	c0, [c29, #-80]
   12938: e0 13 00 c2  	str	c0, [csp, #64]
   1293c: a0 c3 80 02  	sub	c0, c29, #48            // =48
   12940: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   12944: e0 17 00 c2  	str	c0, [csp, #80]
   12948: a0 f3 80 02  	sub	c0, c29, #60            // =60
   1294c: 00 38 c5 c2  	scbnds	c0, c0, #10             // =10
   12950: e0 1b 00 c2  	str	c0, [csp, #96]
;   printf("[M] Entered __xbrtime_ctor()\n");
   12954: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0x98>
   12958: 00 e0 40 c2  	ldr	c0, [c0, #896]
   1295c: e9 03 1f aa  	mov	x9, xzr
   12960: 5c 06 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12964: 08 14 80 52  	mov	w8, #160
   12968: e0 03 08 2a  	mov	w0, w8
;   xb_barrier = malloc(sizeof(uint64_t)*2*10);	
   1296c: 21 06 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   12970: e1 1f 40 c2  	ldr	c1, [csp, #112]
   12974: 02 d0 c1 c2  	mov	c2, c0
   12978: a0 03 5a a2  	ldur	c0, [c29, #-96]
   1297c: 83 00 80 d0  	adrp	c3, 0x24000 <__xbrtime_ctor+0xc0>
   12980: 63 40 42 c2  	ldr	c3, [c3, #2304]
   12984: 62 00 00 c2  	str	c2, [c3, #0]
   12988: e8 03 1f 2a  	mov	w8, wzr
;   int i = 0;
   1298c: 28 00 00 b9  	str	w8, [c1]
   12990: 08 02 80 52  	mov	w8, #16
;   int numOfThreads = MAX_NUM_OF_THREADS;
   12994: 08 00 00 b9  	str	w8, [c0]
;   char *str = getenv("NUM_OF_THREADS");
   12998: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0xdc>
   1299c: 00 e4 40 c2  	ldr	c0, [c0, #912]
   129a0: 50 06 00 94  	bl	0x142e0 <xbrtime_api_asm.s+0x142e0>
   129a4: 01 d0 c1 c2  	mov	c1, c0
   129a8: a0 03 5b a2  	ldur	c0, [c29, #-80]
   129ac: 01 00 00 c2  	str	c1, [c0, #0]
;   if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
   129b0: 00 00 40 c2  	ldr	c0, [c0, #0]
   129b4: e8 03 00 aa  	mov	x8, x0
   129b8: c8 01 00 b4  	cbz	x8, 0x129f0 <__xbrtime_ctor+0xec>
   129bc: 01 00 00 14  	b	0x129c0 <__xbrtime_ctor+0xbc>
   129c0: e0 13 40 c2  	ldr	c0, [csp, #64]
;   if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
   129c4: 00 00 40 c2  	ldr	c0, [c0, #0]
   129c8: 4a 06 00 94  	bl	0x142f0 <xbrtime_api_asm.s+0x142f0>
   129cc: 08 04 00 71  	subs	w8, w0, #1              // =1
   129d0: 0b 01 00 54  	b.lt	0x129f0 <__xbrtime_ctor+0xec>
   129d4: 01 00 00 14  	b	0x129d8 <__xbrtime_ctor+0xd4>
   129d8: e0 13 40 c2  	ldr	c0, [csp, #64]
;   if(str == NULL || atoi(str) <= 0 || atoi(str) > MAX_NUM_OF_THREADS){
   129dc: 00 00 40 c2  	ldr	c0, [c0, #0]
   129e0: 44 06 00 94  	bl	0x142f0 <xbrtime_api_asm.s+0x142f0>
   129e4: 08 44 00 71  	subs	w8, w0, #17             // =17
   129e8: ab 06 00 54  	b.lt	0x12abc <__xbrtime_ctor+0x1b8>
   129ec: 01 00 00 14  	b	0x129f0 <__xbrtime_ctor+0xec>
   129f0: e0 13 40 c2  	ldr	c0, [csp, #64]
;     if(str == NULL) {
   129f4: 00 00 40 c2  	ldr	c0, [c0, #0]
   129f8: e8 03 00 aa  	mov	x8, x0
   129fc: 48 01 00 b5  	cbnz	x8, 0x12a24 <__xbrtime_ctor+0x120>
   12a00: 01 00 00 14  	b	0x12a04 <__xbrtime_ctor+0x100>
;       fprintf(stderr, "\nNUM_OF_THREADS not set; set environment first!\n");
   12a04: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0x148>
   12a08: 00 44 42 c2  	ldr	c0, [c0, #2320]
   12a0c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12a10: 81 00 80 d0  	adrp	c1, 0x24000 <__xbrtime_ctor+0x154>
   12a14: 21 e8 40 c2  	ldr	c1, [c1, #928]
   12a18: e9 03 1f aa  	mov	x9, xzr
   12a1c: 39 06 00 94  	bl	0x14300 <xbrtime_api_asm.s+0x14300>
;     } else {
   12a20: 0f 00 00 14  	b	0x12a5c <__xbrtime_ctor+0x158>
;       fprintf(stderr, "\nNUM_OF_THREADS should be between %d and %d\n",
   12a24: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0x168>
   12a28: 00 44 42 c2  	ldr	c0, [c0, #2320]
   12a2c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12a30: e1 d3 c1 c2  	mov	c1, csp
   12a34: 08 02 80 52  	mov	w8, #16
   12a38: 28 08 00 f9  	str	x8, [c1, #16]
   12a3c: 28 00 80 52  	mov	w8, #1
   12a40: 28 00 00 f9  	str	x8, [c1]
   12a44: 21 38 d0 c2  	scbnds	c1, c1, #32             // =32
   12a48: 29 70 c6 c2  	clrperm	c9, c1, wx
   12a4c: 81 00 80 d0  	adrp	c1, 0x24000 <__xbrtime_ctor+0x190>
   12a50: 21 ec 40 c2  	ldr	c1, [c1, #944]
   12a54: 2b 06 00 94  	bl	0x14300 <xbrtime_api_asm.s+0x14300>
   12a58: 01 00 00 14  	b	0x12a5c <__xbrtime_ctor+0x158>
   12a5c: e0 1b 40 c2  	ldr	c0, [csp, #96]
   12a60: e3 17 40 c2  	ldr	c3, [csp, #80]
   12a64: e1 0f 40 c2  	ldr	c1, [csp, #48]
;     const char *envName = "NUM_OF_THREADS";
   12a68: 82 00 80 d0  	adrp	c2, 0x24000 <__xbrtime_ctor+0x1ac>
   12a6c: 42 e4 40 c2  	ldr	c2, [c2, #912]
   12a70: 62 00 00 c2  	str	c2, [c3, #0]
   12a74: e8 03 1f 2a  	mov	w8, wzr
;     char envValue[10] = "";
   12a78: 08 10 00 79  	strh	w8, [c0, #8]
   12a7c: e8 03 1f aa  	mov	x8, xzr
   12a80: 08 00 00 f9  	str	x8, [c0]
;     sprintf(envValue, "%d", numOfThreads);
   12a84: 28 00 40 b9  	ldr	w8, [c1]
   12a88: e1 d3 c1 c2  	mov	c1, csp
   12a8c: 28 00 00 f9  	str	x8, [c1]
   12a90: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   12a94: 29 70 c6 c2  	clrperm	c9, c1, wx
   12a98: 81 00 80 d0  	adrp	c1, 0x24000 <__xbrtime_ctor+0x1dc>
   12a9c: 21 f0 40 c2  	ldr	c1, [c1, #960]
   12aa0: 1c 06 00 94  	bl	0x14310 <xbrtime_api_asm.s+0x14310>
   12aa4: e1 1b 40 c2  	ldr	c1, [csp, #96]
   12aa8: e0 17 40 c2  	ldr	c0, [csp, #80]
;     setenv(envName, envValue, 1);
   12aac: 00 00 40 c2  	ldr	c0, [c0, #0]
   12ab0: 22 00 80 52  	mov	w2, #1
   12ab4: 1b 06 00 94  	bl	0x14320 <xbrtime_api_asm.s+0x14320>
;   }
   12ab8: 01 00 00 14  	b	0x12abc <__xbrtime_ctor+0x1b8>
;   numOfThreads = atoi(getenv("NUM_OF_THREADS"));
   12abc: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0x200>
   12ac0: 00 e4 40 c2  	ldr	c0, [c0, #912]
   12ac4: 07 06 00 94  	bl	0x142e0 <xbrtime_api_asm.s+0x142e0>
   12ac8: 0a 06 00 94  	bl	0x142f0 <xbrtime_api_asm.s+0x142f0>
   12acc: e1 0f 40 c2  	ldr	c1, [csp, #48]
   12ad0: 20 00 00 b9  	str	w0, [c1]
;   fprintf(stdout, "\nNumber of threads: %d\n", numOfThreads);
   12ad4: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_ctor+0x218>
   12ad8: 00 48 42 c2  	ldr	c0, [c0, #2336]
   12adc: e0 0b 00 c2  	str	c0, [csp, #32]
   12ae0: 00 00 40 c2  	ldr	c0, [c0, #0]
   12ae4: 28 00 40 b9  	ldr	w8, [c1]
   12ae8: e1 d3 c1 c2  	mov	c1, csp
   12aec: 28 00 00 f9  	str	x8, [c1]
   12af0: 21 38 c8 c2  	scbnds	c1, c1, #16             // =16
   12af4: 29 70 c6 c2  	clrperm	c9, c1, wx
   12af8: 81 00 80 d0  	adrp	c1, 0x24000 <__xbrtime_dtor+0xc>
   12afc: 21 f4 40 c2  	ldr	c1, [c1, #976]
   12b00: 00 06 00 94  	bl	0x14300 <xbrtime_api_asm.s+0x14300>
   12b04: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   fflush(stdout);
   12b08: 00 00 40 c2  	ldr	c0, [c0, #0]
   12b0c: 09 06 00 94  	bl	0x14330 <xbrtime_api_asm.s+0x14330>
   12b10: e0 0f 40 c2  	ldr	c0, [csp, #48]
;   pool = tpool_create(numOfThreads);
   12b14: 00 00 80 b9  	ldrsw	x0, [c0]
   12b18: 6d fd ff 97  	bl	0x120cc <tpool_create>
   12b1c: 81 00 80 d0  	adrp	c1, 0x24000 <__xbrtime_dtor+0x30>
   12b20: 21 4c 42 c2  	ldr	c1, [c1, #2352]
   12b24: 20 00 00 c2  	str	c0, [c1, #0]
; }
   12b28: fd 7b c7 42  	ldp	c29, c30, [csp, #224]
   12b2c: ff 03 04 02  	add	csp, csp, #256          // =256
   12b30: c0 53 c2 c2  	ret	c30

0000000000012b34 <__xbrtime_dtor>:
; __attribute__((destructor)) void __xbrtime_dtor(){
   12b34: ff 43 81 02  	sub	csp, csp, #80           // =80
   12b38: fd fb 81 42  	stp	c29, c30, [csp, #48]
   12b3c: fd c3 00 02  	add	c29, csp, #48           // =48
   12b40: a0 23 80 02  	sub	c0, c29, #8             // =8
   12b44: 00 38 c4 c2  	scbnds	c0, c0, #8              // =8
   12b48: e0 07 00 c2  	str	c0, [csp, #16]
;   printf("[M] Entered __xbrtime_dtor()\n");
   12b4c: 80 00 80 d0  	adrp	c0, 0x24000 <__xbrtime_dtor+0x60>
   12b50: 00 f8 40 c2  	ldr	c0, [c0, #992]
   12b54: e9 03 1f aa  	mov	x9, xzr
   12b58: de 05 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
;   tpool_wait(pool);
   12b5c: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close>
   12b60: 00 4c 42 c2  	ldr	c0, [c0, #2352]
   12b64: e0 03 00 c2  	str	c0, [csp, #0]
   12b68: 00 00 40 c2  	ldr	c0, [c0, #0]
   12b6c: 99 fe ff 97  	bl	0x125d0 <tpool_wait>
   12b70: e0 03 40 c2  	ldr	c0, [csp, #0]
;   tpool_destroy(pool); 
   12b74: 00 00 40 c2  	ldr	c0, [c0, #0]
   12b78: 31 fe ff 97  	bl	0x1243c <tpool_destroy>
   12b7c: e0 07 40 c2  	ldr	c0, [csp, #16]
   12b80: e8 03 1f aa  	mov	x8, xzr
; 	uint64_t end = 0;
   12b84: 08 00 00 f9  	str	x8, [c0]
;   free ((void*)xb_barrier); 	
   12b88: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0x2c>
   12b8c: 00 40 42 c2  	ldr	c0, [c0, #2304]
   12b90: 00 00 40 c2  	ldr	c0, [c0, #0]
   12b94: cb 05 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
; }
   12b98: fd fb c1 42  	ldp	c29, c30, [csp, #48]
   12b9c: ff 43 01 02  	add	csp, csp, #80           // =80
   12ba0: c0 53 c2 c2  	ret	c30

0000000000012ba4 <xbrtime_close>:
; extern void xbrtime_close(){
   12ba4: ff 43 81 02  	sub	csp, csp, #80           // =80
   12ba8: fd fb 81 42  	stp	c29, c30, [csp, #48]
   12bac: fd c3 00 02  	add	c29, csp, #48           // =48
   12bb0: a0 13 80 02  	sub	c0, c29, #4             // =4
   12bb4: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   12bb8: 01 d0 c1 c2  	mov	c1, c0
   12bbc: e1 07 00 c2  	str	c1, [csp, #16]
   12bc0: e8 03 1f 2a  	mov	w8, wzr
;   int i = 0;
   12bc4: 08 00 00 b9  	str	w8, [c0]
;   if( __XBRTIME_CONFIG != NULL ){
   12bc8: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0x6c>
   12bcc: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12bd0: 00 00 40 c2  	ldr	c0, [c0, #0]
   12bd4: e8 03 00 aa  	mov	x8, x0
   12bd8: e8 07 00 b4  	cbz	x8, 0x12cd4 <xbrtime_close+0x130>
   12bdc: 01 00 00 14  	b	0x12be0 <xbrtime_close+0x3c>
;     __xbrtime_asm_fence();
   12be0: 6a 05 00 94  	bl	0x14188 <__xbrtime_asm_fence>
   12be4: e0 07 40 c2  	ldr	c0, [csp, #16]
   12be8: e8 03 1f 2a  	mov	w8, wzr
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   12bec: 08 00 00 b9  	str	w8, [c0]
   12bf0: 01 00 00 14  	b	0x12bf4 <xbrtime_close+0x50>
   12bf4: e0 07 40 c2  	ldr	c0, [csp, #16]
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   12bf8: 08 00 40 b9  	ldr	w8, [c0]
   12bfc: 08 fd 1f 71  	subs	w8, w8, #2047           // =2047
   12c00: cc 03 00 54  	b.gt	0x12c78 <xbrtime_close+0xd4>
   12c04: 01 00 00 14  	b	0x12c08 <xbrtime_close+0x64>
   12c08: e1 07 40 c2  	ldr	c1, [csp, #16]
;       if( __XBRTIME_CONFIG->_MMAP[i].size != 0 ){
   12c0c: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0xb0>
   12c10: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12c14: 00 00 40 c2  	ldr	c0, [c0, #0]
   12c18: 00 0c 40 c2  	ldr	c0, [c0, #48]
   12c1c: 28 00 80 b9  	ldrsw	x8, [c1]
   12c20: 00 70 a8 c2  	add	c0, c0, x8, uxtx #4
   12c24: 08 04 40 f9  	ldr	x8, [c0, #8]
   12c28: c8 01 00 b4  	cbz	x8, 0x12c60 <xbrtime_close+0xbc>
   12c2c: 01 00 00 14  	b	0x12c30 <xbrtime_close+0x8c>
   12c30: e1 07 40 c2  	ldr	c1, [csp, #16]
;         xbrtime_free((void *)(__XBRTIME_CONFIG->_MMAP[i].start_addr));
   12c34: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0xd8>
   12c38: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12c3c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12c40: 00 0c 40 c2  	ldr	c0, [c0, #48]
   12c44: 28 00 80 b9  	ldrsw	x8, [c1]
   12c48: 08 ed 7c d3  	lsl	x8, x8, #4
   12c4c: 08 68 68 f8  	ldr	x8, [c0, x8]
   12c50: e0 03 1f aa  	mov	x0, xzr
   12c54: 00 60 a8 c2  	add	c0, c0, x8, uxtx
   12c58: 0c fd ff 97  	bl	0x12088 <xbrtime_free>
;       }
   12c5c: 01 00 00 14  	b	0x12c60 <xbrtime_close+0xbc>
;     }
   12c60: 01 00 00 14  	b	0x12c64 <xbrtime_close+0xc0>
   12c64: e0 07 40 c2  	ldr	c0, [csp, #16]
;     for( i=0; i<_XBRTIME_MEM_SLOTS_; i++ ){
   12c68: 08 00 40 b9  	ldr	w8, [c0]
   12c6c: 08 05 00 11  	add	w8, w8, #1              // =1
   12c70: 08 00 00 b9  	str	w8, [c0]
   12c74: e0 ff ff 17  	b	0x12bf4 <xbrtime_close+0x50>
;     if( __XBRTIME_CONFIG->_MAP != NULL ){
   12c78: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0x11c>
   12c7c: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12c80: 00 00 40 c2  	ldr	c0, [c0, #0]
   12c84: 00 10 40 c2  	ldr	c0, [c0, #64]
   12c88: e8 03 00 aa  	mov	x8, x0
   12c8c: a8 01 00 b4  	cbz	x8, 0x12cc0 <xbrtime_close+0x11c>
   12c90: 01 00 00 14  	b	0x12c94 <xbrtime_close+0xf0>
;       free( __XBRTIME_CONFIG->_MAP );
   12c94: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_close+0x138>
   12c98: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12c9c: e0 03 00 c2  	str	c0, [csp, #0]
   12ca0: 00 00 40 c2  	ldr	c0, [c0, #0]
   12ca4: 00 10 40 c2  	ldr	c0, [c0, #64]
   12ca8: 86 05 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
   12cac: e0 03 40 c2  	ldr	c0, [csp, #0]
;       __XBRTIME_CONFIG->_MAP = NULL;
   12cb0: 01 00 40 c2  	ldr	c1, [c0, #0]
   12cb4: e0 03 1f aa  	mov	x0, xzr
   12cb8: 20 10 00 c2  	str	c0, [c1, #64]
;     }
   12cbc: 01 00 00 14  	b	0x12cc0 <xbrtime_close+0x11c>
;     free( __XBRTIME_CONFIG );
   12cc0: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x28>
   12cc4: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12cc8: 00 00 40 c2  	ldr	c0, [c0, #0]
   12ccc: 7d 05 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
;   }
   12cd0: 01 00 00 14  	b	0x12cd4 <xbrtime_close+0x130>
; }
   12cd4: fd fb c1 42  	ldp	c29, c30, [csp, #48]
   12cd8: ff 43 01 02  	add	csp, csp, #80           // =80
   12cdc: c0 53 c2 c2  	ret	c30

0000000000012ce0 <xbrtime_init>:
; extern int xbrtime_init(){
   12ce0: ff 03 83 02  	sub	csp, csp, #192          // =192
   12ce4: fd 7b 85 42  	stp	c29, c30, [csp, #160]
   12ce8: fd 83 02 02  	add	c29, csp, #160          // =160
   12cec: a0 13 80 02  	sub	c0, c29, #4             // =4
   12cf0: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   12cf4: e0 13 00 c2  	str	c0, [csp, #64]
   12cf8: a0 23 80 02  	sub	c0, c29, #8             // =8
   12cfc: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   12d00: a0 03 1c a2  	stur	c0, [c29, #-64]
   12d04: e0 17 00 c2  	str	c0, [csp, #80]
;   printf("[M] Entered xbrtime_init()\n");
   12d08: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x70>
   12d0c: 00 fc 40 c2  	ldr	c0, [c0, #1008]
   12d10: e9 03 1f aa  	mov	x9, xzr
   12d14: a9 03 1d a2  	stur	c9, [c29, #-48]
   12d18: 6e 05 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12d1c: a1 03 5c a2  	ldur	c1, [c29, #-64]
   12d20: a0 03 5d a2  	ldur	c0, [c29, #-48]
   12d24: e8 03 1f 2a  	mov	w8, wzr
;   int i = 0;
   12d28: 28 00 00 b9  	str	w8, [c1]
;   __XBRTIME_CONFIG = NULL;
   12d2c: 81 00 80 d0  	adrp	c1, 0x24000 <xbrtime_init+0x94>
   12d30: 21 50 42 c2  	ldr	c1, [c1, #2368]
   12d34: a1 03 1e a2  	stur	c1, [c29, #-32]
   12d38: 20 00 00 c2  	str	c0, [c1, #0]
   12d3c: 08 0a 80 52  	mov	w8, #80
   12d40: e0 03 08 2a  	mov	w0, w8
;   __XBRTIME_CONFIG = malloc( sizeof( XBRTIME_DATA ) );
   12d44: 2b 05 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   12d48: 01 d0 c1 c2  	mov	c1, c0
   12d4c: a0 03 5e a2  	ldur	c0, [c29, #-32]
   12d50: 01 00 00 c2  	str	c1, [c0, #0]
;   if( __XBRTIME_CONFIG == NULL ){
   12d54: 00 00 40 c2  	ldr	c0, [c0, #0]
   12d58: e8 03 00 aa  	mov	x8, x0
   12d5c: c8 00 00 b5  	cbnz	x8, 0x12d74 <xbrtime_init+0x94>
   12d60: 01 00 00 14  	b	0x12d64 <xbrtime_init+0x84>
   12d64: e0 13 40 c2  	ldr	c0, [csp, #64]
   12d68: 08 00 80 12  	mov	w8, #-1
;     return -1;
   12d6c: 08 00 00 b9  	str	w8, [c0]
   12d70: cb 00 00 14  	b	0x1309c <xbrtime_init+0x3bc>
   12d74: 08 00 90 52  	mov	w8, #32768
   12d78: e0 03 08 2a  	mov	w0, w8
;   __XBRTIME_CONFIG->_MMAP       = malloc(sizeof(XBRTIME_MEM_T) * _XBRTIME_MEM_SLOTS_);
   12d7c: 1d 05 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   12d80: 01 d0 c1 c2  	mov	c1, c0
   12d84: e0 17 40 c2  	ldr	c0, [csp, #80]
   12d88: 82 00 80 d0  	adrp	c2, 0x24000 <xbrtime_init+0xf0>
   12d8c: 42 50 42 c2  	ldr	c2, [c2, #2368]
   12d90: 43 00 40 c2  	ldr	c3, [c2, #0]
   12d94: 61 0c 00 c2  	str	c1, [c3, #48]
;   __XBRTIME_CONFIG->_ID         = 0;          // __xbrtime_asm_get_id();
   12d98: 41 00 40 c2  	ldr	c1, [c2, #0]
   12d9c: e8 03 1f 2a  	mov	w8, wzr
   12da0: 28 08 00 b9  	str	w8, [c1, #8]
;   __XBRTIME_CONFIG->_MEMSIZE    = 4096 * 4096;// __xbrtime_asm_get_memsize();
   12da4: 41 00 40 c2  	ldr	c1, [c2, #0]
   12da8: 09 20 a0 52  	mov	w9, #16777216
   12dac: 29 00 00 f9  	str	x9, [c1]
;   __XBRTIME_CONFIG->_NPES       = 8;          // __xbrtime_asm_get_npes();
   12db0: 41 00 40 c2  	ldr	c1, [c2, #0]
   12db4: 09 01 80 52  	mov	w9, #8
   12db8: 29 0c 00 b9  	str	w9, [c1, #12]
;   __XBRTIME_CONFIG->_START_ADDR = 0x00ull;    // __xbrtime_asm_get_startaddr();
   12dbc: 41 00 40 c2  	ldr	c1, [c2, #0]
   12dc0: e9 03 1f aa  	mov	x9, xzr
   12dc4: 29 08 00 f9  	str	x9, [c1, #16]
;   __XBRTIME_CONFIG->_SENSE      = 0x00ull;    // __xbrtime_asm_get_sense();
   12dc8: 41 00 40 c2  	ldr	c1, [c2, #0]
   12dcc: 29 0c 00 f9  	str	x9, [c1, #24]
;   __XBRTIME_CONFIG->_BARRIER 		= xb_barrier; // malloc(sizeof(uint64_t)*2*10);
   12dd0: 81 00 80 d0  	adrp	c1, 0x24000 <xbrtime_init+0x138>
   12dd4: 21 40 42 c2  	ldr	c1, [c1, #2304]
   12dd8: 21 00 40 c2  	ldr	c1, [c1, #0]
   12ddc: 42 00 40 c2  	ldr	c2, [c2, #0]
   12de0: 41 08 00 c2  	str	c1, [c2, #32]
; 	for( i = 0; i < 10; i++){
   12de4: 08 00 00 b9  	str	w8, [c0]
   12de8: 01 00 00 14  	b	0x12dec <xbrtime_init+0x10c>
   12dec: e0 17 40 c2  	ldr	c0, [csp, #80]
; 	for( i = 0; i < 10; i++){
   12df0: 08 00 40 b9  	ldr	w8, [c0]
   12df4: 08 25 00 71  	subs	w8, w8, #9              // =9
   12df8: 0c 03 00 54  	b.gt	0x12e58 <xbrtime_init+0x178>
   12dfc: 01 00 00 14  	b	0x12e00 <xbrtime_init+0x120>
   12e00: e1 17 40 c2  	ldr	c1, [csp, #80]
;   	__XBRTIME_CONFIG->_BARRIER[i] 		= 0xfffffffffull;
   12e04: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x16c>
   12e08: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12e0c: 02 00 40 c2  	ldr	c2, [c0, #0]
   12e10: 42 08 40 c2  	ldr	c2, [c2, #32]
   12e14: 29 00 80 b9  	ldrsw	x9, [c1]
   12e18: e8 8f 40 b2  	mov	x8, #68719476735
   12e1c: 48 78 29 f8  	str	x8, [c2, x9, lsl #3]
;   	__XBRTIME_CONFIG->_BARRIER[10+i] 	= 0xaaaaaaaaaull;
   12e20: 00 00 40 c2  	ldr	c0, [c0, #0]
   12e24: 00 08 40 c2  	ldr	c0, [c0, #32]
   12e28: 28 00 40 b9  	ldr	w8, [c1]
   12e2c: 09 29 00 11  	add	w9, w8, #10             // =10
   12e30: 48 55 95 d2  	mov	x8, #43690
   12e34: 48 55 b5 f2  	movk	x8, #43690, lsl #16
   12e38: 48 01 c0 f2  	movk	x8, #10, lsl #32
   12e3c: 08 d8 29 f8  	str	x8, [c0, w9, sxtw #3]
; 	}
   12e40: 01 00 00 14  	b	0x12e44 <xbrtime_init+0x164>
   12e44: e0 17 40 c2  	ldr	c0, [csp, #80]
; 	for( i = 0; i < 10; i++){
   12e48: 08 00 40 b9  	ldr	w8, [c0]
   12e4c: 08 05 00 11  	add	w8, w8, #1              // =1
   12e50: 08 00 00 b9  	str	w8, [c0]
   12e54: e6 ff ff 17  	b	0x12dec <xbrtime_init+0x10c>
; 	printf("PE:%d----BARRIER[O] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[0]);
   12e58: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x1c0>
   12e5c: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12e60: e0 0f 00 c2  	str	c0, [csp, #48]
   12e64: 01 00 40 c2  	ldr	c1, [c0, #0]
   12e68: 20 08 40 c2  	ldr	c0, [c1, #32]
   12e6c: 28 08 40 b9  	ldr	w8, [c1, #8]
   12e70: 09 00 40 f9  	ldr	x9, [c0]
   12e74: e0 d3 c1 c2  	mov	c0, csp
   12e78: 09 08 00 f9  	str	x9, [c0, #16]
   12e7c: 08 00 00 f9  	str	x8, [c0]
   12e80: 00 38 d0 c2  	scbnds	c0, c0, #32             // =32
   12e84: 09 70 c6 c2  	clrperm	c9, c0, wx
   12e88: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x1f0>
   12e8c: 00 00 41 c2  	ldr	c0, [c0, #1024]
   12e90: 10 05 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12e94: e0 0f 40 c2  	ldr	c0, [csp, #48]
; 	printf("PE:%d----BARRIER[1] = 0x%lx\n", __XBRTIME_CONFIG->_ID, __XBRTIME_CONFIG->_BARRIER[1]);
   12e98: 01 00 40 c2  	ldr	c1, [c0, #0]
   12e9c: 20 08 40 c2  	ldr	c0, [c1, #32]
   12ea0: 28 08 40 b9  	ldr	w8, [c1, #8]
   12ea4: 09 04 40 f9  	ldr	x9, [c0, #8]
   12ea8: e0 d3 c1 c2  	mov	c0, csp
   12eac: 09 08 00 f9  	str	x9, [c0, #16]
   12eb0: 08 00 00 f9  	str	x8, [c0]
   12eb4: 00 38 d0 c2  	scbnds	c0, c0, #32             // =32
   12eb8: 09 70 c6 c2  	clrperm	c9, c0, wx
   12ebc: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x224>
   12ec0: 00 04 41 c2  	ldr	c0, [c0, #1040]
   12ec4: 03 05 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12ec8: e0 0f 40 c2  	ldr	c0, [csp, #48]
;   if( __XBRTIME_CONFIG->_NPES > __XBRTIME_MAX_PE ){
   12ecc: 00 00 40 c2  	ldr	c0, [c0, #0]
   12ed0: 08 0c 40 b9  	ldr	w8, [c0, #12]
   12ed4: 08 05 10 71  	subs	w8, w8, #1025           // =1025
   12ed8: 4b 01 00 54  	b.lt	0x12f00 <xbrtime_init+0x220>
   12edc: 01 00 00 14  	b	0x12ee0 <xbrtime_init+0x200>
;     free( __XBRTIME_CONFIG );
   12ee0: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x248>
   12ee4: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12ee8: 00 00 40 c2  	ldr	c0, [c0, #0]
   12eec: f5 04 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
   12ef0: e0 13 40 c2  	ldr	c0, [csp, #64]
   12ef4: 08 00 80 12  	mov	w8, #-1
;     return -1;
   12ef8: 08 00 00 b9  	str	w8, [c0]
   12efc: 68 00 00 14  	b	0x1309c <xbrtime_init+0x3bc>
;                                    __XBRTIME_CONFIG->_NPES );
   12f00: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x268>
   12f04: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12f08: e0 0b 00 c2  	str	c0, [csp, #32]
   12f0c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12f10: 08 0c 80 b9  	ldrsw	x8, [c0, #12]
;   __XBRTIME_CONFIG->_MAP = malloc( sizeof( XBRTIME_PE_MAP ) *
   12f14: 00 ed 7c d3  	lsl	x0, x8, #4
   12f18: b6 04 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   12f1c: 01 d0 c1 c2  	mov	c1, c0
   12f20: e0 0b 40 c2  	ldr	c0, [csp, #32]
   12f24: 02 00 40 c2  	ldr	c2, [c0, #0]
   12f28: 41 10 00 c2  	str	c1, [c2, #64]
;   if( __XBRTIME_CONFIG->_MAP == NULL ){
   12f2c: 00 00 40 c2  	ldr	c0, [c0, #0]
   12f30: 00 10 40 c2  	ldr	c0, [c0, #64]
   12f34: e8 03 00 aa  	mov	x8, x0
   12f38: 48 01 00 b5  	cbnz	x8, 0x12f60 <xbrtime_init+0x280>
   12f3c: 01 00 00 14  	b	0x12f40 <xbrtime_init+0x260>
;     free( __XBRTIME_CONFIG );
   12f40: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x2a8>
   12f44: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12f48: 00 00 40 c2  	ldr	c0, [c0, #0]
   12f4c: dd 04 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
   12f50: e0 13 40 c2  	ldr	c0, [csp, #64]
   12f54: 08 00 80 12  	mov	w8, #-1
;     return -1;
   12f58: 08 00 00 b9  	str	w8, [c0]
   12f5c: 50 00 00 14  	b	0x1309c <xbrtime_init+0x3bc>
;   printf("[M] init the pe mapping block\n");
   12f60: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x2c8>
   12f64: 00 08 41 c2  	ldr	c0, [c0, #1056]
   12f68: e9 03 1f aa  	mov	x9, xzr
   12f6c: d9 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12f70: e0 17 40 c2  	ldr	c0, [csp, #80]
   12f74: e8 03 1f 2a  	mov	w8, wzr
;   for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
   12f78: 08 00 00 b9  	str	w8, [c0]
   12f7c: 01 00 00 14  	b	0x12f80 <xbrtime_init+0x2a0>
   12f80: e0 17 40 c2  	ldr	c0, [csp, #80]
;   for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
   12f84: 08 00 40 b9  	ldr	w8, [c0]
   12f88: 08 fd 1f 71  	subs	w8, w8, #2047           // =2047
   12f8c: cc 02 00 54  	b.gt	0x12fe4 <xbrtime_init+0x304>
   12f90: 01 00 00 14  	b	0x12f94 <xbrtime_init+0x2b4>
   12f94: e1 17 40 c2  	ldr	c1, [csp, #80]
;     __XBRTIME_CONFIG->_MMAP[i].start_addr = 0x00ull;
   12f98: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x300>
   12f9c: 00 50 42 c2  	ldr	c0, [c0, #2368]
   12fa0: 02 00 40 c2  	ldr	c2, [c0, #0]
   12fa4: 42 0c 40 c2  	ldr	c2, [c2, #48]
   12fa8: 28 00 80 b9  	ldrsw	x8, [c1]
   12fac: 09 ed 7c d3  	lsl	x9, x8, #4
   12fb0: e8 03 1f aa  	mov	x8, xzr
   12fb4: 48 68 29 f8  	str	x8, [c2, x9]
;     __XBRTIME_CONFIG->_MMAP[i].size       = 0;
   12fb8: 00 00 40 c2  	ldr	c0, [c0, #0]
   12fbc: 00 0c 40 c2  	ldr	c0, [c0, #48]
   12fc0: 29 00 80 b9  	ldrsw	x9, [c1]
   12fc4: 00 70 a9 c2  	add	c0, c0, x9, uxtx #4
   12fc8: 08 04 00 f9  	str	x8, [c0, #8]
;   }
   12fcc: 01 00 00 14  	b	0x12fd0 <xbrtime_init+0x2f0>
   12fd0: e0 17 40 c2  	ldr	c0, [csp, #80]
;   for( i=0;i<_XBRTIME_MEM_SLOTS_; i++ ){
   12fd4: 08 00 40 b9  	ldr	w8, [c0]
   12fd8: 08 05 00 11  	add	w8, w8, #1              // =1
   12fdc: 08 00 00 b9  	str	w8, [c0]
   12fe0: e8 ff ff 17  	b	0x12f80 <xbrtime_init+0x2a0>
;   printf("[M] init the memory allocation slots\n");
   12fe4: 80 00 80 d0  	adrp	c0, 0x24000 <xbrtime_init+0x34c>
   12fe8: 00 0c 41 c2  	ldr	c0, [c0, #1072]
   12fec: e9 03 1f aa  	mov	x9, xzr
   12ff0: b8 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   12ff4: e0 17 40 c2  	ldr	c0, [csp, #80]
   12ff8: e8 03 1f 2a  	mov	w8, wzr
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   12ffc: 08 00 00 b9  	str	w8, [c0]
   13000: 01 00 00 14  	b	0x13004 <xbrtime_init+0x324>
   13004: e0 17 40 c2  	ldr	c0, [csp, #80]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   13008: 08 00 40 b9  	ldr	w8, [c0]
   1300c: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_init+0x370>
   13010: 00 50 42 c2  	ldr	c0, [c0, #2368]
   13014: 00 00 40 c2  	ldr	c0, [c0, #0]
   13018: 09 0c 40 b9  	ldr	w9, [c0, #12]
   1301c: 08 01 09 6b  	subs	w8, w8, w9
   13020: ea 02 00 54  	b.ge	0x1307c <xbrtime_init+0x39c>
   13024: 01 00 00 14  	b	0x13028 <xbrtime_init+0x348>
   13028: e1 17 40 c2  	ldr	c1, [csp, #80]
;     __XBRTIME_CONFIG->_MAP[i]._LOGICAL   = i;
   1302c: 28 00 80 b9  	ldrsw	x8, [c1]
   13030: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_init+0x394>
   13034: 00 50 42 c2  	ldr	c0, [c0, #2368]
   13038: 02 00 40 c2  	ldr	c2, [c0, #0]
   1303c: 42 10 40 c2  	ldr	c2, [c2, #64]
   13040: 09 ed 7c d3  	lsl	x9, x8, #4
   13044: 48 68 29 b8  	str	w8, [c2, x9]
;     __XBRTIME_CONFIG->_MAP[i]._PHYSICAL  = i+1;
   13048: 29 00 80 b9  	ldrsw	x9, [c1]
   1304c: e8 03 09 2a  	mov	w8, w9
   13050: 08 05 00 11  	add	w8, w8, #1              // =1
   13054: 00 00 40 c2  	ldr	c0, [c0, #0]
   13058: 00 10 40 c2  	ldr	c0, [c0, #64]
   1305c: 00 70 a9 c2  	add	c0, c0, x9, uxtx #4
   13060: 08 04 00 b9  	str	w8, [c0, #4]
;   }
   13064: 01 00 00 14  	b	0x13068 <xbrtime_init+0x388>
   13068: e0 17 40 c2  	ldr	c0, [csp, #80]
;   for( i=0; i<__XBRTIME_CONFIG->_NPES; i++ ){
   1306c: 08 00 40 b9  	ldr	w8, [c0]
   13070: 08 05 00 11  	add	w8, w8, #1              // =1
   13074: 08 00 00 b9  	str	w8, [c0]
   13078: e3 ff ff 17  	b	0x13004 <xbrtime_init+0x324>
;   printf("[M] init the PE mapping structure\n");
   1307c: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_mype+0x10>
   13080: 00 10 41 c2  	ldr	c0, [c0, #1088]
   13084: e9 03 1f aa  	mov	x9, xzr
   13088: 92 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1308c: e0 13 40 c2  	ldr	c0, [csp, #64]
   13090: e8 03 1f 2a  	mov	w8, wzr
;   return 0;
   13094: 08 00 00 b9  	str	w8, [c0]
   13098: 01 00 00 14  	b	0x1309c <xbrtime_init+0x3bc>
   1309c: e0 13 40 c2  	ldr	c0, [csp, #64]
; }
   130a0: 00 00 40 b9  	ldr	w0, [c0]
   130a4: fd 7b c5 42  	ldp	c29, c30, [csp, #160]
   130a8: ff 03 03 02  	add	csp, csp, #192          // =192
   130ac: c0 53 c2 c2  	ret	c30

00000000000130b0 <xbrtime_mype>:
; extern int xbrtime_mype(){
   130b0: ff 83 80 02  	sub	csp, csp, #32           // =32
   130b4: e0 73 00 02  	add	c0, csp, #28            // =28
   130b8: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   130bc: e0 03 00 c2  	str	c0, [csp, #0]
;   if( __XBRTIME_CONFIG == NULL ){
   130c0: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_mype+0x54>
   130c4: 00 50 42 c2  	ldr	c0, [c0, #2368]
   130c8: 00 00 40 c2  	ldr	c0, [c0, #0]
   130cc: e8 03 00 aa  	mov	x8, x0
   130d0: c8 00 00 b5  	cbnz	x8, 0x130e8 <xbrtime_mype+0x38>
   130d4: 01 00 00 14  	b	0x130d8 <xbrtime_mype+0x28>
   130d8: e0 03 40 c2  	ldr	c0, [csp, #0]
   130dc: 08 00 80 12  	mov	w8, #-1
;     return -1;
   130e0: 08 00 00 b9  	str	w8, [c0]
   130e4: 08 00 00 14  	b	0x13104 <xbrtime_mype+0x54>
   130e8: e0 03 40 c2  	ldr	c0, [csp, #0]
;   return __XBRTIME_CONFIG->_ID;
   130ec: 81 00 80 b0  	adrp	c1, 0x24000 <xbrtime_num_pes+0x1c>
   130f0: 21 50 42 c2  	ldr	c1, [c1, #2368]
   130f4: 21 00 40 c2  	ldr	c1, [c1, #0]
   130f8: 28 08 40 b9  	ldr	w8, [c1, #8]
   130fc: 08 00 00 b9  	str	w8, [c0]
   13100: 01 00 00 14  	b	0x13104 <xbrtime_mype+0x54>
   13104: e0 03 40 c2  	ldr	c0, [csp, #0]
; }
   13108: 00 00 40 b9  	ldr	w0, [c0]
   1310c: ff 83 00 02  	add	csp, csp, #32           // =32
   13110: c0 53 c2 c2  	ret	c30

0000000000013114 <xbrtime_num_pes>:
; extern int xbrtime_num_pes(){
   13114: ff 83 80 02  	sub	csp, csp, #32           // =32
   13118: e0 73 00 02  	add	c0, csp, #28            // =28
   1311c: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   13120: e0 03 00 c2  	str	c0, [csp, #0]
;   if( __XBRTIME_CONFIG == NULL ){
   13124: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_num_pes+0x54>
   13128: 00 50 42 c2  	ldr	c0, [c0, #2368]
   1312c: 00 00 40 c2  	ldr	c0, [c0, #0]
   13130: e8 03 00 aa  	mov	x8, x0
   13134: c8 00 00 b5  	cbnz	x8, 0x1314c <xbrtime_num_pes+0x38>
   13138: 01 00 00 14  	b	0x1313c <xbrtime_num_pes+0x28>
   1313c: e0 03 40 c2  	ldr	c0, [csp, #0]
   13140: 08 00 80 12  	mov	w8, #-1
;     return -1;
   13144: 08 00 00 b9  	str	w8, [c0]
   13148: 08 00 00 14  	b	0x13168 <xbrtime_num_pes+0x54>
   1314c: e0 03 40 c2  	ldr	c0, [csp, #0]
;   return __XBRTIME_CONFIG->_NPES;
   13150: 81 00 80 b0  	adrp	c1, 0x24000 <xbrtime_ulonglong_get+0x1c>
   13154: 21 50 42 c2  	ldr	c1, [c1, #2368]
   13158: 21 00 40 c2  	ldr	c1, [c1, #0]
   1315c: 28 0c 40 b9  	ldr	w8, [c1, #12]
   13160: 08 00 00 b9  	str	w8, [c0]
   13164: 01 00 00 14  	b	0x13168 <xbrtime_num_pes+0x54>
   13168: e0 03 40 c2  	ldr	c0, [csp, #0]
; }
   1316c: 00 00 40 b9  	ldr	w0, [c0]
   13170: ff 83 00 02  	add	csp, csp, #32           // =32
   13174: c0 53 c2 c2  	ret	c30

0000000000013178 <xbrtime_ulonglong_get>:
;                            size_t nelems, int stride, int pe){
   13178: ff c3 85 02  	sub	csp, csp, #368          // =368
   1317c: fd 7b 8a 42  	stp	c29, c30, [csp, #320]
   13180: fc 5b 00 c2  	str	c28, [csp, #352]
   13184: fd 03 05 02  	add	c29, csp, #320          // =320
   13188: 26 d0 c1 c2  	mov	c6, c1
   1318c: 08 d0 c1 c2  	mov	c8, c0
   13190: a0 43 80 02  	sub	c0, c29, #16            // =16
   13194: 09 38 c8 c2  	scbnds	c9, c0, #16             // =16
   13198: e9 27 00 c2  	str	c9, [csp, #144]
   1319c: 20 d1 c1 c2  	mov	c0, c9
   131a0: e0 17 00 c2  	str	c0, [csp, #80]
   131a4: a0 83 80 02  	sub	c0, c29, #32            // =32
   131a8: 07 38 c8 c2  	scbnds	c7, c0, #16             // =16
   131ac: a7 03 18 a2  	stur	c7, [c29, #-128]
   131b0: e0 d0 c1 c2  	mov	c0, c7
   131b4: e0 1b 00 c2  	str	c0, [csp, #96]
   131b8: a0 a3 80 02  	sub	c0, c29, #40            // =40
   131bc: 05 38 c4 c2  	scbnds	c5, c0, #8              // =8
   131c0: a5 03 1c a2  	stur	c5, [c29, #-64]
   131c4: a0 d0 c1 c2  	mov	c0, c5
   131c8: e0 1f 00 c2  	str	c0, [csp, #112]
   131cc: a0 b3 80 02  	sub	c0, c29, #44            // =44
   131d0: 01 38 c2 c2  	scbnds	c1, c0, #4              // =4
   131d4: 20 d0 c1 c2  	mov	c0, c1
   131d8: e0 23 00 c2  	str	c0, [csp, #128]
   131dc: a0 c3 80 02  	sub	c0, c29, #48            // =48
   131e0: 00 38 c2 c2  	scbnds	c0, c0, #4              // =4
   131e4: 28 01 00 c2  	str	c8, [c9, #0]
   131e8: e6 00 00 c2  	str	c6, [c7, #0]
   131ec: a2 00 00 f9  	str	x2, [c5]
   131f0: 23 00 00 b9  	str	w3, [c1]
   131f4: 04 00 00 b9  	str	w4, [c0]
;   printf("[M] Entered xbrtime_ulonglong_get()\n");
   131f8: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0xc4>
   131fc: 00 14 41 c2  	ldr	c0, [c0, #1104]
   13200: e9 03 1f aa  	mov	x9, xzr
   13204: a9 03 1b a2  	stur	c9, [c29, #-80]
   13208: 32 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1320c: a9 03 5b a2  	ldur	c9, [c29, #-80]
;   printf("\n========================\n");
   13210: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0xdc>
   13214: 00 18 41 c2  	ldr	c0, [c0, #1120]
   13218: 2e 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1321c: e0 27 40 c2  	ldr	c0, [csp, #144]
;           cheri_base_get(dest),
   13220: 00 00 40 c2  	ldr	c0, [c0, #0]
   13224: 74 00 00 94  	bl	0x133f4 <cheri_base_get>
   13228: e8 03 00 aa  	mov	x8, x0
   1322c: e0 27 40 c2  	ldr	c0, [csp, #144]
   13230: a8 83 17 f8  	stur	x8, [c29, #-136]
;           cheri_length_get(dest),
   13234: 00 00 40 c2  	ldr	c0, [c0, #0]
   13238: 78 00 00 94  	bl	0x13418 <cheri_length_get>
   1323c: e8 03 00 aa  	mov	x8, x0
   13240: e0 27 40 c2  	ldr	c0, [csp, #144]
   13244: a8 03 17 f8  	stur	x8, [c29, #-144]
;           cheri_offset_get(dest),
   13248: 00 00 40 c2  	ldr	c0, [c0, #0]
   1324c: 7c 00 00 94  	bl	0x1343c <cheri_offset_get>
   13250: e8 03 00 aa  	mov	x8, x0
   13254: e0 27 40 c2  	ldr	c0, [csp, #144]
   13258: a8 83 16 f8  	stur	x8, [c29, #-152]
;           cheri_perms_get(dest),
   1325c: 00 00 40 c2  	ldr	c0, [c0, #0]
   13260: 80 00 00 94  	bl	0x13460 <cheri_perms_get>
   13264: e1 03 00 2a  	mov	w1, w0
   13268: e0 27 40 c2  	ldr	c0, [csp, #144]
   1326c: a1 43 16 b8  	stur	w1, [c29, #-156]
;           cheri_tag_get(dest));
   13270: 00 00 40 c2  	ldr	c0, [c0, #0]
   13274: 85 00 00 94  	bl	0x13488 <cheri_tag_get>
   13278: a1 43 56 b8  	ldur	w1, [c29, #-156]
   1327c: aa 83 56 f8  	ldur	x10, [c29, #-152]
   13280: a9 03 57 f8  	ldur	x9, [c29, #-144]
   13284: a8 83 57 f8  	ldur	x8, [c29, #-136]
;   printf("  DEST:\n"
   13288: eb 03 00 2a  	mov	w11, w0
   1328c: 6b 01 40 92  	and	x11, x11, #0x1
   13290: e0 d3 c1 c2  	mov	c0, csp
   13294: 0b 20 00 f9  	str	x11, [c0, #64]
   13298: eb 03 01 2a  	mov	w11, w1
   1329c: 0b 18 00 f9  	str	x11, [c0, #48]
   132a0: 0a 10 00 f9  	str	x10, [c0, #32]
   132a4: 09 08 00 f9  	str	x9, [c0, #16]
   132a8: 08 00 00 f9  	str	x8, [c0]
   132ac: 00 f8 c2 c2  	scbnds	c0, c0, #5, lsl #4      // =80
   132b0: 09 70 c6 c2  	clrperm	c9, c0, wx
   132b4: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0x180>
   132b8: 00 1c 41 c2  	ldr	c0, [c0, #1136]
   132bc: 05 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   132c0: a9 03 5b a2  	ldur	c9, [c29, #-80]
;   printf("========================\n");
   132c4: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0x190>
   132c8: 00 20 41 c2  	ldr	c0, [c0, #1152]
   132cc: 01 04 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   132d0: a0 03 58 a2  	ldur	c0, [c29, #-128]
;           cheri_base_get(src),
   132d4: 00 00 40 c2  	ldr	c0, [c0, #0]
   132d8: 47 00 00 94  	bl	0x133f4 <cheri_base_get>
   132dc: e8 03 00 aa  	mov	x8, x0
   132e0: a0 03 58 a2  	ldur	c0, [c29, #-128]
   132e4: a8 83 1a f8  	stur	x8, [c29, #-88]
;           cheri_length_get(src),
   132e8: 00 00 40 c2  	ldr	c0, [c0, #0]
   132ec: 4b 00 00 94  	bl	0x13418 <cheri_length_get>
   132f0: e8 03 00 aa  	mov	x8, x0
   132f4: a0 03 58 a2  	ldur	c0, [c29, #-128]
   132f8: a8 03 1a f8  	stur	x8, [c29, #-96]
;           cheri_offset_get(src),
   132fc: 00 00 40 c2  	ldr	c0, [c0, #0]
   13300: 4f 00 00 94  	bl	0x1343c <cheri_offset_get>
   13304: e8 03 00 aa  	mov	x8, x0
   13308: a0 03 58 a2  	ldur	c0, [c29, #-128]
   1330c: a8 83 19 f8  	stur	x8, [c29, #-104]
;           cheri_perms_get(src),
   13310: 00 00 40 c2  	ldr	c0, [c0, #0]
   13314: 53 00 00 94  	bl	0x13460 <cheri_perms_get>
   13318: e1 03 00 2a  	mov	w1, w0
   1331c: a0 03 58 a2  	ldur	c0, [c29, #-128]
   13320: a1 43 19 b8  	stur	w1, [c29, #-108]
;           cheri_tag_get(src));
   13324: 00 00 40 c2  	ldr	c0, [c0, #0]
   13328: 58 00 00 94  	bl	0x13488 <cheri_tag_get>
   1332c: a1 43 59 b8  	ldur	w1, [c29, #-108]
   13330: aa 83 59 f8  	ldur	x10, [c29, #-104]
   13334: a9 03 5a f8  	ldur	x9, [c29, #-96]
   13338: a8 83 5a f8  	ldur	x8, [c29, #-88]
;   printf("  SRC:\n"
   1333c: eb 03 00 2a  	mov	w11, w0
   13340: 6b 01 40 92  	and	x11, x11, #0x1
   13344: e0 d3 c1 c2  	mov	c0, csp
   13348: 0b 20 00 f9  	str	x11, [c0, #64]
   1334c: eb 03 01 2a  	mov	w11, w1
   13350: 0b 18 00 f9  	str	x11, [c0, #48]
   13354: 0a 10 00 f9  	str	x10, [c0, #32]
   13358: 09 08 00 f9  	str	x9, [c0, #16]
   1335c: 08 00 00 f9  	str	x8, [c0]
   13360: 00 f8 c2 c2  	scbnds	c0, c0, #5, lsl #4      // =80
   13364: 09 70 c6 c2  	clrperm	c9, c0, wx
   13368: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0x234>
   1336c: 00 24 41 c2  	ldr	c0, [c0, #1168]
   13370: d8 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13374: a9 03 5b a2  	ldur	c9, [c29, #-80]
;     printf("========================\n\n");
   13378: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_ulonglong_get+0x244>
   1337c: 00 28 41 c2  	ldr	c0, [c0, #1184]
   13380: d4 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13384: a0 03 5c a2  	ldur	c0, [c29, #-64]
;   if(nelems == 0){
   13388: 08 00 40 f9  	ldr	x8, [c0]
   1338c: 68 00 00 b5  	cbnz	x8, 0x13398 <xbrtime_ulonglong_get+0x220>
   13390: 01 00 00 14  	b	0x13394 <xbrtime_ulonglong_get+0x21c>
;     return;
   13394: 14 00 00 14  	b	0x133e4 <xbrtime_ulonglong_get+0x26c>
   13398: e3 23 40 c2  	ldr	c3, [csp, #128]
   1339c: e2 1f 40 c2  	ldr	c2, [csp, #112]
   133a0: e1 17 40 c2  	ldr	c1, [csp, #80]
   133a4: e0 1b 40 c2  	ldr	c0, [csp, #96]
;     __xbrtime_get_u8_seq((uint64_t)src,//__xbrtime_ltor((uint64_t)(src),pe),
   133a8: 00 00 40 c2  	ldr	c0, [c0, #0]
   133ac: 00 50 c0 c2  	gcvalue	x0, c0
;                          (uint64_t)(dest),
   133b0: 21 00 40 c2  	ldr	c1, [c1, #0]
   133b4: 21 50 c0 c2  	gcvalue	x1, c1
;                          (uint32_t)(nelems),
   133b8: 42 00 40 b9  	ldr	w2, [c2]
;                          (uint32_t)(stride*sizeof(unsigned long long)));
   133bc: 68 00 40 b9  	ldr	w8, [c3]
   133c0: 03 71 1d 53  	lsl	w3, w8, #3
;     __xbrtime_get_u8_seq((uint64_t)src,//__xbrtime_ltor((uint64_t)(src),pe),
   133c4: 54 03 00 94  	bl	0x14114 <__xbrtime_get_u8_seq>
   133c8: 01 00 00 14  	b	0x133cc <xbrtime_ulonglong_get+0x254>
;   __xbrtime_asm_fence();
   133cc: 6f 03 00 94  	bl	0x14188 <__xbrtime_asm_fence>
;   printf("[M] Exiting xbrtime_ulonglong_get()\n");
   133d0: 80 00 80 b0  	adrp	c0, 0x24000 <cheri_base_get+0x20>
   133d4: 00 2c 41 c2  	ldr	c0, [c0, #1200]
   133d8: e9 03 1f aa  	mov	x9, xzr
   133dc: bd 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; }
   133e0: 01 00 00 14  	b	0x133e4 <xbrtime_ulonglong_get+0x26c>
   133e4: fc 5b 40 c2  	ldr	c28, [csp, #352]
   133e8: fd 7b ca 42  	ldp	c29, c30, [csp, #320]
   133ec: ff c3 05 02  	add	csp, csp, #368          // =368
   133f0: c0 53 c2 c2  	ret	c30

00000000000133f4 <cheri_base_get>:
; __CHERI_GET(base, __SIZE_TYPE__, _get, __SIZE_MAX__)
   133f4: ff 43 80 02  	sub	csp, csp, #16           // =16
   133f8: 01 d0 c1 c2  	mov	c1, c0
   133fc: e0 d3 c1 c2  	mov	c0, csp
   13400: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13404: 01 00 00 c2  	str	c1, [c0, #0]
   13408: 00 00 40 c2  	ldr	c0, [c0, #0]
   1340c: 00 10 c0 c2  	gcbase	x0, c0
   13410: ff 43 00 02  	add	csp, csp, #16           // =16
   13414: c0 53 c2 c2  	ret	c30

0000000000013418 <cheri_length_get>:
; __CHERI_GET(length, __SIZE_TYPE__, _get, __SIZE_MAX__)
   13418: ff 43 80 02  	sub	csp, csp, #16           // =16
   1341c: 01 d0 c1 c2  	mov	c1, c0
   13420: e0 d3 c1 c2  	mov	c0, csp
   13424: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13428: 01 00 00 c2  	str	c1, [c0, #0]
   1342c: 00 00 40 c2  	ldr	c0, [c0, #0]
   13430: 00 30 c0 c2  	gclen	x0, c0
   13434: ff 43 00 02  	add	csp, csp, #16           // =16
   13438: c0 53 c2 c2  	ret	c30

000000000001343c <cheri_offset_get>:
; __CHERI_ACCESSOR(offset, __SIZE_TYPE__, _set, _get, __SIZE_MAX__)
   1343c: ff 43 80 02  	sub	csp, csp, #16           // =16
   13440: 01 d0 c1 c2  	mov	c1, c0
   13444: e0 d3 c1 c2  	mov	c0, csp
   13448: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   1344c: 01 00 00 c2  	str	c1, [c0, #0]
   13450: 00 00 40 c2  	ldr	c0, [c0, #0]
   13454: 00 70 c0 c2  	gcoff	x0, c0
   13458: ff 43 00 02  	add	csp, csp, #16           // =16
   1345c: c0 53 c2 c2  	ret	c30

0000000000013460 <cheri_perms_get>:
; __CHERI_ACCESSOR(perms, cheri_perms_t, _and, _get, 0)
   13460: ff 43 80 02  	sub	csp, csp, #16           // =16
   13464: 01 d0 c1 c2  	mov	c1, c0
   13468: e0 d3 c1 c2  	mov	c0, csp
   1346c: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13470: 01 00 00 c2  	str	c1, [c0, #0]
   13474: 00 00 40 c2  	ldr	c0, [c0, #0]
   13478: 08 d0 c0 c2  	gcperm	x8, c0
   1347c: e0 03 08 2a  	mov	w0, w8
   13480: ff 43 00 02  	add	csp, csp, #16           // =16
   13484: c0 53 c2 c2  	ret	c30

0000000000013488 <cheri_tag_get>:
; __CHERI_GET(tag, __cheri_bool, _get, 0)
   13488: ff 43 80 02  	sub	csp, csp, #16           // =16
   1348c: 01 d0 c1 c2  	mov	c1, c0
   13490: e0 d3 c1 c2  	mov	c0, csp
   13494: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13498: 01 00 00 c2  	str	c1, [c0, #0]
   1349c: 00 00 40 c2  	ldr	c0, [c0, #0]
   134a0: 08 90 c0 c2  	gctag	x8, c0
   134a4: 08 01 00 f1  	subs	x8, x8, #0              // =0
   134a8: e0 07 9f 1a  	cset	w0, ne
   134ac: ff 43 00 02  	add	csp, csp, #16           // =16
   134b0: c0 53 c2 c2  	ret	c30

00000000000134b4 <xbrtime_barrier>:
; extern void xbrtime_barrier(){
   134b4: ff 03 81 02  	sub	csp, csp, #64           // =64
   134b8: fd 7b 81 42  	stp	c29, c30, [csp, #32]
   134bc: fd 83 00 02  	add	c29, csp, #32           // =32
;   printf("[M] Entered xbrtime_barrier()\n");
   134c0: 80 00 80 b0  	adrp	c0, 0x24000 <xbrtime_barrier+0x50>
   134c4: 00 30 41 c2  	ldr	c0, [c0, #1216]
   134c8: e9 03 1f aa  	mov	x9, xzr
   134cc: e9 07 00 c2  	str	c9, [csp, #16]
   134d0: 80 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
;   __xbrtime_asm_fence(); /* wait for all the PEs to reach the barrier */
   134d4: 2d 03 00 94  	bl	0x14188 <__xbrtime_asm_fence>
;   printf( "XBGAS_DEBUG : PE=%d; BARRIER COMPLETE\n", xbrtime_mype() );
   134d8: f6 fe ff 97  	bl	0x130b0 <xbrtime_mype>
   134dc: e8 03 00 2a  	mov	w8, w0
   134e0: e0 d3 c1 c2  	mov	c0, csp
   134e4: 08 00 00 f9  	str	x8, [c0]
   134e8: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   134ec: 09 70 c6 c2  	clrperm	c9, c0, wx
   134f0: 80 00 80 b0  	adrp	c0, 0x24000 <mysecond+0x1c>
   134f4: 00 34 41 c2  	ldr	c0, [c0, #1232]
   134f8: 76 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   134fc: e9 07 40 c2  	ldr	c9, [csp, #16]
;   printf("[M] Exiting xbrtime_barrier()\n");
   13500: 80 00 80 b0  	adrp	c0, 0x24000 <mysecond+0x2c>
   13504: 00 38 41 c2  	ldr	c0, [c0, #1248]
   13508: 72 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; }
   1350c: fd 7b c1 42  	ldp	c29, c30, [csp, #32]
   13510: ff 03 01 02  	add	csp, csp, #64           // =64
   13514: c0 53 c2 c2  	ret	c30

0000000000013518 <mysecond>:
; double mysecond() {
   13518: ff 83 81 02  	sub	csp, csp, #96           // =96
   1351c: fd 7b 82 42  	stp	c29, c30, [csp, #64]
   13520: fd 03 01 02  	add	c29, csp, #64           // =64
   13524: a0 43 80 02  	sub	c0, c29, #16            // =16
   13528: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   1352c: e0 07 00 c2  	str	c0, [csp, #16]
   13530: a1 63 80 02  	sub	c1, c29, #24            // =24
   13534: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
   13538: a2 73 80 02  	sub	c2, c29, #28            // =28
   1353c: 42 38 c2 c2  	scbnds	c2, c2, #4              // =4
   13540: e2 03 00 c2  	str	c2, [csp, #0]
   13544: e8 03 1f 2a  	mov	w8, wzr
; 		int i = 0;
   13548: 48 00 00 b9  	str	w8, [c2]
; 		i = gettimeofday( &tp, &tzp );
   1354c: 7d 03 00 94  	bl	0x14340 <xbrtime_api_asm.s+0x14340>
   13550: e1 03 40 c2  	ldr	c1, [csp, #0]
   13554: e8 03 00 2a  	mov	w8, w0
   13558: e0 07 40 c2  	ldr	c0, [csp, #16]
   1355c: 28 00 00 b9  	str	w8, [c1]
; 		return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
   13560: 00 00 40 fd  	ldr	d0, [c0]
   13564: 00 d8 61 5e  	scvtf	d0, d0
   13568: 01 04 40 fd  	ldr	d1, [c0, #8]
   1356c: 21 d8 61 5e  	scvtf	d1, d1
   13570: 60 ff ff d0  	adrp	c0, 0x1000 <mysecond+0x10>
   13574: 02 80 44 fd  	ldr	d2, [c0, #2304]
   13578: 21 08 62 1e  	fmul	d1, d1, d2
   1357c: 00 28 61 1e  	fadd	d0, d0, d1
   13580: fd 7b c2 42  	ldp	c29, c30, [csp, #64]
   13584: ff 83 01 02  	add	csp, csp, #96           // =96
   13588: c0 53 c2 c2  	ret	c30

000000000001358c <PRINT>:
; void PRINT(double local, double remote, double t_init, double t_mem){
   1358c: ff 03 85 02  	sub	csp, csp, #320          // =320
   13590: fd fb 88 42  	stp	c29, c30, [csp, #272]
   13594: fc 4f 00 c2  	str	c28, [csp, #304]
   13598: fd 43 04 02  	add	c29, csp, #272          // =272
   1359c: a0 23 80 02  	sub	c0, c29, #8             // =8
   135a0: 06 38 c4 c2  	scbnds	c6, c0, #8              // =8
   135a4: e6 1b 00 c2  	str	c6, [csp, #96]
   135a8: a0 43 80 02  	sub	c0, c29, #16            // =16
   135ac: 03 38 c4 c2  	scbnds	c3, c0, #8              // =8
   135b0: e3 17 00 c2  	str	c3, [csp, #80]
   135b4: a0 63 80 02  	sub	c0, c29, #24            // =24
   135b8: 00 38 c4 c2  	scbnds	c0, c0, #8              // =8
   135bc: a1 83 80 02  	sub	c1, c29, #32            // =32
   135c0: 25 38 c4 c2  	scbnds	c5, c1, #8              // =8
   135c4: e5 13 00 c2  	str	c5, [csp, #64]
   135c8: a1 a3 80 02  	sub	c1, c29, #40            // =40
   135cc: 22 38 c4 c2  	scbnds	c2, c1, #8              // =8
   135d0: e2 23 00 c2  	str	c2, [csp, #128]
   135d4: a1 c3 80 02  	sub	c1, c29, #48            // =48
   135d8: 24 38 c4 c2  	scbnds	c4, c1, #8              // =8
   135dc: a4 03 1b a2  	stur	c4, [c29, #-80]
   135e0: 81 d0 c1 c2  	mov	c1, c4
   135e4: e1 0b 00 c2  	str	c1, [csp, #32]
   135e8: a1 e3 80 02  	sub	c1, c29, #56            // =56
   135ec: 21 38 c4 c2  	scbnds	c1, c1, #8              // =8
   135f0: 27 d0 c1 c2  	mov	c7, c1
   135f4: e7 0f 00 c2  	str	c7, [csp, #48]
   135f8: c0 00 00 fd  	str	d0, [c6]
   135fc: 61 00 00 fd  	str	d1, [c3]
   13600: 02 00 00 fd  	str	d2, [c0]
   13604: a3 00 00 fd  	str	d3, [c5]
   13608: 28 00 80 52  	mov	w8, #1
; 	size_t			ne  				= _XBGAS_ALLOC_NELEMS_;
   1360c: 48 00 00 f9  	str	x8, [c2]
   13610: e8 03 1f aa  	mov	x8, xzr
   13614: a8 83 1a f8  	stur	x8, [c29, #-88]
; 	int64_t 		i  					= 0;
   13618: 88 00 00 f9  	str	x8, [c4]
; 	int64_t 		percent			= 0;
   1361c: 28 00 00 f9  	str	x8, [c1]
; 	percent = (int64_t)(100*remote/ne);
   13620: 60 00 40 fd  	ldr	d0, [c3]
   13624: 28 0b e8 d2  	mov	x8, #4636737291354636288
   13628: 01 01 67 9e  	fmov	d1, x8
   1362c: e1 3f 00 fd  	str	d1, [csp, #120]
   13630: 00 08 61 1e  	fmul	d0, d0, d1
   13634: 41 00 40 fd  	ldr	d1, [c2]
   13638: 21 d8 61 7e  	ucvtf	d1, d1
   1363c: 00 18 61 1e  	fdiv	d0, d0, d1
   13640: 08 00 78 9e  	fcvtzs	x8, d0
   13644: 28 00 00 f9  	str	x8, [c1]
; 	printf("Time.init       = %f sec\n", t_init);	
   13648: 00 00 40 fd  	ldr	d0, [c0]
   1364c: e0 d3 c1 c2  	mov	c0, csp
   13650: 00 00 00 fd  	str	d0, [c0]
   13654: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13658: 09 70 c6 c2  	clrperm	c9, c0, wx
   1365c: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x114>
   13660: 00 3c 41 c2  	ldr	c0, [c0, #1264]
   13664: 1b 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13668: e0 13 40 c2  	ldr	c0, [csp, #64]
; 	printf("Time.transfer   = %f sec\n", t_mem);
   1366c: 00 00 40 fd  	ldr	d0, [c0]
   13670: e0 d3 c1 c2  	mov	c0, csp
   13674: 00 00 00 fd  	str	d0, [c0]
   13678: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   1367c: 09 70 c6 c2  	clrperm	c9, c0, wx
   13680: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x138>
   13684: 00 40 41 c2  	ldr	c0, [c0, #1280]
   13688: 12 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1368c: e1 17 40 c2  	ldr	c1, [csp, #80]
   13690: e1 3f 40 fd  	ldr	d1, [csp, #120]
   13694: e0 23 40 c2  	ldr	c0, [csp, #128]
; 	printf("Remote Access   = " BRED "%.3f%%  " RESET, 100*remote/ne);
   13698: 20 00 40 fd  	ldr	d0, [c1]
   1369c: 00 08 61 1e  	fmul	d0, d0, d1
   136a0: 01 00 40 fd  	ldr	d1, [c0]
   136a4: 21 d8 61 7e  	ucvtf	d1, d1
   136a8: 00 18 61 1e  	fdiv	d0, d0, d1
   136ac: e0 d3 c1 c2  	mov	c0, csp
   136b0: 00 00 00 fd  	str	d0, [c0]
   136b4: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   136b8: 09 70 c6 c2  	clrperm	c9, c0, wx
   136bc: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x174>
   136c0: 00 44 41 c2  	ldr	c0, [c0, #1296]
   136c4: 03 03 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 	printf("\n");
   136c8: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x180>
   136cc: 00 48 41 c2  	ldr	c0, [c0, #1312]
   136d0: a0 03 18 a2  	stur	c0, [c29, #-128]
   136d4: e9 03 1f aa  	mov	x9, xzr
   136d8: a9 03 19 a2  	stur	c9, [c29, #-112]
   136dc: fd 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   136e0: e1 1b 40 c2  	ldr	c1, [csp, #96]
   136e4: e1 3f 40 fd  	ldr	d1, [csp, #120]
   136e8: e0 23 40 c2  	ldr	c0, [csp, #128]
; 	printf("Local  Access   = " BGRN "%.3f%%  " RESET, 100*local/ne);
   136ec: 20 00 40 fd  	ldr	d0, [c1]
   136f0: 00 08 61 1e  	fmul	d0, d0, d1
   136f4: 01 00 40 fd  	ldr	d1, [c0]
   136f8: 21 d8 61 7e  	ucvtf	d1, d1
   136fc: 00 18 61 1e  	fdiv	d0, d0, d1
   13700: e0 d3 c1 c2  	mov	c0, csp
   13704: 00 00 00 fd  	str	d0, [c0]
   13708: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   1370c: 09 70 c6 c2  	clrperm	c9, c0, wx
   13710: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x1c8>
   13714: 00 4c 41 c2  	ldr	c0, [c0, #1328]
   13718: ee 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1371c: a9 03 59 a2  	ldur	c9, [c29, #-112]
   13720: a0 03 58 a2  	ldur	c0, [c29, #-128]
; 	printf("\n");
   13724: eb 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13728: a9 03 59 a2  	ldur	c9, [c29, #-112]
; 	printf("------------------------------------------\n");
   1372c: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x1e4>
   13730: 00 50 41 c2  	ldr	c0, [c0, #1344]
   13734: e7 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13738: a9 03 59 a2  	ldur	c9, [c29, #-112]
; 	printf("Request Distribution:  [");
   1373c: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x1f4>
   13740: 00 54 41 c2  	ldr	c0, [c0, #1360]
   13744: e3 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13748: a8 83 5a f8  	ldur	x8, [c29, #-88]
   1374c: a0 03 5b a2  	ldur	c0, [c29, #-80]
; 	for(i = 0; i < percent; i++)
   13750: 08 00 00 f9  	str	x8, [c0]
   13754: 01 00 00 14  	b	0x13758 <PRINT+0x1cc>
   13758: e0 0f 40 c2  	ldr	c0, [csp, #48]
   1375c: e1 0b 40 c2  	ldr	c1, [csp, #32]
; 	for(i = 0; i < percent; i++)
   13760: 28 00 40 f9  	ldr	x8, [c1]
   13764: 09 00 40 f9  	ldr	x9, [c0]
   13768: 08 01 09 eb  	subs	x8, x8, x9
   1376c: 8a 01 00 54  	b.ge	0x1379c <PRINT+0x210>
   13770: 01 00 00 14  	b	0x13774 <PRINT+0x1e8>
; 		printf(BRED "|" RESET);
   13774: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x22c>
   13778: 00 58 41 c2  	ldr	c0, [c0, #1376]
   1377c: e9 03 1f aa  	mov	x9, xzr
   13780: d4 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13784: 01 00 00 14  	b	0x13788 <PRINT+0x1fc>
   13788: e0 0b 40 c2  	ldr	c0, [csp, #32]
; 	for(i = 0; i < percent; i++)
   1378c: 08 00 40 f9  	ldr	x8, [c0]
   13790: 08 05 00 91  	add	x8, x8, #1              // =1
   13794: 08 00 00 f9  	str	x8, [c0]
   13798: f0 ff ff 17  	b	0x13758 <PRINT+0x1cc>
   1379c: e0 0b 40 c2  	ldr	c0, [csp, #32]
   137a0: e8 03 1f aa  	mov	x8, xzr
; 	for(i = 0; i < 100 - percent; i++)
   137a4: 08 00 00 f9  	str	x8, [c0]
   137a8: 01 00 00 14  	b	0x137ac <PRINT+0x220>
   137ac: e0 0f 40 c2  	ldr	c0, [csp, #48]
   137b0: e1 0b 40 c2  	ldr	c1, [csp, #32]
; 	for(i = 0; i < 100 - percent; i++)
   137b4: 28 00 40 f9  	ldr	x8, [c1]
   137b8: 0a 00 40 f9  	ldr	x10, [c0]
   137bc: 89 0c 80 52  	mov	w9, #100
   137c0: 29 01 0a eb  	subs	x9, x9, x10
   137c4: 08 01 09 eb  	subs	x8, x8, x9
   137c8: 8a 01 00 54  	b.ge	0x137f8 <PRINT+0x26c>
   137cc: 01 00 00 14  	b	0x137d0 <PRINT+0x244>
; 		printf(BGRN "|" RESET);
   137d0: 80 00 80 b0  	adrp	c0, 0x24000 <PRINT+0x288>
   137d4: 00 5c 41 c2  	ldr	c0, [c0, #1392]
   137d8: e9 03 1f aa  	mov	x9, xzr
   137dc: bd 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   137e0: 01 00 00 14  	b	0x137e4 <PRINT+0x258>
   137e4: e0 0b 40 c2  	ldr	c0, [csp, #32]
; 	for(i = 0; i < 100 - percent; i++)
   137e8: 08 00 40 f9  	ldr	x8, [c0]
   137ec: 08 05 00 91  	add	x8, x8, #1              // =1
   137f0: 08 00 00 f9  	str	x8, [c0]
   137f4: ee ff ff 17  	b	0x137ac <PRINT+0x220>
; 	printf("]\n");
   137f8: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x10>
   137fc: 00 60 41 c2  	ldr	c0, [c0, #1408]
   13800: e9 03 1f aa  	mov	x9, xzr
   13804: e9 07 00 c2  	str	c9, [csp, #16]
   13808: b2 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   1380c: e9 07 40 c2  	ldr	c9, [csp, #16]
; 	printf("------------------------------------------\n");
   13810: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x28>
   13814: 00 50 41 c2  	ldr	c0, [c0, #1344]
   13818: ae 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; }
   1381c: fc 4f 40 c2  	ldr	c28, [csp, #304]
   13820: fd fb c8 42  	ldp	c29, c30, [csp, #272]
   13824: ff 03 05 02  	add	csp, csp, #320          // =320
   13828: c0 53 c2 c2  	ret	c30

000000000001382c <main>:
; int main( int argc, char **argv ){
   1382c: fd fb be 62  	stp	c29, c30, [csp, #-48]!
   13830: fc 0b 00 c2  	str	c28, [csp, #32]
   13834: fd d3 c1 c2  	mov	c29, csp
   13838: ff 83 8b 02  	sub	csp, csp, #736          // =736
   1383c: e8 03 00 2a  	mov	w8, w0
   13840: a0 13 80 02  	sub	c0, c29, #4             // =4
   13844: 03 38 c2 c2  	scbnds	c3, c0, #4              // =4
   13848: a0 23 80 02  	sub	c0, c29, #8             // =8
   1384c: 02 38 c2 c2  	scbnds	c2, c0, #4              // =4
   13850: a0 83 80 02  	sub	c0, c29, #32            // =32
   13854: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13858: a4 93 80 02  	sub	c4, c29, #36            // =36
   1385c: 84 38 c2 c2  	scbnds	c4, c4, #4              // =4
   13860: a4 03 10 a2  	stur	c4, [c29, #-256]
   13864: e4 2b 00 c2  	str	c4, [csp, #160]
   13868: a4 c3 80 02  	sub	c4, c29, #48            // =48
   1386c: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   13870: a4 03 11 a2  	stur	c4, [c29, #-240]
   13874: e4 2f 00 c2  	str	c4, [csp, #176]
   13878: a4 e3 80 02  	sub	c4, c29, #56            // =56
   1387c: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   13880: a4 03 12 a2  	stur	c4, [c29, #-224]
   13884: e4 33 00 c2  	str	c4, [csp, #192]
   13888: a4 03 81 02  	sub	c4, c29, #64            // =64
   1388c: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   13890: a4 03 16 a2  	stur	c4, [c29, #-160]
   13894: e4 37 00 c2  	str	c4, [csp, #208]
   13898: a4 43 81 02  	sub	c4, c29, #80            // =80
   1389c: 84 38 c8 c2  	scbnds	c4, c4, #16             // =16
   138a0: e4 77 00 c2  	str	c4, [csp, #464]
   138a4: e4 3b 00 c2  	str	c4, [csp, #224]
   138a8: a4 83 81 02  	sub	c4, c29, #96            // =96
   138ac: 84 38 c8 c2  	scbnds	c4, c4, #16             // =16
   138b0: a4 03 13 a2  	stur	c4, [c29, #-208]
   138b4: e4 3f 00 c2  	str	c4, [csp, #240]
   138b8: a4 a3 81 02  	sub	c4, c29, #104           // =104
   138bc: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   138c0: e4 5b 00 c2  	str	c4, [csp, #352]
   138c4: e4 43 00 c2  	str	c4, [csp, #256]
   138c8: a4 c3 81 02  	sub	c4, c29, #112           // =112
   138cc: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   138d0: e4 5f 00 c2  	str	c4, [csp, #368]
   138d4: e4 47 00 c2  	str	c4, [csp, #272]
   138d8: a4 e3 81 02  	sub	c4, c29, #120           // =120
   138dc: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   138e0: e4 63 00 c2  	str	c4, [csp, #384]
   138e4: e4 4b 00 c2  	str	c4, [csp, #288]
   138e8: a4 03 82 02  	sub	c4, c29, #128           // =128
   138ec: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   138f0: e4 6b 00 c2  	str	c4, [csp, #416]
   138f4: e4 4f 00 c2  	str	c4, [csp, #304]
   138f8: a4 23 82 02  	sub	c4, c29, #136           // =136
   138fc: 84 38 c4 c2  	scbnds	c4, c4, #8              // =8
   13900: e4 67 00 c2  	str	c4, [csp, #400]
   13904: e4 53 00 c2  	str	c4, [csp, #320]
   13908: e9 03 1f 2a  	mov	w9, wzr
   1390c: e9 5f 01 b9  	str	w9, [csp, #348]
   13910: 69 00 00 b9  	str	w9, [c3]
   13914: 48 00 00 b9  	str	w8, [c2]
   13918: 01 00 00 c2  	str	c1, [c0, #0]
; 	printf("[M]"GRN " Entered Main matmul...\n"RESET);
   1391c: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x134>
   13920: 00 64 41 c2  	ldr	c0, [c0, #1424]
   13924: e9 03 1f aa  	mov	x9, xzr
   13928: a9 03 14 a2  	stur	c9, [c29, #-192]
   1392c: 69 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13930: e8 5f 41 b9  	ldr	w8, [csp, #348]
   13934: e4 5b 40 c2  	ldr	c4, [csp, #352]
   13938: e3 5f 40 c2  	ldr	c3, [csp, #368]
   1393c: e2 63 40 c2  	ldr	c2, [csp, #384]
   13940: e1 67 40 c2  	ldr	c1, [csp, #400]
   13944: e7 77 40 c2  	ldr	c7, [csp, #464]
   13948: ac 03 50 a2  	ldur	c12, [c29, #-256]
   1394c: ab 03 51 a2  	ldur	c11, [c29, #-240]
   13950: aa 03 52 a2  	ldur	c10, [c29, #-224]
   13954: a6 03 53 a2  	ldur	c6, [c29, #-208]
   13958: a5 03 54 a2  	ldur	c5, [c29, #-192]
   1395c: a9 03 56 a2  	ldur	c9, [c29, #-160]
   13960: e0 6b 40 c2  	ldr	c0, [csp, #416]
;   int 			rtn 			= 0;
   13964: 88 01 00 b9  	str	w8, [c12]
   13968: 08 01 80 52  	mov	w8, #8
;   size_t 		sz 				= _XBGAS_ALLOC_SIZE_;
   1396c: 68 01 00 f9  	str	x8, [c11]
;   size_t 		ne 				= _XBGAS_ALLOC_NELEMS_*8;
   13970: 48 01 00 f9  	str	x8, [c10]
   13974: e8 03 1f aa  	mov	x8, xzr
   13978: a8 83 15 f8  	stur	x8, [c29, #-168]
;   uint64_t 	i   			= 0;
   1397c: 28 01 00 f9  	str	x8, [c9]
;   uint64_t 	*private  = NULL;
   13980: e5 00 00 c2  	str	c5, [c7, #0]
; 	uint64_t 	*shared  	= NULL;
   13984: c5 00 00 c2  	str	c5, [c6, #0]
; 	double 		t_mem	  	= 0;
   13988: 88 00 00 f9  	str	x8, [c4]
; 	double 		t_start  	= 0;
   1398c: 68 00 00 f9  	str	x8, [c3]
; 	double 		t_end  		= 0;
   13990: 48 00 00 f9  	str	x8, [c2]
   13994: 68 01 80 52  	mov	w8, #11
;   unsigned long long x = 11;
   13998: 08 00 00 f9  	str	x8, [c0]
   1399c: c8 02 80 52  	mov	w8, #22
;   unsigned long long y = 22;
   139a0: 28 00 00 f9  	str	x8, [c1]
;         cheri_base_get(&x),
   139a4: 94 fe ff 97  	bl	0x133f4 <cheri_base_get>
   139a8: e8 03 00 aa  	mov	x8, x0
   139ac: e0 6b 40 c2  	ldr	c0, [csp, #416]
   139b0: e8 e7 00 f9  	str	x8, [csp, #456]
;         cheri_length_get(&x),
   139b4: 99 fe ff 97  	bl	0x13418 <cheri_length_get>
   139b8: e8 03 00 aa  	mov	x8, x0
   139bc: e0 6b 40 c2  	ldr	c0, [csp, #416]
   139c0: e8 e3 00 f9  	str	x8, [csp, #448]
;         cheri_offset_get(&x),
   139c4: 9e fe ff 97  	bl	0x1343c <cheri_offset_get>
   139c8: e8 03 00 aa  	mov	x8, x0
   139cc: e0 6b 40 c2  	ldr	c0, [csp, #416]
   139d0: e8 df 00 f9  	str	x8, [csp, #440]
;         cheri_perms_get(&x),
   139d4: a3 fe ff 97  	bl	0x13460 <cheri_perms_get>
   139d8: e1 03 00 2a  	mov	w1, w0
   139dc: e0 6b 40 c2  	ldr	c0, [csp, #416]
   139e0: e1 b7 01 b9  	str	w1, [csp, #436]
;         cheri_tag_get(&x));
   139e4: a9 fe ff 97  	bl	0x13488 <cheri_tag_get>
   139e8: e1 b7 41 b9  	ldr	w1, [csp, #436]
   139ec: ea df 40 f9  	ldr	x10, [csp, #440]
   139f0: e9 e3 40 f9  	ldr	x9, [csp, #448]
   139f4: e8 e7 40 f9  	ldr	x8, [csp, #456]
;   printf("  X:\n"
   139f8: eb 03 00 2a  	mov	w11, w0
   139fc: 6b 01 40 92  	and	x11, x11, #0x1
   13a00: e0 d3 c1 c2  	mov	c0, csp
   13a04: 0b 20 00 f9  	str	x11, [c0, #64]
   13a08: eb 03 01 2a  	mov	w11, w1
   13a0c: 0b 18 00 f9  	str	x11, [c0, #48]
   13a10: 0a 10 00 f9  	str	x10, [c0, #32]
   13a14: 09 08 00 f9  	str	x9, [c0, #16]
   13a18: 08 00 00 f9  	str	x8, [c0]
   13a1c: 00 f8 c2 c2  	scbnds	c0, c0, #5, lsl #4      // =80
   13a20: 09 70 c6 c2  	clrperm	c9, c0, wx
   13a24: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x23c>
   13a28: 00 68 41 c2  	ldr	c0, [c0, #1440]
   13a2c: 29 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13a30: a9 03 54 a2  	ldur	c9, [c29, #-192]
; 	printf("[M]"GRN " Passed vars\n"RESET);
   13a34: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x24c>
   13a38: 00 6c 41 c2  	ldr	c0, [c0, #1456]
   13a3c: 25 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13a40: a0 03 52 a2  	ldur	c0, [c29, #-224]
; 	private = malloc( sizeof( uint64_t ) * ne );
   13a44: 08 00 40 f9  	ldr	x8, [c0]
   13a48: 00 f1 7d d3  	lsl	x0, x8, #3
   13a4c: e9 01 00 94  	bl	0x141f0 <xbrtime_api_asm.s+0x141f0>
   13a50: e1 77 40 c2  	ldr	c1, [csp, #464]
   13a54: a9 03 54 a2  	ldur	c9, [c29, #-192]
   13a58: 20 00 00 c2  	str	c0, [c1, #0]
; 	printf("[M]"GRN " Passed malloc\n"RESET);
   13a5c: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x274>
   13a60: 00 70 41 c2  	ldr	c0, [c0, #1472]
   13a64: 1b 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
;   rtn = xbrtime_init();
   13a68: 9e fc ff 97  	bl	0x12ce0 <xbrtime_init>
   13a6c: a1 03 50 a2  	ldur	c1, [c29, #-256]
   13a70: a9 03 54 a2  	ldur	c9, [c29, #-192]
   13a74: 20 00 00 b9  	str	w0, [c1]
; 	printf("[M]"GRN " Passed xbrtime_init()\n"RESET); 
   13a78: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x290>
   13a7c: 00 74 41 c2  	ldr	c0, [c0, #1488]
   13a80: 14 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13a84: a1 03 51 a2  	ldur	c1, [c29, #-240]
   13a88: a0 03 52 a2  	ldur	c0, [c29, #-224]
;   shared = (uint64_t *)(xbrtime_malloc( sz*ne ));
   13a8c: 28 00 40 f9  	ldr	x8, [c1]
   13a90: 09 00 40 f9  	ldr	x9, [c0]
   13a94: 00 7d 09 9b  	mul	x0, x8, x9
   13a98: 53 f9 ff 97  	bl	0x11fe4 <xbrtime_malloc>
   13a9c: a1 03 53 a2  	ldur	c1, [c29, #-208]
   13aa0: a9 03 54 a2  	ldur	c9, [c29, #-192]
   13aa4: 20 00 00 c2  	str	c0, [c1, #0]
; 	printf("[M]"GRN " Passed xbrtime_malloc()\n"RESET); 
   13aa8: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x2c0>
   13aac: 00 78 41 c2  	ldr	c0, [c0, #1504]
   13ab0: 08 02 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13ab4: a8 83 55 f8  	ldur	x8, [c29, #-168]
   13ab8: a0 03 56 a2  	ldur	c0, [c29, #-160]
;  	for( i = 0; i< ne; i++ ){
   13abc: 08 00 00 f9  	str	x8, [c0]
   13ac0: 01 00 00 14  	b	0x13ac4 <main+0x298>
   13ac4: e0 33 40 c2  	ldr	c0, [csp, #192]
   13ac8: e1 37 40 c2  	ldr	c1, [csp, #208]
;  	for( i = 0; i< ne; i++ ){
   13acc: 28 00 40 f9  	ldr	x8, [c1]
   13ad0: 09 00 40 f9  	ldr	x9, [c0]
   13ad4: 08 01 09 eb  	subs	x8, x8, x9
   13ad8: 22 03 00 54  	b.hs	0x13b3c <main+0x310>
   13adc: 01 00 00 14  	b	0x13ae0 <main+0x2b4>
   13ae0: e0 37 40 c2  	ldr	c0, [csp, #208]
; 		shared[i] 	= (uint64_t)(i + xbrtime_mype());
   13ae4: 08 00 40 f9  	ldr	x8, [c0]
   13ae8: e8 4f 00 f9  	str	x8, [csp, #152]
   13aec: 71 fd ff 97  	bl	0x130b0 <xbrtime_mype>
   13af0: e8 4f 40 f9  	ldr	x8, [csp, #152]
   13af4: e2 3f 40 c2  	ldr	c2, [csp, #240]
   13af8: e1 37 40 c2  	ldr	c1, [csp, #208]
   13afc: e9 03 00 2a  	mov	w9, w0
   13b00: e0 3b 40 c2  	ldr	c0, [csp, #224]
   13b04: 08 c1 29 8b  	add	x8, x8, w9, sxtw
   13b08: 42 00 40 c2  	ldr	c2, [c2, #0]
   13b0c: 29 00 40 f9  	ldr	x9, [c1]
   13b10: 48 78 29 f8  	str	x8, [c2, x9, lsl #3]
; 		private[i] 	= 1;
   13b14: 00 00 40 c2  	ldr	c0, [c0, #0]
   13b18: 29 00 40 f9  	ldr	x9, [c1]
   13b1c: 28 00 80 52  	mov	w8, #1
   13b20: 08 78 29 f8  	str	x8, [c0, x9, lsl #3]
; 	}
   13b24: 01 00 00 14  	b	0x13b28 <main+0x2fc>
   13b28: e0 37 40 c2  	ldr	c0, [csp, #208]
;  	for( i = 0; i< ne; i++ ){
   13b2c: 08 00 40 f9  	ldr	x8, [c0]
   13b30: 08 05 00 91  	add	x8, x8, #1              // =1
   13b34: 08 00 00 f9  	str	x8, [c0]
   13b38: e3 ff ff 17  	b	0x13ac4 <main+0x298>
; 	printf("[M]"GRN " Passed shared[] & private[] init\n"RESET);
   13b3c: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x354>
   13b40: 00 7c 41 c2  	ldr	c0, [c0, #1520]
   13b44: e9 03 1f aa  	mov	x9, xzr
   13b48: e2 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
;   xbrtime_barrier();
   13b4c: 5a fe ff 97  	bl	0x134b4 <xbrtime_barrier>
; 	if(xbrtime_mype() == 0){
   13b50: 58 fd ff 97  	bl	0x130b0 <xbrtime_mype>
   13b54: 20 07 00 35  	cbnz	w0, 0x13c38 <main+0x40c>
   13b58: 01 00 00 14  	b	0x13b5c <main+0x330>
; 		printf("========================\n");
   13b5c: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x374>
   13b60: 00 20 41 c2  	ldr	c0, [c0, #1152]
   13b64: e0 23 00 c2  	str	c0, [csp, #128]
   13b68: e9 03 1f aa  	mov	x9, xzr
   13b6c: e9 1f 00 c2  	str	c9, [csp, #112]
   13b70: d8 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13b74: e9 1f 40 c2  	ldr	c9, [csp, #112]
; 		printf(" xBGAS Matmul Benchmark\n");
   13b78: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x390>
   13b7c: 00 80 41 c2  	ldr	c0, [c0, #1536]
   13b80: d4 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13b84: e9 1f 40 c2  	ldr	c9, [csp, #112]
   13b88: e0 23 40 c2  	ldr	c0, [csp, #128]
; 		printf("========================\n");
   13b8c: d1 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13b90: e9 1f 40 c2  	ldr	c9, [csp, #112]
; 		printf(" Data type: uint64_t\n");
   13b94: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x3ac>
   13b98: 00 84 41 c2  	ldr	c0, [c0, #1552]
   13b9c: cd 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13ba0: e0 33 40 c2  	ldr	c0, [csp, #192]
; 		printf(" Element #: %lu\n", ne);
   13ba4: 08 00 40 f9  	ldr	x8, [c0]
   13ba8: e0 d3 c1 c2  	mov	c0, csp
   13bac: 08 00 00 f9  	str	x8, [c0]
   13bb0: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13bb4: 09 70 c6 c2  	clrperm	c9, c0, wx
   13bb8: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x3d0>
   13bbc: 00 88 41 c2  	ldr	c0, [c0, #1568]
   13bc0: c4 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13bc4: e1 2f 40 c2  	ldr	c1, [csp, #176]
   13bc8: e0 33 40 c2  	ldr	c0, [csp, #192]
;   	printf(" Data size: %lu bytes\n",  (int)(sz) * (int)(ne) );
   13bcc: 28 00 40 b9  	ldr	w8, [c1]
   13bd0: 09 00 40 b9  	ldr	w9, [c0]
   13bd4: 09 7d 09 1b  	mul	w9, w8, w9
   13bd8: e8 03 09 2a  	mov	w8, w9
   13bdc: e0 d3 c1 c2  	mov	c0, csp
   13be0: 08 00 00 f9  	str	x8, [c0]
   13be4: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13be8: 09 70 c6 c2  	clrperm	c9, c0, wx
   13bec: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x404>
   13bf0: 00 8c 41 c2  	ldr	c0, [c0, #1584]
   13bf4: b7 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 		printf(" PE #     : %d\n", xbrtime_num_pes());
   13bf8: 47 fd ff 97  	bl	0x13114 <xbrtime_num_pes>
   13bfc: e8 03 00 2a  	mov	w8, w0
   13c00: e0 d3 c1 c2  	mov	c0, csp
   13c04: 08 00 00 f9  	str	x8, [c0]
   13c08: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13c0c: 09 70 c6 c2  	clrperm	c9, c0, wx
   13c10: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x428>
   13c14: 00 90 41 c2  	ldr	c0, [c0, #1600]
   13c18: ae 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13c1c: e9 1f 40 c2  	ldr	c9, [csp, #112]
   13c20: e0 23 40 c2  	ldr	c0, [csp, #128]
;     printf("========================\n");
   13c24: ab 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 		t_start = mysecond();
   13c28: 3c fe ff 97  	bl	0x13518 <mysecond>
   13c2c: e0 47 40 c2  	ldr	c0, [csp, #272]
   13c30: 00 00 00 fd  	str	d0, [c0]
; 	}
   13c34: 01 00 00 14  	b	0x13c38 <main+0x40c>
;   if(xbrtime_mype() == 0){
   13c38: 1e fd ff 97  	bl	0x130b0 <xbrtime_mype>
   13c3c: a0 01 00 35  	cbnz	w0, 0x13c70 <main+0x444>
   13c40: 01 00 00 14  	b	0x13c44 <main+0x418>
   13c44: e1 53 40 c2  	ldr	c1, [csp, #320]
   13c48: e0 4f 40 c2  	ldr	c0, [csp, #304]
   13c4c: 24 00 80 52  	mov	w4, #1
   13c50: e2 03 04 2a  	mov	w2, w4
;     xbrtime_ulonglong_get(&x,&y,1,1,1);
   13c54: e3 03 04 2a  	mov	w3, w4
   13c58: 48 fd ff 97  	bl	0x13178 <xbrtime_ulonglong_get>
;     printf("  Completed\n");
   13c5c: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x474>
   13c60: 00 94 41 c2  	ldr	c0, [c0, #1616]
   13c64: e9 03 1f aa  	mov	x9, xzr
   13c68: 9a 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
;   }
   13c6c: 01 00 00 14  	b	0x13c70 <main+0x444>
;   xbrtime_barrier();
   13c70: 11 fe ff 97  	bl	0x134b4 <xbrtime_barrier>
; 	if(xbrtime_mype() == 0){
   13c74: 0f fd ff 97  	bl	0x130b0 <xbrtime_mype>
   13c78: 20 04 00 35  	cbnz	w0, 0x13cfc <main+0x4d0>
   13c7c: 01 00 00 14  	b	0x13c80 <main+0x454>
; 		t_end = mysecond();
   13c80: 26 fe ff 97  	bl	0x13518 <mysecond>
   13c84: e2 4b 40 c2  	ldr	c2, [csp, #288]
   13c88: e0 43 40 c2  	ldr	c0, [csp, #256]
   13c8c: e1 47 40 c2  	ldr	c1, [csp, #272]
   13c90: 40 00 00 fd  	str	d0, [c2]
; 		t_mem = t_end - t_start;
   13c94: 40 00 40 fd  	ldr	d0, [c2]
   13c98: 21 00 40 fd  	ldr	d1, [c1]
   13c9c: 00 38 61 1e  	fsub	d0, d0, d1
   13ca0: 00 00 00 fd  	str	d0, [c0]
; 		printf("--------------------------------------------\n");
   13ca4: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x4bc>
   13ca8: 00 98 41 c2  	ldr	c0, [c0, #1632]
   13cac: e0 1b 00 c2  	str	c0, [csp, #96]
   13cb0: e9 03 1f aa  	mov	x9, xzr
   13cb4: e9 17 00 c2  	str	c9, [csp, #80]
   13cb8: 86 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13cbc: e0 43 40 c2  	ldr	c0, [csp, #256]
; 		printf("Time cost"BRED	" (raw transactions):       %f\n"RESET, t_mem);
   13cc0: 00 00 40 fd  	ldr	d0, [c0]
   13cc4: e0 d3 c1 c2  	mov	c0, csp
   13cc8: 00 00 00 fd  	str	d0, [c0]
   13ccc: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13cd0: 09 70 c6 c2  	clrperm	c9, c0, wx
   13cd4: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x4ec>
   13cd8: 00 9c 41 c2  	ldr	c0, [c0, #1648]
   13cdc: 7d 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13ce0: e9 17 40 c2  	ldr	c9, [csp, #80]
   13ce4: e0 1b 40 c2  	ldr	c0, [csp, #96]
; 		printf("--------------------------------------------\n");
   13ce8: 7a 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 		t_start = mysecond();
   13cec: 0b fe ff 97  	bl	0x13518 <mysecond>
   13cf0: e0 47 40 c2  	ldr	c0, [csp, #272]
   13cf4: 00 00 00 fd  	str	d0, [c0]
; 	}
   13cf8: 01 00 00 14  	b	0x13cfc <main+0x4d0>
;   xbrtime_barrier();
   13cfc: ee fd ff 97  	bl	0x134b4 <xbrtime_barrier>
; 	if(xbrtime_mype() == 0){
   13d00: ec fc ff 97  	bl	0x130b0 <xbrtime_mype>
   13d04: 60 02 00 35  	cbnz	w0, 0x13d50 <main+0x524>
   13d08: 01 00 00 14  	b	0x13d0c <main+0x4e0>
; 		t_end = mysecond();
   13d0c: 03 fe ff 97  	bl	0x13518 <mysecond>
   13d10: e2 4b 40 c2  	ldr	c2, [csp, #288]
   13d14: e0 43 40 c2  	ldr	c0, [csp, #256]
   13d18: e1 47 40 c2  	ldr	c1, [csp, #272]
   13d1c: 40 00 00 fd  	str	d0, [c2]
; 		t_mem = t_end - t_start;
   13d20: 40 00 40 fd  	ldr	d0, [c2]
   13d24: 21 00 40 fd  	ldr	d1, [c1]
   13d28: 00 38 61 1e  	fsub	d0, d0, d1
   13d2c: 00 00 00 fd  	str	d0, [c0]
; 		printf("--------------------------------------------\n");
   13d30: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x548>
   13d34: 00 98 41 c2  	ldr	c0, [c0, #1632]
   13d38: e9 03 1f aa  	mov	x9, xzr
   13d3c: 65 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 		t_start = mysecond();
   13d40: f6 fd ff 97  	bl	0x13518 <mysecond>
   13d44: e0 47 40 c2  	ldr	c0, [csp, #272]
   13d48: 00 00 00 fd  	str	d0, [c0]
; 	}
   13d4c: 01 00 00 14  	b	0x13d50 <main+0x524>
   13d50: e0 37 40 c2  	ldr	c0, [csp, #208]
   13d54: e8 03 1f aa  	mov	x8, xzr
; 	for( i = 0; i < ne; i ++)
   13d58: 08 00 00 f9  	str	x8, [c0]
   13d5c: 01 00 00 14  	b	0x13d60 <main+0x534>
   13d60: e0 33 40 c2  	ldr	c0, [csp, #192]
   13d64: e1 37 40 c2  	ldr	c1, [csp, #208]
; 	for( i = 0; i < ne; i ++)
   13d68: 28 00 40 f9  	ldr	x8, [c1]
   13d6c: 09 00 40 f9  	ldr	x9, [c0]
   13d70: 08 01 09 eb  	subs	x8, x8, x9
   13d74: 62 02 00 54  	b.hs	0x13dc0 <main+0x594>
   13d78: 01 00 00 14  	b	0x13d7c <main+0x550>
   13d7c: e0 3b 40 c2  	ldr	c0, [csp, #224]
   13d80: e2 37 40 c2  	ldr	c2, [csp, #208]
   13d84: e1 3f 40 c2  	ldr	c1, [csp, #240]
; 		private[i] *= shared[i];                           // matrix multiplication
   13d88: 21 00 40 c2  	ldr	c1, [c1, #0]
   13d8c: 48 00 40 f9  	ldr	x8, [c2]
   13d90: 09 f1 7d d3  	lsl	x9, x8, #3
   13d94: 2a 68 69 f8  	ldr	x10, [c1, x9]
   13d98: 00 00 40 c2  	ldr	c0, [c0, #0]
   13d9c: 08 68 69 f8  	ldr	x8, [c0, x9]
   13da0: 08 7d 0a 9b  	mul	x8, x8, x10
   13da4: 08 68 29 f8  	str	x8, [c0, x9]
   13da8: 01 00 00 14  	b	0x13dac <main+0x580>
   13dac: e0 37 40 c2  	ldr	c0, [csp, #208]
; 	for( i = 0; i < ne; i ++)
   13db0: 08 00 40 f9  	ldr	x8, [c0]
   13db4: 08 05 00 91  	add	x8, x8, #1              // =1
   13db8: 08 00 00 f9  	str	x8, [c0]
   13dbc: e9 ff ff 17  	b	0x13d60 <main+0x534>
; 	if(xbrtime_mype() == 0){
   13dc0: bc fc ff 97  	bl	0x130b0 <xbrtime_mype>
   13dc4: 00 03 00 35  	cbnz	w0, 0x13e24 <main+0x5f8>
   13dc8: 01 00 00 14  	b	0x13dcc <main+0x5a0>
; 		t_end = mysecond();
   13dcc: d3 fd ff 97  	bl	0x13518 <mysecond>
   13dd0: e2 4b 40 c2  	ldr	c2, [csp, #288]
   13dd4: e1 47 40 c2  	ldr	c1, [csp, #272]
   13dd8: e0 43 40 c2  	ldr	c0, [csp, #256]
   13ddc: 40 00 00 fd  	str	d0, [c2]
; 		t_mem = t_end - t_start;
   13de0: 40 00 40 fd  	ldr	d0, [c2]
   13de4: 21 00 40 fd  	ldr	d1, [c1]
   13de8: 00 38 61 1e  	fsub	d0, d0, d1
   13dec: 00 00 00 fd  	str	d0, [c0]
; 		printf("Time cost"BMAG " (matrix multiplication):  %f\n"RESET, t_mem);
   13df0: 00 00 40 fd  	ldr	d0, [c0]
   13df4: e0 d3 c1 c2  	mov	c0, csp
   13df8: 00 00 00 fd  	str	d0, [c0]
   13dfc: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13e00: 09 70 c6 c2  	clrperm	c9, c0, wx
   13e04: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x61c>
   13e08: 00 a0 41 c2  	ldr	c0, [c0, #1664]
   13e0c: 31 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 		printf("--------------------------------------------\n");
   13e10: 80 00 80 b0  	adrp	c0, 0x24000 <main+0x628>
   13e14: 00 98 41 c2  	ldr	c0, [c0, #1632]
   13e18: e9 03 1f aa  	mov	x9, xzr
   13e1c: 2d 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
; 	}
   13e20: 01 00 00 14  	b	0x13e24 <main+0x5f8>
   13e24: e0 3b 40 c2  	ldr	c0, [csp, #224]
; 	free(private);
   13e28: 00 00 40 c2  	ldr	c0, [c0, #0]
   13e2c: 25 01 00 94  	bl	0x142c0 <xbrtime_api_asm.s+0x142c0>
   13e30: e0 3f 40 c2  	ldr	c0, [csp, #240]
;   xbrtime_free( shared );
   13e34: 00 00 40 c2  	ldr	c0, [c0, #0]
   13e38: 94 f8 ff 97  	bl	0x12088 <xbrtime_free>
;   xbrtime_close();
   13e3c: 5a fb ff 97  	bl	0x12ba4 <xbrtime_close>
; 	printf("[M]"GRN " Returning Main matmul...\n"RESET);
   13e40: 80 00 80 b0  	adrp	c0, 0x24000 <tpool_work_unit_get+0x1c>
   13e44: 00 a4 41 c2  	ldr	c0, [c0, #1680]
   13e48: e9 03 1f aa  	mov	x9, xzr
   13e4c: 21 01 00 94  	bl	0x142d0 <xbrtime_api_asm.s+0x142d0>
   13e50: e0 2b 40 c2  	ldr	c0, [csp, #160]
;   return rtn;
   13e54: 00 00 40 b9  	ldr	w0, [c0]
   13e58: ff 83 0b 02  	add	csp, csp, #736          // =736
   13e5c: fc 0b 40 c2  	ldr	c28, [csp, #32]
   13e60: fd fb c1 22  	ldp	c29, c30, [csp], #48
   13e64: c0 53 c2 c2  	ret	c30

0000000000013e68 <tpool_work_unit_get>:
; {                                                                               
   13e68: ff 83 81 02  	sub	csp, csp, #96           // =96
   13e6c: 01 d0 c1 c2  	mov	c1, c0
   13e70: e0 43 01 02  	add	c0, csp, #80            // =80
   13e74: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13e78: e0 03 00 c2  	str	c0, [csp, #0]
   13e7c: e0 03 01 02  	add	c0, csp, #64            // =64
   13e80: 00 38 c8 c2  	scbnds	c0, c0, #16             // =16
   13e84: 02 d0 c1 c2  	mov	c2, c0
   13e88: e2 07 00 c2  	str	c2, [csp, #16]
   13e8c: e2 c3 00 02  	add	c2, csp, #48            // =48
   13e90: 42 38 c8 c2  	scbnds	c2, c2, #16             // =16
   13e94: e2 0b 00 c2  	str	c2, [csp, #32]
   13e98: 01 00 00 c2  	str	c1, [c0, #0]
;   if (wq == NULL)                                                               
   13e9c: 00 00 40 c2  	ldr	c0, [c0, #0]
   13ea0: e8 03 00 aa  	mov	x8, x0
   13ea4: c8 00 00 b5  	cbnz	x8, 0x13ebc <tpool_work_unit_get+0x54>
   13ea8: 01 00 00 14  	b	0x13eac <tpool_work_unit_get+0x44>
   13eac: e1 03 40 c2  	ldr	c1, [csp, #0]
;     return NULL;                                                                
   13eb0: e0 03 1f aa  	mov	x0, xzr
   13eb4: 20 00 00 c2  	str	c0, [c1, #0]
   13eb8: 27 00 00 14  	b	0x13f54 <tpool_work_unit_get+0xec>
   13ebc: e0 0b 40 c2  	ldr	c0, [csp, #32]
   13ec0: e1 07 40 c2  	ldr	c1, [csp, #16]
;   work = wq->work_head;                                                         
   13ec4: 21 00 40 c2  	ldr	c1, [c1, #0]
   13ec8: 21 00 40 c2  	ldr	c1, [c1, #0]
   13ecc: 01 00 00 c2  	str	c1, [c0, #0]
;   if (work == NULL)                                                             
   13ed0: 00 00 40 c2  	ldr	c0, [c0, #0]
   13ed4: e8 03 00 aa  	mov	x8, x0
   13ed8: c8 00 00 b5  	cbnz	x8, 0x13ef0 <tpool_work_unit_get+0x88>
   13edc: 01 00 00 14  	b	0x13ee0 <tpool_work_unit_get+0x78>
   13ee0: e1 03 40 c2  	ldr	c1, [csp, #0]
;     return NULL;                                                                
   13ee4: e0 03 1f aa  	mov	x0, xzr
   13ee8: 20 00 00 c2  	str	c0, [c1, #0]
   13eec: 1a 00 00 14  	b	0x13f54 <tpool_work_unit_get+0xec>
   13ef0: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   if (work->next == NULL) {                                                     
   13ef4: 00 00 40 c2  	ldr	c0, [c0, #0]
   13ef8: 00 08 40 c2  	ldr	c0, [c0, #32]
   13efc: e8 03 00 aa  	mov	x8, x0
   13f00: 28 01 00 b5  	cbnz	x8, 0x13f24 <tpool_work_unit_get+0xbc>
   13f04: 01 00 00 14  	b	0x13f08 <tpool_work_unit_get+0xa0>
   13f08: e1 07 40 c2  	ldr	c1, [csp, #16]
;     wq->work_head = NULL;                                                       
   13f0c: 22 00 40 c2  	ldr	c2, [c1, #0]
   13f10: e0 03 1f aa  	mov	x0, xzr
   13f14: 40 00 00 c2  	str	c0, [c2, #0]
;     wq->work_tail = NULL;                                                       
   13f18: 21 00 40 c2  	ldr	c1, [c1, #0]
   13f1c: 20 04 00 c2  	str	c0, [c1, #16]
;   } else {                                                                      
   13f20: 08 00 00 14  	b	0x13f40 <tpool_work_unit_get+0xd8>
   13f24: e1 07 40 c2  	ldr	c1, [csp, #16]
   13f28: e0 0b 40 c2  	ldr	c0, [csp, #32]
;     wq->work_head = work->next;                                                 
   13f2c: 00 00 40 c2  	ldr	c0, [c0, #0]
   13f30: 00 08 40 c2  	ldr	c0, [c0, #32]
   13f34: 21 00 40 c2  	ldr	c1, [c1, #0]
   13f38: 20 00 00 c2  	str	c0, [c1, #0]
   13f3c: 01 00 00 14  	b	0x13f40 <tpool_work_unit_get+0xd8>
   13f40: e1 03 40 c2  	ldr	c1, [csp, #0]
   13f44: e0 0b 40 c2  	ldr	c0, [csp, #32]
;   return work;                                                                  
   13f48: 00 00 40 c2  	ldr	c0, [c0, #0]
   13f4c: 20 00 00 c2  	str	c0, [c1, #0]
   13f50: 01 00 00 14  	b	0x13f54 <tpool_work_unit_get+0xec>
   13f54: e0 03 40 c2  	ldr	c0, [csp, #0]
; }                                                                               
   13f58: 00 00 40 c2  	ldr	c0, [c0, #0]
   13f5c: ff 83 01 02  	add	csp, csp, #96           // =96
   13f60: c0 53 c2 c2  	ret	c30

0000000000013f64 <__xbrtime_get_u1_seq>:
;   MOV X12, XZR
   13f64: ec 03 1f aa  	mov	x12, xzr

0000000000013f68 <.get_u1_seq>:
;   LDRB W10, [X0]
   13f68: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13f6c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13f70: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13f74: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13f78: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13f7c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u1_seq
   13f80: 41 ff ff 54  	b.ne	0x13f68 <.get_u1_seq>
;   RET
   13f84: c0 53 c2 c2  	ret	c30

0000000000013f88 <__xbrtime_put_u1_seq>:
;   MOV X12, XZR
   13f88: ec 03 1f aa  	mov	x12, xzr

0000000000013f8c <.put_u1_seq>:
;   LDRB W10, [X0]
   13f8c: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13f90: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13f94: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13f98: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13f9c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13fa0: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u1_seq
   13fa4: 41 ff ff 54  	b.ne	0x13f8c <.put_u1_seq>
;   RET
   13fa8: c0 53 c2 c2  	ret	c30

0000000000013fac <__xbrtime_get_s1_seq>:
;   MOV X12, XZR
   13fac: ec 03 1f aa  	mov	x12, xzr

0000000000013fb0 <.get_s1_seq>:
;   LDRB W10, [X0]
   13fb0: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13fb4: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13fb8: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13fbc: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13fc0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13fc4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s1_seq
   13fc8: 41 ff ff 54  	b.ne	0x13fb0 <.get_s1_seq>
;   RET
   13fcc: c0 53 c2 c2  	ret	c30

0000000000013fd0 <__xbrtime_put_s1_seq>:
;   MOV X12, XZR
   13fd0: ec 03 1f aa  	mov	x12, xzr

0000000000013fd4 <.put_s1_seq>:
;   LDRB W10, [X0]
   13fd4: 0a 04 00 e2  	ldurb	w10, [x0, #0]
;   ADD X0, X0, X3
   13fd8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   13fdc: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRB W10, [X1]
   13fe0: 2a 00 00 e2  	sturb	w10, [x1, #0]
;   ADD X1, X1, X3
   13fe4: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   13fe8: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s1_seq
   13fec: 41 ff ff 54  	b.ne	0x13fd4 <.put_s1_seq>
;   RET
   13ff0: c0 53 c2 c2  	ret	c30

0000000000013ff4 <__xbrtime_get_u2_seq>:
;   MOV X12, XZR
   13ff4: ec 03 1f aa  	mov	x12, xzr

0000000000013ff8 <.get_u2_seq>:
;   LDRH W10, [X0]
   13ff8: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   13ffc: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14000: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   14004: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   14008: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1400c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u2_seq
   14010: 41 ff ff 54  	b.ne	0x13ff8 <.get_u2_seq>
;   RET
   14014: c0 53 c2 c2  	ret	c30

0000000000014018 <__xbrtime_put_u2_seq>:
;   MOV X12, XZR
   14018: ec 03 1f aa  	mov	x12, xzr

000000000001401c <.put_u2_seq>:
;   LDRH W10, [X0]
   1401c: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   14020: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14024: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   14028: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   1402c: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14030: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u2_seq
   14034: 41 ff ff 54  	b.ne	0x1401c <.put_u2_seq>
;   RET
   14038: c0 53 c2 c2  	ret	c30

000000000001403c <__xbrtime_get_s2_seq>:
;   MOV X12, XZR
   1403c: ec 03 1f aa  	mov	x12, xzr

0000000000014040 <.get_s2_seq>:
;   LDRH W10, [X0]
   14040: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   14044: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14048: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   1404c: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   14050: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14054: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s2_seq
   14058: 41 ff ff 54  	b.ne	0x14040 <.get_s2_seq>
;   RET
   1405c: c0 53 c2 c2  	ret	c30

0000000000014060 <__xbrtime_put_s2_seq>:
;   MOV X12, XZR
   14060: ec 03 1f aa  	mov	x12, xzr

0000000000014064 <.put_s2_seq>:
;   LDRH W10, [X0]
   14064: 0a 04 40 e2  	ldurh	w10, [x0, #0]
;   ADD X0, X0, X3
   14068: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1406c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STRH W10, [X1]
   14070: 2a 00 40 e2  	sturh	w10, [x1, #0]
;   ADD X1, X1, X3
   14074: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14078: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s2_seq
   1407c: 41 ff ff 54  	b.ne	0x14064 <.put_s2_seq>
;   RET
   14080: c0 53 c2 c2  	ret	c30

0000000000014084 <__xbrtime_get_u4_seq>:
;   MOV X12, XZR
   14084: ec 03 1f aa  	mov	x12, xzr

0000000000014088 <.get_u4_seq>:
;   LDR W10, [X0]
   14088: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   1408c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14090: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   14094: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   14098: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1409c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_u4_seq
   140a0: 41 ff ff 54  	b.ne	0x14088 <.get_u4_seq>
;   RET
   140a4: c0 53 c2 c2  	ret	c30

00000000000140a8 <__xbrtime_put_u4_seq>:
;   MOV X12, XZR
   140a8: ec 03 1f aa  	mov	x12, xzr

00000000000140ac <.put_u4_seq>:
;   LDR W10, [X0]
   140ac: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   140b0: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   140b4: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   140b8: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   140bc: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   140c0: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u4_seq
   140c4: 41 ff ff 54  	b.ne	0x140ac <.put_u4_seq>
;   RET
   140c8: c0 53 c2 c2  	ret	c30

00000000000140cc <__xbrtime_get_s4_seq>:
;   MOV X12, XZR
   140cc: ec 03 1f aa  	mov	x12, xzr

00000000000140d0 <.get_s4_seq>:
;   LDR W10, [X0]
   140d0: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   140d4: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   140d8: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   140dc: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   140e0: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   140e4: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s4_seq
   140e8: 41 ff ff 54  	b.ne	0x140d0 <.get_s4_seq>
;   RET
   140ec: c0 53 c2 c2  	ret	c30

00000000000140f0 <__xbrtime_put_s4_seq>:
;   MOV X12, XZR
   140f0: ec 03 1f aa  	mov	x12, xzr

00000000000140f4 <.put_s4_seq>:
;   LDR W10, [X0]
   140f4: 0a 04 80 e2  	ldur	w10, [x0, #0]
;   ADD X0, X0, X3
   140f8: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   140fc: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR W10, [X1]
   14100: 2a 00 80 e2  	stur	w10, [x1, #0]
;   ADD X1, X1, X3
   14104: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14108: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s4_seq
   1410c: 41 ff ff 54  	b.ne	0x140f4 <.put_s4_seq>
;   RET
   14110: c0 53 c2 c2  	ret	c30

0000000000014114 <__xbrtime_get_u8_seq>:
;   MOV X0, XZR
   14114: e0 03 1f aa  	mov	x0, xzr

0000000000014118 <.get_u8_seq>:
;   RET
   14118: c0 53 c2 c2  	ret	c30

000000000001411c <__xbrtime_put_u8_seq>:
;   MOV X12, XZR
   1411c: ec 03 1f aa  	mov	x12, xzr

0000000000014120 <.put_u8_seq>:
;   LDR X10, [X0]
   14120: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   14124: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14128: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   1412c: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   14130: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14134: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_u8_seq
   14138: 41 ff ff 54  	b.ne	0x14120 <.put_u8_seq>
;   RET
   1413c: c0 53 c2 c2  	ret	c30

0000000000014140 <__xbrtime_get_s8_seq>:
;   MOV X12, XZR
   14140: ec 03 1f aa  	mov	x12, xzr

0000000000014144 <.get_s8_seq>:
;   LDR X10, [X0]
   14144: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   14148: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   1414c: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   14150: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   14154: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   14158: 9f 01 02 eb  	cmp	x12, x2
;   BNE .get_s8_seq
   1415c: 41 ff ff 54  	b.ne	0x14144 <.get_s8_seq>
;   RET
   14160: c0 53 c2 c2  	ret	c30

0000000000014164 <__xbrtime_put_s8_seq>:
;   MOV X12, XZR
   14164: ec 03 1f aa  	mov	x12, xzr

0000000000014168 <.put_s8_seq>:
;   LDR X10, [X0]
   14168: 0a 04 c0 e2  	ldur	x10, [x0, #0]
;   ADD X0, X0, X3
   1416c: 00 00 03 8b  	add	x0, x0, x3
;   ADD X12, X12, #1
   14170: 8c 05 00 91  	add	x12, x12, #1            // =1
;   STR X10, [X1]
   14174: 2a 00 c0 e2  	stur	x10, [x1, #0]
;   ADD X1, X1, X3
   14178: 21 00 03 8b  	add	x1, x1, x3
;   CMP X12, X2
   1417c: 9f 01 02 eb  	cmp	x12, x2
;   BNE .put_s8_seq
   14180: 41 ff ff 54  	b.ne	0x14168 <.put_s8_seq>
;   RET
   14184: c0 53 c2 c2  	ret	c30

0000000000014188 <__xbrtime_asm_fence>:
;   DSB SY
   14188: 9f 3f 03 d5  	dsb	sy
;   ISB
   1418c: df 3f 03 d5  	isb
;   RET
   14190: c0 53 c2 c2  	ret	c30

0000000000014194 <__xbrtime_asm_quiet_fence>:
;   DMB SY
   14194: bf 3f 03 d5  	dmb	sy
;   RET
   14198: c0 53 c2 c2  	ret	c30

Disassembly of section .plt:

00000000000141a0 <.plt>:
   141a0: f0 7b bf 62  	stp	c16, c30, [csp, #-32]!
   141a4: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x84>
   141a8: 11 66 42 c2  	ldr	c17, [c16, #2448]
   141ac: 10 42 26 02  	add	c16, c16, #2448         // =2448
   141b0: 20 12 c2 c2  	br	c17
   141b4: 1f 20 03 d5  	nop
   141b8: 1f 20 03 d5  	nop
   141bc: 1f 20 03 d5  	nop
   141c0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xa0>
   141c4: 10 82 26 02  	add	c16, c16, #2464         // =2464
   141c8: 11 02 40 c2  	ldr	c17, [c16, #0]
   141cc: 20 12 c2 c2  	br	c17
   141d0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xb0>
   141d4: 10 c2 26 02  	add	c16, c16, #2480         // =2480
   141d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   141dc: 20 12 c2 c2  	br	c17
   141e0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xc0>
   141e4: 10 02 27 02  	add	c16, c16, #2496         // =2496
   141e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   141ec: 20 12 c2 c2  	br	c17
   141f0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xd0>
   141f4: 10 42 27 02  	add	c16, c16, #2512         // =2512
   141f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   141fc: 20 12 c2 c2  	br	c17
   14200: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xe0>
   14204: 10 82 27 02  	add	c16, c16, #2528         // =2528
   14208: 11 02 40 c2  	ldr	c17, [c16, #0]
   1420c: 20 12 c2 c2  	br	c17
   14210: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0xf0>
   14214: 10 c2 27 02  	add	c16, c16, #2544         // =2544
   14218: 11 02 40 c2  	ldr	c17, [c16, #0]
   1421c: 20 12 c2 c2  	br	c17
   14220: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x100>
   14224: 10 02 28 02  	add	c16, c16, #2560         // =2560
   14228: 11 02 40 c2  	ldr	c17, [c16, #0]
   1422c: 20 12 c2 c2  	br	c17
   14230: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x110>
   14234: 10 42 28 02  	add	c16, c16, #2576         // =2576
   14238: 11 02 40 c2  	ldr	c17, [c16, #0]
   1423c: 20 12 c2 c2  	br	c17
   14240: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x120>
   14244: 10 82 28 02  	add	c16, c16, #2592         // =2592
   14248: 11 02 40 c2  	ldr	c17, [c16, #0]
   1424c: 20 12 c2 c2  	br	c17
   14250: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x130>
   14254: 10 c2 28 02  	add	c16, c16, #2608         // =2608
   14258: 11 02 40 c2  	ldr	c17, [c16, #0]
   1425c: 20 12 c2 c2  	br	c17
   14260: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x140>
   14264: 10 02 29 02  	add	c16, c16, #2624         // =2624
   14268: 11 02 40 c2  	ldr	c17, [c16, #0]
   1426c: 20 12 c2 c2  	br	c17
   14270: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x150>
   14274: 10 42 29 02  	add	c16, c16, #2640         // =2640
   14278: 11 02 40 c2  	ldr	c17, [c16, #0]
   1427c: 20 12 c2 c2  	br	c17
   14280: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x160>
   14284: 10 82 29 02  	add	c16, c16, #2656         // =2656
   14288: 11 02 40 c2  	ldr	c17, [c16, #0]
   1428c: 20 12 c2 c2  	br	c17
   14290: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x170>
   14294: 10 c2 29 02  	add	c16, c16, #2672         // =2672
   14298: 11 02 40 c2  	ldr	c17, [c16, #0]
   1429c: 20 12 c2 c2  	br	c17
   142a0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x180>
   142a4: 10 02 2a 02  	add	c16, c16, #2688         // =2688
   142a8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142ac: 20 12 c2 c2  	br	c17
   142b0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x190>
   142b4: 10 42 2a 02  	add	c16, c16, #2704         // =2704
   142b8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142bc: 20 12 c2 c2  	br	c17
   142c0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1a0>
   142c4: 10 82 2a 02  	add	c16, c16, #2720         // =2720
   142c8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142cc: 20 12 c2 c2  	br	c17
   142d0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1b0>
   142d4: 10 c2 2a 02  	add	c16, c16, #2736         // =2736
   142d8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142dc: 20 12 c2 c2  	br	c17
   142e0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1c0>
   142e4: 10 02 2b 02  	add	c16, c16, #2752         // =2752
   142e8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142ec: 20 12 c2 c2  	br	c17
   142f0: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1d0>
   142f4: 10 42 2b 02  	add	c16, c16, #2768         // =2768
   142f8: 11 02 40 c2  	ldr	c17, [c16, #0]
   142fc: 20 12 c2 c2  	br	c17
   14300: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1e0>
   14304: 10 82 2b 02  	add	c16, c16, #2784         // =2784
   14308: 11 02 40 c2  	ldr	c17, [c16, #0]
   1430c: 20 12 c2 c2  	br	c17
   14310: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x1f0>
   14314: 10 c2 2b 02  	add	c16, c16, #2800         // =2800
   14318: 11 02 40 c2  	ldr	c17, [c16, #0]
   1431c: 20 12 c2 c2  	br	c17
   14320: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x200>
   14324: 10 02 2c 02  	add	c16, c16, #2816         // =2816
   14328: 11 02 40 c2  	ldr	c17, [c16, #0]
   1432c: 20 12 c2 c2  	br	c17
   14330: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x210>
   14334: 10 42 2c 02  	add	c16, c16, #2832         // =2832
   14338: 11 02 40 c2  	ldr	c17, [c16, #0]
   1433c: 20 12 c2 c2  	br	c17
   14340: 10 01 80 90  	adrp	c16, 0x34000 <.plt+0x220>
   14344: 10 82 2c 02  	add	c16, c16, #2848         // =2848
   14348: 11 02 40 c2  	ldr	c17, [c16, #0]
   1434c: 20 12 c2 c2  	br	c17
