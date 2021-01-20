part of xpx_chain_sdk.transaction;

abstract class AssetId {
  const AssetId(this.value);

  final Uint64 value;

  @override
  String toString() => value.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AssetId && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => 'Id'.hashCode ^ value.hashCode;

  String toHex() {
    if (value == null) {
      return null;
    }

    var s = value.toHex().toUpperCase();
    if (s.length % 2 != 0) {
      s = '0$s';
    }
    return s;
  }

  List<int> toIntArray() => value.toIntArray();

  Uint64 toUint64() => value;

  Uint8List toBytes() => value.toBytes();
}
