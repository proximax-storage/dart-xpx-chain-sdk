part of nem2_sdk_dart;

final RegExp regValidNamespace = new RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);
//final RegExp regValidMosaicName = new RegExp(r"(^[a-z0-9][a-z0-9-_]*$)");

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

int EndianLittleUint32(List<int> v) {
  var z = new Uint8List(4);
  for (int i = 0; i < 4; i++) z[i] = v[i];

  var bdata = new ByteData.view(z.buffer);
  return bdata.getUint32(0, Endian.little);
}

List<int> FromBigInt(BigInt v) {
  List<int> i = [];
  final u64 = v.toInt();
  final l = (u64 & 0xFFFFFFFF);
  final r = (u64 >> 32);
  i.add(l);
  i.add(r);
  return i;
}

String IntToHex(int u) {
  var raw = integerToBytes(u, 4).reversed;
  return HEX.encode(raw.toList());
}

String BigIntegerToHex(BigInt id){
  var u = FromBigInt(id);
  return IntToHex(u[1]) + IntToHex(u[0]);
}

Uint8List integerToBytes(int e, int length) {
  var byteList = new Uint8List(length);
  for (var i = 0; i < length; i++) {
    byteList[0 + i] = (e >> (i * 8));
  }
  ;
  return byteList;
}
