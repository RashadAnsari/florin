import 'package:flutter/material.dart';

void main() {
  runApp(const FlorinApp());
}

class FlorinApp extends StatelessWidget {
  const FlorinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Florin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(body: Center(child: Text('Florin'))),
    );
  }
}
