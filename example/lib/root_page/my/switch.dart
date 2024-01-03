import 'package:flutter/cupertino.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage(this.title, {super.key});

  final String title;

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool switchValue = false;

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
              Text('switch value: $switchValue'),
              const SizedBox(height: 8),
              CupertinoSwitch(
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
                value: switchValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
