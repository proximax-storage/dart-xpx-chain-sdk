part of xpx_chain_sdk.buffer.model;

class MetadataModificationBuffer {
  factory MetadataModificationBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MetadataModificationBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<MetadataModificationBuffer> reader = _MetadataModificationBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  int get modificationType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 6, 0);

  int get keySize => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 8, 0);

  List<int> get valueSize => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 10, null);

  List<int> get key => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 12, null);

  List<int> get value => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 14, null);

  @override
  String toString() => 'MetadataModificationBuffer{'
      'size: $size,'
      ' modificationType: $modificationType,'
      ' keySize: $keySize,'
      ' valueSize: $valueSize,'
      ' key: $key,'
      ' value: $value}';
}

class _MetadataModificationBufferReader extends fb.TableReader<MetadataModificationBuffer> {
  const _MetadataModificationBufferReader();

  @override
  MetadataModificationBuffer createObject(fb.BufferContext bc, int offset) => MetadataModificationBuffer._(bc, offset);
}

class MetadataModificationBufferBuilder {
  MetadataModificationBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addSize(int size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addModificationType(int modificationType) {
    fbBuilder.addUint8(1, modificationType);
    return fbBuilder.offset;
  }

  int addKeySize(int keySize) {
    fbBuilder.addUint8(2, keySize);
    return fbBuilder.offset;
  }

  int addValueSizeOffset(int offset) {
    fbBuilder.addOffset(3, offset);
    return fbBuilder.offset;
  }

  int addKeyOffset(int offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int addValueOffset(int offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MetadataModificationBufferObjectBuilder extends fb.ObjectBuilder {
  MetadataModificationBufferObjectBuilder({
    int size,
    int modificationType,
    int keySize,
    List<int> valueSize,
    List<int> key,
    List<int> value,
  })  : _size = size,
        _modificationType = modificationType,
        _keySize = keySize,
        _valueSize = valueSize,
        _key = key,
        _value = value;

  final int _size;
  final int _modificationType;
  final int _keySize;
  final List<int> _valueSize;
  final List<int> _key;
  final List<int> _value;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int valueSizeOffset = _valueSize?.isNotEmpty == true ? fbBuilder.writeListUint8(_valueSize) : null;
    final int keyOffset = _key?.isNotEmpty == true ? fbBuilder.writeListUint8(_key) : null;
    final int valueOffset = _value?.isNotEmpty == true ? fbBuilder.writeListUint8(_value) : null;

    fbBuilder.startTable();
    fbBuilder.addUint32(0, _size);
    fbBuilder.addUint8(1, _modificationType);
    fbBuilder.addUint8(2, _keySize);
    if (valueSizeOffset != null) {
      fbBuilder.addOffset(3, valueSizeOffset);
    }
    if (keyOffset != null) {
      fbBuilder.addOffset(4, keyOffset);
    }
    if (valueOffset != null) {
      fbBuilder.addOffset(5, valueOffset);
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

class ModifyMetadataTransactionBuffer {
  factory ModifyMetadataTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  ModifyMetadataTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<ModifyMetadataTransactionBuffer> reader = _ModifyMetadataTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get metadataType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get metadataId => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 20, null);

  List<MetadataModificationBuffer> get modifications =>
      const fb.ListReader<MetadataModificationBuffer>(MetadataModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 22, null);

  @override
  String toString() => 'ModifyMetadataTransactionBuffer{size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' metadataType: $metadataType,'
      ' metadataId: $metadataId,'
      ' modifications: $modifications}';
}

class _ModifyMetadataTransactionBufferReader extends fb.TableReader<ModifyMetadataTransactionBuffer> {
  const _ModifyMetadataTransactionBufferReader();

  @override
  ModifyMetadataTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ModifyMetadataTransactionBuffer._(bc, offset);
}

class ModifyMetadataTransactionBufferBuilder {
  ModifyMetadataTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addMetadataType(int metadataType) {
    fbBuilder.addUint8(7, metadataType);
    return fbBuilder.offset;
  }

  int addMetadataIdOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addModificationsOffset(int offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class ModifyMetadataTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  ModifyMetadataTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    int metadataType,
    List<int> metadataId,
    List<MetadataModificationBufferObjectBuilder> modifications,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _metadataType = metadataType,
        _metadataId = metadataId,
        _modifications = modifications;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final int _metadataType;
  final List<int> _metadataId;
  final List<MetadataModificationBufferObjectBuilder> _modifications;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int metadataIdOffset = _metadataId?.isNotEmpty == true ? fbBuilder.writeListUint8(_metadataId) : null;
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
    fbBuilder.addUint8(7, _metadataType);
    if (metadataIdOffset != null) {
      fbBuilder.addOffset(8, metadataIdOffset);
    }
    if (modificationsOffset != null) {
      fbBuilder.addOffset(9, modificationsOffset);
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
