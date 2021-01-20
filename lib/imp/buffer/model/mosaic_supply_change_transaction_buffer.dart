part of xpx_chain_sdk.buffer.model;

class MosaicSupplyChangeTransactionBuffer {
  factory MosaicSupplyChangeTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MosaicSupplyChangeTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<MosaicSupplyChangeTransactionBuffer> reader = _MosaicSupplyChangeTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  List<int> get mosaicId => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 18, null);

  int get direction => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 20, 0);

  List<int> get delta => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 22, null);

  @override
  String toString() => 'MosaicSupplyChangeTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' mosaicId: $mosaicId,'
      ' direction: $direction,'
      ' delta: $delta}';
}

class _MosaicSupplyChangeTransactionBufferReader extends fb.TableReader<MosaicSupplyChangeTransactionBuffer> {
  const _MosaicSupplyChangeTransactionBufferReader();

  @override
  MosaicSupplyChangeTransactionBuffer createObject(fb.BufferContext bc, int offset) =>
      MosaicSupplyChangeTransactionBuffer._(bc, offset);
}

class MosaicSupplyChangeTransactionBufferBuilder {
  MosaicSupplyChangeTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addMosaicIdOffset(int offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addDirection(int direction) {
    fbBuilder.addUint8(8, direction);
    return fbBuilder.offset;
  }

  int addDeltaOffset(int offset) {
    fbBuilder.addOffset(9, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MosaicSupplyChangeTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  MosaicSupplyChangeTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    List<int> mosaicId,
    int direction,
    List<int> delta,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _mosaicId = mosaicId,
        _direction = direction,
        _delta = delta;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final List<int> _mosaicId;
  final int _direction;
  final List<int> _delta;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int mosaicIdOffset = _mosaicId?.isNotEmpty == true ? fbBuilder.writeListUint32(_mosaicId) : null;
    final int deltaOffset = _delta?.isNotEmpty == true ? fbBuilder.writeListUint32(_delta) : null;

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
    if (mosaicIdOffset != null) {
      fbBuilder.addOffset(7, mosaicIdOffset);
    }
    fbBuilder.addUint8(8, _direction);
    if (deltaOffset != null) {
      fbBuilder.addOffset(9, deltaOffset);
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
