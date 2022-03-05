# blake3-nim

blake3-nim is a wrapper for the [blake3](https://github.com/BLAKE3-team/BLAKE3) library for windows using [rust_blake3_c_bindings](https://github.com/zmeyc/rust_blake3_c_bindings).

To build:
To get submodule dependencies:

```git submodule update --init --recursive```

Build rust_blake3_c_bindings

```nimble cargo```

Finally

```nimble build```
