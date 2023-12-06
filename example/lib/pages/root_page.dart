import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material_root_page.dart';
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
    context.visitAncestorElements((element) {
      if (element.widget is CupertinoApp) {
        useMaterial = false;
        return false;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return useMaterial
        ? const MaterialRootPage(pages: materialPages)
        : const CupertinoRootPage(pages: cupertinoPages);
  }
}
