import '../models/message.dart';
import '../models/user.dart';
import 'enums.dart';
import 'images.dart';

class AppConstants {
  static List<User> users = [
    User(
      id: 0,
      name: 'Joe',
      image: AppImages.profile1,
    ),
    User(
      id: 1,
      name: 'Beck',
      image: AppImages.profile2,
    ),
    User(
      id: 2,
      name: 'Theo',
      image: AppImages.profile3,
    ),
  ];

  static List<Message> allMessages = [
    Message(
        message: 'Hello',
        chatIndex: 0,
        time: '11:45',
        type: MessageType.reciever),
    Message(
        message: 'hey, how are you',
        chatIndex: 0,
        time: '11:46',
        type: MessageType.sender),
    Message(
        message: 'fine, you?',
        chatIndex: 0,
        time: '12:11',
        type: MessageType.reciever),
    Message(
        message: 'where are u',
        chatIndex: 1,
        time: '16:39',
        type: MessageType.reciever),
    Message(
        message: 'text me',
        chatIndex: 2,
        time: '09:01',
        type: MessageType.reciever)
  ];
}
