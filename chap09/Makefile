SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main
Main: DBSchema.smi ../excercises/jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi AnalyzeDB.smi Main.smi DBSchema.o \
 ../excercises/jsonImport/JSONImport.o DataSource.o DBSetup.o AnalyzeDB.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
DBSchema.o: DBSchema.sml DBSchema.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSchema.o -c DBSchema.sml
../excercises/jsonImport/JSONImport.o: ../excercises/jsonImport/JSONImport.sml \
 ../excercises/jsonImport/JSONImport.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../excercises/jsonImport/JSONImport.o -c \
 ../excercises/jsonImport/JSONImport.sml
DataSource.o: DataSource.sml ../excercises/jsonImport/JSONImport.smi \
 DataSource.smi
	$(SMLSHARP) $(SMLFLAGS) -o DataSource.o -c DataSource.sml
DBSetup.o: DBSetup.sml DBSchema.smi ../excercises/jsonImport/JSONImport.smi \
 DataSource.smi DBSetup.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSetup.o -c DBSetup.sml
AnalyzeDB.o: AnalyzeDB.sml DBSchema.smi AnalyzeDB.smi
	$(SMLSHARP) $(SMLFLAGS) -o AnalyzeDB.o -c AnalyzeDB.sml
Main.o: Main.sml DBSchema.smi ../excercises/jsonImport/JSONImport.smi \
 DataSource.smi DBSetup.smi AnalyzeDB.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
