// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

import './schema_modify_contract_transaction_catapult.buffers_generated.dart';

class ModifyMultisigAccountTransactionBuffer {
  ModifyMultisigAccountTransactionBuffer._(this._bc, this._bcOffset);

  factory ModifyMultisigAccountTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ModifyMultisigAccountTransactionBuffer> reader =
      _ModifyMultisigAccountTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int>? get signature => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);

  List<int>? get signer => const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 14);

  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGetNullable(_bc, _bcOffset, 16);

  int get minRemovalDelta => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  int get minApprovalDelta => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 20, 0);

  int get numModifications => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  List<CosignatoryModificationBuffer>? get modifications =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 24);

  @override
  String toString() {
    return 'ModifyMultisigAccountTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, minRemovalDelta: ${minRemovalDelta}, minApprovalDelta: ${minApprovalDelta}, numModifications: ${numModifications}, modifications: ${modifications}}';
  }
}

class _ModifyMultisigAccountTransactionBufferReader extends fb.TableReader<ModifyMultisigAccountTransactionBuffer> {
  const _ModifyMultisigAccountTransactionBufferReader();

  @override
  ModifyMultisigAccountTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyMultisigAccountTransactionBuffer._(bc, offset);
}

class ModifyMultisigAccountTransactionBufferBuilder {
  ModifyMultisigAccountTransactionBufferBuilder(this.fbBuilder);

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

  int addMinRemovalDelta(int? minRemovalDelta) {
    fbBuilder.addInt8(7, minRemovalDelta);
    return fbBuilder.offset;
  }

  int addMinApprovalDelta(int? minApprovalDelta) {
    fbBuilder.addInt8(8, minApprovalDelta);
    return fbBuilder.offset;
  }

  int addNumModifications(int? numModifications) {
    fbBuilder.addUint8(9, numModifications);
    return fbBuilder.offset;
  }

  int addModificationsOffset(int? offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ModifyMultisigAccountTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _minRemovalDelta;
  final int? _minApprovalDelta;
  final int? _numModifications;
  final List<CosignatoryModificationBufferObjectBuilder>? _modifications;

  ModifyMultisigAccountTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? minRemovalDelta,
    int? minApprovalDelta,
    int? numModifications,
    List<CosignatoryModificationBufferObjectBuilder>? modifications,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _minRemovalDelta = minRemovalDelta,
        _minApprovalDelta = minApprovalDelta,
        _numModifications = numModifications,
        _modifications = modifications;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset = _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset = _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset = _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset = _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? modificationsOffset = _modifications == null
        ? null
        : fbBuilder.writeList(_modifications!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(11);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addInt8(7, _minRemovalDelta);
    fbBuilder.addInt8(8, _minApprovalDelta);
    fbBuilder.addUint8(9, _numModifications);
    fbBuilder.addOffset(10, modificationsOffset);
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
