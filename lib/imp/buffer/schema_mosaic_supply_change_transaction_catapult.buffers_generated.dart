// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class MosaicSupplyChangeTransactionBuffer {
  MosaicSupplyChangeTransactionBuffer._(this._bc, this._bcOffset);
  factory MosaicSupplyChangeTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<MosaicSupplyChangeTransactionBuffer> reader =
      _MosaicSupplyChangeTransactionBufferReader();

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
  List<int>? get mosaicId => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 18);
  int get direction => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 20, 0);
  List<int>? get delta => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 22);

  @override
  String toString() {
    return 'MosaicSupplyChangeTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, mosaicId: ${mosaicId}, direction: ${direction}, delta: ${delta}}';
  }
}

class _MosaicSupplyChangeTransactionBufferReader
    extends fb.TableReader<MosaicSupplyChangeTransactionBuffer> {
  const _MosaicSupplyChangeTransactionBufferReader();

  @override
  MosaicSupplyChangeTransactionBuffer createObject(
          fb.BufferContext bc, int offset) =>
      MosaicSupplyChangeTransactionBuffer._(bc, offset);
}

class MosaicSupplyChangeTransactionBufferBuilder {
  MosaicSupplyChangeTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(10);
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

  int addMosaicIdOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addDirection(int? direction) {
    fbBuilder.addUint8(8, direction);
    return fbBuilder.offset;
  }

  int addDeltaOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class MosaicSupplyChangeTransactionBufferObjectBuilder
    extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _mosaicId;
  final int? _direction;
  final List<int>? _delta;

  MosaicSupplyChangeTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? mosaicId,
    int? direction,
    List<int>? delta,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _mosaicId = mosaicId,
        _direction = direction,
        _delta = delta;

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
    final int? mosaicIdOffset =
        _mosaicId == null ? null : fbBuilder.writeListUint32(_mosaicId!);
    final int? deltaOffset =
        _delta == null ? null : fbBuilder.writeListUint32(_delta!);
    fbBuilder.startTable(10);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, mosaicIdOffset);
    fbBuilder.addUint8(8, _direction);
    fbBuilder.addOffset(9, deltaOffset);
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