SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: castLike.smi GetArg.smi main.smi castLike.o GetArg.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
castLike.o: castLike.sml castLike.smi
	$(SMLSHARP) $(SMLFLAGS) -o castLike.o -c castLike.sml
GetArg.o: GetArg.sml castLike.smi GetArg.smi
	$(SMLSHARP) $(SMLFLAGS) -o GetArg.o -c GetArg.sml
main.o: main.sml castLike.smi GetArg.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
