import 'package:flutter/material.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FlutterLogo(size: 40),
              const SizedBox(width: 8),
              Text(
                'Flutter Admin System',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
