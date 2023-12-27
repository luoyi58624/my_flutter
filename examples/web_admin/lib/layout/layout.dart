import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_admin/layout/nav_rail.dart';

import 'navbar.dart';
import 'sidebar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavRailWidget(),
                SidebarWidget(
                  navigationShell: widget.navigationShell,
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 56, child: NavbarWidget()),
                  Expanded(
                    child: Material(
                      color: Colors.grey.shade900,
                      child: widget.navigationShell,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
