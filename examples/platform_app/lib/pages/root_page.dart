import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/root_page.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'cupertino/root_page/index.dart';
import 'material/root_page/index.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool useMaterial = true;

  @override
  void initState() {
    super.initState();
    useMaterial = CommonUtil.hasAncestorElements<MaterialApp>(context);
  }

  @override
  Widget build(BuildContext context) {
    return useMaterial
        ? MaterialRootPage(pages: materialPages)
        : CupertinoRootPage(pages: cupertinoPages);
  }
}
