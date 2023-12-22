import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      home: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
          splashFactory: InkRipple.splashFactory,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        dragClosed: false,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: _pageIndex,
            onChanged: (index) {
              setState(() => _pageIndex = index);
            },
            items: List.generate(
              100,
              (index) => SidebarItem(
                leading: const MacosIcon(CupertinoIcons.home),
                label: Text('Home - $index'),
              ),
            ).toList(),
          );
        },
      ),
      child: IndexedStack(
        index: _pageIndex,
        children: [
          MacosScaffold(
            children: [
              ContentArea(builder: (context, scrollController) {
                return Center(
                  child: PushButton(
                    onPressed: () async {
                      setState(() {
                        count++;
                      });
                    },
                    controlSize: ControlSize.large,
                    child: Text('count: $count'),
                  ),
                );
              }),
            ],
          ),
          MacosScaffold(
            children: [
              ContentArea(builder: (context, scrollController) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        count++;
                      });
                    },
                    child: Text('count: $count'),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
