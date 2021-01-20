part of xpx_chain_sdk.buffer.model;

class AddExchangeOfferTransactionBuffer {
  factory AddExchangeOfferTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  AddExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<AddExchangeOfferTransactionBuffer> reader = _AddExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get offersCount => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<AddExchangeOfferBuffer> get offers =>
      const fb.ListReader<AddExchangeOfferBuffer>(AddExchangeOfferBuffer.reader).vTableGet(_bc, _bcOffset, 20, null);

  @override
  String toString() =>
      'AddExchangeOfferTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, offersCount: $offersCount, offers: $offers}';
}

class _AddExchangeOfferTransactionBufferReader extends fb.TableReader<AddExchangeOfferTransactionBuffer> {
  const _AddExchangeOfferTransactionBufferReader();

  @override
  AddExchangeOfferTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      AddExchangeOfferTransactionBuffer._(bc, offset);
}

class AddExchangeOfferTransactionBufferBuilder {
  AddExchangeOfferTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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

  int addOffersCount(int offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class AddExchangeOfferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  AddExchangeOfferTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int offersCount,
    List<AddExchangeOfferBufferObjectBuilder> offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _offersCount;
  final List<AddExchangeOfferBufferObjectBuilder> _offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int offersOffset = _offers?.isNotEmpty == true
        ? fbBuilder.writeList(_offers.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    fbBuilder.addUint8(7, _offersCount);
    if (offersOffset != null) {
      fbBuilder.addOffset(8, offersOffset);
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

class ExchangeOfferTransactionBuffer {
  factory ExchangeOfferTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  ExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<ExchangeOfferTransactionBuffer> reader = _ExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get offersCount => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<ExchangeOfferBuffer> get offers =>
      const fb.ListReader<ExchangeOfferBuffer>(ExchangeOfferBuffer.reader).vTableGet(_bc, _bcOffset, 20, null);

  @override
  String toString() =>
      'ExchangeOfferTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, offersCount: $offersCount, offers: $offers}';
}

class _ExchangeOfferTransactionBufferReader extends fb.TableReader<ExchangeOfferTransactionBuffer> {
  const _ExchangeOfferTransactionBufferReader();

  @override
  ExchangeOfferTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      ExchangeOfferTransactionBuffer._(bc, offset);
}

class ExchangeOfferTransactionBufferBuilder {
  ExchangeOfferTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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

  int addOffersCount(int offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class ExchangeOfferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  ExchangeOfferTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int offersCount,
    List<ExchangeOfferBufferObjectBuilder> offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _offersCount;
  final List<ExchangeOfferBufferObjectBuilder> _offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int offersOffset = _offers?.isNotEmpty == true
        ? fbBuilder.writeList(_offers.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    fbBuilder.addUint8(7, _offersCount);
    if (offersOffset != null) {
      fbBuilder.addOffset(8, offersOffset);
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

class RemoveExchangeOfferTransactionBuffer {
  factory RemoveExchangeOfferTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  RemoveExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<RemoveExchangeOfferTransactionBuffer> reader = _RemoveExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get offersCount => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<RemoveExchangeOfferBuffer> get offers =>
      const fb.ListReader<RemoveExchangeOfferBuffer>(RemoveExchangeOfferBuffer.reader)
          .vTableGet(_bc, _bcOffset, 20, null);

  @override
  String toString() =>
      'RemoveExchangeOfferTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, offersCount: $offersCount, offers: $offers}';
}

class _RemoveExchangeOfferTransactionBufferReader extends fb.TableReader<RemoveExchangeOfferTransactionBuffer> {
  const _RemoveExchangeOfferTransactionBufferReader();

  @override
  RemoveExchangeOfferTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      RemoveExchangeOfferTransactionBuffer._(bc, offset);
}

class RemoveExchangeOfferTransactionBufferBuilder {
  RemoveExchangeOfferTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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

  int addOffersCount(int offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class RemoveExchangeOfferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  RemoveExchangeOfferTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    int offersCount,
    List<RemoveExchangeOfferBufferObjectBuilder> offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final int _offersCount;
  final List<RemoveExchangeOfferBufferObjectBuilder> _offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int offersOffset = _offers?.isNotEmpty == true
        ? fbBuilder.writeList(_offers.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    fbBuilder.addUint8(7, _offersCount);
    if (offersOffset != null) {
      fbBuilder.addOffset(8, offersOffset);
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

class AddExchangeOfferBuffer {
  factory AddExchangeOfferBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  AddExchangeOfferBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<AddExchangeOfferBuffer> reader = _AddExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int> get mosaicId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 4, null);

  List<int> get mosaicAmount => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get cost => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 10, 0);

  List<int> get duration => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 12, null);

  @override
  String toString() =>
      'AddExchangeOfferBuffer{mosaicId: $mosaicId, mosaicAmount: $mosaicAmount, cost: $cost, type: $type, duration: $duration}';
}

class _AddExchangeOfferBufferReader extends fb.TableReader<AddExchangeOfferBuffer> {
  const _AddExchangeOfferBufferReader();

  @override
  AddExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) => AddExchangeOfferBuffer._(bc, offset);
}

class AddExchangeOfferBufferBuilder {
  AddExchangeOfferBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addMosaicIdOffset(int offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addMosaicAmountOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addCostOffset(int offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addType(int type) {
    fbBuilder.addUint8(3, type);
    return fbBuilder.offset;
  }

  int addDurationOffset(int offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class AddExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  AddExchangeOfferBufferObjectBuilder({
    List<int> mosaicId,
    List<int> mosaicAmount,
    List<int> cost,
    int type,
    List<int> duration,
  })  : _mosaicId = mosaicId,
        _mosaicAmount = mosaicAmount,
        _cost = cost,
        _type = type,
        _duration = duration;

  final List<int> _mosaicId;
  final List<int> _mosaicAmount;
  final List<int> _cost;
  final int _type;
  final List<int> _duration;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int mosaicIdOffset = _mosaicId?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicId) : null;
    final int mosaicAmountOffset = _mosaicAmount?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicAmount) : null;
    final int costOffset = _cost?.isNotEmpty == true ? fbBuilder.writeListUint32(_cost) : null;
    final int durationOffset = _duration?.isNotEmpty == true ? fbBuilder.writeListUint32(_duration) : null;

    fbBuilder.startTable();
    if (mosaicIdOffset != null) {
      fbBuilder.addOffset(0, mosaicIdOffset);
    }
    if (mosaicAmountOffset != null) {
      fbBuilder.addOffset(1, mosaicAmountOffset);
    }
    if (costOffset != null) {
      fbBuilder.addOffset(2, costOffset);
    }
    fbBuilder.addUint8(3, _type);
    if (durationOffset != null) {
      fbBuilder.addOffset(4, durationOffset);
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

class ExchangeOfferBuffer {
  factory ExchangeOfferBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  ExchangeOfferBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<ExchangeOfferBuffer> reader = _ExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int> get mosaicId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 4, null);

  List<int> get mosaicAmount => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get cost => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 10, 0);

  List<int> get owner => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 12, null);

  @override
  String toString() =>
      'ExchangeOfferBuffer{mosaicId: $mosaicId, mosaicAmount: $mosaicAmount, cost: $cost, type: $type, owner: $owner}';
}

class _ExchangeOfferBufferReader extends fb.TableReader<ExchangeOfferBuffer> {
  const _ExchangeOfferBufferReader();

  @override
  ExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) => ExchangeOfferBuffer._(bc, offset);
}

class ExchangeOfferBufferBuilder {
  ExchangeOfferBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addMosaicIdOffset(int offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addMosaicAmountOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addCostOffset(int offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addType(int type) {
    fbBuilder.addUint8(3, type);
    return fbBuilder.offset;
  }

  int addOwnerOffset(int offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class ExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  ExchangeOfferBufferObjectBuilder({
    List<int> mosaicId,
    List<int> mosaicAmount,
    List<int> cost,
    int type,
    List<int> owner,
  })  : _mosaicId = mosaicId,
        _mosaicAmount = mosaicAmount,
        _cost = cost,
        _type = type,
        _owner = owner;

  final List<int> _mosaicId;
  final List<int> _mosaicAmount;
  final List<int> _cost;
  final int _type;
  final List<int> _owner;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int mosaicIdOffset = _mosaicId?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicId) : null;
    final int mosaicAmountOffset = _mosaicAmount?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicAmount) : null;
    final int costOffset = _cost?.isNotEmpty == true ? fbBuilder.writeListUint32(_cost) : null;
    final int ownerOffset = _owner?.isNotEmpty == true ? fbBuilder.writeListUint8(_owner) : null;

    fbBuilder.startTable();
    if (mosaicIdOffset != null) {
      fbBuilder.addOffset(0, mosaicIdOffset);
    }
    if (mosaicAmountOffset != null) {
      fbBuilder.addOffset(1, mosaicAmountOffset);
    }
    if (costOffset != null) {
      fbBuilder.addOffset(2, costOffset);
    }
    fbBuilder.addUint8(3, _type);
    if (ownerOffset != null) {
      fbBuilder.addOffset(4, ownerOffset);
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

class RemoveExchangeOfferBuffer {
  factory RemoveExchangeOfferBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  RemoveExchangeOfferBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<RemoveExchangeOfferBuffer> reader = _RemoveExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int> get mosaicId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 4, null);

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 6, 0);

  @override
  String toString() => 'RemoveExchangeOfferBuffer{mosaicId: $mosaicId, type: $type}';
}

class _RemoveExchangeOfferBufferReader extends fb.TableReader<RemoveExchangeOfferBuffer> {
  const _RemoveExchangeOfferBufferReader();

  @override
  RemoveExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) => RemoveExchangeOfferBuffer._(bc, offset);
}

class RemoveExchangeOfferBufferBuilder {
  RemoveExchangeOfferBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addMosaicIdOffset(int offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addType(int type) {
    fbBuilder.addUint8(1, type);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class RemoveExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  RemoveExchangeOfferBufferObjectBuilder({
    List<int> mosaicId,
    int type,
  })  : _mosaicId = mosaicId,
        _type = type;

  final List<int> _mosaicId;
  final int _type;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int mosaicIdOffset = _mosaicId?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicId) : null;

    fbBuilder.startTable();
    if (mosaicIdOffset != null) {
      fbBuilder.addOffset(0, mosaicIdOffset);
    }
    fbBuilder.addUint8(1, _type);
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
