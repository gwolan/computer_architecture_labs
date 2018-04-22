SRCNAME=fib

clean:
	rm -rf $(SRCNAME).o $(SRCNAME) 

$(SRCNAME)_obj: $(SRCNAME).s
	as $< -o $(SRCNAME).o

$(SRCNAME): $(SRCNAME).o
	ld $^ -o $(SRCNAME)
	rm -rf $(SRCNAME).o

run: clean $(SRCNAME)
	./fib
