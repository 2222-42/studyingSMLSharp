structure Cairo =
struct
    exception Error of string;
    type cairo_surface_t = unit ptr;
    type cairo_status_t = int;
    val CAIRO_STATUS_SUCCESS = 0;
    val cairo_surface_status =
        _import "cairo_surface_status": cairo_surface_t -> cairo_status_t;
    val cairo_status_to_string_ORIG =
        _import "cairo_status_to_string" : cairo_status_t -> char ptr;
    fun cairo_status_to_string status =
        Pointer.importString (cairo_status_to_string_ORIG status); (* this is inheritted rom ffi.smi *)
    fun checkSurface s =
        let
            val r = cairo_surface_status s
        in
            if r = CAIRO_STATUS_SUCCESS then s
            else raise Error (cairo_status_to_string r)
        end;
    val cairo_pdf_surface_create_ORIG =
        _import "cairo_pdf_surface_create" : (string, real, real) -> cairo_surface_t;
    fun cairo_pdf_surface_create arg =
        checkSurface (cairo_pdf_surface_create_ORIG arg);
    type cairo_t = unit ptr;
    val cairo_status =
        _import "cairo_status" : cairo_t -> cairo_status_t;
    fun cairoCheck c =
        let
            val r = cairo_status c
        in
            if r = CAIRO_STATUS_SUCCESS
            then c else raise Error (cairo_status_to_string r)
        end;
    val cairo_create_ORIG =
        _import "cairo_create" : cairo_surface_t -> cairo_t;
    fun cairo_create arg =
        cairoCheck (cairo_create_ORIG arg);

    val cairo_text_extents_ORIG =
        _import "cairo_text_extents" : (cairo_t, string, real array) -> ();
    fun cairo_text_extents (c,s,a) =
        (if Array.length a = 6 then () else raise Size;
         cairo_text_extents_ORIG(c,s,a));

    type cairo_surface_t_ =
         cairo_surface_t * (word8 vector -> cairo_status_t);
    val 'a#boxed cairo_pdf_surface_create_for_stream_ORIG =
        _import "cairo_pdf_surface_create_for_stream"
        : (('a, word8 ptr, word) -> cairo_status_t, 'a, real, real) -> cairo_surface_t;
    fun cairo_pdf_surface_create_for_stream_CALLBACK (f, y, z) =
        f (Pointer.importBytes (y, Word.toInt z));
    fun cairo_pdf_surface_create_for_stream (f, x, y) =
        (cairo_pdf_surface_create_for_stream_ORIG
             (cairo_pdf_surface_create_for_stream_CALLBACK, f, x, y),
         f) : cairo_surface_t_;
    (* TODO: cairo_surface_t *型の引数を受け取る関数をcairo_surface_t_型を受け取るようにインポートし定義するのは後でやる*)

end
