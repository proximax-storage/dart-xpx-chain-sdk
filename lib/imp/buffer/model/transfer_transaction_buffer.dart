part of xpx_chain_sdk.buffer.model;

class MessageBuffer {
  factory MessageBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MessageBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<MessageBuffer> reader = _MessageBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get payload => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  @override
  String toString() => 'MessageBuffer{type: $type, payload: $payload}';
}

class _MessageBufferReader extends fb.TableReader<MessageBuffer> {
  const _MessageBufferReader();

  @override
  MessageBuffer createObject(fb.BufferContext bc, int offset) => MessageBuffer._(bc, offset);
}

class MessageBufferBuilder {
  MessageBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addType(int type) {
    fbBuilder.addUint8(0, type);
    return fbBuilder.offset;
  }

  int addPayloadOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MessageBufferObjectBuilder extends fb.ObjectBuilder {
  MessageBufferObjectBuilder({
    int type,
    List<int> payload,
  })  : _type = type,
        _payload = payload;

  final int _type;
  final List<int> _payload;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int payloadOffset = _payload?.isNotEmpty == true ? fbBuilder.writeListUint8(_payload) : null;

    fbBuilder.startTable();
    fbBuilder.addUint8(0, _type);
    if (payloadOffset != null) {
      fbBuilder.addOffset(1, payloadOffset);
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

class MosaicBuffer {
  factory MosaicBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  MosaicBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<MosaicBuffer> reader = _MosaicBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int> get id => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 4, null);

  List<int> get amount => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 6, null);

  @override
  String toString() => 'MosaicBuffer{id: $id, amount: $amount}';
}

class _MosaicBufferReader extends fb.TableReader<MosaicBuffer> {
  const _MosaicBufferReader();

  @override
  MosaicBuffer createObject(fb.BufferContext bc, int offset) => MosaicBuffer._(bc, offset);
}

class MosaicBufferBuilder {
  MosaicBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable();
  }

  int addIdOffset(int offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addAmountOffset(int offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class MosaicBufferObjectBuilder extends fb.ObjectBuilder {
  MosaicBufferObjectBuilder({
    List<int> id,
    List<int> amount,
  })  : _id = id,
        _amount = amount;

  final List<int> _id;
  final List<int> _amount;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int idOffset = _id?.isNotEmpty == true ? fbBuilder.writeListUint32(_id) : null;
    final int amountOffset = _amount?.isNotEmpty == true ? fbBuilder.writeListUint32(_amount) : null;

    fbBuilder.startTable();
    if (idOffset != null) {
      fbBuilder.addOffset(0, idOffset);
    }
    if (amountOffset != null) {
      fbBuilder.addOffset(1, amountOffset);
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

class TransferTransactionBuffer {
  factory TransferTransactionBuffer(List<int> bytes) {
    final fb.BufferContext rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  TransferTransactionBuffer._(this._bc, this._bcOffset);

  static const fb.Reader<TransferTransactionBuffer> reader = _TransferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);

  List<int> get signature => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 6, null);

  List<int> get signer => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 8, null);

  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);

  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);

  List<int> get maxFee => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 14, null);

  List<int> get deadline => const fb.ListReader<int>(fb.Uint32Reader()).vTableGet(_bc, _bcOffset, 16, null);

  List<int> get recipient => const fb.ListReader<int>(fb.Uint8Reader()).vTableGet(_bc, _bcOffset, 18, null);

  int get messageSize => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 20, 0);

  int get numMosaics => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 22, 0);

  MessageBuffer get message => MessageBuffer.reader.vTableGet(_bc, _bcOffset, 24, null);

  List<MosaicBuffer> get mosaics =>
      const fb.ListReader<MosaicBuffer>(MosaicBuffer.reader).vTableGet(_bc, _bcOffset, 26, null);

  @override
  String toString() =>
      'TransferTransactionBuffer{size: $size, signature: $signature, signer: $signer, version: $version, type: $type, maxFee: $maxFee, deadline: $deadline, recipient: $recipient, messageSize: $messageSize, numMosaics: $numMosaics, message: $message, mosaics: $mosaics}';
}

class _TransferTransactionBufferReader extends fb.TableReader<TransferTransactionBuffer> {
  const _TransferTransactionBufferReader();

  @override
  TransferTransactionBuffer createObject(fb.BufferContext bc, int offset) => TransferTransactionBuffer._(bc, offset);
}

class TransferTransactionBufferBuilder {
  TransferTransactionBufferBuilder(this.fbBuilder) : assert(fbBuilder != null);

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

  int addRecipientOffset(int offset) {
    fbBuilder.addOffset(7, offset);
    return fbBuilder.offset;
  }

  int addMessageSize(int messageSize) {
    fbBuilder.addUint16(8, messageSize);
    return fbBuilder.offset;
  }

  int addNumMosaics(int numMosaics) {
    fbBuilder.addUint8(9, numMosaics);
    return fbBuilder.offset;
  }

  int addMessageOffset(int offset) {
    fbBuilder.addOffset(10, offset);
    return fbBuilder.offset;
  }

  int addMosaicsOffset(int offset) {
    fbBuilder.addOffset(11, offset);
    return fbBuilder.offset;
  }

  int finish() => fbBuilder.endTable();
}

class TransferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  TransferTransactionBufferObjectBuilder({
    int size,
    List<int> signature,
    List<int> signer,
    int version,
    int type,
    List<int> maxFee,
    List<int> deadline,
    List<int> recipient,
    int messageSize,
    int numMosaics,
    MessageBufferObjectBuilder message,
    List<MosaicBufferObjectBuilder> mosaics,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _recipient = recipient,
        _messageSize = messageSize,
        _numMosaics = numMosaics,
        _message = message,
        _mosaics = mosaics;

  final int _size;
  final List<int> _signature;
  final List<int> _signer;
  final int _version;
  final int _type;
  final List<int> _maxFee;
  final List<int> _deadline;
  final List<int> _recipient;
  final int _messageSize;
  final int _numMosaics;
  final MessageBufferObjectBuilder _message;
  final List<MosaicBufferObjectBuilder> _mosaics;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    assert(fbBuilder != null);
    final int signatureOffset = _signature?.isNotEmpty == true ? fbBuilder.writeListUint8(_signature) : null;
    final int signerOffset = _signer?.isNotEmpty == true ? fbBuilder.writeListUint8(_signer) : null;
    final int maxFeeOffset = _maxFee?.isNotEmpty == true ? fbBuilder.writeListUint32(_maxFee) : null;
    final int deadlineOffset = _deadline?.isNotEmpty == true ? fbBuilder.writeListUint32(_deadline) : null;
    final int recipientOffset = _recipient?.isNotEmpty == true ? fbBuilder.writeListUint8(_recipient) : null;
    final int messageOffset = _message?.getOrCreateOffset(fbBuilder);
    final int mosaicsOffset = _mosaics?.isNotEmpty == true
        ? fbBuilder.writeList(_mosaics.map((b) => b.getOrCreateOffset(fbBuilder)).toList())
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
    if (recipientOffset != null) {
      fbBuilder.addOffset(7, recipientOffset);
    }
    fbBuilder.addUint16(8, _messageSize);
    fbBuilder.addUint8(9, _numMosaics);
    if (messageOffset != null) {
      fbBuilder.addOffset(10, messageOffset);
    }
    if (mosaicsOffset != null) {
      fbBuilder.addOffset(11, mosaicsOffset);
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
