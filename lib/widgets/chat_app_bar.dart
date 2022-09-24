import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../constants/styles.dart';
import '../models/user.dart';

class ChatAppBar extends StatefulWidget with PreferredSizeWidget {
  final User user;
  const ChatAppBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Row(children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(widget.user.image),
              maxRadius: 20,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              widget.user.name,
              style: AppStyles.subheading,
            )
          ]),
        ));
  }
}
