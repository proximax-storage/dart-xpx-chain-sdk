part of xpx_chain_sdk.buffer.model;

class MosaicPropertyB {
  factory MosaicPropertyB(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MosaicPropertyB._(this._bc, this._bcOffset);

  static const fb.Reader<MosaicPropertyB> reader = _MosaicPropertyReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get mosaicPropertyId => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get value => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 6, null);

  @override
  String toString() => 'MosaicProperty{mosaicPropertyId: $mosaicPropertyId, value: $value}';
}

class _MosaicPropertyReader extends fb.TableReader<MosaicPropertyB> {
  const _MosaicPropertyReader();

  @override
  MosaicPropertyB createObject(fb.BufferContext bc, int offset) => MosaicPropertyB._(bc, offset);
}

class MosaicPropertyBuilder {
  MosaicPropertyBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addMosaicPropertyId(int mosaicPropertyId) {
    fbBuilder.addUint8(0, mosaicPropertyId);
    return fbBuilder.offset;
  }

  int addValueOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MosaicPropertyObjectBuilder extends fb.ObjectBuilder {
  MosaicPropertyObjectBuilder({
    int mosaicPropertyId,
    List<int> value,
  })  : _mosaicPropertyId = mosaicPropertyId,
        _value = value;

  final int _mosaicPropertyId;
  final List<int> _value;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int valueOffset = _value?.isNotEmpty == true ? fbBuilder.writeListUint32(_value) : null;

    fbBuilder.startTable();
    fbBuilder.addUint8(0, _mosaicPropertyId);
    if (valueOffset != null) {
      fbBuilder.addOffset(1, valueOffset);
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

class MosaicDefinitionTransactionBuffer {
  factory MosaicDefinitionTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MosaicDefinitionTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<MosaicDefinitionTransactionBuffer> reader = _MosaicDefinitionTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get mosaicNonce => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get mosaicId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 20, null);

  int get numOptionalProperties => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  int get flags => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 24, 0);

  int get divisibility => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 26, 0);

  List<MosaicPropertyB> get optionalProperties =>
      const fb.ListReader<MosaicPropertyB>(MosaicPropertyB.reader).vTableGet(_bc, _bcOffset, 28, null);

  @override
  String toString() =>
      'MosaicDefinitionTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, mosaicNonce: $mosaicNonce, mosaicId: $mosaicId, numOptionalProperties: $numOptionalProperties, flags: $flags, divisibility: $divisibility, optionalProperties: $optionalProperties}';
}

class _MosaicDefinitionTransactionBufferReader extends fb.TableReader<MosaicDefinitionTransactionBuffer> {
  const _MosaicDefinitionTransactionBufferReader();

  @override
  MosaicDefinitionTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      MosaicDefinitionTransactionBuffer._(bc, offset);
}

class MosaicDefinitionTransactionBufferBuilder {
  MosaicDefinitionTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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

  int addMosaicNonce(int mosaicNonce) {
    fbBuilder.addUint32(7, mosaicNonce);
    return fbBuilder.offset;
  }

  int addMosaicIdOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int addNumOptionalProperties(int numOptionalProperties) {
    fbBuilder.addUint8(9, numOptionalProperties);
    return fbBuilder.offset;
  }

  int addFlags(int flags) {
    fbBuilder.addUint8(10, flags);
    return fbBuilder.offset;
  }

  int addDivisibility(int divisibility) {
    fbBuilder.addUint8(11, divisibility);
    return fbBuilder.offset;
  }

  int addOptionalPropertiesOffset(int offset) {
    fbBuilder.addOffset(12, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MosaicDefinitionTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  MosaicDefinitionTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int mosaicNonce,
    List<int> mosaicId,
    int numOptionalProperties,
    int flags,
    int divisibility,
    List<MosaicPropertyObjectBuilder> optionalProperties,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _mosaicNonce = mosaicNonce,
        _mosaicId = mosaicId,
        _numOptionalProperties = numOptionalProperties,
        _flags = flags,
        _divisibility = divisibility,
        _optionalProperties = optionalProperties;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _mosaicNonce;
  final List<int> _mosaicId;
  final int _numOptionalProperties;
  final int _flags;
  final int _divisibility;
  final List<MosaicPropertyObjectBuilder> _optionalProperties;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int mosaicIdOffset = _mosaicId?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicId) : null;
    final int optionalPropertiesOffset = _optionalProperties?.isNotEmpty == true
        ? fbBuilder.writeList(_optionalProperties.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    if (maxFeeOffset != null) {
      fbBuilder.addOffset(5, maxFeeOffset);
    }
    if (deadlineOffset != null) {
      fbBuilder.addOffset(6, deadlineOffset);
    }
    fbBuilder.addUint32(7, _mosaicNonce);
    if (mosaicIdOffset != null) {
      fbBuilder.addOffset(8, mosaicIdOffset);
    }
    fbBuilder.addUint8(9, _numOptionalProperties);
    fbBuilder.addUint8(10, _flags);
    fbBuilder.addUint8(11, _divisibility);
    if (optionalPropertiesOffset != null) {
      fbBuilder.addOffset(12, optionalPropertiesOffset);
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
