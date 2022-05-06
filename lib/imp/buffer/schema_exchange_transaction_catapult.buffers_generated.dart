// automatically generated by the FlatBuffers compiler, do not modify
// ignore_for_file: unused_import, unused_field, unused_element, unused_local_variable

library catapult.buffers;

import 'dart:typed_data' show Uint8List;

import 'package:flat_buffers/flat_buffers.dart' as fb;

class AddExchangeOfferTransactionBuffer {
  AddExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);
  factory AddExchangeOfferTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<AddExchangeOfferTransactionBuffer> reader =
      _AddExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);
  List<int>? get signature =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get signer =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);
  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);
  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);
  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 14);
  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 16);
  int get offersCount =>
      const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);
  List<AddExchangeOfferBuffer>? get offers =>
      const fb.ListReader<AddExchangeOfferBuffer>(AddExchangeOfferBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 20);

  @override
  String toString() {
    return 'AddExchangeOfferTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, offersCount: ${offersCount}, offers: ${offers}}';
  }
}

class _AddExchangeOfferTransactionBufferReader
    extends fb.TableReader<AddExchangeOfferTransactionBuffer> {
  const _AddExchangeOfferTransactionBufferReader();

  @override
  AddExchangeOfferTransactionBuffer createObject(
          fb.BufferContext bc, int offset) =>
      AddExchangeOfferTransactionBuffer._(bc, offset);
}

class AddExchangeOfferTransactionBufferBuilder {
  AddExchangeOfferTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(9);
  }

  int addSize(int? size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addSignatureOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addSignerOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addVersion(int? version) {
    fbBuilder.addUint32(3, version);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint16(4, type);
    return fbBuilder.offset;
  }

  int addMaxFeeOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int? offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addOffersCount(int? offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class AddExchangeOfferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _offersCount;
  final List<AddExchangeOfferBufferObjectBuilder>? _offers;

  AddExchangeOfferTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? offersCount,
    List<AddExchangeOfferBufferObjectBuilder>? offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset =
        _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset =
        _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset =
        _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset =
        _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? offersOffset = _offers == null
        ? null
        : fbBuilder.writeList(
            _offers!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(9);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addUint8(7, _offersCount);
    fbBuilder.addOffset(8, offersOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ExchangeOfferTransactionBuffer {
  ExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);
  factory ExchangeOfferTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ExchangeOfferTransactionBuffer> reader =
      _ExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);
  List<int>? get signature =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get signer =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);
  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);
  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);
  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 14);
  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 16);
  int get offersCount =>
      const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);
  List<ExchangeOfferBuffer>? get offers =>
      const fb.ListReader<ExchangeOfferBuffer>(ExchangeOfferBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 20);

  @override
  String toString() {
    return 'ExchangeOfferTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, offersCount: ${offersCount}, offers: ${offers}}';
  }
}

class _ExchangeOfferTransactionBufferReader
    extends fb.TableReader<ExchangeOfferTransactionBuffer> {
  const _ExchangeOfferTransactionBufferReader();

  @override
  ExchangeOfferTransactionBuffer createObject(
          fb.BufferContext bc, int offset) =>
      ExchangeOfferTransactionBuffer._(bc, offset);
}

