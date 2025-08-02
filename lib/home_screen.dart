import 'package:flutter/material.dart';
import 'package:krex/utils/result.dart';
import 'package:krex/utils/secures.dart';
import 'package:provider/provider.dart';

Future<void> doit() async {
  print("doit begin");
  await Future.delayed(Duration(seconds: 5));
  print("doit end");
}

final class Securex extends ChangeNotifier {
  Securex({bool onDisk = true});

  Future<void> init() async {
    await doit();
    print("done");
  }

  String? _lastUsername;
  String? get lastUsername => _lastUsername;
  set lastUsername(String? value) {
    _lastUsername = value;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HOME')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final res = Result.ok(101);
          // switch (res) {
          //   case Ok():
          //     print(res.value);
          //   case Error():
          //     print(res.error);
          // }

          // print('111');
          // final s1 = await Securex()
          //   ..init();
          // final s2 = Securex();
          // await s2.init();
          // print(s1);
          // print('222');

          final s = context.read<Secures>();
          s.lastUsername = 'kim';
        },
        child: Icon(Icons.run_circle_outlined),
      ),
      body: Center(
        child: Column(
          children: [
            Text('hello'),
            Consumer<Secures>(
              builder: (context, value, child) => Text(
                'data: ${value.boardedVersion ?? '--'} ${value.lastUsername ?? '--'} ${value.accessToken ?? '--'}',
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().boardedVersion = null,
              child: Text('version = null'),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().boardedVersion = '1.2.3',
              child: Text('version = 1.2.3'),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().lastUsername = null,
              child: Text('name = null'),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().lastUsername = '',
              child: Text('name = __'),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().lastUsername = 'bob',
              child: Text('name = bob'),
            ),
            ElevatedButton(
              onPressed: () => context.read<Secures>().accessToken = '123456',
              child: Text('token = 123456'),
            ),
          ],
        ),
      ),
    );
  }
}
