part of xpx_chain_sdk;

final RegExp regValidNamespace = RegExp(
  r'^[a-zA-Z0-9]+$',
  caseSensitive: false,
  multiLine: false,
);

// hexDecodeStringOdd return padding hex representation of string
Uint8List hexDecodeStringOdd(final String s) {
  String data = s;
  if (s.length % 2 != 0) {
    data = '0$s';
  }
  return Uint8List.fromList(hex.decode(data));
}

// extractNetworkType return networkType from version
int extractNetworkType(int version) => version.toUnsigned(32) >> 24;

int extractVersion(int version) {
  final buffer = Uint8List(8).buffer;
  final bufferData = ByteData.view(buffer)
    ..setUint64(0, version, Endian.little);
  return bufferData.getUint8(0);
}

int endianLittleUint32(List<int> v) {
  final z = Uint8List(4);
  for (int i = 0; i < 4; i++) {
    z[i] = v[i];
  }

  final bufferData = ByteData.view(z.buffer);
  return bufferData.getUint32(0, Endian.little);
}

String bigIntegerToHex(BigInt id) {
  if (id == null) {
    return null;
  }

  var s = id.toRadixString(16).toUpperCase();
  if (s.length % 2 != 0) {
    s = '0$s';
  }

  return s;
}

int bytesToInteger(List<int> data) {
  num value = 0;
  // ignore: parameter_assignments
  final bytes = data.sublist(0, 32);
  for (var i = 0; i < bytes.length; i++) {
    value += bytes[i] * pow(256, i);
  }
  return value.toInt();
}

Uint8List integerToBytes(int e, int length) {
  final byteList = Uint8List(length);
  for (var i = 0; i < length; i++) {
    byteList[0 + i] = e >> (i * 8);
  }

  return byteList;
}

bool equalsBigInts(BigInt first, BigInt second) {
  if (first == null && second == null) {
    return true;
  }

  if (first != null) {
    return first.compareTo(second) == 0;
  }

  return second.compareTo(first) == 0;
}

Uint8List addUint8List(Uint8List a, Uint8List b) {
  if (a == null) {
    return b;
  }

  final Uint8List hash = Uint8List(b.length + a.length);
  for (int i = 0; i < a.length; i++) {
    hash[i] = a[i];
  }

  for (int i = 0; i < b.length; i++) {
    hash[i + a.length] = b[i];
  }

  return hash;
}

List<int> bigIntToArray(BigInt v) {
  if (v == null) {
    return [0, 0];
  }
  final l = v.toUnsigned(32);
  final r = (v >> 32).toUnsigned(32);

  return List<int>.from([l.toInt(), r.toInt()]);
}

List<int> fromBigInt(BigInt v) {
  if (v == null) {
    return [0, 0];
  }

  final u64 = v.toInt();
  final List<int> r = List(2);
  r[0] = u64 & 0xFFFFFFFF;
  r[1] = u64 >> 32;

  return r;
}

List<int> bigIntToList(BigInt v) {
  final u64 = Int64.fromBytesBigEndian(crypto.encodeBigInt(v));

  final l = u64 & 0xFFFFFFFF;
  final r = u64 >> 32 & 0xFFFFFFFF;
  return [l.toInt(), r.toInt()];
}

bool hasBits(BigInt number, int bits) => number.toInt() & bits == bits;
