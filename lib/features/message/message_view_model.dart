import 'package:flutter/material.dart';
import '/utils/result.dart';

import 'message_repository.dart';
import 'message.dart';

final class MessageViewModel extends ChangeNotifier {
  MessageViewModel({required MessageRepo repo}) : _repo = repo;

  final MessageRepo _repo;

  List<Message> messageList = [];

  Future<void> load() async {
    final result = await _repo.messageList();
    switch (result) {
      case Ok():
        print(result.value);
      case Error():
        print(result.error);
    }
    // messageList = result.value;
    notifyListeners();
  }
}
