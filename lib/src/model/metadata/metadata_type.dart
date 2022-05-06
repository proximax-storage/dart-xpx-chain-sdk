/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.metadata;

/// Types of metadata
enum MetadataType {
  metadataNone,
  metadataAccount,
  metadataMosaic,
  metadataNamespace,
}

extension MetadataTypeExt on MetadataType {
  int get toInt => index;
  String get getName {
    switch (this) {
      case MetadataType.metadataAccount:
        return 'metadataAccount';
      case MetadataType.metadataMosaic:
        return 'metadataMosaic';
      case MetadataType.metadataNamespace:
        return 'metadataNamespace';
      default:
        return 'metadataNone';
    }
  }
}

extension MetadataTypeIntExt on int {
  MetadataType get toMetadataType {
    switch (this) {
      case 0:
        return MetadataType.metadataAccount;
      case 1:
        return MetadataType.metadataMosaic;
      case 2:
        return MetadataType.metadataNamespace;
      default:
        return MetadataType.metadataNone;
    }
  }
}
