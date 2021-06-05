SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
all: Main Setup Update Analyze
Main: ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 AnalyzeDB.smi Main.smi ../excercises/IntScan/IOError.o myDBEnv.o DBSchema.o \
 ../excercises/jsonImport/JSONImport.o DataSource.o DBSetup.o AnalyzeDB.o Main.o
	$(SMLSHARP) $(LDFLAGS) -o Main Main.smi $(LIBS)
Setup: ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi Setup.smi \
 ../excercises/IntScan/IOError.o myDBEnv.o DBSchema.o \
 ../excercises/jsonImport/JSONImport.o DataSource.o DBSetup.o Setup.o
	$(SMLSHARP) $(LDFLAGS) -o Setup Setup.smi $(LIBS)
Update: ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi Update.smi \
 ../excercises/IntScan/IOError.o myDBEnv.o DBSchema.o \
 ../excercises/jsonImport/JSONImport.o DataSource.o DBSetup.o Update.o
	$(SMLSHARP) $(LDFLAGS) -o Update Update.smi $(LIBS)
Analyze: ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 AnalyzeDB.smi Analyze.smi ../excercises/IntScan/IOError.o myDBEnv.o \
 DBSchema.o ../excercises/jsonImport/JSONImport.o DataSource.o DBSetup.o \
 AnalyzeDB.o Analyze.o
	$(SMLSHARP) $(LDFLAGS) -o Analyze Analyze.smi $(LIBS)
../excercises/IntScan/IOError.o: ../excercises/IntScan/IOError.sml \
 ../excercises/IntScan/IOError.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../excercises/IntScan/IOError.o -c \
 ../excercises/IntScan/IOError.sml
myDBEnv.o: myDBEnv.sml ../excercises/IntScan/IOError.smi myDBEnv.smi
	$(SMLSHARP) $(SMLFLAGS) -o myDBEnv.o -c myDBEnv.sml
DBSchema.o: DBSchema.sml ../excercises/IntScan/IOError.smi myDBEnv.smi \
 DBSchema.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSchema.o -c DBSchema.sml
../excercises/jsonImport/JSONImport.o: ../excercises/jsonImport/JSONImport.sml \
 ../excercises/jsonImport/JSONImport.smi
	$(SMLSHARP) $(SMLFLAGS) -o ../excercises/jsonImport/JSONImport.o -c \
 ../excercises/jsonImport/JSONImport.sml
DataSource.o: DataSource.sml ../excercises/jsonImport/JSONImport.smi \
 DataSource.smi
	$(SMLSHARP) $(SMLFLAGS) -o DataSource.o -c DataSource.sml
DBSetup.o: DBSetup.sml ../excercises/IntScan/IOError.smi myDBEnv.smi \
 DBSchema.smi ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi
	$(SMLSHARP) $(SMLFLAGS) -o DBSetup.o -c DBSetup.sml
AnalyzeDB.o: AnalyzeDB.sml ../excercises/IntScan/IOError.smi myDBEnv.smi \
 DBSchema.smi AnalyzeDB.smi
	$(SMLSHARP) $(SMLFLAGS) -o AnalyzeDB.o -c AnalyzeDB.sml
Main.o: Main.sml ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi \
 AnalyzeDB.smi Main.smi
	$(SMLSHARP) $(SMLFLAGS) -o Main.o -c Main.sml
Setup.o: Setup.sml ../excercises/IntScan/IOError.smi myDBEnv.smi DBSchema.smi \
 ../excercises/jsonImport/JSONImport.smi DataSource.smi DBSetup.smi Setup.smi
	$(SMLSHARP) $(SMLFLAGS) -o Setup.o -c Setup.sml
Update.o: Update.sml ../excercises/IntScan/IOError.smi myDBEnv.smi \
 DBSchema.smi ../excercises/jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi Update.smi
	$(SMLSHARP) $(SMLFLAGS) -o Update.o -c Update.sml
Analyze.o: Analyze.sml ../excercises/IntScan/IOError.smi myDBEnv.smi \
 DBSchema.smi ../excercises/jsonImport/JSONImport.smi DataSource.smi \
 DBSetup.smi AnalyzeDB.smi Analyze.smi
	$(SMLSHARP) $(SMLFLAGS) -o Analyze.o -c Analyze.sml
