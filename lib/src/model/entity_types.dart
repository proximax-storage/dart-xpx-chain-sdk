/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

library xpx_chain_sdk.model.entity_types;

import 'package:xpx_chain_sdk/xpx_chain_sdk.dart';

typedef Amount = Uint64;
typedef Height = Uint64;
// typedef Duration = Uint64;
typedef Difficulty = Uint64;
typedef StorageSize = Uint64;
typedef ScopedMetadataKey = Uint64;

extension HeightExt on int {
  Height get toHeight => Height.fromInt(this);
}
