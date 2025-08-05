import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/storage/secures.dart';
import '/network/http_client.dart';

import 'home_api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final client = context.read<Networkable>();
    final secures = context.read<Secures>();
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final str = await client.req(HomeApi.slideshowList(10));
                print(str);
              },
              child: Text('req'),
            ),
            ElevatedButton(
              onPressed: () {
                secures.accessToken = '123';
              },
              child: Text('reset'),
            ),
          ],
        ),
      ),
    );
  }
}
