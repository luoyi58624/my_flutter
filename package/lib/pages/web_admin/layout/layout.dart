import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:package/index.dart';

import 'navbar.dart';
import 'sidebar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final MultiSplitViewController _controller = MultiSplitViewController(
    areas: [
      Area(size: 240, minimalSize: 240),
      Area(minimalSize: 360),
    ],
  );

  @override
  Widget build(BuildContext context) {
    MultiSplitView multiSplitView = MultiSplitView(
      controller: _controller,
      children: [
        Material(
          color: Colors.grey.shade800,
          child: SidebarWidget(
            navigationShell: widget.navigationShell,
          ),
        ),
        Material(
          color: Colors.grey.shade900,
          child: widget.navigationShell,
        ),
      ],
      dividerBuilder:
          (axis, index, resizable, dragging, highlighted, themeData) =>
              Container(color: Colors.grey.shade900),
    );
    MultiSplitViewTheme multiSplitViewTheme = MultiSplitViewTheme(
      data: MultiSplitViewThemeData(dividerThickness: 8),
      child: multiSplitView,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const NavbarWidget(),
            Expanded(child: multiSplitViewTheme),
          ],
        ),
      ),
    );
  }
}
