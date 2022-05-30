/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

class TransactionCountDTO {
  TransactionCountDTO.fromJson(Map json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    type = json['type'] as int;
    count = json['count'] as int;
  }

  late final int type;
  late final int count;
}
