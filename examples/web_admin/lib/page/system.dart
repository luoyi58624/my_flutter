import 'package:flutter/material.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('系统管理2-count: $count'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
