// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

import './schema_operation_transaction_catapult.buffers_generated.dart';

class DeployTransactionBuffer {
  DeployTransactionBuffer._(this._bc, this._bcOffset);

  factory DeployTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<DeployTransactionBuffer> reader = _DeployTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  List<int>? get driveKey => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 18);

  List<int>? get owner => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 20);

  List<int>? get fileHash => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 22);

  List<int>? get vmVersion => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 24);

  @override
  String toString() {
    return 'DeployTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, driveKey: ${driveKey}, owner: ${owner}, fileHash: ${fileHash}, vmVersion: ${vmVersion}}';
  }
}

class _DeployTransactionBufferReader extends fb.TableReader<DeployTransactionBuffer> {
  const _DeployTransactionBufferReader();

  @override
  DeployTransactionBuffer createObject(fb.BufferContext bc, int offset) => DeployTransactionBuffer._(bc, offset);
}

class DeployTransactionBufferBuilder {
  DeployTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(11);
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

  int addDriveKeyOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addOwnerOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addFileHashOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int addVmVersionOffset(int? offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class DeployTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _driveKey;
  final List<int>? _owner;
  final List<int>? _fileHash;
  final List<int>? _vmVersion;

  DeployTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? driveKey,
    List<int>? owner,
    List<int>? fileHash,
    List<int>? vmVersion,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _driveKey = driveKey,
        _owner = owner,
        _fileHash = fileHash,
        _vmVersion = vmVersion;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? driveKeyOffset = _driveKey == null ? null : fbBuilder.writeListUint8(_driveKey!);
    final int? ownerOffset = _owner == null ? null : fbBuilder.writeListUint8(_owner!);
    final int? fileHashOffset = _fileHash == null ? null : fbBuilder.writeListUint8(_fileHash!);
    final int? vmVersionOffset = _vmVersion == null ? null : fbBuilder.writeListUint32(_vmVersion!);
    fbBuilder.startTable(11);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, driveKeyOffset);
    fbBuilder.addOffset(8, ownerOffset);
    fbBuilder.addOffset(9, fileHashOffset);
    fbBuilder.addOffset(10, vmVersionOffset);
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

class StartExecuteTransactionBuffer {
  StartExecuteTransactionBuffer._(this._bc, this._bcOffset);

  factory StartExecuteTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<StartExecuteTransactionBuffer> reader = _StartExecuteTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  List<int>? get superContract => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 18);

  int get functionSize => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 20, 0);

  int get mosaicsCount => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  List<int>? get dataSize => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 24);

  List<int>? get function => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 26);

  List<MosaicBuffer>? get mosaics =>
      const fb.ListReader<MosaicBuffer>(MosaicBuffer.reader).vTableGetNullable(_bc, _bcOffset, 28);

  List<int>? get data => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 30);

  @override
  String toString() {
    return 'StartExecuteTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, superContract: ${superContract}, functionSize: ${functionSize}, mosaicsCount: ${mosaicsCount}, dataSize: ${dataSize}, function: ${function}, mosaics: ${mosaics}, data: ${data}}';
  }
}

class _StartExecuteTransactionBufferReader extends fb.TableReader<StartExecuteTransactionBuffer> {
  const _StartExecuteTransactionBufferReader();

  @override
  StartExecuteTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      StartExecuteTransactionBuffer._(bc, offset);
}

class StartExecuteTransactionBufferBuilder {
  StartExecuteTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(14);
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

  int addSuperContractOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addFunctionSize(int? functionSize) {
    fbBuilder.addUint8(8, functionSize);
    return fbBuilder.offset;
  }

  int addMosaicsCount(int? mosaicsCount) {
    fbBuilder.addUint8(9, mosaicsCount);
    return fbBuilder.offset;
  }

  int addDataSizeOffset(int? offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int addFunctionOffset(int? offset) {
    fbBuilder.addOffset(11, offset);
    return fbBuilder.offset;
  }

  int addMosaicsOffset(int? offset) {
    fbBuilder.addOffset(12, offset);
    return fbBuilder.offset;
  }

  int addDataOffset(int? offset) {
    fbBuilder.addOffset(13, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class StartExecuteTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _superContract;
  final int? _functionSize;
  final int? _mosaicsCount;
  final List<int>? _dataSize;
  final List<int>? _function;
  final List<MosaicBufferObjectBuilder>? _mosaics;
  final List<int>? _data;

  StartExecuteTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? superContract,
    int? functionSize,
    int? mosaicsCount,
    List<int>? dataSize,
    List<int>? function,
    List<MosaicBufferObjectBuilder>? mosaics,
    List<int>? data,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _superContract = superContract,
        _functionSize = functionSize,
        _mosaicsCount = mosaicsCount,
        _dataSize = dataSize,
        _function = function,
        _mosaics = mosaics,
        _data = data;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? superContractOffset = _superContract == null ? null : fbBuilder.writeListUint8(_superContract!);
    final int? dataSizeOffset = _dataSize == null ? null : fbBuilder.writeListUint8(_dataSize!);
    final int? functionOffset = _function == null ? null : fbBuilder.writeListUint8(_function!);
    final int? mosaicsOffset =
        _mosaics == null ? null : fbBuilder.writeList(_mosaics!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    final int? dataOffset = _data == null ? null : fbBuilder.writeListUint8(_data!);
    fbBuilder.startTable(14);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, superContractOffset);
    fbBuilder.addUint8(8, _functionSize);
    fbBuilder.addUint8(9, _mosaicsCount);
    fbBuilder.addOffset(10, dataSizeOffset);
    fbBuilder.addOffset(11, functionOffset);
    fbBuilder.addOffset(12, mosaicsOffset);
    fbBuilder.addOffset(13, dataOffset);
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

class DeactivateTransactionBuffer {
  DeactivateTransactionBuffer._(this._bc, this._bcOffset);

  factory DeactivateTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<DeactivateTransactionBuffer> reader = _DeactivateTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  List<int>? get superContract => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 18);

  List<int>? get driveKey => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 20);

  @override
  String toString() {
    return 'DeactivateTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, superContract: ${superContract}, driveKey: ${driveKey}}';
  }
}

class _DeactivateTransactionBufferReader extends fb.TableReader<DeactivateTransactionBuffer> {
  const _DeactivateTransactionBufferReader();

  @override
  DeactivateTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      DeactivateTransactionBuffer._(bc, offset);
}

class DeactivateTransactionBufferBuilder {
  DeactivateTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(9);
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

  int addSuperContractOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addDriveKeyOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class DeactivateTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _superContract;
  final List<int>? _driveKey;

  DeactivateTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? superContract,
    List<int>? driveKey,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _superContract = superContract,
        _driveKey = driveKey;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? superContractOffset = _superContract == null ? null : fbBuilder.writeListUint8(_superContract!);
    final int? driveKeyOffset = _driveKey == null ? null : fbBuilder.writeListUint8(_driveKey!);
    fbBuilder.startTable(9);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, superContractOffset);
    fbBuilder.addOffset(8, driveKeyOffset);
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
