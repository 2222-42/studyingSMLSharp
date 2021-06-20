structure Main =
struct
    type schema = {files: {name: string, suffix: string, size : int} list};
    exception Abort of string;
    datatype outPutType =
             Plot of {xkey: string, ykey: string}
             | Histogram of {xkey: string}
    fun parseArgs (name, args) =
        case args
         of [x] => {outPutType = Histogram{xkey = x}, pdfFile = "outPutHistogram.pdf", dbFile = "db"}
          | [x, y] => {outPutType = Plot{xkey = x, ykey = y}, pdfFile = "out.pdf", dbFile = "db"}
          | [x, y, pdfFile] => {outPutType = Plot{xkey = x, ykey = y}, pdfFile = pdfFile, dbFile = "db"}
          | [x, y, pdfFile, dbFile] => {outPutType = Plot{xkey = x, ykey = y}, pdfFile = pdfFile, dbFile = dbFile}
          | _ => raise Abort ("usage: " ^ name ^ " xkey ykey [pdf[db]] or xkey\n");

    fun createQuery {xkey, ykey, ...} =
        fn db => _sql select #x.size as x, #y.size as y
                                                   from #db.files as x
                                                   join #db.files as y
                                                   on #x.name = #y.name
                                                                    where (#x.suffix = xkey and #y.suffix = ykey);

    fun fetchData {dbFile, ...} query =
       let
           val db = _sqlserver SQL.sqlite3 dbFile : schema
           val c = SQL.connect db
           val data = SQL.fetchAll (query c)
           val _ = SQL.closeConn c
       in
           map (fn {x, y} => {x = real x, y = real y}) data
       end;

    fun createQueryHistogram {xkey, ...} =
        fn db => _sql select #x.size as x
                      from #db.files as x
                                       where (#x.suffix = xkey);

    fun fetchDataHistogram {dbFile, ...} query =
       let
           val db = _sqlserver SQL.sqlite3 dbFile : schema
           val c = SQL.connect db
           val data = SQL.fetchAll (query c)
           val _ = SQL.closeConn c
       in
           map (fn {x} => {x = real x}) data
       end;


    fun main (name, args) =
        let
            val args as {outPutType, pdfFile, ...} = parseArgs (name, args)
            val graph = case outPutType
                         of Histogram {xkey} =>
                            let
                                val query = createQueryHistogram {xkey = xkey}
                                val data = fetchDataHistogram args (_sql db => select...(query db))
                            in
                                Graph.histogram data
                            end
                          | Plot{xkey, ykey} =>
                            let
                                val query = createQuery {xkey = xkey, ykey = ykey}
                                val data = fetchData args (_sql db => select...(query db))
                            in
                                Graph.plot data
                            end

        in
            Draw.toPDF pdfFile graph;
            OS.Process.success
        end
        handle Abort s =>
               (TextIO.output (TextIO.stdErr, s);
                OS.Process.failure);
end
