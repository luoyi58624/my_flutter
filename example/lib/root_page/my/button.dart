import 'package:flutter/cupertino.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage(this.title, {super.key});

  final String title;

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        previousPageTitle: '组件列表',
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('count: $count'),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                child: Text('count: $count'),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
