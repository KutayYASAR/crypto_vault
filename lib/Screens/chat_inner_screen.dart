// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsInnerScreen extends StatefulWidget {
  String clickedPersonUid;
  String whoSent;
  final String userName;
  final String currentUserName;
  ChatsInnerScreen(
      {Key? key,
      required this.whoSent,
      required this.clickedPersonUid,
      required this.userName,
      required this.currentUserName})
      : super(key: key);
  @override
  _ChatsInnerScreenState createState() => _ChatsInnerScreenState();
}

class _ChatsInnerScreenState extends State<ChatsInnerScreen> {
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
    var clickedPersonUid = widget.clickedPersonUid;
    var userName = widget.userName;
    var currentUserName = widget.currentUserName;
    String firebaseNameField = "";

    Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
        .collection('Messages')
        .doc(whoSent)
        .collection(clickedPersonUid)
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
          userName,
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
                          bool cardPerson;
                          if (whoSent == qs['whoSent']) {
                            cardPerson = true;
                          } else {
                            cardPerson = false;
                          }
                          return cardPerson
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: whoSent == qs['whoSent']
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Card(
                                              elevation: 2,
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: kPrimaryColor,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 15, 20, 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          qs['message'],
                                                          style: const TextStyle(
                                                              color:
                                                                  kTextDarkColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      Text(d.hour.toString() +
                                                          ":" +
                                                          d.minute.toString()),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: whoSent == qs['whoSent']
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Card(
                                              elevation: 5,
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 15, 20, 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          qs['message'],
                                                          style: const TextStyle(
                                                              color:
                                                                  kTextDarkColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                      Text(d.hour.toString() +
                                                          ":" +
                                                          d.minute.toString()),
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
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(30),
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
                            .collection('Messages')
                            .doc(whoSent)
                            .collection(clickedPersonUid)
                            .doc()
                            .set({
                          'message': message.text.trim(),
                          'time': DateTime.now(),
                          'whoSent': whoSent,
                          'sender': currentUserName
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
