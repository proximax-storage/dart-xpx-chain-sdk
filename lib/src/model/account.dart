/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.model.account;

import 'dart:typed_data';

import 'package:base32/base32.dart';
import 'package:convert/convert.dart' show hex;
import 'package:pointycastle/api.dart';
import 'package:sha3/sha3.dart';
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';
import 'package:xpx_crypto/xpx_crypto.dart' as crypto;

import '../api/dto.dart';

part 'account/account.dart';
part 'account/account_info.dart';
part 'account/account_internal.dart';
part 'account/account_names.dart';
part 'account/account_properties.dart';
part 'account/account_properties_type.dart';
part 'account/address.dart';
part 'account/public_account.dart';
