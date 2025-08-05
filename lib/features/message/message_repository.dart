import 'dart:convert';
import 'package:flutter/foundation.dart';
import '/network/http_client.dart';
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
      final res = await _network.req(MessageApi.messageList(10));
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = await compute((message) {
          final json = jsonDecode(message) as Map<String, dynamic>;
          final data = (json['data'] as List).cast<Map<String, dynamic>>();
          final ret = data.map((m) => Message.fromJson(m)).toList();
          return ret;
        }, res.body);
        return Result.ok(list);
      } else {
        // return Result.error('error');
      }
    } catch (e) {
      return Result.error('error');
    }
  }
}
