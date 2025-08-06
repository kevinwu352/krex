import 'package:flutter/material.dart';
import '/network/http_client.dart';
import 'message_view_model.dart';
import 'message_repository.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required MessageViewModel vm}) : _vm = vm;

  final MessageViewModel _vm;

  MessageScreen.create({super.key, required Networkable network})
    : _vm = MessageViewModel(repo: MessageRepository(network: network));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // _vm.load();
          },
          child: Text('load'),
        ),
      ),
    );
  }
}
