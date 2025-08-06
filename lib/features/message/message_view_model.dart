import 'dart:collection';
import 'package:flutter/material.dart';
import '/utils/command.dart';
import '/utils/result.dart';

import 'message_repository.dart';
import 'message.dart';

final class MessageViewModel extends ChangeNotifier {
  MessageViewModel({required MessageRepo repo}) : _repo = repo {
    load = Command0(_load)..execute();
    delete = Command1(_delete);
  }

  final MessageRepo _repo;

  bool get hasData => _messageList.isNotEmpty;
  bool get isLoading => false;
  bool get failed => _error != null;

  Exception? _error;
  Exception? get error => _error;

  List<Message> _messageList = [];
  UnmodifiableListView<Message> get messageList => UnmodifiableListView(_messageList);

  late final Command0<void> load;
  late final Command1<void, String> delete;

  Future<Result<void>> _load() async {
    final result = await _repo.getAllMessages();
    switch (result) {
      case Ok():
        print(result.value);
        _messageList = result.value;
      case Error():
        print(result.error);
    }
    notifyListeners();
    return result.toVoid();
  }

  Future<Result<void>> _delete(String key) async {
    final result = await _repo.deleteMessage(key);
    notifyListeners();
    return result.toVoid();
  }
}
