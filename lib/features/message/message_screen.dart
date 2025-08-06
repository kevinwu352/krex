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
      body: ListenableBuilder(
        listenable: Listenable.merge([_vm.load, _vm.delete]),
        builder: (context, child) {
          if (_vm.hasData) {
            return ListView.separated(
              itemCount: _vm.messageList.length + 1,
              separatorBuilder: (context, index) => Divider(thickness: 0),
              itemBuilder: (context, index) {
                if (index < _vm.messageList.length) {
                  final item = _vm.messageList[index];
                  return ListTile(title: Text('[${item.id}] ${item.title}'), subtitle: Text(item.body));
                } else {
                  return Container();
                }
              },
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
