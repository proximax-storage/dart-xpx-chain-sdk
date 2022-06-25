/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class MultisigCosignatoryModification {
  MultisigCosignatoryModification(this.type, this.publicAccount);

  MultisigCosignatoryModification.fromDTO(int? networkType, MultisigCosignatoryModificationDTO dto) {
    if (dto.cosignatoryPublicKey == null) {
      return;
    }

    type = dto.type == 0 ? add : remove;
    publicAccount = PublicAccount.fromPublicKey(dto.cosignatoryPublicKey, NetworkType.fromInt(networkType!));
  }

  MultisigCosignatoryModificationType? type;
  PublicAccount? publicAccount;

  @override
  String toString() => encoder.convert(this);

  static List<MultisigCosignatoryModification>? listFromDTO(
          int? networkType, List<MultisigCosignatoryModificationDTO>? dto) =>
      dto == null ? null : dto.map((value) => MultisigCosignatoryModification.fromDTO(networkType, value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type!.index;
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
  ModifyMultisigAccountTransaction.create(Deadline deadline, int minApproval, int minRemoval,
      List<MultisigCosignatoryModification> modifications, NetworkType networkType,
      [Uint64? maxFee])
      : assert(modifications.isNotEmpty, 'modifications must not be empty'),
        super(networkType, deadline, TransactionType.modifyMultisig, modifyMultisigAccountVersion, maxFee) {
    if (modifications.isEmpty && minApproval == 0 && minRemoval == 0) {
      throw errEmptyModifications;
    } else {
      minApprovalDelta = minApproval;
      minRemovalDelta = minRemoval;
      this.modifications = modifications;
    }
  }

  ModifyMultisigAccountTransaction.fromDTO(ModifyMultisigAccountTransactionInfoDTO dto)
      : super.fromDto(dto.transaction!, dto.meta!) {
    minApprovalDelta = dto.transaction!.minApprovalDelta;
    minRemovalDelta = dto.transaction!.minRemovalDelta;
    modifications = MultisigCosignatoryModification.listFromDTO(networkType.identifier, dto.transaction!.modifications);
  }

  int? minApprovalDelta;
  int? minRemovalDelta;
  List<MultisigCosignatoryModification>? modifications;

  @override
  TransactionType entityType() => type;

  AbstractTransaction get abstractTransaction => absTransaction();

  static List<ModifyMultisigAccountTransaction> listFromDTO(List<ModifyMultisigAccountTransactionInfoDTO> dto) =>
      dto.isEmpty ? <ModifyMultisigAccountTransaction>[] : dto.map(ModifyMultisigAccountTransaction.fromDTO).toList();

  @override
  String toString() => encoder.convert(this);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> val = {}..addAll(_absToJson());

    val['minApproval'] = minApprovalDelta;
    val['minRemoval'] = minRemovalDelta;
    val['modifications'] = modifications;

    return val;
  }

  @override
  int size() => modifyMultisigHeaderSize + ((keySize + 1 /* MultisigModificationType size */) * modifications!.length);

  @override
  AbstractTransaction absTransaction() => _absTransaction();

  @override
  Uint8List generateBytes() {
    final builder = fb.Builder(initialSize: 0);

    final mV = cosignatoryModificationArrayToBuffer(builder, modifications!);

    final vectors = _generateCommonVector(builder);

    final txnBuilder = $buffer.ModifyMultisigAccountTransactionBufferBuilder(builder)
      ..begin()
      ..addSize(size())
      ..addMinRemovalDelta(minRemovalDelta!)
      ..addMinApprovalDelta(minApprovalDelta!)
      ..addNumModifications(modifications!.length)
      ..addModificationsOffset(mV);
    _buildCommonVector(builder, vectors);

    final codedModifyMultisigAccount = txnBuilder.finish();
    builder.finish(codedModifyMultisigAccount);
    return modifyMultisigAccountTransactionSchema().serialize(builder.buffer);
  }
}
