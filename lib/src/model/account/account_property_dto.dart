part of xpx_chain_sdk.account;

class AccountPropertyDTO {
  AccountPropertyDTO.fromJson(Map<String, dynamic> json) : assert(json != null, 'json must not be null') {
    propertyType = json['propertyType'];

    if (propertyType & 0x01 != 0) {
      addresses = List<String>.from(json['values']);
    } else if (propertyType & 0x02 != 0) {
      mosaicIds = UInt64DTO.listFromJson(json['values']);
    } else if (propertyType & 0x04 != 0) {
      entityTypes = List<int>.from(json['values']);
    } else {
      throw errUnknownPropertyType;
    }
  }

  int propertyType;
  List<String> addresses;
  List<UInt64DTO> mosaicIds;
  List<int> entityTypes;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['propertyType'] = propertyType;
    data['addresses'] = addresses;
    data['mosaicIds'] = mosaicIds;
    data['entityTypes'] = entityTypes;

    return data;
  }

  static List<AccountPropertyDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertyDTO.fromJson(value)).toList();

  static Map<String, AccountPropertyDTO> mapFromJson(Map<String, Map<String, dynamic>> json) {
    final map = <String, AccountPropertyDTO>{};
    if (json != null && json.isNotEmpty) {
      json.forEach((key, value) => map[key] = AccountPropertyDTO.fromJson(value));
    }
    return map;
  }
}

class AccountPropertiesAddressModificationDTO {
  AccountPropertiesAddressModificationDTO(this.modificationType, this.address);

  AccountPropertiesAddressModificationDTO.fromJson(Map<String, dynamic> json) {
    modificationType = json['type'];
    address = json['value'];
  }

  int modificationType;
  String address;

  static List<AccountPropertiesAddressModificationDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesAddressModificationDTO.fromJson(value)).toList();
}

class AccountPropertiesAddressTransactionInfoDTO {
  AccountPropertiesAddressTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction =
        json['transaction'] != null ? AccountPropertiesAddressTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  AccountPropertiesAddressTransactionDTO transaction;

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

class AccountPropertiesAddressTransactionDTO extends AbstractTransactionDTO {
  AccountPropertiesAddressTransactionDTO(
      {String signature, String signer, int version, int type, List<int> maxFee, List<int> deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  AccountPropertiesAddressTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    propertyType = json['propertyType'];
    modifications = AccountPropertiesAddressModificationDTO.listFromJson(json['modifications']);
  }

  List<AccountPropertiesAddressModificationDTO> modifications;
  int propertyType;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['propertyType'] = propertyType;
    data['modifications'] = modifications;

    return data;
  }
}

class AccountPropertiesMosaicModificationDTO {
  AccountPropertiesMosaicModificationDTO(this.modificationType, this.assetId);

  AccountPropertiesMosaicModificationDTO.fromJson(Map<String, dynamic> json) {
    modificationType = json['type'];
    assetId = UInt64DTO.fromJson(json['value']);
  }

  int modificationType;
  UInt64DTO assetId;

  static List<AccountPropertiesMosaicModificationDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesMosaicModificationDTO.fromJson(value)).toList();
}

class AccountPropertiesMosaicTransactionInfoDTO {
  AccountPropertiesMosaicTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction =
        json['transaction'] != null ? AccountPropertiesMosaicTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  AccountPropertiesMosaicTransactionDTO transaction;

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

class AccountPropertiesMosaicTransactionDTO extends AbstractTransactionDTO {
  AccountPropertiesMosaicTransactionDTO(
      {String signature, String signer, int version, int type, List<int> maxFee, List<int> deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  AccountPropertiesMosaicTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    propertyType = json['propertyType'];
    modifications = AccountPropertiesMosaicModificationDTO.listFromJson(json['modifications']);
  }

  List<AccountPropertiesMosaicModificationDTO> modifications;
  int propertyType;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['propertyType'] = propertyType;
    data['modifications'] = modifications;

    return data;
  }
}

class AccountPropertiesEntityTypeModificationDTO {
  AccountPropertiesEntityTypeModificationDTO(this.modificationType, this.entityType);

  AccountPropertiesEntityTypeModificationDTO.fromJson(Map<String, dynamic> json) {
    modificationType = json['type'];
    entityType = json['value'];
  }

  int modificationType;
  int entityType;

  static List<AccountPropertiesEntityTypeModificationDTO> listFromJson(List<dynamic> json) =>
      json == null ? null : json.map((value) => AccountPropertiesEntityTypeModificationDTO.fromJson(value)).toList();
}

class AccountPropertiesEntityTypeTransactionInfoDTO {
  AccountPropertiesEntityTypeTransactionInfoDTO.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? MetaTransactionDTO.fromJson(json['meta']) : null;

    transaction =
        json['transaction'] != null ? AccountPropertiesEntityTypeTransactionDTO.fromJson(json['transaction']) : null;
  }

  MetaTransactionDTO meta;
  AccountPropertiesEntityTypeTransactionDTO transaction;

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

class AccountPropertiesEntityTypeTransactionDTO extends AbstractTransactionDTO {
  AccountPropertiesEntityTypeTransactionDTO(
      {String signature, String signer, int version, int type, List<int> maxFee, List<int> deadline}) {
    this.signature = signature;
    this.signer = signer;
    this.version = version;
    this.type = type;
    this.deadline = UInt64DTO.fromJson(deadline);
    fee = UInt64DTO.fromJson(maxFee);
  }

  AccountPropertiesEntityTypeTransactionDTO.fromJson(Map<String, dynamic> json) {
    signature = json['signature'];
    signer = json['signer'];
    version = json['version'];
    type = json['type'];
    fee = UInt64DTO.fromJson(json['maxFee']);
    deadline = UInt64DTO.fromJson(json['deadline']);
    propertyType = json['propertyType'];
    modifications = AccountPropertiesEntityTypeModificationDTO.listFromJson(json['modifications']);
  }

  List<AccountPropertiesEntityTypeModificationDTO> modifications;
  int propertyType;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['signature'] = signature;
    data['signer'] = signer;
    data['version'] = version;
    data['type'] = type;
    data['maxFee'] = fee;
    data['deadline'] = deadline;
    data['propertyType'] = propertyType;
    data['modifications'] = modifications;

    return data;
  }
}
