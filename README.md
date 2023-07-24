`xbrtime-simple`
# xBGAS Runtime Simplified

Porting the xBGAS runtime library onto the CHERI-enabled Morello boards consists of work in four main abstraction layers. 
First, we utilize ARM’s Fixed-Virtual Platform (FVP) ecosystem to emulate a real Morello SoC. 
The FVP provides a functionality-accurate programmer’s view of the hardware platform using the binary translation technology running at speeds comparable to the real hardware. 
Second, we modify the low-level runtime by translating the xBGAS API assembly functions written in RISC-V ISA to ARM ISA. 
Third, we leverage thread pooling on the high-level runtime to model the behavior of multiple processes. 
Finally, we propose minimal changes to the existing xBGAS benchmarks by only requiring the developer to add an entry point and an exit point in their programs to define the code segment that multiple threads can execute in parallel.
