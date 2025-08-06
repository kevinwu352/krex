import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/ui/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.message);
            },
            icon: Icon(Icons.message),
          ),
        ],
      ),
      body: Center(child: Text('data')),
    );
  }
}
