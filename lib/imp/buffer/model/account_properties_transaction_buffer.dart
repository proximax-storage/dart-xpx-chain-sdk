part of xpx_chain_sdk.buffer.model;

class PropertyModificationBuffer {
  factory PropertyModificationBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  PropertyModificationBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<PropertyModificationBuffer> reader = _PropertyModificationBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get modificationType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  ///  In case of address it is 25 bytes array. In case of mosaic it is 8 byte array(or 2 uint32 array).
  ///  In case of transaction it is 2 byte array(ushort)
  List<int> get value => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  @override
  String toString() => 'PropertyModificationBuffer{modificationType: $modificationType, value: $value}';
}

class _PropertyModificationBufferReader extends fb.TableReader<PropertyModificationBuffer> {
  const _PropertyModificationBufferReader();

  @override
  PropertyModificationBuffer createObject(fb.BufferContext bc, int offset) => PropertyModificationBuffer._(bc, offset);
}

class PropertyModificationBufferBuilder {
  PropertyModificationBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addModificationType(int modificationType) {
    fbBuilder.addUint8(0, modificationType);
    return fbBuilder.offset;
  }

  int addValueOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class PropertyModificationBufferObjectBuilder extends fb.ObjectBuilder {
  PropertyModificationBufferObjectBuilder({
    int modificationType,
    List<int> value,
  })  : _modificationType = modificationType,
        _value = value;

  final int _modificationType;
  final List<int> _value;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int valueOffset = _value?.isNotEmpty == true ? fbBuilder.writeListUint8(_value) : null;

    fbBuilder.startTable();
    fbBuilder.addUint8(0, _modificationType);
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

class AccountPropertiesTransactionBuffer {
  factory AccountPropertiesTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  AccountPropertiesTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<AccountPropertiesTransactionBuffer> reader = _AccountPropertiesTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get propertyType => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  int get modificationCount => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 20, 0);

  List<PropertyModificationBuffer> get modifications =>
      const fb.ListReader<PropertyModificationBuffer>(PropertyModificationBuffer.reader)
          .vTableGet(_bc, _bcOffset, 22, null);

  @override
  String toString() =>
      'AccountPropertiesTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, propertyType: $propertyType, modificationCount: $modificationCount, modifications: $modifications}';
}

class _AccountPropertiesTransactionBufferReader extends fb.TableReader<AccountPropertiesTransactionBuffer> {
  const _AccountPropertiesTransactionBufferReader();

  @override
  AccountPropertiesTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      AccountPropertiesTransactionBuffer._(bc, offset);
}

class AccountPropertiesTransactionBufferBuilder {
  AccountPropertiesTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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
    fbBuilder.addUint32(3, version);
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

  int addPropertyType(int propertyType) {
    fbBuilder.addUint8(7, propertyType);
    return fbBuilder.offset;
  }

  int addModificationCount(int modificationCount) {
    fbBuilder.addUint8(8, modificationCount);
    return fbBuilder.offset;
  }

  int addModificationsOffset(int offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class AccountPropertiesTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  AccountPropertiesTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int propertyType,
    int modificationCount,
    List<PropertyModificationBufferObjectBuilder> modifications,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _propertyType = propertyType,
        _modificationCount = modificationCount,
        _modifications = modifications;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _propertyType;
  final int _modificationCount;
  final List<PropertyModificationBufferObjectBuilder> _modifications;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
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
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    if (maxFeeOffset != null) {
      fbBuilder.addOffset(5, maxFeeOffset);
    }
    if (deadlineOffset != null) {
      fbBuilder.addOffset(6, deadlineOffset);
    }
    fbBuilder.addUint8(7, _propertyType);
    fbBuilder.addUint8(8, _modificationCount);
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
