# Home-manager settings that only make sense on this computer.
{ ... }:

{
  # Force the NVIDIA EGL vendor; breaks EGL on non-NVIDIA machines.
  home.sessionVariables.__EGL_VENDOR_LIBRARY_FILENAMES =
    "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
}
