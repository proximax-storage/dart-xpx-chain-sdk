/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

abstract class AssetId {
  const AssetId(this.value);

  final Uint64 value;

  @override
  String toString() => encoder.convert(this);

  String toJson() => value.toHexString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AssetId && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => 'Id'.hashCode ^ value.hashCode;

  String toHex() {
    var s = value.toHexString().toUpperCase();
    if (s.length % 2 != 0) {
      s = '0$s';
    }
    return s;
  }

  List<int> toIntArray() => value.toIntArray();

  Uint64? toUint64() => value;

  Uint8List toBytes() => value.toBytes();
}
