import 'package:flutter/foundation.dart';
import '/network/http_client.dart';
import '/network/decode.dart';
import '/utils/result.dart';

import 'message_api.dart';
import 'message.dart';

abstract class MessageRepo {
  Future<Result<List<Message>>> getAllMessages();
  Future<Result<void>> deleteMessage(String key);
}

class MessageRepository implements MessageRepo {
  MessageRepository({required Networkable network}) : _network = network;

  final Networkable _network;

  @override
  Future<Result<List<Message>>> getAllMessages() async {
    try {
      final result = await _network.req(MessageApi.getAll());
      switch (result) {
        case Ok():
          // print(result.value);
          final list = await compute((message) => key2list(message, 'data', Message.fromJson), result.value.body);
          return Result.ok(list);
        case Error():
          // print(result.error);
          return Result.error(result.error);
      }
    } catch (e) {
      return Result.error(HttpExcep.decodeError());
    }
  }

  @override
  Future<Result<void>> deleteMessage(String key) async {
    await Future.delayed(Duration(seconds: 2));
    if (key.endsWith('1') || key.endsWith('3') || key.endsWith('5') || key.endsWith('7') || key.endsWith('9')) {
      return Result.error(HttpExcep.operationFailed());
    } else {
      return Result.ok(null);
    }
  }
}
