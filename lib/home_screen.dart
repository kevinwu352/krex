import 'package:flutter/material.dart';
import 'package:krex/utils/result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final res = Result.ok(101);
          switch (res) {
            case Ok():
              print(res.value);
            case Error():
              print(res.error);
          }
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Center(child: Text('hello')),
    );
  }
}
