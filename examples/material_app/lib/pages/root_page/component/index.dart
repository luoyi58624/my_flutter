import 'package:flutter/material.dart';

class ComponentRootPage extends StatefulWidget {
  const ComponentRootPage({super.key});

  @override
  State<ComponentRootPage> createState() => _ComponentRootPageState();
}

class _ComponentRootPageState extends State<ComponentRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue.shade700,
            elevation: 4,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "组件列表",
              ),
              background:
                  Image.asset("assets/images/home_bg.png", fit: BoxFit.fill),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 160.0,
            pinned: true,
            floating: false,
            snap: false,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              onTap: () {},
              title: Text('列表 - ${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}
