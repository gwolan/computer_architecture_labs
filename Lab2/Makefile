BINNAME=fib
SRCNAME=$(BINNAME).s
OBJNAME=$(BINNAME).o

clean:
	rm -rf $(OBJNAME) $(BINNAME) 

$(OBJNAME): clean $(SRCNAME)
	as $(word 2, $^) -o $@

$(BINNAME): $(OBJNAME)
	ld $^ -o $@
	rm -rf $^

run: $(BINNAME)
	./$^
