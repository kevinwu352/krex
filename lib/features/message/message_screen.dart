import 'package:flutter/material.dart';
import '/network/http_client.dart';
import '/utils/list_view_ext.dart';
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
      body: ListenableBuilder(
        listenable: Listenable.merge([_vm.load, _vm.delete]),
        builder: (context, child) {
          if (_vm.hasData) {
            return ListViewExt.separate(
              items: _vm.messageList,
              separator: (ctx, i) => Divider(thickness: 0),
              tile: (ctx, i, it) => ListTile(title: Text('[${it.id}] ${it.title}'), subtitle: Text(it.body)),
            );
          }
          if (_vm.isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (_vm.failed) {
            return Center(child: Text('failed'));
          }
          return Center(child: Text('empty'));
        },
      ),
    );
  }
}
