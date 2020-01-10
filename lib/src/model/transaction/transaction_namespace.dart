part of xpx_chain_sdk.transaction;

/// Register a namespace to organize your assets.
/// Announce a [RegisterNamespaceTransaction] to register and re-rent a namespace.
///
class RegisterNamespaceTransaction extends AbstractTransaction
    implements Transaction {
  RegisterNamespaceTransaction.createRoot(Deadline deadline,
      String rootNamespaceName, BigInt duration, int networkType)
      : super() {
    if (rootNamespaceName == null) {
      throw errInvalidNamespaceName;
    } else if (duration == null) {
      throw errNullDuration;
    } else {
      version = registerNamespaceVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16718);
      namespaceId = NamespaceId.fromName(rootNamespaceName);
      this.networkType = networkType;
      namespaceName = rootNamespaceName;
      namespaceType = NamespaceType.root;
      this.duration = duration;
    }
  }

  RegisterNamespaceTransaction.createSub(Deadline deadline,
      String subNamespaceName, String rootNamespaceName, int networkType)
      : super() {
    if (subNamespaceName == null || subNamespaceName == '') {
      throw errInvalidNamespaceName;
    } else if (rootNamespaceName == null || rootNamespaceName == '') {
      throw errInvalidNamespaceName;
    } else {
      version = registerNamespaceVersion;
      this.deadline = deadline;
      type = transactionTypeFromRaw(16718);
      parentId = NamespaceId.fromName(rootNamespaceName);
      namespaceId =
          NamespaceId(id: generateId(subNamespaceName, parentId.toBigInt()));
      this.networkType = networkType;
      namespaceName = subNamespaceName;
      namespaceType = NamespaceType.sub;
    }
  }

  RegisterNamespaceTransaction.fromDTO(
      RegisterNamespaceTransactionInfoDTO value)
      : assert(value != null, 'value must not be null'),
        super.fromDto(value.transaction, value.meta) {
    namespaceId = NamespaceId(id: value.transaction.namespaceId.toBigInt());
    namespaceType = value.transaction.namespaceType == 0
        ? NamespaceType.root
        : NamespaceType.sub;
    namespaceName = value.transaction.name;
    if (namespaceType == NamespaceType.root) {
      duration = value.transaction.duration.toBigInt();
    } else {
      parentId = NamespaceId(id: value.transaction.parentId.toBigInt());
    }
  }

  NamespaceId namespaceId;
  NamespaceType namespaceType;
  String namespaceName;
  BigInt duration;
  NamespaceId parentId;

  static List<RegisterNamespaceTransaction> listFromDTO(
          List<RegisterNamespaceTransactionInfoDTO> data) =>
      data == null
          ? List
          : data
              .map((value) => RegisterNamespaceTransaction.fromDTO(value))
              .toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${abstractTransactionToString()}')
      ..writeln('\t"namespaceType": ${namespaceType.toString().split('.')[1]},')
      ..writeln('\t"namespaceName": $namespaceName,')
      ..writeln('\t"namespaceId": $namespaceId,');
    if (parentId != null) {
      sb.writeln('\t"parentId": ${parentId.toHex()},');
    }
    if (duration != null) {
      sb.writeln('\t"duration": $duration');
    }
    sb.write('}\n');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = abstractTransactionToJson();
    data['namespaceId'] = namespaceId.toHex();
    data['namespaceType'] = namespaceType;
    data['namespaceName'] = namespaceName;
    if (parentId != null) {
      data['parentId'] = parentId.toHex();
    }
    if (parentId != null) {
      data['duration'] = duration;
    }
    return data;
  }

  @override
  AbstractTransaction getAbstractTransaction() => abstractTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final nV = builder.writeListUint32(bigIntToArray(namespaceId.toBigInt()));
    int dV;
    if (namespaceType == NamespaceType.root) {
      dV = builder.writeListUint32(bigIntToArray(duration));
    } else {
      dV = builder.writeListUint32(bigIntToArray(parentId.toBigInt()));
    }

    final n = builder.writeString(namespaceName);

    final vector = generateVector(builder);

    final txnBuilder = RegisterNamespaceTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addNamespaceType(namespaceType.index)
      ..addDurationParentIdOffset(dV)
      ..addNamespaceIdOffset(nV)
      ..addNamespaceNameSize(namespaceName.length)
      ..addNamespaceNameOffset(n);
    buildVector(builder, vector);

    final codedRegisterNamespace = txnBuilder.finish();
    return registerNamespaceTransactionSchema()
        .serialize(builder.finish(codedRegisterNamespace));
  }

  @override
  int size() => registerNamespaceHeaderSize + namespaceName.length;
}
