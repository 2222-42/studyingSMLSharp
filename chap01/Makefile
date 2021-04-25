SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: first.smi main.smi first.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
first.o: first.sml first.smi
	$(SMLSHARP) $(SMLFLAGS) -o first.o -c first.sml
main.o: main.sml first.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
