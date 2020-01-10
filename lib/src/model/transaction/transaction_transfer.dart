part of xpx_chain_sdk.transaction;

/// Send mosaics and messages between two accounts.
/// Announce a [TransferTransaction] to send [Mosaic] or [Message] between two [Account].
///
class TransferTransaction extends AbstractTransaction implements Transaction {
  TransferTransaction(Deadline deadline, Address recipient,
      List<Mosaic> mosaics, Message message, int networkType)
      : super() {
    if (recipient == null) {
      throw errNullRecipient;
    } else if (mosaics == null) {
      throw errNullMosaics;
    } else if (message == null) {
      throw errNullMessage;
    } else {
      version = transferVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16724);
      this.recipient = recipient;
      this.mosaics = mosaics;
      this.message = message;
      this.networkType = networkType;
    }
  }

  TransferTransaction.fromDTO(_TransferTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value._transaction, value.meta) {
    mosaics = Mosaic.listFromDTO(value._transaction._mosaics);
    recipient = Address.fromEncoded(value._transaction._recipient);
    message = value._transaction._message != null
        ? Message.fromDTO(value._transaction._message)
        : null;
  }

  List<Mosaic> mosaics;
  Address recipient;
  Message message;

  static List<TransferTransaction> listFromDTO(
          List<_TransferTransactionInfoDTO> json) =>
      json == null
          ? null
          : json.map((value) => TransferTransaction.fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${abstractTransactionToString()}')
      ..writeln('\t"recipient": $recipient')
      ..writeln('\t"mosaics": ${mosaics.map((v) => v.toJson()).toList()},');
    if (message != null) {
      sb.writeln('\t"message": $message,');
    }
    sb.write('}\n');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    if (mosaics != null) {
      data['mosaics'] = mosaics.map((v) => v.toJson()).toList();
    }
    data['recipient'] = recipient?.toJson();
    data['message'] = message;
    return data;
  }

  int messageSize() => message.payload.length + 1;

  @override
  int size() =>
      transferHeaderSize +
      (mosaicIdSize + amountSize) * mosaics.length +
      messageSize();

  @override
  AbstractTransaction getAbstractTransaction() => abstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final List<int> mb = List(mosaics.length);
    int i = 0;
    for (final mosaic in mosaics) {
      final id = builder.writeListUint32(mosaic.assetId.toArray());
      final amount = builder.writeListUint32(mosaic.amount.toIntArray());

      final ms = MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    }

    /// Create message;
    final mp = builder.writeListUint8(this.message.payload);
    final message = MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message.type.value)
      ..addPayloadOffset(mp);
    final int m = message.finish();

    final recipient = base32.decode(this.recipient.address);

    final rV = builder.writeListUint8(recipient);

    final mV = builder.writeList(mb);

    final vectors = generateVector(builder);

    final txnBuilder = TransferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addRecipientOffset(rV)
      ..addNumMosaics(mosaics.length)
      ..addMessageSize(this.message.payload.length + 1)
      ..addMessageOffset(m)
      ..addMosaicsOffset(mV);
    buildVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();

    return transferTransactionSchema().serialize(builder.finish(codedTransfer));
  }
}
