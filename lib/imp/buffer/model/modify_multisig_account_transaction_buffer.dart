part of xpx_chain_sdk.buffer.model;

class ModifyMultisigAccountTransactionBuffer {
  factory ModifyMultisigAccountTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  ModifyMultisigAccountTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<ModifyMultisigAccountTransactionBuffer> reader =
      _ModifyMultisigAccountTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get minRemovalDelta => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  int get minApprovalDelta => const fb.Int8Reader().vTableGet(_bc, _bcOffset, 20, 0);

  int get numModifications => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  List<CosignatoryModificationBuffer> get modifications =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 24, null);

  @override
  String toString() => 'ModifyMultisigAccountTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' minRemovalDelta: $minRemovalDelta,'
      ' minApprovalDelta: $minApprovalDelta,'
      ' numModifications: $numModifications,'
      ' modifications: $modifications}';
}

class _ModifyMultisigAccountTransactionBufferReader extends fb.TableReader<ModifyMultisigAccountTransactionBuffer> {
  const _ModifyMultisigAccountTransactionBufferReader();

  @override
  ModifyMultisigAccountTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyMultisigAccountTransactionBuffer._(bc, offset);
}

class ModifyMultisigAccountTransactionBufferBuilder {
  ModifyMultisigAccountTransactionBufferBuilder(this.fbBuilder)
      : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addMinRemovalDelta(int minRemovalDelta) {
    fbBuilder.addInt8(7, minRemovalDelta);
    return fbBuilder.offset;
  }

  int addMinApprovalDelta(int minApprovalDelta) {
    fbBuilder.addInt8(8, minApprovalDelta);
    return fbBuilder.offset;
  }

  int addNumModifications(int numModifications) {
    fbBuilder.addUint8(9, numModifications);
    return fbBuilder.offset;
  }

  int addModificationsOffset(int offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class ModifyMultisigAccountTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  ModifyMultisigAccountTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    int minRemovalDelta,
    int minApprovalDelta,
    int numModifications,
    List<CosignatoryModificationBufferObjectBuilder> modifications,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _minRemovalDelta = minRemovalDelta,
        _minApprovalDelta = minApprovalDelta,
        _numModifications = numModifications,
        _modifications = modifications;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final int _minRemovalDelta;
  final int _minApprovalDelta;
  final int _numModifications;
  final List<CosignatoryModificationBufferObjectBuilder> _modifications;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int modificationsOffset = _modifications?.isNotEmpty == true
        ? fbBuilder.writeList(_modifications.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
        : null;

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
    fbBuilder.addInt8(7, _minRemovalDelta);
    fbBuilder.addInt8(8, _minApprovalDelta);
    fbBuilder.addUint8(9, _numModifications);
    if (modificationsOffset != null) {
      fbBuilder.addOffset(10, modificationsOffset);
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
