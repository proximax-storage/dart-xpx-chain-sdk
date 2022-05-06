// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class SecretProofTransactionBuffer {
  SecretProofTransactionBuffer._(this._bc, this._bcOffset);
  factory SecretProofTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<SecretProofTransactionBuffer> reader =
      _SecretProofTransactionBufferReader();

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
  int get hashAlgorithm =>
      const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);
  List<int>? get secret =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 20);
  List<int>? get recipient =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 22);
  int get proofSize => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 24, 0);
  List<int>? get proof =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 26);

  @override
  String toString() {
    return 'SecretProofTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, hashAlgorithm: ${hashAlgorithm}, secret: ${secret}, recipient: ${recipient}, proofSize: ${proofSize}, proof: ${proof}}';
  }
}

class _SecretProofTransactionBufferReader
    extends fb.TableReader<SecretProofTransactionBuffer> {
  const _SecretProofTransactionBufferReader();

  @override
  SecretProofTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      SecretProofTransactionBuffer._(bc, offset);
}

class SecretProofTransactionBufferBuilder {
  SecretProofTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(12);
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

  int addHashAlgorithm(int? hashAlgorithm) {
    fbBuilder.addUint8(7, hashAlgorithm);
    return fbBuilder.offset;
  }

  int addSecretOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addRecipientOffset(int? offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int addProofSize(int? proofSize) {
    fbBuilder.addUint16(10, proofSize);
    return fbBuilder.offset;
  }

  int addProofOffset(int? offset) {
    fbBuilder.addOffset(11, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class SecretProofTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _hashAlgorithm;
  final List<int>? _secret;
  final List<int>? _recipient;
  final int? _proofSize;
  final List<int>? _proof;

  SecretProofTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? hashAlgorithm,
    List<int>? secret,
    List<int>? recipient,
    int? proofSize,
    List<int>? proof,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _hashAlgorithm = hashAlgorithm,
        _secret = secret,
        _recipient = recipient,
        _proofSize = proofSize,
        _proof = proof;

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
    final int? secretOffset =
        _secret == null ? null : fbBuilder.writeListUint8(_secret!);
    final int? recipientOffset =
        _recipient == null ? null : fbBuilder.writeListUint8(_recipient!);
    final int? proofOffset =
        _proof == null ? null : fbBuilder.writeListUint8(_proof!);
    fbBuilder.startTable(12);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addUint8(7, _hashAlgorithm);
    fbBuilder.addOffset(8, secretOffset);
    fbBuilder.addOffset(9, recipientOffset);
    fbBuilder.addUint16(10, _proofSize);
    fbBuilder.addOffset(11, proofOffset);
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
