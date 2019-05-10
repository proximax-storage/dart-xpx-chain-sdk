part of xpx_catapult_sdk;

/// Buffer wraps a fixed size Uint8List and writes values into it using
/// big-endian byte order.
abstract class Buffer {
  /// Output buffer.
  final Uint8List out;

  /// Current position within [out].
  var position = 0;

  Buffer._create(this.out);

  factory Buffer.BigEndian(size) {
    final out = new Uint8List(size);
    return new _WriterForBEHost._create(out);
  }

  factory Buffer.LittleEndian(size) {
    final out = new Uint8List(size);
    return new _WriterForLEHost._create(out);
  }

  writeInt32(int v);

  writeInt16(int v);

  writeInt8(int v) {
    out[position] = v;
    position++;
  }

  writeFloat64(double v);

  writeFloat32(double v);

  writeString(String str) {
    out.setAll(position, str.codeUnits);
    position += str.codeUnits.length;
  }

  /// Decode a BigInt from bytes in big-endian encoding.
  BigInt toBigInt() {
    BigInt result = new BigInt.from(0);
    for (int i = 0; i < this.out.length; i++) {
      result += new BigInt.from(this.out[this.out.length - i - 1]) << (8 * i);
    }
    return result;
  }
}

/// Lists used for data convertion (alias each other).
final Uint8List _convU8 = new Uint8List(8);
final Float32List _convF32 = new Float32List.view(_convU8.buffer);
final Float64List _convF64 = new Float64List.view(_convU8.buffer);

/// Writer used on little-endian host.
class _WriterForLEHost extends Buffer {
  _WriterForLEHost._create(out) : super._create(out);

  writeInt16(int v) {
    out[position + 0] = v;
    out[position + 1] = (v >> 8);
    position += 2;
  }

  writeInt32(int v) {
    out[position + 0] = v;
    out[position + 1] = (v >> 8);
    out[position + 2] = (v >> 16);
    out[position + 3] = (v >> 24);
    position += 4;
  }

  writeFloat64(double v) {
    _convF64[0] = v;
    out[position + 7] = _convU8[0];
    out[position + 6] = _convU8[1];
    out[position + 5] = _convU8[2];
    out[position + 4] = _convU8[3];
    out[position + 3] = _convU8[4];
    out[position + 2] = _convU8[5];
    out[position + 1] = _convU8[6];
    out[position + 0] = _convU8[7];
    position += 8;
  }

  writeFloat32(double v) {
    _convF32[0] = v;
    out[position + 3] = _convU8[0];
    out[position + 2] = _convU8[1];
    out[position + 1] = _convU8[2];
    out[position + 0] = _convU8[3];
    position += 4;
  }
}

/// Writer used on the big-endian host.
class _WriterForBEHost extends Buffer {
  _WriterForBEHost._create(out) : super._create(out);

  writeInt32(int v) {
    out[position + 3] = v;
    out[position + 2] = (v >> 8);
    out[position + 1] = (v >> 16);
    out[position + 0] = (v >> 24);
    position += 4;
  }

  writeInt16(int v) {
    out[position + 1] = v;
    out[position + 0] = (v >> 8);
    position += 2;
  }

  writeFloat64(double v) {
    _convF64[0] = v;
    out[position + 0] = _convU8[0];
    out[position + 1] = _convU8[1];
    out[position + 2] = _convU8[2];
    out[position + 3] = _convU8[3];
    out[position + 4] = _convU8[4];
    out[position + 5] = _convU8[5];
    out[position + 6] = _convU8[6];
    out[position + 7] = _convU8[7];
    position += 8;
  }

  writeFloat32(double v) {
    _convF32[0] = v;
    out[position + 0] = _convU8[0];
    out[position + 1] = _convU8[1];
    out[position + 2] = _convU8[2];
    out[position + 3] = _convU8[3];
    position += 4;
  }
}