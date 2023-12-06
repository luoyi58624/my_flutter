import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino.dart';
import 'package:my_flutter_app/controller/demo_controller.dart';

class CartRootPage extends StatefulWidget {
  const CartRootPage({Key? key}) : super(key: key);

  @override
  State<CartRootPage> createState() => _CartRootPageState();
}

class _CartRootPageState extends State<CartRootPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('购物车'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute(builder: (ctx) => const _ChildPage()));
                },
                child: const Text('子页面'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  RouterUtil.push(
                    context,
                    const WebviewPage(
                      title: '百度',
                      url: 'https://www.baidu.com',
                    ),
                  );
                },
                child: const Text('百度网页'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  rebootApp(context);
                },
                child: const Text('重启App'),
              ),
              // ImageWidget(
              //     "https://w.wallhaven.cc/full/1p/wallhaven-1poo61.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildPage extends StatefulWidget {
  const _ChildPage();

  @override
  State<_ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<_ChildPage> {
  final DemolController demolController = Get.put(DemolController());

  @override
  void dispose() {
    super.dispose();
    Get.delete<DemolController>();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('购物车-子页面'),
        previousPageTitle: '购物车',
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoButton.filled(
            onPressed: () {
              demolController.count.value++;
            },
            child: Obx(() => Text('count: ${demolController.count}')),
          ),
        ),
      ),
    );
  }
}