class ExchangeOfferTransactionBufferBuilder {
  ExchangeOfferTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(9);
  }

  int addSize(int? size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addSignatureOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addSignerOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addVersion(int? version) {
    fbBuilder.addUint32(3, version);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint16(4, type);
    return fbBuilder.offset;
  }

  int addMaxFeeOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int? offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addOffersCount(int? offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ExchangeOfferTransactionBufferObjectBuilder extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _offersCount;
  final List<ExchangeOfferBufferObjectBuilder>? _offers;

  ExchangeOfferTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? offersCount,
    List<ExchangeOfferBufferObjectBuilder>? offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset =
        _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset =
        _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset =
        _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset =
        _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? offersOffset = _offers == null
        ? null
        : fbBuilder.writeList(
            _offers!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(9);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addUint8(7, _offersCount);
    fbBuilder.addOffset(8, offersOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class RemoveExchangeOfferTransactionBuffer {
  RemoveExchangeOfferTransactionBuffer._(this._bc, this._bcOffset);
  factory RemoveExchangeOfferTransactionBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<RemoveExchangeOfferTransactionBuffer> reader =
      _RemoveExchangeOfferTransactionBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  int get size => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 4, 0);
  List<int>? get signature =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get signer =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 8);
  int get version => const fb.Uint32Reader().vTableGet(_bc, _bcOffset, 10, 0);
  int get type => const fb.Uint16Reader().vTableGet(_bc, _bcOffset, 12, 0);
  List<int>? get maxFee => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 14);
  List<int>? get deadline => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 16);
  int get offersCount =>
      const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 18, 0);
  List<RemoveExchangeOfferBuffer>? get offers =>
      const fb.ListReader<RemoveExchangeOfferBuffer>(
              RemoveExchangeOfferBuffer.reader)
          .vTableGetNullable(_bc, _bcOffset, 20);

  @override
  String toString() {
    return 'RemoveExchangeOfferTransactionBuffer{size: ${size}, signature: ${signature}, signer: ${signer}, version: ${version}, type: ${type}, maxFee: ${maxFee}, deadline: ${deadline}, offersCount: ${offersCount}, offers: ${offers}}';
  }
}

class _RemoveExchangeOfferTransactionBufferReader
    extends fb.TableReader<RemoveExchangeOfferTransactionBuffer> {
  const _RemoveExchangeOfferTransactionBufferReader();

  @override
  RemoveExchangeOfferTransactionBuffer createObject(
          fb.BufferContext bc, int offset) =>
      RemoveExchangeOfferTransactionBuffer._(bc, offset);
}

class RemoveExchangeOfferTransactionBufferBuilder {
  RemoveExchangeOfferTransactionBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(9);
  }

  int addSize(int? size) {
    fbBuilder.addUint32(0, size);
    return fbBuilder.offset;
  }

  int addSignatureOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addSignerOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addVersion(int? version) {
    fbBuilder.addUint32(3, version);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint16(4, type);
    return fbBuilder.offset;
  }

  int addMaxFeeOffset(int? offset) {
    fbBuilder.addOffset(5, offset);
    return fbBuilder.offset;
  }

  int addDeadlineOffset(int? offset) {
    fbBuilder.addOffset(6, offset);
    return fbBuilder.offset;
  }

  int addOffersCount(int? offersCount) {
    fbBuilder.addUint8(7, offersCount);
    return fbBuilder.offset;
  }

  int addOffersOffset(int? offset) {
    fbBuilder.addOffset(8, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class RemoveExchangeOfferTransactionBufferObjectBuilder
    extends fb.ObjectBuilder {
  final int? _size;
  final List<int>? _signature;
  final List<int>? _signer;
  final int? _version;
  final int? _type;
  final List<int>? _maxFee;
  final List<int>? _deadline;
  final int? _offersCount;
  final List<RemoveExchangeOfferBufferObjectBuilder>? _offers;

  RemoveExchangeOfferTransactionBufferObjectBuilder({
    int? size,
    List<int>? signature,
    List<int>? signer,
    int? version,
    int? type,
    List<int>? maxFee,
    List<int>? deadline,
    int? offersCount,
    List<RemoveExchangeOfferBufferObjectBuilder>? offers,
  })  : _size = size,
        _signature = signature,
        _signer = signer,
        _version = version,
        _type = type,
        _maxFee = maxFee,
        _deadline = deadline,
        _offersCount = offersCount,
        _offers = offers;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? signatureOffset =
        _signature == null ? null : fbBuilder.writeListUint8(_signature!);
    final int? signerOffset =
        _signer == null ? null : fbBuilder.writeListUint8(_signer!);
    final int? maxFeeOffset =
        _maxFee == null ? null : fbBuilder.writeListUint32(_maxFee!);
    final int? deadlineOffset =
        _deadline == null ? null : fbBuilder.writeListUint32(_deadline!);
    final int? offersOffset = _offers == null
        ? null
        : fbBuilder.writeList(
            _offers!.map((b) => b.getOrCreateOffset(fbBuilder)).toList());
    fbBuilder.startTable(9);
    fbBuilder.addUint32(0, _size);
    fbBuilder.addOffset(1, signatureOffset);
    fbBuilder.addOffset(2, signerOffset);
    fbBuilder.addUint32(3, _version);
    fbBuilder.addUint16(4, _type);
    fbBuilder.addOffset(5, maxFeeOffset);
    fbBuilder.addOffset(6, deadlineOffset);
    fbBuilder.addUint8(7, _offersCount);
    fbBuilder.addOffset(8, offersOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class AddExchangeOfferBuffer {
  AddExchangeOfferBuffer._(this._bc, this._bcOffset);
  factory AddExchangeOfferBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<AddExchangeOfferBuffer> reader =
      _AddExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get mosaicId => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);
  List<int>? get mosaicAmount => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get cost => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 8);
  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 10, 0);
  List<int>? get duration => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 12);

  @override
  String toString() {
    return 'AddExchangeOfferBuffer{mosaicId: ${mosaicId}, mosaicAmount: ${mosaicAmount}, cost: ${cost}, type: ${type}, duration: ${duration}}';
  }
}

