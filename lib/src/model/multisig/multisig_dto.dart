part of xpx_chain_sdk.multisig;

class MultisigCosignatoryModificationDTO {
  MultisigCosignatoryModificationDTO(this.type, this.cosignatoryPublicKey);

  MultisigCosignatoryModificationDTO.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    cosignatoryPublicKey = json['cosignatoryPublicKey'];
  }

  int type;
  String cosignatoryPublicKey;

  static List<MultisigCosignatoryModificationDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => MultisigCosignatoryModificationDTO.fromJson(value)).toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['cosignatoryPublicKey'] = cosignatoryPublicKey;
    return data;
  }
}

class ModifyMultisigAccountTransactionInfoDTO {
  ModifyMultisigAccountTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction =
        json['transaction'] != null ? _ModifyMultisigAccountTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  _ModifyMultisigAccountTransactionDTO transaction;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta.toJson();
    }
    if (transaction != null) {
      data['transaction'] = transaction.toJson();
    }
    return data;
  }
}

class _ModifyMultisigAccountTransactionDTO extends AbstractTransactionDTO {
  _ModifyMultisigAccountTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    modifications = MultisigCosignatoryModificationDTO.listFromJson(json['modifications']);
    minApprovalDelta = json['minApprovalDelta'];
    minRemovalDelta = json['minRemovalDelta'];
  }

  int minApprovalDelta;
  int minRemovalDelta;
  List<MultisigCosignatoryModificationDTO> modifications;

  List<dynamic> transactions;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'signer': signer,
        'version': version,
        'type': type,
        'maxFee': fee,
        'deadline': deadline,
        'minApprovalDelta': minApprovalDelta,
        'minRemovalDelta': minRemovalDelta,
        'modifications': modifications,
      };
}
