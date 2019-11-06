let
  nixpkgs = import <nixpkgs> {};
in
  with nixpkgs;
  nixpkgs.mkShell {
    name = "dev_shell";
    buildInputs = [
      rustc
      cargo
      rls
      rustPackages.clippy
      rustfmt

      alsaLib
      cmake
      freetype
      expat
      openssl
      pkgconfig
      python3
      vulkan-validation-layers
      xlibs.libX11
      vulkan-tools
      sccache
    ];

    RUST_BACKTRACE = 1;
    APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
      vulkan-loader
      xlibs.libXcursor
      xlibs.libXi
      xlibs.libXrandr
    ];

    shellHook = ''
      export PATH="~/.cargo/bin:$PATH"
      export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
    '';
  }
