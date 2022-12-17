import 'package:flutter/material.dart';
import 'CalculatorFinals.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator Finals',
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: CalculatorFinals(),
    );
  }
}




