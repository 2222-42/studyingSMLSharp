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

end
