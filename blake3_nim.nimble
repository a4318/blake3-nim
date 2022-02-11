# Package

version       = "0.1.0"
author        = "a4318"
description   = "Nim wrapper for blake3"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.4"


task cargo, "build rust_blake3_c_bindings":
  cd("src/blake3rs")
  exec("cargo build --release --target x86_64-pc-windows-gnu")
  exec("cbindgen --lang c --output blake3_bindings.h")
  cpFile("target/x86_64-pc-windows-gnu/release/libblake3rs.a","../../lib/libblake3rs.a")
  cpFile("blake3_bindings.h","../../lib/blake3_bindings.h")
