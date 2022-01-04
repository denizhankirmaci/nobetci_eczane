import 'package:flutter/material.dart';
import 'anasayfa.dart';

void main() {
  runApp(AnaGiris());
}

class AnaGiris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: AnaSayfa(),
    );
  }
}
