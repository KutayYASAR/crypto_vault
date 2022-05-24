import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/messages.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsInnerScreen extends StatefulWidget {
  String clickedPersonUid;
  String whoSent;
  final String userName;
  ChatsInnerScreen(
      {Key? key,
      required this.whoSent,
      required this.clickedPersonUid,
      required this.userName})
      : super(key: key);
  @override
  _ChatsInnerScreenState createState() => _ChatsInnerScreenState();
}

class _ChatsInnerScreenState extends State<ChatsInnerScreen> {
  AuthService _authService = AuthService();

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var whoSent = widget.whoSent;
    var clickedPersonUid = widget.clickedPersonUid;
    var userName = widget.userName;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
        elevation: 0.0,
        backgroundColor: kPrimaryLightColor,
        centerTitle: true,
        title: Text(
          userName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: messages(
                whoSent: whoSent,
                clickedPersonUid: clickedPersonUid,
                //nameOfSender: nameOfClickedUser,
                //nameOfReceiver: nameOfCurrentUser,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.photo_camera,
                      color: kPrimaryColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.file_copy_outlined,
                      color: kPrimaryColor,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'message',
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: kPrimaryColor),
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: kPrimaryColor),
                          borderRadius: new BorderRadius.circular(30),
                        ),
                      ),
                      validator: (value) {},
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () {
                      if (message.text.isNotEmpty) {
                        fs
                            .collection('Messages')
                            .doc(whoSent)
                            .collection(clickedPersonUid)
                            .doc()
                            .set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'whoSent': whoSent,
                        });

                        fs
                            .collection('Messages')
                            .doc(clickedPersonUid)
                            .collection(whoSent)
                            .doc()
                            .set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'whoSent': whoSent,
                        });

                        message.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send_sharp,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
