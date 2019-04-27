part of nem2_sdk_dart;

// HexDecodeStringOdd return padding hex representation of string
Uint8List HexDecodeStringOdd(String s) {
  if (s.length % 2 != 0) {
    s = "0" + s;
  }
  return HEX.decode(s);
}
