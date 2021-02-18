all:numarray

numarray:numarray.o
	gcc -o numarray numarray.o

numarray.o:numarray.s
	as -o numarray.o numarray.s

clean:
	rm -rf numarray *.o