class _AddExchangeOfferBufferReader
    extends fb.TableReader<AddExchangeOfferBuffer> {
  const _AddExchangeOfferBufferReader();

  @override
  AddExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) =>
      AddExchangeOfferBuffer._(bc, offset);
}

class AddExchangeOfferBufferBuilder {
  AddExchangeOfferBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(5);
  }

  int addMosaicIdOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addMosaicAmountOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addCostOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint8(3, type);
    return fbBuilder.offset;
  }

  int addDurationOffset(int? offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class AddExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  final List<int>? _mosaicId;
  final List<int>? _mosaicAmount;
  final List<int>? _cost;
  final int? _type;
  final List<int>? _duration;

  AddExchangeOfferBufferObjectBuilder({
    List<int>? mosaicId,
    List<int>? mosaicAmount,
    List<int>? cost,
    int? type,
    List<int>? duration,
  })  : _mosaicId = mosaicId,
        _mosaicAmount = mosaicAmount,
        _cost = cost,
        _type = type,
        _duration = duration;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? mosaicIdOffset =
        _mosaicId == null ? null : fbBuilder.writeListUint32(_mosaicId!);
    final int? mosaicAmountOffset = _mosaicAmount == null
        ? null
        : fbBuilder.writeListUint32(_mosaicAmount!);
    final int? costOffset =
        _cost == null ? null : fbBuilder.writeListUint32(_cost!);
    final int? durationOffset =
        _duration == null ? null : fbBuilder.writeListUint32(_duration!);
    fbBuilder.startTable(5);
    fbBuilder.addOffset(0, mosaicIdOffset);
    fbBuilder.addOffset(1, mosaicAmountOffset);
    fbBuilder.addOffset(2, costOffset);
    fbBuilder.addUint8(3, _type);
    fbBuilder.addOffset(4, durationOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class ExchangeOfferBuffer {
  ExchangeOfferBuffer._(this._bc, this._bcOffset);
  factory ExchangeOfferBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<ExchangeOfferBuffer> reader =
      _ExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get mosaicId => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);
  List<int>? get mosaicAmount => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 6);
  List<int>? get cost => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 8);
  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 10, 0);
  List<int>? get owner =>
      const fb.Uint8ListReader().vTableGetNullable(_bc, _bcOffset, 12);

  @override
  String toString() {
    return 'ExchangeOfferBuffer{mosaicId: ${mosaicId}, mosaicAmount: ${mosaicAmount}, cost: ${cost}, type: ${type}, owner: ${owner}}';
  }
}

class _ExchangeOfferBufferReader extends fb.TableReader<ExchangeOfferBuffer> {
  const _ExchangeOfferBufferReader();

  @override
  ExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) =>
      ExchangeOfferBuffer._(bc, offset);
}

