import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:flutter/material.dart';

class messages extends StatefulWidget {
  String clickedPersonUid;
  String whoSent;
  messages({Key? key, required this.whoSent, required this.clickedPersonUid})
      : super(key: key);
  @override
  _messagesState createState() => _messagesState();
}

class _messagesState extends State<messages> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var whoSent = widget.whoSent;
    var clickedPersonUid = widget.clickedPersonUid;
    Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
        .collection('Messages')
        .doc(whoSent)
        .collection(clickedPersonUid)
        .orderBy('time')
        .snapshots();

    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          backgroundColor: kPrimaryLightColor,
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot qs = snapshot.data!.docs[index];
              Timestamp t = qs['time'];
              DateTime d = t.toDate();
              print(d.toString());
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: whoSent == qs['whoSent']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            child: Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    qs['message'],
                                    style: const TextStyle(
                                        color: kTextDarkColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  d.hour.toString() + ":" + d.minute.toString(),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
