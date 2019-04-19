part of nem2_sdk_dart;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {

  String basePath;
  var client = new BrowserClient();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "http://localhost:3000"}) {
    // Setup authentications (key: authentication name, value: authentication).
  }

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'AccountDTO':
          return new AccountDTO.fromJson(value);
        case 'AccountInfoDTO':
          return new AccountInfoDTO.fromJson(value);
        case 'AccountMetaDTO':
          return new AccountMetaDTO.fromJson(value);
        case 'AccountPropertiesDTO':
          return new AccountPropertiesDTO.fromJson(value);
        case 'AccountPropertiesInfoDTO':
          return new AccountPropertiesInfoDTO.fromJson(value);
        case 'AccountPropertiesMetaDTO':
          return new AccountPropertiesMetaDTO.fromJson(value);
        case 'AccountPropertyDTO':
          return new AccountPropertyDTO.fromJson(value);
        case 'Addresses':
          return new Addresses.fromJson(value);
        case 'AliasDTO':
          return new AliasDTO.fromJson(value);
        case 'AnnounceTransactionInfoDTO':
          return new AnnounceTransactionInfoDTO.fromJson(value);
        case 'BlockDTO':
          return new BlockDTO.fromJson(value);
        case 'BlockInfoDTO':
          return new BlockInfoDTO.fromJson(value);
        case 'BlockMetaDTO':
          return new BlockMetaDTO.fromJson(value);
        case 'BlockchainScoreDTO':
          return new BlockchainScoreDTO.fromJson(value);
        case 'BlockchainStorageInfoDTO':
          return new BlockchainStorageInfoDTO.fromJson(value);
        case 'CommunicationTimestamps':
          return new CommunicationTimestamps.fromJson(value);
        case 'HeightDTO':
          return new HeightDTO.fromJson(value);
        case 'MerklePathItem':
          return new MerklePathItem.fromJson(value);
        case 'MerkleProofInfoDTO':
          return new MerkleProofInfoDTO.fromJson(value);
        case 'MerkleProofInfoPayload':
          return new MerkleProofInfoPayload.fromJson(value);
        case 'MosaicDTO':
          return new MosaicDTO.fromJson(value);
        case 'MosaicDefinitionDTO':
          return new MosaicDefinitionDTO.fromJson(value);
        case 'MosaicIds':
          return new MosaicIds.fromJson(value);
        case 'MosaicInfoDTO':
          return new MosaicInfoDTO.fromJson(value);
        case 'MosaicMetaDTO':
          return new MosaicMetaDTO.fromJson(value);
        case 'MosaicNameDTO':
          return new MosaicNameDTO.fromJson(value);
        case 'MosaicPropertiesDTO':
          return new MosaicPropertiesDTO.fromJson(value);
        case 'MultisigAccountGraphInfoDTO':
          return new MultisigAccountGraphInfoDTO.fromJson(value);
        case 'MultisigAccountInfoDTO':
          return new MultisigAccountInfoDTO.fromJson(value);
        case 'MultisigDTO':
          return new MultisigDTO.fromJson(value);
        case 'NamespaceDTO':
          return new NamespaceDTO.fromJson(value);
        case 'NamespaceIds':
          return new NamespaceIds.fromJson(value);
        case 'NamespaceInfoDTO':
          return new NamespaceInfoDTO.fromJson(value);
        case 'NamespaceMetaDTO':
          return new NamespaceMetaDTO.fromJson(value);
        case 'NamespaceNameDTO':
          return new NamespaceNameDTO.fromJson(value);
        case 'NetworkTypeDTO':
          return new NetworkTypeDTO.fromJson(value);
        case 'NodeInfoDTO':
          return new NodeInfoDTO.fromJson(value);
        case 'NodeTimeDTO':
          return new NodeTimeDTO.fromJson(value);
        case 'TransactionHashes':
          return new TransactionHashes.fromJson(value);
        case 'TransactionIds':
          return new TransactionIds.fromJson(value);
        case 'TransactionPayload':
          return new TransactionPayload.fromJson(value);
        case 'TransactionStatusDTO':
          return new TransactionStatusDTO.fromJson(value);
        case 'UInt64DTO':
          return new UInt64DTO.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    return _deserialize(decodedJson, targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(String path,
                             String method,
                             Iterable<QueryParam> queryParams,
                             Object body,
                             Map<String, String> headerParams,
                             Map<String, String> formParams,
                             String contentType,
                             List<String> authNames) async {

    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams.where((p) => p.value != null).map((p) => '${p.name}=${p.value}');
    String queryString = ps.isNotEmpty ?
                         '?' + ps.join('&') :
                         '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if(body is MultipartRequest) {
      var request = new MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded" ? formParams : serialize(body);
      switch(method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        default:
          return client.get(url, headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames, List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null) throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }
}
