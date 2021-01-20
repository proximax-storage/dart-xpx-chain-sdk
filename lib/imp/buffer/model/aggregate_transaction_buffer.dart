part of xpx_chain_sdk.buffer.model;

class AggregateTransactionBuffer {
  factory AggregateTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  AggregateTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<AggregateTransactionBuffer> reader = _AggregateTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get fee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  int get transactionsSize => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 18, 0);

  List<int> get transactions => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 20, null);

  @override
  String toString() => 'AggregateTransactionBuffer{'
      'size: $size,'
      ' signature: $signature,'
      ' signer: $signer,'
      ' version: $version,'
      ' type: $type,'
      ' fee: $fee,'
      ' deadline: $deadline,'
      ' transactionsSize: $transactionsSize,'
      ' transactions: $transactions}';
}

class _AggregateTransactionBufferReader extends fb.TableReader<AggregateTransactionBuffer> {
  const _AggregateTransactionBufferReader();

  @override
  AggregateTransactionBuffer createObject(fb.BufferContext bc, int offset) => AggregateTransactionBuffer._(bc, offset);
}

class AggregateTransactionBufferBuilder {
  AggregateTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null, 'fbBuilder must not be null');

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

  int addTransactionsSize(int transactionsSize) {
    fbBuilder.addUint32(7, transactionsSize);
    return fbBuilder.offset;
  }

  int addTransactionsOffset(int offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class AggregateTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  AggregateTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> fee,
    List<int> deadline,
    int transactionsSize,
    List<int> transactions,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _fee = fee,
        _deadline = deadline,
        _transactionsSize = transactionsSize,
        _transactions = transactions;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _fee;
  final List<int> _deadline;
  final int _transactionsSize;
  final List<int> _transactions;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null, 'fbBuilder must not be null');
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int feeOffset = _fee?.isNotEmpty == true ? fbBuilder.writeListUint32(_fee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int transactionsOffset = _transactions?.isNotEmpty == true ? fbBuilder.writeListUint8(_transactions) : null;

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

    fbBuilder.addUint32(7, _transactionsSize);
    if (transactionsOffset != null) {
      fbBuilder.addOffset(8, transactionsOffset);
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
