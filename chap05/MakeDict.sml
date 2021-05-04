structure MakeDict =
struct
    exception Empty
    type ('key, 'value) dict = ('key * 'value) list
    fun makeDict comp = 
            let
                val empty = nil
                fun find (dict, key) = 
                        case dict of
                            nil => raise Empty
                        | ((k, v) :: tl) => 
                            (case comp(k, key) of
                                    EQUAL => v
                                | _ => find (tl, key))
                fun enter ((k, v), dict) = (k, v) :: dict

            in
                {empty = empty, find = find, enter = enter}
            end
end