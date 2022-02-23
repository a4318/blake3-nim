before install: #, "build rust_blake3_c_bindings"
  cd("src/blake3rs")
  exec("git submodule update --init")
  exec("cargo build --release --target x86_64-pc-windows-gnu")
  cpFile("target/x86_64-pc-windows-gnu/release/libblake3rs.a","../lib/libblake3rs.a")
