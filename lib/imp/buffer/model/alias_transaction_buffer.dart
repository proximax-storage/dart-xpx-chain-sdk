part of xpx_chain_sdk.buffer.model;

class AliasTransactionBuffer {
  factory AliasTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  AliasTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<AliasTransactionBuffer> reader = _AliasTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get actionType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get namespaceId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 20, null);

  ///  In case of address it is 25 bytes array. In case of mosaic
  ///  it is 8 byte array(or 2 uint32 array)
  List<int> get aliasId => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 22, null);

  @override
  String toString() => 'AliasTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' maxFee: $maxFee,'
      ' deadline: $deadline,'
      ' actionType: $actionType,'
      ' namespaceId: $namespaceId,'
      ' aliasId: $aliasId}';
}

class _AliasTransactionBufferReader extends fb.TableReader<AliasTransactionBuffer> {
  const _AliasTransactionBufferReader();

  @override
  AliasTransactionBuffer createObject(fb.BufferContext bc, int offset) => AliasTransactionBuffer._(bc, offset);
}

class AliasTransactionBufferBuilder {
  AliasTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addMaxFeeOffset(int offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addActionType(int actionType) {
    fbBuilder.addUint8(7, actionType);
    return fbBuilder.offset;
  }

  int addNamespaceIdOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addAliasIdOffset(int offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class AliasTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  AliasTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int actionType,
    List<int> namespaceId,
    List<int> aliasId,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _actionType = actionType,
        _namespaceId = namespaceId,
        _aliasId = aliasId;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _actionType;
  final List<int> _namespaceId;
  final List<int> _aliasId;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int namespaceIdOffset = _namespaceId?.isNotEmpty == true ? fbBuilder.writeListUint32(_namespaceId) : null;
    final int aliasIdOffset = _aliasId?.isNotEmpty == true ? fbBuilder.writeListUint8(_aliasId) : null;

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
    if (maxFeeOffset != null) {
      fbBuilder.addOffset(5, maxFeeOffset);
    }
    if (deadlineOffset != null) {
      fbBuilder.addOffset(6, deadlineOffset);
    }
    fbBuilder.addUint8(7, _actionType);
    if (namespaceIdOffset != null) {
      fbBuilder.addOffset(8, namespaceIdOffset);
    }
    if (aliasIdOffset != null) {
      fbBuilder.addOffset(9, aliasIdOffset);
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
