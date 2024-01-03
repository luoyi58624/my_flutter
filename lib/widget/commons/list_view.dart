// import 'package:flutter/widgets.dart';
// import 'package:super_sliver_list/super_sliver_list.dart';
//
// /// 使用[SuperSliverList]构建ListView
// class ListViewWidget extends StatelessWidget {
//   const ListViewWidget({
//     super.key,
//     this.shrinkWrap = false,
//   }) : itemCount = null;
//
//   const ListViewWidget.builder({
//     super.key,
//     this.itemCount,
//     this.shrinkWrap = false,
//   });
//
//   final int? itemCount;
//
//   final bool shrinkWrap;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SuperSliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) => ListTile(
//               onTap: () {},
//               title: Text('${controller.userList[index]['userId']} - ${controller.userList[index]['username']} '),
//             ),
//             childCount: controller.userList.length,
//           ),
//         )
//       ],
//     );
//   }
// }
