#ifndef sk_gpu_DEFINED
#define sk_gpu_DEFINED

#include "sk_types.h" 
#include "sk_imageinfo.h"
SK_C_PLUS_PLUS_BEGIN_GUARD

SK_API sk_surface_t* sk_surface_new_from_backend_render_target(
  int dw, int dh
);

SK_API void flush_gr_context();

SK_C_PLUS_PLUS_END_GUARD

#endif
