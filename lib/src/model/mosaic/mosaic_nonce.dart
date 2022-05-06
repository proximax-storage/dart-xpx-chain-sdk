/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.mosaic;

/// The mosaic nonce structure.
class MosaicNonce {
  static const int nonceSize = 4;

  /// The nonce.
  final Uint8List nonce;

  MosaicNonce._(this.nonce);

  factory MosaicNonce(final Uint8List nonce) {
    ArgumentError.checkNotNull(nonce);

    if (nonceSize != nonce.length) {
      throw new ArgumentError(
          'Invalid nonce size. The nonce should be $nonceSize bytes but received: ${nonce.length}');
    }

    return new MosaicNonce._(nonce);
  }

  /// Creates a random MosaicNonce.
  static MosaicNonce random() => MosaicNonce(randombytes(4));

  // /// Creates a MosaicNonce from a [hex] string.
  // static MosaicNonce fromHex(final String hex) {
  //   if (!HexUtils.isHex(hex)) {
  //     throw new ArgumentError('invalid hex string');
  //   }
  //
  //   return MosaicNonce(HexUtils.getBytes(hex));
  // }

  /// Creates a [MosaicNonce] from a [Uint64] value.
  static MosaicNonce fromUint64(final Uint64 uint64) {
    final List<int> intArray = uint64.toIntArray();
    final int lower = intArray[0];
    final Uint8List bytes = _intToBytes(lower);

    return MosaicNonce._(bytes);
  }

  static MosaicNonce fromInt(final int value) =>
      fromUint64(Uint64.fromInt(value));

  /// Converts the nonce bytes to a hex string.
  String toHex() => HexUtils.getString(nonce);

  /// Converts the nonce bytes to a 32-bit [int] value.
  int toInt() => _bytesToInt(nonce);

  // for internal use
  Uint8List toDTO() => nonce;

  // ------------------------------- private / protected functions ------------------------------ //

  static Uint8List _intToBytes(int value) {
    final List<int> result = List<int>.filled(4, 0);
    result[0] = value & 0xff;
    result[1] = (value >> 8) & 0xff;
    result[2] = (value >> 16) & 0xff;
    result[3] = (value >> 24) & 0xff;
    return Uint8List.fromList(result);
  }

  static int _bytesToInt(Uint8List bytes) {
    int lower = bytes[3] & 0xff;
    lower <<= 8;
    lower |= bytes[2] & 0xff;
    lower <<= 8;
    lower |= bytes[1] & 0xff;
    lower <<= 8;
    lower |= bytes[0] & 0xff;
    return lower;
  }

  @override
  String toString() => encoder.convert(this);

  int toJson() => toInt();
}
