// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class MetadataModificationBuffer {
  MetadataModificationBuffer._(this._bc, this._bcOffset);

  factory MetadataModificationBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<MetadataModificationBuffer> reader = _MetadataModificationBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  int get modificationType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 6, 0);

  int get keySize => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 8, 0);

  List<int>? get valueSize => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 10);

  List<int>? get key => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 12);

  List<int>? get value => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 14);

  @override
  String toString() {
    return 'MetadataModificationBuffer{size: ${size}, modificationType: ${modificationType}, keySize: ${keySize}, valueSize: ${valueSize}, key: ${key}, value: ${value}}';
  }
}

class _MetadataModificationBufferReader extends fb.TableReader<MetadataModificationBuffer> {
  const _MetadataModificationBufferReader();

  @override
  MetadataModificationBuffer createObject(fb.BufferContext bc, int offset) => MetadataModificationBuffer._(bc, offset);
}

class MetadataModificationBufferBuilder {
  MetadataModificationBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(6);
  }

  int addSize(int? size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addModificationType(int? modificationType) {
    fbBuilder.addUint8(1, modificationType);
    return fbBuilder.offset;
  }

  int addKeySize(int? keySize) {
    fbBuilder.addUint8(2, keySize);
    return fbBuilder.offset;
  }

  int addValueSizeOffset(int? offset) {
    fbBuilder.addOffset(3, offset);
    return fbBuilder.offset;
  }

  int addKeyOffset(int? offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int addValueOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class MetadataModificationBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final int? _modificationType;
  final int? _keySize;
  final List<int>? _valueSize;
  final List<int>? _key;
  final List<int>? _value;

  MetadataModificationBufferObjectBuilder({
    int? size,
    int? modificationType,
    int? keySize,
    List<int>? valueSize,
    List<int>? key,
    List<int>? value,
  })  : _size = size,
        _modificationType = modificationType,
        _keySize = keySize,
        _valueSize = valueSize,
        _key = key,
        _value = value;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? valueSizeOffset = _valueSize == null ? null : fbBuilder.writeListUint8(_valueSize!);
    final int? keyOffset = _key == null ? null : fbBuilder.writeListUint8(_key!);
    final int? valueOffset = _value == null ? null : fbBuilder.writeListUint8(_value!);
    fbBuilder.startTable(6);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addUint8(1, _modificationType);
    fbBuilder.addUint8(2, _keySize);
    fbBuilder.addOffset(3, valueSizeOffset);
    fbBuilder.addOffset(4, keyOffset);
    fbBuilder.addOffset(5, valueOffset);
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

class ModifyMetadataTransactionBuffer {
  ModifyMetadataTransactionBuffer._(this._bc, this._bcOffset);

  factory ModifyMetadataTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ModifyMetadataTransactionBuffer> reader = _ModifyMetadataTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  int get metadataType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  ///  In case of address it is 25 bytes array. In case of mosaic or namespace it is 8 byte array(or 2 uint32 array)
  List<int>? get metadataId => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 20);

  List<MetadataModificationBuffer>? get modifications =>
      const fb.ListReader<MetadataModificationBuffer>(MetadataModificationBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 22);

  @override
  String toString() {
    return 'ModifyMetadataTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, metadataType: ${metadataType}, metadataId: ${metadataId}, modifications: ${modifications}}';
  }
}

class _ModifyMetadataTransactionBufferReader extends fb.TableReader<ModifyMetadataTransactionBuffer> {
  const _ModifyMetadataTransactionBufferReader();

  @override
  ModifyMetadataTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyMetadataTransactionBuffer._(bc, offset);
}

class ModifyMetadataTransactionBufferBuilder {
  ModifyMetadataTransactionBufferBuilder(this.fbBuilder);

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

  int addMetadataType(int? metadataType) {
    fbBuilder.addUint8(7, metadataType);
    return fbBuilder.offset;
  }

  int addMetadataIdOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addModificationsOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ModifyMetadataTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _metadataType;
  final List<int>? _metadataId;
  final List<MetadataModificationBufferObjectBuilder>? _modifications;

  ModifyMetadataTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? metadataType,
    List<int>? metadataId,
    List<MetadataModificationBufferObjectBuilder>? modifications,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _metadataType = metadataType,
        _metadataId = metadataId,
        _modifications = modifications;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? metadataIdOffset = _metadataId == null ? null : fbBuilder.writeListUint8(_metadataId!);
    final int? modificationsOffset = _modifications == null
        ? null
        : fbBuilder.writeList(_modifications!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(10);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addUint8(7, _metadataType);
    fbBuilder.addOffset(8, metadataIdOffset);
    fbBuilder.addOffset(9, modificationsOffset);
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
