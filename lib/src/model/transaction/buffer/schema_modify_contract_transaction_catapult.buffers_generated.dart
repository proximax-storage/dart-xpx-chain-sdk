// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class CosignatoryModificationBuffer {
  CosignatoryModificationBuffer._(this._bc, this._bcOffset);

  factory CosignatoryModificationBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<CosignatoryModificationBuffer> reader = _CosignatoryModificationBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get cosignatoryPublicKey => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  @override
  String toString() {
    return 'CosignatoryModificationBuffer{type: ${type}, cosignatoryPublicKey: ${cosignatoryPublicKey}}';
  }
}

class _CosignatoryModificationBufferReader extends fb.TableReader<CosignatoryModificationBuffer> {
  const _CosignatoryModificationBufferReader();

  @override
  CosignatoryModificationBuffer createObject(fb.BufferContext bc, int offset) =>
      CosignatoryModificationBuffer._(bc, offset);
}

class CosignatoryModificationBufferBuilder {
  CosignatoryModificationBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(2);
  }

  int addType(int? type) {
    fbBuilder.addUint8(0, type);
    return fbBuilder.offset;
  }

  int addCosignatoryPublicKeyOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class CosignatoryModificationBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _type;
  final List<int>? _cosignatoryPublicKey;

  CosignatoryModificationBufferObjectBuilder({
    int? type,
    List<int>? cosignatoryPublicKey,
  })  : _type = type,
        _cosignatoryPublicKey = cosignatoryPublicKey;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? cosignatoryPublicKeyOffset =
        _cosignatoryPublicKey == null ? null : fbBuilder.writeListUint8(_cosignatoryPublicKey!);
    fbBuilder.startTable(2);
    fbBuilder.addUint8(0, _type);
    fbBuilder.addOffset(1, cosignatoryPublicKeyOffset);
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

class ModifyContractTransactionBuffer {
  ModifyContractTransactionBuffer._(this._bc, this._bcOffset);

  factory ModifyContractTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ModifyContractTransactionBuffer> reader = _ModifyContractTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  List<int>? get durationDelta => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 18);

  List<int>? get hash => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 20);

  int get numCustomers => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  int get numExecutors => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 24, 0);

  int get numVerifiers => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 26, 0);

  List<CosignatoryModificationBuffer>? get customers =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 28);

  List<CosignatoryModificationBuffer>? get executors =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 30);

  List<CosignatoryModificationBuffer>? get verifiers =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 32);

  @override
  String toString() {
    return 'ModifyContractTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, durationDelta: ${durationDelta}, hash: ${hash}, numCustomers: ${numCustomers}, numExecutors: ${numExecutors}, numVerifiers: ${numVerifiers}, customers: ${customers}, executors: ${executors}, verifiers: ${verifiers}}';
  }
}

class _ModifyContractTransactionBufferReader extends fb.TableReader<ModifyContractTransactionBuffer> {
  const _ModifyContractTransactionBufferReader();

  @override
  ModifyContractTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyContractTransactionBuffer._(bc, offset);
}

class ModifyContractTransactionBufferBuilder {
  ModifyContractTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(15);
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

  int addDurationDeltaOffset(int? offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addHashOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addNumCustomers(int? numCustomers) {
    fbBuilder.addUint8(9, numCustomers);
    return fbBuilder.offset;
  }

  int addNumExecutors(int? numExecutors) {
    fbBuilder.addUint8(10, numExecutors);
    return fbBuilder.offset;
  }

  int addNumVerifiers(int? numVerifiers) {
    fbBuilder.addUint8(11, numVerifiers);
    return fbBuilder.offset;
  }

  int addCustomersOffset(int? offset) {
    fbBuilder.addOffset(12, offset);
    return fbBuilder.offset;
  }

  int addExecutorsOffset(int? offset) {
    fbBuilder.addOffset(13, offset);
    return fbBuilder.offset;
  }

  int addVerifiersOffset(int? offset) {
    fbBuilder.addOffset(14, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ModifyContractTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final List<int>? _durationDelta;
  final List<int>? _hash;
  final int? _numCustomers;
  final int? _numExecutors;
  final int? _numVerifiers;
  final List<CosignatoryModificationBufferObjectBuilder>? _customers;
  final List<CosignatoryModificationBufferObjectBuilder>? _executors;
  final List<CosignatoryModificationBufferObjectBuilder>? _verifiers;

  ModifyContractTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    List<int>? durationDelta,
    List<int>? hash,
    int? numCustomers,
    int? numExecutors,
    int? numVerifiers,
    List<CosignatoryModificationBufferObjectBuilder>? customers,
    List<CosignatoryModificationBufferObjectBuilder>? executors,
    List<CosignatoryModificationBufferObjectBuilder>? verifiers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _durationDelta = durationDelta,
        _hash = hash,
        _numCustomers = numCustomers,
        _numExecutors = numExecutors,
        _numVerifiers = numVerifiers,
        _customers = customers,
        _executors = executors,
        _verifiers = verifiers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? durationDeltaOffset = _durationDelta == null ? null : fbBuilder.writeListUint32(_durationDelta!);
    final int? hashOffset = _hash == null ? null : fbBuilder.writeListUint8(_hash!);
    final int? customersOffset = _customers == null
        ? null
        : fbBuilder.writeList(_customers!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    final int? executorsOffset = _executors == null
        ? null
        : fbBuilder.writeList(_executors!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    final int? verifiersOffset = _verifiers == null
        ? null
        : fbBuilder.writeList(_verifiers!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(15);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addOffset(7, durationDeltaOffset);
    fbBuilder.addOffset(8, hashOffset);
    fbBuilder.addUint8(9, _numCustomers);
    fbBuilder.addUint8(10, _numExecutors);
    fbBuilder.addUint8(11, _numVerifiers);
    fbBuilder.addOffset(12, customersOffset);
    fbBuilder.addOffset(13, executorsOffset);
    fbBuilder.addOffset(14, verifiersOffset);
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
