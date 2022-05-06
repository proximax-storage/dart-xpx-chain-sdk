/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.api.dto;

// Message
class MessageDTO {
  MessageDTO.fromJson(Map<String, dynamic> json)
      : assert(json.isNotEmpty, 'json must not be empty') {
    type = json['type'];
    payload = json['payload'];
  }

  int? type;
  String? payload;

  Map<String, dynamic> toJson() => {'type': type, 'payload': payload};
}
