/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.model.message;

import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';
import 'package:xpx_crypto/xpx_crypto.dart' as crypto;

import '../api/dto.dart';

part 'message/encrypted_message.dart';
part 'message/message.dart';
part 'message/message_internal.dart';
part 'message/message_type.dart';
part 'message/plain_message.dart';
