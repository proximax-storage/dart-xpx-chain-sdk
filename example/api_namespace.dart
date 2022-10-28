/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

void main() async {
  const baseUrl = 'https://api-2.testnet2.xpxsirius.io';

  /// Creating a client instance
  final client = SiriusClient.fromUrl(baseUrl);

  final namespaceIdOne = NamespaceId.fromHex('BFFB42A19116BDF6');
  final namespaceIdTwo = NamespaceId.fromHex('CCD875904F024AAC');

  final addressOne = Address.fromRawAddress('VCMCJPRMJ6IUBOZ7HCYBQOSEOVGISX6AMUJ4ESTN');
  final addressTwo = Address.fromRawAddress('VB2HPZ-FL3IRV-62FGZM-7GGIZS-LZGAZE-DZ23P3-EFOR');

  // // Gets a [NamespaceInfo] for a given namespaceId.
  // try {
  //   final result = await client.namespace.getNamespace(namespaceIdOne);
  //   print(result);
  // } on Exception catch (e) {
  //   print('Exception when calling Namespace->GetNamespace: $e\n');
  // }

  // Gets an List of [NamespaceInfo] for a given account address.
  try {
    final result = await client.namespace.getNamespacesFromAccount(addressOne);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesFromAccount: $e\n');
  }

  // Gets namespaces for a given List of addresses.
  try {
    final result = await client.namespace.getNamespacesFromAccounts([addressOne, addressTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesFromAccounts: $e\n');
  }

  // Returns a [NamespaceName] friendly names for mosaics.
  try {
    final result = await client.namespace.getNamespacesNames([namespaceIdOne, namespaceIdTwo]);
    print(result);
  } on Exception catch (e) {
    print('Exception when calling Namespace->GetNamespacesNames: $e\n');
  }
}
