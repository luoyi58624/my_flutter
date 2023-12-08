import 'dart:math';

import 'package:cupertino_chat/pages/root_page/chat/chat_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

class ChatModel {
  final String username;
  final String face;
  final String chatContent;
  final String sendTime;
  final int unReadNum;

  ChatModel(this.username, this.face, this.chatContent, this.sendTime,
      this.unReadNum);
}

class ChatRootPage extends StatefulWidget {
  const ChatRootPage({super.key});

  @override
  State<ChatRootPage> createState() => _ChatRootPageState();
}

class _ChatRootPageState extends State<ChatRootPage> {
  List<ChatModel> listData = List.generate(
    1000,
    (index) => ChatModel(
      faker.person.name(),
      faker.image.image(random: true),
      faker.lorem.sentence(),
      CommonUtil.formatDate(
          faker.date
              .dateTime(minYear: 2023, maxYear: 2023)
              .millisecondsSinceEpoch,
          format: 'HH:mm'),
      Random().nextInt(99) - 50,
    ),
  ).toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: HideKeybordWidget(
        child: CupertinoPageScaffold(
          child: CupertinoScrollbar(
            child: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text('Chats'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                            IconData(0xe660, fontFamily: 'iconfont')),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                            IconData(0xe66e, fontFamily: 'iconfont')),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  border: null,
                ),
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: CustomSliverPersistentHeaderDelegate.fixedHeight(
                //     height: 56,
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 8, horizontal: 12),
                //       color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                //       child: const CupertinoSearchTextField(),
                //     ),
                //   ),
                // ),
                SliverList.separated(
                  itemCount: listData.length,
                  itemBuilder: (context, index) => _ChatItem(listData[index]),
                  separatorBuilder: buildSeparatorWidget(indent: 64),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatItem extends StatefulWidget {
  const _ChatItem(this.chatModel);

  final ChatModel chatModel;

  @override
  State<_ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<_ChatItem> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        setState(() {
          _tapped = true;
        });
      },
      onTapUp: (e) {
        Future.delayed(
          const Duration(milliseconds: 150),
          () {
            if (mounted) {
              setState(() {
                _tapped = false;
              });
            }
          },
        );
        RouterUtil.push(context, ChatItemPage(chatModel: widget.chatModel));
      },
      onTapCancel: () {
        setState(() {
          _tapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: _tapped
            ? const CupertinoDynamicColor.withBrightness(
                color: Color(0xFFe4e4e7),
                darkColor: Color(0xFF525252),
              )
            : CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            ImageWidget.circle(widget.chatModel.face, 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.chatModel.username,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        widget.chatModel.sendTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.chatModel.chatContent,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                      if (widget.chatModel.unReadNum > 0)
                        Container(
                          height: 16,
                          constraints: const BoxConstraints(
                            minWidth: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              widget.chatModel.unReadNum.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              CupertinoIcons.right_chevron,
              size: 14,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ),
      ),
    );
  }
}
