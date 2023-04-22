CC=/home/parallels/cheri/cheri-exercises/tools/ccc
# CC=gcc
#RISCV=/home/meside/xbgas-tools
SRCS= $(wildcard *.c)
OBJS = $(SRCS:.c=.exe)
#CFLAGS = -std=c11 -I$(RISCV)/include -L$(RISCV)/lib/
#LIBS = -lxbrtime -lm


all: $(OBJS)

%.exe:%.c
	$(CC) -o $@ $^

clean:
	rm -f ./*.o ./*.exe
