datatype json
    = BOOL of bool
    | NUMBER of string
    | STRING of string
    | NULL
    | ARRAY of json list
    | OBJECT of (string * json) list;
