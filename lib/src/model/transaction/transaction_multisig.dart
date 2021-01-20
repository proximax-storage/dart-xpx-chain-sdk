part of xpx_chain_sdk.transaction;

class MultisigCosignatoryModification {
  MultisigCosignatoryModification(this.type, this.publicAccount);

  MultisigCosignatoryModification.fromDTO(int networkType, MultisigCosignatoryModificationDTO dto) {
    if (dto?.cosignatoryPublicKey == null) {
      return;
    }

    type = dto.type == 0 ? add : remove;
    publicAccount = PublicAccount.fromPublicKey(dto.cosignatoryPublicKey, networkType);
  }

  MultisigCosignatoryModificationType type;
  PublicAccount publicAccount;

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"type": ${type.index},')
      ..writeln('\t"publicAccount": $publicAccount')
      ..write('}');
    return sb.toString();
  }

  static List<MultisigCosignatoryModification> listFromDTO(
          int networkType, List<MultisigCosignatoryModificationDTO> dto) =>
      dto == null ? null : dto.map((value) => MultisigCosignatoryModification.fromDTO(networkType, value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type.index;
    data['publicAccount'] = publicAccount;
    return data;
  }
}

/// Create or modify a multisig contract.
/// Announce a modify multisig account transaction to:
/// a) Transform an account to multisig account.
/// b) Change the configurable properties of a multisig account.
/// c) Add or delete cosignatories from a multisig account.
///
class ModifyMultisigAccountTransaction extends AbstractTransaction implements Transaction {
  ModifyMultisigAccountTransaction(Deadline deadline, int minApproval, int minRemoval,
      List<MultisigCosignatoryModification> modifications, int networkType)
      : assert(modifications != null, 'modifications must not be null'),
        super() {
    if (modifications.isEmpty && minApproval == 0 && minRemoval == 0) {
      throw errEmptyModifications;
    } else {
      version = modifyMultisigVersion;
      this.deadline = deadline;
      type = TransactionType.modifyMultisig;
      this.networkType = networkType;
      minApprovalDelta = minApproval;
      minRemovalDelta = minRemoval;
      this.modifications = modifications;
    }
  }

  ModifyMultisigAccountTransaction.fromDTO(ModifyMultisigAccountTransactionInfoDTO dto)
      : assert(dto != null, 'dto must not be null'),
        super.fromDto(dto.transaction, dto.meta) {
    type = TransactionType.fromInt(dto.transaction.type);
    deadline = Deadline.fromUInt64DTO(dto.transaction.deadline);
    signature = dto.transaction.signature;
    networkType = extractNetworkType(dto.transaction.version);
    version = extractVersion(dto.transaction.version);
    maxFee = dto.transaction.fee.toUint64();
    signer = PublicAccount.fromPublicKey(dto.transaction.signer, networkType);

    minApprovalDelta = dto.transaction.minApprovalDelta;
    minRemovalDelta = dto.transaction.minRemovalDelta;
    modifications = MultisigCosignatoryModification.listFromDTO(networkType, dto.transaction.modifications);
  }

  int minApprovalDelta;
  int minRemovalDelta;
  List<MultisigCosignatoryModification> modifications;

  int get size => _size();

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  static List<ModifyMultisigAccountTransaction> listFromDTO(List<ModifyMultisigAccountTransactionInfoDTO> dto) =>
      dto == null ? null : dto.map((value) => ModifyMultisigAccountTransaction.fromDTO(value)).toList();

  @override
  String toString() {
    final sb = StringBuffer()
      ..writeln('{')
      ..writeln('\t"abstractTransaction": ${_absToString()}')
      ..writeln('\t"minApproval": $minApprovalDelta,')
      ..writeln('\t"minRemoval": $minRemovalDelta,')
      ..writeln('\t"modifications": $modifications')
      ..write('}');
    return sb.toString();
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['abstractTransaction'] = _absToJson();
    data['minApproval'] = minApprovalDelta;
    data['minRemoval'] = minRemovalDelta;
    data['modifications'] = modifications;

    return data;
  }

  @override
  int _size() => modifyMultisigHeaderSize + ((keySize + 1 /* MultisigModificationType size */) * modifications.length);

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = cosignatoryModificationArrayToBuffer(builder, modifications);

    final vectors = _generateVector(builder);

    final txnBuilder = ModifyMultisigAccountTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(_size())
      ..addMinRemovalDelta(minRemovalDelta)
      ..addMinApprovalDelta(minApprovalDelta)
      ..addNumModifications(modifications.length)
      ..addModificationsOffset(mV);
    _buildVector(builder, vectors);

    final codedModifyMultisigAccount = txnBuilder.finish();
    return modifyMultisigAccountTransactionSchema().serialize(builder.finish(codedModifyMultisigAccount));
  }
}
