import 'package:customsomepaint/reusablewidget/animationButton.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          AnimationButton(onclick: _onclick,)
          
        ],
      ),
    );
  }

  void _onclick() {
  }
}