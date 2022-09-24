import 'package:chat_task/constants/enums.dart';

class Message {
  String message;
  String? imagePath;
  String? audioPath;
  int chatIndex;
  String time;
  MessageType type;

  Message({
    required this.message,
    this.imagePath,
    this.audioPath,
    required this.chatIndex,
    required this.time,
    required this.type,
  });
}
