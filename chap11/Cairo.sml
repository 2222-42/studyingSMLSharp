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
    val cairo_surface_destroy =
        _import "cairo_surface_destroy" : cairo_surface_t -> ();


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
    val cairo_destroy =
        _import "cairo_destroy" : cairo_t -> ();
    val cairo_save =
        _import "cairo_save" : cairo_t -> ();
    val cairo_restore = _import "cairo_restore" : cairo_t -> ();
    val cairo_fill = _import "cairo_fill" : cairo_t -> ();
    val cairo_stroke = _import "cairo_stroke" : cairo_t -> ();
    val cairo_paint = _import "cairo_paint" : cairo_t -> ();
    val cairo_set_source_rgb = _import "cairo_set_source_rgb" : (cairo_t, real, real, real) -> ();
    val cairo_set_line_width = _import "cairo_set_line_width" : (cairo_t, real) -> ();
    val cairo_new_sub_path = _import "cairo_new_sub_path" : cairo_t -> ();
    val cairo_move_to = _import "cairo_move_to" : (cairo_t, real, real) -> ();
    val cairo_line_to = _import "cairo_line_to" : (cairo_t, real, real) -> ();
    val cairo_rectangle = _import "cairo_rectangle" : (cairo_t, real, real, real, real) -> ();
    val cairo_arc = _import "cairo_arc" : (cairo_t, real, real, real, real, real) -> ();
    val cairo_set_font_size = _import "cairo_set_font_size": (cairo_t, real) -> ();

    val cairo_text_extents_ORIG =
        _import "cairo_text_extents" : (cairo_t, string, real array) -> ();
    fun cairo_text_extents (c,s,a) =
        (if Array.length a = 6 then () else raise Size;
         cairo_text_extents_ORIG(c,s,a));

    val cairo_text_path = _import "cairo_text_path" : (cairo_t, string) -> ();
    val cairo_translate = _import "cairo_translate" : (cairo_t, real, real) -> ();
    val cairo_scale = _import "cairo_scale" : (cairo_t, real, real) -> ();
    val cairo_rotate = _import "cairo_rotate" : (cairo_t, real) -> ();

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
