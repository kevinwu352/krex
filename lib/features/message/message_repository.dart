import 'package:flutter/foundation.dart';
import '/network/http_client.dart';
import '/network/decode.dart';
import '/utils/result.dart';

import 'message_api.dart';
import 'message.dart';

abstract class MessageRepo {
  Future<Result<List<Message>>> messageList();
}

class MessageRepository implements MessageRepo {
  MessageRepository({required Networkable network}) : _network = network;

  final Networkable _network;

  @override
  Future<Result<List<Message>>> messageList() async {
    try {
      final result = await _network.req(MessageApi.messageList(10));
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
}
