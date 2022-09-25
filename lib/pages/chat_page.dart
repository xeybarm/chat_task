import 'dart:io';

import 'package:chat_task/constants/constants.dart';
import 'package:chat_task/constants/enums.dart';
import 'package:chat_task/models/message.dart';
import 'package:chat_task/widgets/chat_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../constants/styles.dart';
import '../models/user.dart';
import 'package:just_audio/just_audio.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  List<Message> _allMessages = [];
  List<Message> _chatMessages = [];

  ImagePicker picker = ImagePicker();
  XFile? image;

  final recorder = FlutterSoundRecorder();
  final player = AudioPlayer();
  bool isRecording = false;
  int recorderIndex = 0;

  initiliazeRecording() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission is not allowed';
    }

    await recorder.openRecorder();
  }

  @override
  void initState() {
    _allMessages = AppConstants.allMessages;

    initiliazeRecording();

    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _chatMessages =
        _allMessages.where((e) => e.chatIndex == widget.user.id).toList();
    return Scaffold(
        appBar: ChatAppBar(user: widget.user),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 8.4.h, top: 1.h),
              reverse: true,
              physics: const BouncingScrollPhysics(),
              child: ListView.builder(
                itemCount: _chatMessages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final message = _chatMessages[index];
                  return Align(
                    alignment: (message.type == MessageType.reciever
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: message.audioPath != null
                          ? null
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: (message.type == MessageType.reciever
                                  ? Colors.grey.shade200
                                  : Colors.blue.shade200),
                            ),
                      padding: EdgeInsets.all(2.5.w),
                      margin: message.audioPath != null
                          ? null
                          : EdgeInsets.symmetric(horizontal: 2.w, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          message.imagePath != null
                              ? Image.file(File(message.imagePath!),
                                  height: 40.h)
                              : message.audioPath != null
                                  ? VoiceMessage(
                                      audioSrc: message.audioPath!,
                                      played: true,
                                      me: true,
                                      onPlay: () async {
                                        await player.setUrl(message.audioPath!);
                                      },
                                      meBgColor: Colors.blue.shade200,
                                    )
                                  : Text(_chatMessages[index].message),
                          const SizedBox(height: 3),
                          Text(_chatMessages[index].time,
                              style: AppStyles.timeText),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 8.h,
                  padding: EdgeInsets.only(
                      left: 3.w, right: 3.w, bottom: 1.h, top: 1.h),
                  color: Colors.white,
                  child: Row(children: [
                    //ChatAttachments
                    GestureDetector(
                        onTap: () {
                          _showAttachmentOptions();
                        },
                        child: const Icon(Icons.add, color: Colors.black)),
                    SizedBox(width: 3.w),
                    //Chat Message Input
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: _controller,
                        decoration: const InputDecoration(
                            hintText: "Message",
                            hintStyle: AppStyles.hintText,
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    //Chat Voice Recorder
                    GestureDetector(
                        onLongPressStart: (details) async {
                          setState(() {
                            isRecording = true;
                          });
                          await recorder.startRecorder(
                              toFile: 'voice${recorderIndex++}');
                        },
                        onLongPressEnd: (details) async {
                          final audioPath = await recorder.stopRecorder();
                          setState(() {
                            isRecording = false;
                            AppConstants.allMessages.add(Message(
                                message: '',
                                audioPath: audioPath,
                                chatIndex: widget.user.id,
                                time: 'now',
                                type: MessageType.sender));
                          });
                        },
                        child: !isRecording
                            ? const Icon(Icons.mic, size: 30)
                            : const Icon(Icons.mic, size: 50)),
                    //Chat Send Message
                    FloatingActionButton(
                      onPressed: () {
                        if (_controller.text != '') {
                          setState(() {
                            AppConstants.allMessages.add(Message(
                                message: _controller.text,
                                chatIndex: widget.user.id,
                                time: 'now',
                                type: MessageType.sender));
                            _controller.clear();
                          });
                        }
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ]),
                )),
          ],
        ));
  }

  _showAttachmentOptions() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Photo'),
                onTap: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);

                  setState(() {
                    AppConstants.allMessages.add(Message(
                        message: '',
                        imagePath: image!.path,
                        chatIndex: widget.user.id,
                        time: 'now',
                        type: MessageType.sender));
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Camera'),
                onTap: () async {
                  image = await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    AppConstants.allMessages.add(Message(
                        message: '',
                        imagePath: image!.path,
                        chatIndex: widget.user.id,
                        time: 'now',
                        type: MessageType.sender));
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
