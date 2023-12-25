import 'package:flutter/material.dart';
import 'package:package/index.dart';

const String imageUrl = 'https://images.pexels.com/photos/2286895/pexels-photo-2286895.jpeg';

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
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              LoggerUtil.i(e);
            },
            child: const Text('首页'),
          ),
          Text(demo(context).toString()),
          ElevatedButton(
            onPressed: () {
              ToastUtil.showToast('hello');
            },
            child: const Text('Toast'),
          ),
          ElevatedButton(
            onPressed: () {
              ToastUtil.showSuccessToast('hello');
            },
            child: const Text('Success Toast'),
          ),
          Image.network(imageUrl),
          const ImageWidget.circle(
            url: imageUrl,
            size: 64,
          ),
          const ImageWidget(
            url: imageUrl,
            width: 64,
            height: 64,
            // fit: BoxFit.contain,
          ),
          ImageWidget.circle(
            file: 'D://',
          ),
          ImageWidget(
            file: 'D://',
          ),
        ],
      ),
    );
  }
}

double Function(BuildContext context) computedNum(double x, double y) => (context) => x + y;

var demo = computedNum(10, 20);
