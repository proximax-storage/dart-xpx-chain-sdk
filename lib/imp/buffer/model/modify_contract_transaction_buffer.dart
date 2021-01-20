part of xpx_chain_sdk.buffer.model;

class CosignatoryModificationBuffer {
  factory CosignatoryModificationBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  CosignatoryModificationBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<CosignatoryModificationBuffer> reader = _CosignatoryModificationBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get cosignatoryPublicKey => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  @override
  String toString() => 'CosignatoryModificationBuffer{'
      'type: $type,'
      ' cosignatoryPublicKey: $cosignatoryPublicKey}';
}

class _CosignatoryModificationBufferReader extends fb.TableReader<CosignatoryModificationBuffer> {
  const _CosignatoryModificationBufferReader();

  @override
  CosignatoryModificationBuffer createObject(fb.BufferContext bc, int offset) =>
      CosignatoryModificationBuffer._(bc, offset);
}

class CosignatoryModificationBufferBuilder {
  CosignatoryModificationBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addType(int type) {
    fbBuilder.addUint8(0, type);
    return fbBuilder.offset;
  }

  int addCosignatoryPublicKeyOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class CosignatoryModificationBufferObjectBuilder extends fb.ObjectBuilder {
  CosignatoryModificationBufferObjectBuilder({
    int type,
    List<int> cosignatoryPublicKey,
  })  : _type = type,
        _cosignatoryPublicKey = cosignatoryPublicKey;

  final int _type;
  final List<int> _cosignatoryPublicKey;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int cosignatoryPublicKeyOffset =
        _cosignatoryPublicKey?.isNotEmpty == true ? fbBuilder.writeListUint8(_cosignatoryPublicKey) : null;

    fbBuilder.startTable();
    fbBuilder.addUint8(0, _type);
    if (cosignatoryPublicKeyOffset != null) {
      fbBuilder.addOffset(1, cosignatoryPublicKeyOffset);
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

class ModifyContractTransactionBuffer {
  factory ModifyContractTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  ModifyContractTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<ModifyContractTransactionBuffer> reader = _ModifyContractTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  List<int> get durationDelta => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 18, null);

  List<int> get hash => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 20, null);

  int get numCustomers => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  int get numExecutors => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 24, 0);

  int get numVerifiers => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 26, 0);

  List<CosignatoryModificationBuffer> get customers =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 28, null);

  List<CosignatoryModificationBuffer> get executors =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 30, null);

  List<CosignatoryModificationBuffer> get verifiers =>
      const fb.ListReader<CosignatoryModificationBuffer>(CosignatoryModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 32, null);

  @override
  String toString() => 'ModifyContractTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' durationDelta: $durationDelta,'
      ' hash: $hash,'
      ' numCustomers: $numCustomers,'
      ' numExecutors: $numExecutors,'
      ' numVerifiers: $numVerifiers,'
      ' customers: $customers,'
      ' executors: $executors,'
      ' verifiers: $verifiers}';
}

class _ModifyContractTransactionBufferReader extends fb.TableReader<ModifyContractTransactionBuffer> {
  const _ModifyContractTransactionBufferReader();

  @override
  ModifyContractTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyContractTransactionBuffer._(bc, offset);
}

class ModifyContractTransactionBufferBuilder {
  ModifyContractTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addDurationDeltaOffset(int offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addHashOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addNumCustomers(int numCustomers) {
    fbBuilder.addUint8(9, numCustomers);
    return fbBuilder.offset;
  }

  int addNumExecutors(int numExecutors) {
    fbBuilder.addUint8(10, numExecutors);
    return fbBuilder.offset;
  }

  int addNumVerifiers(int numVerifiers) {
    fbBuilder.addUint8(11, numVerifiers);
    return fbBuilder.offset;
  }

  int addCustomersOffset(int offset) {
    fbBuilder.addOffset(12, offset);
    return fbBuilder.offset;
  }

  int addExecutorsOffset(int offset) {
    fbBuilder.addOffset(13, offset);
    return fbBuilder.offset;
  }

  int addVerifiersOffset(int offset) {
    fbBuilder.addOffset(14, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class ModifyContractTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  ModifyContractTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    List<int> durationDelta,
    List<int> hash,
    int numCustomers,
    int numExecutors,
    int numVerifiers,
    List<CosignatoryModificationBufferObjectBuilder> customers,
    List<CosignatoryModificationBufferObjectBuilder> executors,
    List<CosignatoryModificationBufferObjectBuilder> verifiers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _durationDelta = durationDelta,
        _hash = hash,
        _numCustomers = numCustomers,
        _numExecutors = numExecutors,
        _numVerifiers = numVerifiers,
        _customers = customers,
        _executors = executors,
        _verifiers = verifiers;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final List<int> _durationDelta;
  final List<int> _hash;
  final int _numCustomers;
  final int _numExecutors;
  final int _numVerifiers;
  final List<CosignatoryModificationBufferObjectBuilder> _customers;
  final List<CosignatoryModificationBufferObjectBuilder> _executors;
  final List<CosignatoryModificationBufferObjectBuilder> _verifiers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int durationDeltaOffset =
        _durationDelta?.isNotEmpty == true ? fbBuilder.writeListUint32(_durationDelta) : null;
    final int hashOffset = _hash?.isNotEmpty == true ? fbBuilder.writeListUint8(_hash) : null;
    final int customersOffset = _customers?.isNotEmpty == true
        ? fbBuilder.writeList(_customers.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
        : null;
    final int executorsOffset = _executors?.isNotEmpty == true
        ? fbBuilder.writeList(_executors.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
        : null;
    final int verifiersOffset = _verifiers?.isNotEmpty == true
        ? fbBuilder.writeList(_verifiers.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    if (durationDeltaOffset != null) {
      fbBuilder.addOffset(7, durationDeltaOffset);
    }
    if (hashOffset != null) {
      fbBuilder.addOffset(8, hashOffset);
    }
    fbBuilder.addUint8(9, _numCustomers);
    fbBuilder.addUint8(10, _numExecutors);
    fbBuilder.addUint8(11, _numVerifiers);
    if (customersOffset != null) {
      fbBuilder.addOffset(12, customersOffset);
    }
    if (executorsOffset != null) {
      fbBuilder.addOffset(13, executorsOffset);
    }
    if (verifiersOffset != null) {
      fbBuilder.addOffset(14, verifiersOffset);
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
