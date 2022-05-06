/*
 * Copyright 2018 ProximaX Limited. All rights reserved.
 * Use of this source code is governed by the Apache 2.0
 * license that can be found in the LICENSE file.
 */

part of xpx_chain_sdk.model.transaction;

class Deadline {
  Deadline(
      {int days = 0,
      int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliseconds = 0,
      int microseconds = 0}) {
    final d = Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds);
    value = DateTime.now().add(d);
  }

  Deadline.fromUInt64DTO(UInt64DTO data)
      : assert(data.lower != null || data.higher == null,
            'lower or higher must not be null') {
    value = data.toUint64() != null
        ? DateTime.fromMillisecondsSinceEpoch(data.toUint64()!.toInt() +
            timestampNemesisBlock.toUtc().millisecondsSinceEpoch)
        : null;
  }

  DateTime? value;

  int toBlockchainTimestamp() =>
      value!.millisecondsSinceEpoch -
      timestampNemesisBlock.millisecondsSinceEpoch;

  @override
  String toString() => encoder.convert(this);

  String toJson() => value != null ? '$value ${value!.timeZoneName}' : '';
}
