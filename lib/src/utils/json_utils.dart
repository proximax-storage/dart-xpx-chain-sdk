/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.utils;

/// Used to avoid to serialize properties to json
// ignore: prefer_void_to_null
Null readonly(_) => null;

const JsonEncoder encoder = JsonEncoder.withIndent('  ');
