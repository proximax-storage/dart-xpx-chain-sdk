part of xpx_chain_sdk.buffer.model;

class SecretProofTransactionBuffer {
  factory SecretProofTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  SecretProofTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<SecretProofTransactionBuffer> reader = _SecretProofTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get hashAlgorithm => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get secret => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 20, null);

  int get proofSize => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 22, 0);

  List<int> get proof => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 24, null);

  @override
  String toString() => 'SecretProofTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' hashAlgorithm: $hashAlgorithm,'
      ' secret: $secret,'
      ' proofSize: $proofSize,'
      ' proof: $proof}';
}

class _SecretProofTransactionBufferReader extends fb.TableReader<SecretProofTransactionBuffer> {
  const _SecretProofTransactionBufferReader();

  @override
  SecretProofTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      SecretProofTransactionBuffer._(bc, offset);
}

class SecretProofTransactionBufferBuilder {
  SecretProofTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addSize(int size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addSignatureOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addSignerOffset(int offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addVersion(int version) {
    fbBuilder.addUint16(3, version);
    return fbBuilder.offset;
  }

  int addType(int type) {
    fbBuilder.addUint16(4, type);
    return fbBuilder.offset;
  }

  int addFeeOffset(int offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addHashAlgorithm(int hashAlgorithm) {
    fbBuilder.addUint8(7, hashAlgorithm);
    return fbBuilder.offset;
  }

  int addSecretOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addProofSize(int proofSize) {
    fbBuilder.addUint16(9, proofSize);
    return fbBuilder.offset;
  }

  int addProofOffset(int offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class SecretProofTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  SecretProofTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    int hashAlgorithm,
    List<int> secret,
    int proofSize,
    List<int> proof,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _hashAlgorithm = hashAlgorithm,
        _secret = secret,
        _proofSize = proofSize,
        _proof = proof;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final int _hashAlgorithm;
  final List<int> _secret;
  final int _proofSize;
  final List<int> _proof;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int secretOffset = _secret?.isNotEmpty == true ? fbBuilder.writeListUint8(_secret) : null;
    final int proofOffset = _proof?.isNotEmpty == true ? fbBuilder.writeListUint8(_proof) : null;

    fbBuilder.startTable();
    fbBuilder.addUint32(0, _size);
    if (signatureOffset != null) {
      fbBuilder.addOffset(1, signatureOffset);
    }
    if (signerOffset != null) {
      fbBuilder.addOffset(2, signerOffset);
    }
    fbBuilder.addUint16(3, _version);
    fbBuilder.addUint16(4, _type);
    if (feeOffset != null) {
      fbBuilder.addOffset(5, feeOffset);
    }
    if (deadlineOffset != null) {
      fbBuilder.addOffset(6, deadlineOffset);
    }
    fbBuilder.addUint8(7, _hashAlgorithm);
    if (secretOffset != null) {
      fbBuilder.addOffset(8, secretOffset);
    }
    fbBuilder.addUint16(9, _proofSize);
    if (proofOffset != null) {
      fbBuilder.addOffset(10, proofOffset);
    }
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String fileIdentifier]) {
    final fb.Builder fbBuilder = fb.Builder();
    final int offset = finish(fbBuilder);
    return fbBuilder.finish(offset, fileIdentifier);
  }
}
