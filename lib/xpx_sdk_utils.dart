part of xpx_catapult_sdk;

final RegExp regValidNamespace = new RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);

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
  bdata.setUint64(0, version, Endian.little);
  return bdata.getUint8(1);
}

int ExtractVersion(int version) {
  var buffer = new Uint8List(8).buffer;
  var bdata = new ByteData.view(buffer);
  bdata.setUint64(0, version, Endian.little);
  return bdata.getUint8(0);
}

int EndianLittleUint32(List<int> v) {
  var z = new Uint8List(4);
  for (int i = 0; i < 4; i++) z[i] = v[i];

  var bdata = new ByteData.view(z.buffer);
  return bdata.getUint32(0, Endian.little);
}

List<Int64> FromBigInt(BigInt v) {
  final u64 = new Int64.fromBytesBigEndian(crypto.encodeBigInt(v));
  final l = (u64 & 0xFFFFFFFF);
  final r = (u64 >> 32);
  return [l, r];
}

String _intToHex(int u) {
  var raw = integerToBytes(u, 4).reversed;
  return HEX.encode(raw.toList());
}

String bigIntegerToHex(BigInt id) {
  if (id == null) {
    return null;
  }

  var u = FromBigInt(id);
  return _intToHex(u[1].toInt()) + _intToHex(u[0].toInt());
}

int bytesToInteger(List<int> bytes) {
  num value = 0;
  bytes = bytes.sublist(0, 32);
  for (var i = 0; i < bytes.length; i++) {
    value += bytes[i] * pow(256, i);
  }
  ;
  return value.toInt();
}

Uint8List integerToBytes(int e, int length) {
  var byteList = new Uint8List(length);
  for (var i = 0; i < length; i++) {
    byteList[0 + i] = (e >> (i * 8));
  }
  ;
  return byteList;
}

bool EqualsBigInts(BigInt first, second) {
  if (first == null && second == null) {
    return true;
  }

  if (first != null) {
    return (first.compareTo(second) == 0);
  }

  return (second.compareTo(first) == 0);
}

Uint8List addUint8List(Uint8List a, Uint8List b) {
  Uint8List hash = Uint8List(b.length + a.length);
  for (int i = 0; i < a.length; i++) hash[i] = a[i];
  for (int i = 0; i < b.length; i++) hash[i + a.length] = b[i];
  return hash;
}