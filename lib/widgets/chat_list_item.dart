import 'package:chat_task/constants/styles.dart';
import 'package:chat_task/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'package:chat_task/models/user.dart';
import 'package:sizer/sizer.dart';

class ChatListItem extends StatefulWidget {
  final User user;
  const ChatListItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage(user: widget.user);
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.user.image),
              maxRadius: 30,
            ),
            SizedBox(width: 4.w),
            Text(
              widget.user.name,
              style: AppStyles.subheading,
            )
          ],
        ),
      ),
    );
  }
}
