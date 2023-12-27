import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:web_admin/layout/controller.dart';

class NavRailWidget extends StatefulWidget {
  const NavRailWidget({super.key});

  @override
  State<NavRailWidget> createState() => _NavRailWidgetState();
}

class _NavRailWidgetState extends State<NavRailWidget> {
  final LayoutController layoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => NavigationRail(
        selectedIndex: layoutController.railIndex.value,
        labelType: NavigationRailLabelType.all,
        elevation: 4,
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: Text('首页'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.book),
            label: Text('系统管理'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: Text('用户管理'),
          ),
        ],
      ),
    );
  }
}
