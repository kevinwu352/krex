import 'package:flutter/material.dart';
import 'message_view_model.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required MessageViewModel vm}) : _vm = vm;

  final MessageViewModel _vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message')),
      body: Center(child: Text('data')),
    );
  }
}
