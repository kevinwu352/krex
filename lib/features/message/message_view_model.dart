import 'package:flutter/material.dart';

import 'message_repository.dart';
import 'message.dart';

final class MessageViewModel extends ChangeNotifier {
  MessageViewModel({required MessageRepo repo}) : _repo = repo;

  final MessageRepo _repo;

  List<Message> messageList = [];

  Future<void> _load() async {
    final list = await _repo.messageList();
    messageList = list;
    notifyListeners();
  }
}
