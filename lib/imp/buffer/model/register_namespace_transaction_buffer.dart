part of xpx_chain_sdk.buffer.model;

class RegisterNamespaceTransactionBuffer {
  factory RegisterNamespaceTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  RegisterNamespaceTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<RegisterNamespaceTransactionBuffer> reader = _RegisterNamespaceTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get namespaceType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get durationParentId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 20, null);

  List<int> get namespaceId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 22, null);

  int get namespaceNameSize => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 24, 0);

  String get namespaceName => const fb.StringReader().vTableGet(_bc, _bcOffset, 26, null);

  @override
  String toString() => 'RegisterNamespaceTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' namespaceType: $namespaceType,'
      ' durationParentId: $durationParentId,'
      ' namespaceId: $namespaceId,'
      ' namespaceNameSize: $namespaceNameSize,'
      ' namespaceName: $namespaceName}';
}

class _RegisterNamespaceTransactionBufferReader extends fb.TableReader<RegisterNamespaceTransactionBuffer> {
  const _RegisterNamespaceTransactionBufferReader();

  @override
  RegisterNamespaceTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      RegisterNamespaceTransactionBuffer._(bc, offset);
}

class RegisterNamespaceTransactionBufferBuilder {
  RegisterNamespaceTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addNamespaceType(int namespaceType) {
    fbBuilder.addUint8(7, namespaceType);
    return fbBuilder.offset;
  }

  int addDurationParentIdOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addNamespaceIdOffset(int offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int addNamespaceNameSize(int namespaceNameSize) {
    fbBuilder.addUint8(10, namespaceNameSize);
    return fbBuilder.offset;
  }

  int addNamespaceNameOffset(int offset) {
    fbBuilder.addOffset(11, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class RegisterNamespaceTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  RegisterNamespaceTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    int namespaceType,
    List<int> durationParentId,
    List<int> namespaceId,
    int namespaceNameSize,
    String namespaceName,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _namespaceType = namespaceType,
        _durationParentId = durationParentId,
        _namespaceId = namespaceId,
        _namespaceNameSize = namespaceNameSize,
        _namespaceName = namespaceName;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final int _namespaceType;
  final List<int> _durationParentId;
  final List<int> _namespaceId;
  final int _namespaceNameSize;
  final String _namespaceName;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int durationParentIdOffset =
        _durationParentId?.isNotEmpty == true ? fbBuilder.writeListUint32(_durationParentId) : null;
    final int namespaceIdOffset = _namespaceId?.isNotEmpty == true ? fbBuilder.writeListUint32(_namespaceId) : null;
    final int namespaceNameOffset = fbBuilder.writeString(_namespaceName);

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
    fbBuilder.addUint8(7, _namespaceType);
    if (durationParentIdOffset != null) {
      fbBuilder.addOffset(8, durationParentIdOffset);
    }
    if (namespaceIdOffset != null) {
      fbBuilder.addOffset(9, namespaceIdOffset);
    }
    fbBuilder.addUint8(10, _namespaceNameSize);
    if (namespaceNameOffset != null) {
      fbBuilder.addOffset(11, namespaceNameOffset);
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
