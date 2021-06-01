SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: main
main: IOError.smi readStream.smi main.smi IOError.o readStream.o main.o
	$(SMLSHARP) $(LDFLAGS) -o main main.smi $(LIBS)
IOError.o: IOError.sml IOError.smi
	$(SMLSHARP) $(SMLFLAGS) -o IOError.o -c IOError.sml
readStream.o: readStream.sml IOError.smi readStream.smi
	$(SMLSHARP) $(SMLFLAGS) -o readStream.o -c readStream.sml
main.o: main.sml IOError.smi readStream.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml
