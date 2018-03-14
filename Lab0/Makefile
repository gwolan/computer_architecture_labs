test: test.o
	ld test.o -o test
	rm test.o
test.o: test.s
	as test.s -o test.o
clean:
	rm test