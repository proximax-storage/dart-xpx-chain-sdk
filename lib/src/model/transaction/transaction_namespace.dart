/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

/// Register a namespace to organize your assets.
/// Announce a [RegisterNamespaceTransaction] to register and re-rent a namespace.
///
class RegisterNamespaceTransaction extends AbstractTransaction
    implements Transaction {
  RegisterNamespaceTransaction.createRoot(Deadline deadline,
      String rootNamespaceName, Uint64 duration, NetworkType networkType,
      [Uint64? maxFee])
      : super(networkType, deadline, TransactionType.registerNamespace,
            registerNamespaceVersion, maxFee) {
    if (rootNamespaceName.isEmpty) {
      throw errInvalidNamespaceName;
    } else {
      namespaceId = NamespaceId.fromName(rootNamespaceName);
      namespaceName = rootNamespaceName;
      namespaceType = NamespaceType.root;
      this.duration = duration;
      maxFee ??= this.maxFee = calculateFee(size());
    }
  }

  RegisterNamespaceTransaction.createSub(
      Deadline deadline,
      String subNamespaceName,
      String rootNamespaceName,
      NetworkType networkType,
      {Uint64? maxFee})
      : super(networkType, deadline, TransactionType.registerNamespace,
            registerNamespaceVersion, maxFee) {
    if (subNamespaceName.isEmpty) {
      throw errInvalidNamespaceName;
    } else if (rootNamespaceName.isEmpty) {
      throw errInvalidNamespaceName;
    } else {
      parentId = NamespaceId.fromName(rootNamespaceName);
      namespaceId = NamespaceId(
          id: generateNamespaceId(subNamespaceName, parentId!.toUint64()!));
      namespaceName = subNamespaceName;
      namespaceType = NamespaceType.sub;
      maxFee ??= this.maxFee = calculateFee(size());
    }
  }

  RegisterNamespaceTransaction.fromDTO(RegisterNamespaceTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    namespaceId = NamespaceId(id: dto.transaction!.namespaceId!.toUint64());
    namespaceType = dto.transaction!.namespaceType == 0
        ? NamespaceType.root
        : NamespaceType.sub;
    namespaceName = dto.transaction!.name;
    if (namespaceType == NamespaceType.root) {
      duration = dto.transaction!.duration!.toUint64();
    } else {
      parentId = NamespaceId(id: dto.transaction!.parentId!.toUint64());
    }
  }

  late NamespaceId namespaceId;
  NamespaceType? namespaceType;
  String? namespaceName;
  Uint64? duration;
  NamespaceId? parentId;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

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

    writeNotNull('namespaceId', namespaceId.toHex());
    writeNotNull('namespaceType', namespaceType.toString());
    writeNotNull('namespaceName', namespaceName);
    writeNotNull('parentId', parentId);
    writeNotNull('duration', duration);
    return val;
  }

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final namespaceIdOffset = builder.writeListUint32(namespaceId.toIntArray());
    int durationParentIdOffset;
    if (namespaceType == NamespaceType.root) {
      durationParentIdOffset = builder.writeListUint32(duration!.toIntArray());
    } else {
      durationParentIdOffset = builder.writeListUint32(parentId!.toIntArray());
    }

    final namespaceNameOffset = builder.writeString(namespaceName!);

    final vector = _generateCommonVector(builder);

    final txnBuilder =
        $buffer.RegisterNamespaceTransactionBufferBuilder(builder)
          ..begin()
          ..addSize(size())
          ..addNamespaceType(namespaceType!.index)
          ..addDurationParentIdOffset(durationParentIdOffset)
          ..addNamespaceIdOffset(namespaceIdOffset)
          ..addNamespaceNameSize(namespaceName!.length)
          ..addNamespaceNameOffset(namespaceNameOffset);
    _buildCommonVector(builder, vector);

    final codedRegisterNamespace = txnBuilder.finish();
    builder.finish(codedRegisterNamespace);
    return registerNamespaceTransactionSchema().serialize(builder.buffer);
  }

  @override
  int size() => registerNamespaceHeaderSize + namespaceName!.length;
}
