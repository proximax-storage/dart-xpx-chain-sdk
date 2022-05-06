// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class MetadataV2transactionBuffer {
  MetadataV2transactionBuffer._(this._bc, this._bcOffset);
  factory MetadataV2transactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<MetadataV2transactionBuffer> reader =
      _MetadataV2transactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);
  List<int>? get signature =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get signer =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);
  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);
  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);
  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 14);
  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 16);
  List<int>? get targetKey =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 18);
  List<int>? get scopedMetadataKey =>
      const fb.ListReader<int>(fb.Uint32Reader())
          .vTableGetNullable(_bc, _bcOffset, 20);

  ///  In case of address it is empty array. In case of mosaic or namespace id it is 8 byte array(or 2 uint32 array)
  List<int>? get targetId =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 22);
  List<int>? get valueSizeDelta =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 24);
  List<int>? get valueSize =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 26);
  List<int>? get value =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 28);

  @override
  String toString() {
    return 'MetadataV2transactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, targetKey: ${targetKey}, scopedMetadataKey: ${scopedMetadataKey}, targetId: ${targetId}, valueSizeDelta: ${valueSizeDelta}, valueSize: ${valueSize}, value: ${value}}';
  }
}

class _MetadataV2transactionBufferReader
    extends fb.TableReader<MetadataV2transactionBuffer> {
  const _MetadataV2transactionBufferReader();

  @override
  MetadataV2transactionBuffer createObject(fb.BufferContext bc, int offset) =>
      MetadataV2transactionBuffer._(bc, offset);
}

class MetadataV2transactionBufferBuilder {
  MetadataV2transactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(13);
  }

  int addSize(int? size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addSignatureOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addSignerOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addVersion(int? version) {
    fbBuilder.addUint32(3, version);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint16(4, type);
    return fbBuilder.offset;
  }

  int addMaxFeeOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int? offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addTargetKeyOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addScopedMetadataKeyOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addTargetIdOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int addValueSizeDeltaOffset(int? offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int addValueSizeOffset(int? offset) {
    fbBuilder.addOffset(11, offset);
    return fbBuilder.offset;
  }

  int addValueOffset(int? offset) {
    fbBuilder.addOffset(12, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class MetadataV2transactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _targetKey;
  final List<int>? _scopedMetadataKey;
  final List<int>? _targetId;
  final List<int>? _valueSizeDelta;
  final List<int>? _valueSize;
  final List<int>? _value;

  MetadataV2transactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? targetKey,
    List<int>? scopedMetadataKey,
    List<int>? targetId,
    List<int>? valueSizeDelta,
    List<int>? valueSize,
    List<int>? value,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _targetKey = targetKey,
        _scopedMetadataKey = scopedMetadataKey,
        _targetId = targetId,
        _valueSizeDelta = valueSizeDelta,
        _valueSize = valueSize,
        _value = value;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset =
        _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset =
        _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset =
        _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset =
        _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? targetKeyOffset =
        _targetKey == null ? null : fbBuilder.writeListUint8(_targetKey!);
    final int? scopedMetadataKeyOffset = _scopedMetadataKey == null
        ? null
        : fbBuilder.writeListUint32(_scopedMetadataKey!);
    final int? targetIdOffset =
        _targetId == null ? null : fbBuilder.writeListUint8(_targetId!);
    final int? valueSizeDeltaOffset = _valueSizeDelta == null
        ? null
        : fbBuilder.writeListUint8(_valueSizeDelta!);
    final int? valueSizeOffset =
        _valueSize == null ? null : fbBuilder.writeListUint8(_valueSize!);
    final int? valueOffset =
        _value == null ? null : fbBuilder.writeListUint8(_value!);
    fbBuilder.startTable(13);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, targetKeyOffset);
    fbBuilder.addOffset(8, scopedMetadataKeyOffset);
    fbBuilder.addOffset(9, targetIdOffset);
    fbBuilder.addOffset(10, valueSizeDeltaOffset);
    fbBuilder.addOffset(11, valueSizeOffset);
    fbBuilder.addOffset(12, valueOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}
