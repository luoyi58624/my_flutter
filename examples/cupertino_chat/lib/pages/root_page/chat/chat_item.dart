import 'package:cupertino_chat/pages/root_page/chat/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

class ChatItemPage extends StatefulWidget {
  const ChatItemPage({super.key, required this.chatModel});

  final ChatModel chatModel;

  @override
  State<ChatItemPage> createState() => _ChatItemPageState();
}

class _ChatItemPageState extends State<ChatItemPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.chatModel.username),
        previousPageTitle: 'Chats',
      ),
      child: Center(
        child: CupertinoButton.filled(
            child: const Text('Back'),
            onPressed: () {
              RouterUtil.back(context);
            }),
      ),
    );
  }
}
