import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void addCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: count,
      child: Provider.value(
        value: this,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('首页'),
          ),
          body: Center(
            child: Column(
              children: [
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const _ChildPage()));
                  },
                  child: const Text('子页面'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChildWidget extends StatelessWidget {
  const _ChildWidget();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<_HomePageState>().addCount();
      },
      child: Text('count: ${context.watch<int?>()}'),
    );
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<_HomePageState>().addCount();
          },
          child: Text('count: ${context.watch<int?>()}'),
        ),
      ),
    );
  }
}
