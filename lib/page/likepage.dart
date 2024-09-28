import 'package:flutter/material.dart';

class Likepage extends StatefulWidget {
  const Likepage({Key? key});

  @override
  LikepageState createState() => LikepageState();
}

class LikepageState extends State<Likepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Example')),
      body: Center(
        child: Image.asset('assets/images/img2.jpg'),
      ),
    );
  }
}
