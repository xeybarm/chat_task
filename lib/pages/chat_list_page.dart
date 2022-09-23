import 'package:chat_task/constants/styles.dart';
import 'package:chat_task/models/user.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<User> users = [
    User(name: 'Joe', image: '', lastMessage: 'Where are you', time: 'today'),
    User(name: 'Beck', image: '', lastMessage: 'Hi', time: '4 days ago'),
    User(name: 'Theo', image: '', lastMessage: 'Alright', time: '2 days ago'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 30, top: 50),
            child: Text('Chats', style: AppStyles.heading),
          ),
        ],
      ),
    ));
  }
}
