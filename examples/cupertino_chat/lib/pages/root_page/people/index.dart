import 'package:flutter/cupertino.dart';

class PeopleRootPage extends StatefulWidget {
  const PeopleRootPage({super.key});

  @override
  State<PeopleRootPage> createState() => _PeopleRootPageState();
}

class _PeopleRootPageState extends State<PeopleRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('模版列表')),
        ],
      ),
    );
  }
}
