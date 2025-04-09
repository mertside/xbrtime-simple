# Compiler and Flags
CC = cc
CFLAGS = -O2 -Wall
LDFLAGS = -lm
SHMEM_LIBS = -lshmem

# Source and Object Files
SRCS = shmem_ping_pong.c shmem_sum_example.c shmem_vector_add.c stream_triad.c
BINS = $(SRCS:.c=)

# Default target
all: $(BINS)

# Compile each binary
%: %.c
	$(CC) $(CFLAGS) -o $@ $< $(SHMEM_LIBS) $(LDFLAGS)

# Clean build
clean:
	rm -f $(BINS)

# Run one binary (example: make run_ping)
run_%: %
	./$*

.PHONY: all clean