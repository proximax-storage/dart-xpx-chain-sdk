part of xpx_chain_sdk.transaction;

/// Register a namespace to organize your assets.
/// Announce a [RegisterNamespaceTransaction] to register and re-rent a namespace.
///
class RegisterNamespaceTransaction extends AbstractTransaction implements Transaction {
  RegisterNamespaceTransaction.createRoot(Deadline deadline, String rootNamespaceName, Uint64 duration, int networkType)
      : super() {
    if (rootNamespaceName == null) {
      throw errInvalidNamespaceName;
    } else if (duration == null) {
      throw errNullDuration;
    } else {
      version = registerNamespaceVersion;
      this.deadline = deadline;
      type = TransactionType.registerNamespace;
      namespaceId = NamespaceId.fromName(rootNamespaceName);
      this.networkType = networkType;
      namespaceName = rootNamespaceName;
      namespaceType = NamespaceType.root;
      this.duration = duration;
    }
  }

  RegisterNamespaceTransaction.createSub(
      Deadline deadline, String subNamespaceName, String rootNamespaceName, int networkType)
      : super() {
    if (subNamespaceName == null || subNamespaceName == '') {
      throw errInvalidNamespaceName;
    } else if (rootNamespaceName == null || rootNamespaceName == '') {
      throw errInvalidNamespaceName;
    } else {
      version = registerNamespaceVersion;
      this.deadline = deadline;
      type = TransactionType.registerNamespace;
      parentId = NamespaceId.fromName(rootNamespaceName);
      namespaceId = NamespaceId(id: generateNamespaceId(subNamespaceName, parentId.toUint64()));
      this.networkType = networkType;
      namespaceName = subNamespaceName;
      namespaceType = NamespaceType.sub;
    }
  }

  RegisterNamespaceTransaction.fromDTO(RegisterNamespaceTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    namespaceId = NamespaceId(id: dto.transaction.namespaceId.toUint64());
    namespaceType = dto.transaction.namespaceType == 0 ? NamespaceType.root : NamespaceType.sub;
    namespaceName = dto.transaction.name;
    if (namespaceType == NamespaceType.root) {
      duration = dto.transaction.duration.toUint64();
    } else {
      parentId = NamespaceId(id: dto.transaction.parentId.toUint64());
    }
  }

  NamespaceId namespaceId;
  NamespaceType namespaceType;
  String namespaceName;
  Uint64 duration;
  NamespaceId parentId;

  int get size => _size();

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  static List<RegisterNamespaceTransaction> listFromDTO(List<RegisterNamespaceTransactionInfoDTO> data) =>
      data == null ? List : data.map((value) => RegisterNamespaceTransaction.fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('\n{')
      ..writeln('\t"abstractTransaction": ${_absToString()}')
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
    data['abstractTransaction'] = _absToJson();
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
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final nV = builder.writeListUint32(namespaceId.toIntArray());
    int dV;
    if (namespaceType == NamespaceType.root) {
      dV = builder.writeListUint32(duration.toIntArray());
    } else {
      dV = builder.writeListUint32(parentId.toIntArray());
    }

    final n = builder.writeString(namespaceName);

    final vector = _generateVector(builder);

    final txnBuilder = RegisterNamespaceTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addNamespaceType(namespaceType.index)
      ..addDurationParentIdOffset(dV)
      ..addNamespaceIdOffset(nV)
      ..addNamespaceNameSize(namespaceName.length)
      ..addNamespaceNameOffset(n);
    _buildVector(builder, vector);

    final codedRegisterNamespace = txnBuilder.finish();
    return registerNamespaceTransactionSchema().serialize(builder.finish(codedRegisterNamespace));
  }

  @override
  int _size() => registerNamespaceHeaderSize + namespaceName.length;
}
