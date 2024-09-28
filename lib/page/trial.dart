import 'package:flutter/material.dart';

class Trial extends StatefulWidget {
  const Trial({super.key});

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: const Text("Trial")),
      body: const Center(
        child: Text("Trial Screen", style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
