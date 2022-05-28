// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatInnerScreen extends StatefulWidget {
  String whoSent;
  String currentUserName;
  String vaultUid;
  GroupChatInnerScreen(
      {Key? key,
      required this.whoSent,
      required this.currentUserName,
      required this.vaultUid})
      : super(key: key);
  @override
  _GroupChatInnerScreenState createState() => _GroupChatInnerScreenState();
}

class _GroupChatInnerScreenState extends State<GroupChatInnerScreen> {
  AuthService _authService = AuthService();

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  final ScrollController _scrollController = ScrollController();

  _scrollToEnd() async {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    var whoSent = widget.whoSent;
    var currentUserName = widget.currentUserName;
    var vaultUid = widget.vaultUid;
    String nameText = "";

    AuthService _authService = AuthService();

    Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
        .collection('Vault Messages')
        .doc(vaultUid)
        .collection('Messages')
        .orderBy('time')
        .snapshots();

    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
        elevation: 0.0,
        backgroundColor: kPrimaryLightColor,
        centerTitle: true,
        title: Text(
          'Vault Chat',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.79,
                  child: StreamBuilder(
                    stream: _messageStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("something is wrong");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (_, index) {
                          QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                          Timestamp t = qs['time'];
                          DateTime d = t.toDate();
                          var whoSentPerson;
                          if (currentUserName == qs['sender']) {
                            nameText = "";
                          } else {
                            nameText = qs['sender'];
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: whoSent == qs['whoSent']
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Row(
                                          children: [
                                            Text(
                                              nameText,
                                              style: const TextStyle(
                                                  color: kTextDarkColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        elevation: 5,
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    qs['message'],
                                                    style: const TextStyle(
                                                        color: kTextDarkColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Text(
                                                  d.hour.toString() +
                                                      ":" +
                                                      d.minute.toString(),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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
                    onPressed: () async {
                      if (message.text.isNotEmpty) {
                        fs
                            .collection('Vault Messages')
                            .doc(vaultUid)
                            .collection('Messages')
                            .doc()
                            .set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'whoSent': whoSent,
                          'sender': currentUserName
                        });

                        message.clear();
                        _scrollToEnd();
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
