// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/ChatMessage.dart';
import 'package:flutter/material.dart';

class ChatsInnerScreen extends StatefulWidget {
  const ChatsInnerScreen({Key? key}) : super(key: key);

  @override
  State<ChatsInnerScreen> createState() => _ChatsInnerScreenState();
}

AppBar appBarChatsInnerScreen() {
  var appBarText = 'Example Chat Name';
  return AppBar(
    foregroundColor: kPrimaryColor,
    elevation: 0.0,
    backgroundColor: kPrimaryLightColor,
    title:
        Text(appBarText, style: TextStyle(color: Colors.black, fontSize: 14)),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                  size: 30,
                )),
          ],
        ),
      )
    ],
    centerTitle: true,
  );
}

class _ChatsInnerScreenState extends State<ChatsInnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarChatsInnerScreen(),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: ((context, index) => Message(
                    message: demeChatMessages[index],
                  )),
            ),
          ),
        ),
        chatInputField()
      ]),
    );
  }

  Container chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
      ),
      child: SafeArea(
          child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.photo_camera,
            ),
            color: kPrimaryColor,
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.file_copy),
            color: kPrimaryColor,
          ),
          Expanded(
              child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: kPrimaryColor)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 20 / 4,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Send Message", border: InputBorder.none),
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.audio:
          return AudioMessage(
            message: message,
          );
          break;
        case ChatMessageType.video:
          return VideoMessage(
            message: message,
          );
          break;
        case ChatMessageType.image:
          return ImageMessage(message: message);
          break;
        default:
          return SizedBox();
      }
    }

    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        messageContaint(message),
      ],
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Text(
              message.isSender ? '' : message.senderName,
              style: TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20 / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: message.isSender
                      ? Border.all(color: kPrimaryColor)
                      : Border.all(color: Colors.white)),
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.40),
                  child: Text(message.text,
                      style: TextStyle(color: Colors.black45)))),
        ),
      ],
    );
  }
}

class AudioMessage extends StatelessWidget {
  final ChatMessage message;

  const AudioMessage({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Text(
              message.isSender ? '' : message.senderName,
              style: TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            padding:
                EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20 / 2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: message.isSender
                  ? Border.all(color: kPrimaryColor)
                  : Border.all(color: Colors.white),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(Icons.play_arrow, color: kPrimaryColor),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: kPrimaryColor.withOpacity(0.4),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: kPrimaryColor, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                )),
                Text(
                  '0.37',
                  style: TextStyle(fontSize: 12, color: kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoMessage extends StatelessWidget {
  final ChatMessage message;
  const VideoMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: AspectRatio(
            aspectRatio: 1.6,
            child: Row(
              mainAxisAlignment: message.isSender
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  final ChatMessage message;
  const ImageMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: AspectRatio(
            aspectRatio: 1.6,
            child: Row(
              mainAxisAlignment: message.isSender
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
