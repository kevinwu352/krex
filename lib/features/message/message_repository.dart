import 'package:flutter/foundation.dart';
import '/core/core.dart';
import '/network/network.dart';

import 'message_api.dart';
import 'message.dart';

abstract class MessageRepo {
  Future<Result<List<Message>>> getAllMessages();
  Future<Result<void>> deleteMessage(int id);
}

class MessageRepository implements MessageRepo {
  MessageRepository({required Networkable network}) : _network = network;

  final Networkable _network;

  @override
  Future<Result<List<Message>>> getAllMessages() async {
    try {
      final result = await _network.req(MessageApi.getAll());
      await Future.delayed(Duration(seconds: 1));
      switch (result) {
        case Ok():
          // if (kDebugMode) debugPrint('${result.value}');
          final list = await compute((message) => key2list(message, 'data', Message.fromJson), result.value.body);
          return Result.ok(list);
        case Error():
          // if (kDebugMode) debugPrint('${result.error}');
          return Result.error(result.error);
      }
    } catch (e) {
      return Result.error(HttpExcep.decodeError());
    }
  }

  @override
  Future<Result<void>> deleteMessage(int id) async {
    await Future.delayed(Duration(seconds: 1));
    if (id % 2 == 1) {
      return Result.error(HttpExcep.operationFailed());
    } else {
      return Result.ok(null);
    }
  }
}
