import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text('首页'),
          Text(demo(context).toString()),
        ],
      ),
    );
  }
}

double Function(BuildContext context) computedNum(double x, double y) =>
    (context) => x + y;

var demo = computedNum(10, 20);
