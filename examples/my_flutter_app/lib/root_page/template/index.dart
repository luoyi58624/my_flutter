import 'package:flutter/material.dart';
import 'package:package/index.dart';
import 'package:provider/provider.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => TemplateRootPageState();
}

class TemplateRootPageState extends State<TemplateRootPage> {
  int count = 0;

  void addCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // LoggerUtil.i('build');
    return Provider.value(
      value: count,
      child: Provider.value(
        value: this,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('模版列表'),
          ),
          body: buildCenterColumn([
            Consumer<int>(
              builder: (context, provider, child) {
                return ElevatedButton(
                  onPressed: () {
                    addCount();
                  },
                  child: Text('count: $provider'),
                );
              },
            ),
            const _ChildWidget(),
          ]),
        ),
      ),
    );
  }
}

class _ChildWidget extends StatelessWidget {
  const _ChildWidget();

  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('build');
    return TextButton(
      onPressed: () {
        context.read<TemplateRootPageState>().addCount();
      },
      child: Text('count: ${context.watch<int?>()}'),
    );
  }
}
