

fun main () =
    Dynamic.pp {
        binL = ReadIntStream.readBinStream "binStreamFile.txt",
        decL = ReadIntStream.readDecStream "decStreamFile.txt",
        hexL = ReadIntStream.readHexStream "hexStreamFile.txt",
        octL = ReadIntStream.readOctStream "octStreamFile.txt"
    };
val _ = main();
