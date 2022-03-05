# Package

version       = "0.1.0"
author        = "a4318"
description   = "Nim wrapper for blake3"
license       = "MIT"
srcDir        = "src"
skipDirs      = @["blake3_nim", "blake3rs"]


# Dependencies

requires "nim >= 1.6.4"


before install: #, "build rust_blake3_c_bindings"
  cd("src/blake3rs")
  exec("git submodule update --init")
  exec("cargo build --release --target x86_64-pc-windows-gnu")
  cpFile("target/x86_64-pc-windows-gnu/release/libblake3rs.a","../libblake3rs.a")
