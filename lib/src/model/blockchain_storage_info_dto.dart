part of xpx_catapult_sdk;

class BlockchainStorageInfoDTO {
  int numBlocks = null;

  int numTransactions = null;

  int numAccounts = null;

  BlockchainStorageInfoDTO();

  @override
  String toString() {
    return 'BlockchainStorageInfoDTO[numBlocks=$numBlocks, numTransactions=$numTransactions, numAccounts=$numAccounts, ]';
  }

  BlockchainStorageInfoDTO.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    numBlocks = json['numBlocks'];
    numTransactions = json['numTransactions'];
    numAccounts = json['numAccounts'];
  }

  Map<String, dynamic> toJson() {
    return {
      'numBlocks': numBlocks,
      'numTransactions': numTransactions,
      'numAccounts': numAccounts
    };
  }

  static List<BlockchainStorageInfoDTO> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<BlockchainStorageInfoDTO>()
        : json
            .map((value) => new BlockchainStorageInfoDTO.fromJson(value))
            .toList();
  }

  static Map<String, BlockchainStorageInfoDTO> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, BlockchainStorageInfoDTO>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new BlockchainStorageInfoDTO.fromJson(value));
    }
    return map;
  }
}
