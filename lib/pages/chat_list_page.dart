import 'package:chat_task/constants/styles.dart';
import 'package:chat_task/widgets/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/constants.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, top: 6.h),
            child: const Text('Chats', style: AppStyles.heading),
          ),
          ListView.builder(
              itemCount: AppConstants.users.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 1.h),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatListItem(user: AppConstants.users[index]);
              }),
        ],
      ),
    ));
  }
}
