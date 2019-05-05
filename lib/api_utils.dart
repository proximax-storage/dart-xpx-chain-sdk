part of nem2_sdk_dart;

// HexDecodeStringOdd return padding hex representation of string
Uint8List HexDecodeStringOdd(String s) {
  if (s.length % 2 != 0) {
    s = "0" + s;
  }
  return HEX.decode(s);
}

// ExtractNetworkType return networkType from version
int ExtractNetworkType(int version) {
  var buffer = new Uint8List(8).buffer;
  var bdata = new ByteData.view(buffer);
  bdata.setInt64(0, version, Endian.little);
  return bdata.getUint8(1);
}