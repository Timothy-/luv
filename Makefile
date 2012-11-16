CFLAGS=-Ilibuv/include -I/usr/local/include/luajit-2.0 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wall -Werror -fPIC
LIBS=-lm -lpthread -lrt

all: luv.so

libuvlibuv.a:
	CPPFLAGS=-fPIC $(MAKE) -C libuv

common.o: common.c common.h
	$(CC) -c $< -o $@ ${CFLAGS}

luv.o: luv.c luv.h luv_functions.c luv_handle.c luv_stream.c luv_tcp.c luv_timer.c
	$(CC) -c $< -o $@ ${CFLAGS}

luv.so: luv.o libuv/libuv.a common.o
	$(CC) -o luv.so luv.o libuv/libuv.a common.o ${LIBS} -shared

clean:
	rm -f *.so *.o
