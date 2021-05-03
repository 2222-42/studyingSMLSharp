datatype json
    = BOOL of bool
| NUMBER of string
| STRING of string
| NULL
| ARRAY of json list
| OBJECT of (string * json) list;

fun copyJson json =
        case json of
            BOOL bool => BOOL bool
        | NUMBER string => NUMBER string
        | STRING string => STRING string
        | NULL => NULL
        | ARRAY jsonList => ARRAY (map copyJson jsonList)
        | OBJECT stringJsonList => OBJECT (map (fn (string, json) => (string, copyJson json)) stringJsonList);
    
fun serializeJson json = 
        let
            fun quoteString string = "\"" ^ string ^ "\""
            fun toArray stringList = "[" ^ String.concatWith ", " stringList ^ "]"
            fun toObject stringStringList = 
                    "{" 
                    ^ String.concatWith ", " (map (fn (s1, s2) => quoteString s1 ^ ":" ^ s2) stringStringList) 
                    ^ "}"
        in
            case json of
                BOOL bool => Bool.toString bool
            | NUMBER string => string
            | STRING string => quoteString string
            | NULL => "NULL"
            | ARRAY jsonList => toArray (map serializeJson jsonList)
            | OBJECT stringJsonList => toObject (map (fn (string, json) => (string, serializeJson json)) stringJsonList)
        end;

val testJson = OBJECT [("key1", NUMBER "1"), ("key2", STRING "2"), ("array", ARRAY [BOOL true,OBJECT[("key1", NUMBER "1"), ("key2", STRING "2")],NULL])];
val result = serializeJson testJson;