class ExchangeOfferBufferBuilder {
  ExchangeOfferBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(5);
  }

  int addMosaicIdOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addMosaicAmountOffset(int? offset) {
    fbBuilder.addOffset(1, offset);
    return fbBuilder.offset;
  }

  int addCostOffset(int? offset) {
    fbBuilder.addOffset(2, offset);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint8(3, type);
    return fbBuilder.offset;
  }

  int addOwnerOffset(int? offset) {
    fbBuilder.addOffset(4, offset);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class ExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  final List<int>? _mosaicId;
  final List<int>? _mosaicAmount;
  final List<int>? _cost;
  final int? _type;
  final List<int>? _owner;

  ExchangeOfferBufferObjectBuilder({
    List<int>? mosaicId,
    List<int>? mosaicAmount,
    List<int>? cost,
    int? type,
    List<int>? owner,
  })  : _mosaicId = mosaicId,
        _mosaicAmount = mosaicAmount,
        _cost = cost,
        _type = type,
        _owner = owner;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? mosaicIdOffset =
        _mosaicId == null ? null : fbBuilder.writeListUint32(_mosaicId!);
    final int? mosaicAmountOffset = _mosaicAmount == null
        ? null
        : fbBuilder.writeListUint32(_mosaicAmount!);
    final int? costOffset =
        _cost == null ? null : fbBuilder.writeListUint32(_cost!);
    final int? ownerOffset =
        _owner == null ? null : fbBuilder.writeListUint8(_owner!);
    fbBuilder.startTable(5);
    fbBuilder.addOffset(0, mosaicIdOffset);
    fbBuilder.addOffset(1, mosaicAmountOffset);
    fbBuilder.addOffset(2, costOffset);
    fbBuilder.addUint8(3, _type);
    fbBuilder.addOffset(4, ownerOffset);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}

class RemoveExchangeOfferBuffer {
  RemoveExchangeOfferBuffer._(this._bc, this._bcOffset);
  factory RemoveExchangeOfferBuffer(List<int> bytes) {
    final rootRef = fb.BufferContext.fromBytes(bytes);
    return reader.read(rootRef, 0);
  }

  static const fb.Reader<RemoveExchangeOfferBuffer> reader =
      _RemoveExchangeOfferBufferReader();

  final fb.BufferContext _bc;
  final int _bcOffset;

  List<int>? get mosaicId => const fb.ListReader<int>(fb.Uint32Reader())
      .vTableGetNullable(_bc, _bcOffset, 4);
  int get type => const fb.Uint8Reader().vTableGet(_bc, _bcOffset, 6, 0);

  @override
  String toString() {
    return 'RemoveExchangeOfferBuffer{mosaicId: ${mosaicId}, type: ${type}}';
  }
}

class _RemoveExchangeOfferBufferReader
    extends fb.TableReader<RemoveExchangeOfferBuffer> {
  const _RemoveExchangeOfferBufferReader();

  @override
  RemoveExchangeOfferBuffer createObject(fb.BufferContext bc, int offset) =>
      RemoveExchangeOfferBuffer._(bc, offset);
}

class RemoveExchangeOfferBufferBuilder {
  RemoveExchangeOfferBufferBuilder(this.fbBuilder);

  final fb.Builder fbBuilder;

  void begin() {
    fbBuilder.startTable(2);
  }

  int addMosaicIdOffset(int? offset) {
    fbBuilder.addOffset(0, offset);
    return fbBuilder.offset;
  }

  int addType(int? type) {
    fbBuilder.addUint8(1, type);
    return fbBuilder.offset;
  }

  int finish() {
    return fbBuilder.endTable();
  }
}

class RemoveExchangeOfferBufferObjectBuilder extends fb.ObjectBuilder {
  final List<int>? _mosaicId;
  final int? _type;

  RemoveExchangeOfferBufferObjectBuilder({
    List<int>? mosaicId,
    int? type,
  })  : _mosaicId = mosaicId,
        _type = type;

  /// Finish building, and store into the [fbBuilder].
  @override
  int finish(fb.Builder fbBuilder) {
    final int? mosaicIdOffset =
        _mosaicId == null ? null : fbBuilder.writeListUint32(_mosaicId!);
    fbBuilder.startTable(2);
    fbBuilder.addOffset(0, mosaicIdOffset);
    fbBuilder.addUint8(1, _type);
    return fbBuilder.endTable();
  }

  /// Convenience method to serialize to byte list.
  @override
  Uint8List toBytes([String? fileIdentifier]) {
    final fbBuilder = fb.Builder(deduplicateTables: false);
    fbBuilder.finish(finish(fbBuilder), fileIdentifier);
    return fbBuilder.buffer;
  }
}