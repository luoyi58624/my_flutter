import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserRootPage extends StatefulWidget {
  const UserRootPage({Key? key}) : super(key: key);

  @override
  State<UserRootPage> createState() => _UserRootPageState();
}

class _UserRootPageState extends State<UserRootPage> {
  int count = 100;

  double height1 = 200;
  double height2 = 250;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('个人中心'),
      ),
      child: SafeArea(
        child: CustomScrollView(slivers: [
          SliverMasonryGrid.count(
            childCount: 100,
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) {
              double height =
                  (index == 0 || index == (count - 1)) ? height1 : height2;
              return Tile(
                title: '${index + 1} - $height',
                height: height,
              );
            },
          ),
        ]),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    this.height,
  }) : super(key: key);

  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemCyan,
      height: height,
      child: Center(
        child: Text(title, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
