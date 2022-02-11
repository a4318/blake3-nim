{.push header:"../lib/blake3_bindings.h".}

type
  blake3_hasher* {.incompleteStruct.} = object
proc blake3_hasher_new*(): ptr blake3_hasher
proc blake3_hasher_reset*(hasher: ptr blake3_hasher)
proc blake3_hasher_update*(hasher: ptr blake3_hasher; buf: ptr uint8;
                           len: ptr uint)
proc blake3_hasher_update*(hasher: ptr blake3_hasher; buf: pointer;
                           len: ptr uint)
proc blake3_hasher_finalize*(hasher: ptr blake3_hasher;
                             output: ptr array[32, uint8])
proc blake3_hasher_free*(hasher: ptr blake3_hasher)

{.pop.}

{.passL: "../lib/libblake3rs.a".}

import strutils
import memfiles

func toString32*(bytes: openArray[byte]): string {.inline.} =
  ## Converts a byte sequence to the corresponding string.
  let length = 32
  result = newString(length)
  copyMem(result.cstring, bytes[0].unsafeAddr, length)

proc hash*(fBuf: ptr uint8, fsizeaddr:ptr uint) : string =
  var hasher: ptr blake3_hasher = blake3_hasher_new()
  blake3_hasher_update(hasher, fBuf, fsizeaddr)
  var outs : array[32, uint8]
  blake3_hasher_finalize(hasher, outs.addr)
  result = outs.toString32.toHex
  blake3_hasher_free(hasher)

proc hash*(fBuf: pointer, fsizeaddr:ptr uint) : string =
  var hasher: ptr blake3_hasher = blake3_hasher_new()
  blake3_hasher_update(hasher, fBuf, fsizeaddr)
  var outs : array[32, uint8]
  blake3_hasher_finalize(hasher, outs.addr)
  result = outs.toString32.toHex
  blake3_hasher_free(hasher)

proc hash*(filename: string) : string =
  let f = memfiles.open(filename, mode = fmRead, mappedSize = -1)
  return hash(f.mem, cast[ptr uint](f.size))
