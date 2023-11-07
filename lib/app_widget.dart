import 'package:assincrona/pages/home_widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home(),
    );
  }
}
