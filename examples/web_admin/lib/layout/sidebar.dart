import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:web_admin/router.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key, required this.navigationShell});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  @override
  Widget build(BuildContext context) {
    LoggerUtil.i(router.configuration.routes[1]);
    return SizedBox(
      width: 240,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              widget.navigationShell.goBranch(0);
            },
            title: const Text('Home'),
            leading: const Icon(Icons.home),
          ),
          ListTile(
            onTap: () {
              context.go('/user');
              // widget.navigationShell.goBranch(1);
            },
            title: const Text('User Manager'),
            leading: const Icon(Icons.people),
          ),
          ListTile(
            onTap: () {
              widget.navigationShell.goBranch(2);
            },
            title: const Text('Menu Manager'),
            leading: const Icon(Icons.grid_view),
          ),
          ListTile(
            onTap: () {
              widget.navigationShell.goBranch(3);
            },
            title: const Text('System Manager'),
            leading: const Icon(Icons.settings),
          ),
          ListTile(
            onTap: () {
              localStorage.removeItem('auth');
              context.go('/login');
            },
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
