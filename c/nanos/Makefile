CC = gcc
CFLAGS = -Wall -Wextra -O2
BIN_DIR = ~/.dotfiles/bin
SRC = nanos.c
TARGET = ${BIN_DIR}/nanos

all: ${TARGET}

${TARGET}: ${SRC}
	${CC} ${CFLAGS} ${SRC} -o ${TARGET}

clean:
	rm -f ${TARGET}
