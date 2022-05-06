/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Send mosaics and messages between two accounts.
/// Announce a [TransferTransaction] to send [Mosaic] or [Message] between two [Account].
///
class TransferTransaction extends AbstractTransaction implements Transaction {
  TransferTransaction.create(Deadline deadline, Address this.recipient,
      List<Mosaic> this.mosaics, Message this.message, NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.transfer, transferVersion,
            maxFee);

  TransferTransaction.fromDTO(TransferTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    mosaics = Mosaic.listFromDTO(dto.transaction!.mosaics);
    recipient = Address.fromEncoded(dto.transaction!.recipient!);
    message = dto.transaction!.message != null
        ? Message.fromDTO(dto.transaction!.message!)
        : null;
  }

  List<Mosaic>? mosaics;
  Address? recipient;
  Message? message;

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    void writeNotNull(String key, value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('mosaics', mosaics);
    writeNotNull('recipient', recipient);
    writeNotNull('message', message);

    return val;
  }

  int messageSize() => message!.payload.length + 1;

  @override
  int size() =>
      transferHeaderSize +
      (mosaicIdSize + amountSize) * mosaics!.length +
      messageSize();

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    /// Create mosaics
    final mb = List.generate(mosaics!.length, (_) => 0);
    int i = 0;
    for (final mosaic in mosaics!) {
      final id = builder.writeListUint32(mosaic.assetId!.toIntArray());
      final amount = builder.writeListUint32(mosaic.amount!.toIntArray());

      final ms = $buffer.MosaicBufferBuilder(builder)
        ..begin()
        ..addIdOffset(id)
        ..addAmountOffset(amount);
      mb[i] = ms.finish();
      i++;
    }

    /// Create message;
    final mp = builder.writeListUint8(this.message!.payload);
    final message = $buffer.MessageBufferBuilder(builder)
      ..begin()
      ..addType(this.message!.type.value)
      ..addPayloadOffset(mp);
    final int messageOffset = message.finish();

    final recipient = base32.decode(this.recipient!.address);
    final recipientOffset = builder.writeListUint8(recipient);
    final mosaicsOffset = builder.writeList(mb);

    final vectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.TransferTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addRecipientOffset(recipientOffset)
      ..addNumMosaics(mosaics!.length)
      ..addMessageSize(this.message!.payload.length + 1)
      ..addMessageOffset(messageOffset)
      ..addMosaicsOffset(mosaicsOffset);
    _buildCommonVector(builder, vectors);

    final codedTransfer = txnBuilder.finish();
    builder.finish(codedTransfer);
    return transferTransactionSchema().serialize(builder.buffer);
  }

  @override
  TransactionType entityType() => type;
}
