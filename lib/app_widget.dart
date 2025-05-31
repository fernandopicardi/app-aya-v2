// App Widget - Root widget of the MaterialApp

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App Aya',
      home: Scaffold(body: Center(child: Text('App Aya'))),
    );
  }
}
