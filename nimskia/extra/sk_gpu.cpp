#include "include/gpu/GrBackendSurface.h"
#include "include/gpu/GrContext.h"
#include "include/gpu/gl/GrGLInterface.h"
#include "src/gpu/gl/GrGLUtil.h"
#include "src/gpu/gl/GrGLDefines.h"
#include "include/core/SkColorSpace.h"
#include "include/core/SkImageInfo.h"
#include "include/core/SkSurface.h"

#include "include/c/sk_surface.h"
#include "src/c/sk_types_priv.h"

#include "include/c/sk_gpu.h"
#include "include/c/sk_colorspace.h"
#include "include/c/sk_imageinfo.h"

GrContext* sContext;

void flush_gr_context() {
  sContext->flush();
}

sk_surface_t* sk_surface_new_from_backend_render_target(int dw, int dh) {
    sContext = GrContext::MakeGL().release();
    GrGLFramebufferInfo framebufferInfo;
    framebufferInfo.fFBOID = 0; 
    framebufferInfo.fFormat = GR_GL_RGBA8;

    SkColorType colorType;
    colorType = kRGBA_8888_SkColorType;
    
    GrBackendRenderTarget backendRenderTarget(dw, dh,
      0, 
      0,
      framebufferInfo);

    SkSurface* sSurface = SkSurface::MakeFromBackendRenderTarget(
      sContext, 
      backendRenderTarget, 
      kBottomLeft_GrSurfaceOrigin, 
      colorType, 
      nullptr, 
      nullptr).release();
      
    return (sk_surface_t*) sSurface;
}
