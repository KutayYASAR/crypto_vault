// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/firebase_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //kayıt ol fonksiyonu
  Future<User?> createVault(String email, String nameSurname, String vaultName,
      String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore
        .collection("Vaults")
        .doc(user.user!.uid)
        .set({'Vault Name': vaultName, 'vault_uid': user.user!.uid});

    await _firestore
        .collection("Vaults")
        .doc(user.user!.uid)
        .collection('Users')
        .doc(nameSurname)
        .set({
      'userUid': user.user!.uid,
      'email': email,
      'name': nameSurname,
    });

    await _firestore
        .collection("Vaults")
        .doc(user.user!.uid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc("Vaults")
        .set({
      '0': true,
      '1': true,
      '2': true,
      '3': true,
      '4': true,
      '5': true,
      '6': true,
      '7': true,
    });

    await _firestore.collection("Users").doc(user.user!.uid).set({
      'name': nameSurname,
      'vault_uid': user.user!.uid,
      'email': email,
      'userUid': user.user!.uid,
      'admin': 'Admin',
    });

    await _firestore
        .collection('Vault Chats')
        .doc(getCurrentUser()?.uid)
        .collection('Users')
        .doc(getCurrentUser()?.uid)
        .set({'uid': getCurrentUser()?.uid, 'name': nameSurname});

    return user.user;
  }

  Future<void> addUser(String email, String nameSurname) async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random.secure();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    var phrase = getRandomString(10);

    String uid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });

    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: phrase);

    await _firestore
        .collection("Vaults")
        .doc(uid)
        .collection('Users')
        .doc(nameSurname)
        .set({
      'userUid': user.user!.uid,
      'email': email,
      'name': nameSurname,
    });

    await _firestore
        .collection("Vaults")
        .doc(uid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc("Vaults")
        .set({
      '0': true,
      '1': true,
      '2': true,
      '3': true,
      '4': true,
      '5': true,
      '6': true,
      '7': true,
    });
    await _firestore.collection("Users").doc(user.user!.uid).set({
      'name': nameSurname,
      'vault_uid': uid,
      'email': email,
      'userUid': user.user!.uid,
      'admin': 'Member'
    });

    await _firestore
        .collection('Vault Chats')
        .doc(uid)
        .collection('Users')
        .doc(user.user!.uid)
        .set({'uid': user.user!.uid, 'name': nameSurname});
  }

  Future changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user?.email as String, password: currentPassword);

    user?.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  contentPadding: EdgeInsets.only(top: 10),
                  content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          child: Text(
                            'Attention',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Text(
                            'Your Password Has Been Changed.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 5, 20),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              kPrimaryColor)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ));
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  contentPadding: EdgeInsets.only(top: 10),
                  content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          child: Text(
                            'Attention',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
                          child: Text(
                            'Password must be atleast 6 characters.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 5, 20),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              kPrimaryColor)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ));
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.only(top: 10),
                content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        child: Text(
                          'Attention',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Text(
                          'Wrong Password.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 5, 20),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryColor)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ));
    });
  }

  Future<String> getVaultUid() async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });
    return uid;
  }

  Future<String> getVaultUidFromEmail(String email) async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });
    return uid;
  }

  Future<List<Reference>> getRecentFiles() async {
    var vaultUid = await getVaultUid();
    List<Reference> recentFiles = [];
    int count = 0;
    await _firestore
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Files')
        .orderBy('time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        recentFiles.add(FirebaseStorage.instance.ref(doc['path']));
        if (count >= 2) {
          break;
        }
        count++;
      }
      count = 0;
    });

    return recentFiles;
  }

  Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  Future<List<FirebaseFile>> listAllRecent() async {
    var recentFiles = await getRecentFiles();
    List<FirebaseFile> fileList = [];
    final urls = await _getDownloadLinks(recentFiles);
    for (var ref in recentFiles) {
      fileList.add(FirebaseFile(ref: ref, name: ref.name));
    }
    return fileList;
  }

  Future<List<String>> getPeopleName() async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });

    String userName = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userName = doc['name'].toString();
      }
    });

    List<String> name = [];
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(uid)
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        name.add(doc['name']);
      }
    });
    name.remove(userName);
    return name;
  }

  Future<String> getClickedPersonUid(String name) async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('name', isEqualTo: name)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['userUid'];
      }
    });
    return uid;
  }

  Future<List<String>> getPeopleChats() async {
    List<String> chatNameList = [];
    await _firestore
        .collection('Chats')
        .doc(getCurrentUser()?.uid)
        .collection('Chats')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chatNameList.add(doc['name']);
      }
    });
    return chatNameList;
  }

  Future createChats(String chatPersonUid, String chatPersonName) async {
    var currentUserName = await getCurrentUserName();
    var uid = await getCurrentUser()?.uid;
    await _firestore
        .collection('Chats')
        .doc(getCurrentUser()?.uid)
        .collection('Chats')
        .doc(chatPersonUid)
        .set({'chatPersonUid': chatPersonUid, 'name': chatPersonName});
    await _firestore
        .collection('Chats')
        .doc(chatPersonUid)
        .collection('Chats')
        .doc(getCurrentUser()?.uid)
        .set({'chatPersonUid': '$uid', 'name': currentUserName});
  }

  Future<String> getCurrentUserName() async {
    String name = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        name = doc['name'];
      }
    });
    return name;
  }

  Future<String> getAdminStatus() async {
    String status = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        status = doc['admin'].toString();
      }
    });
    return status;
  }

  Future<void> setAdminStatus(String nameSurname) async {
    String vaultUid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vaultUid = doc['vault_uid'].toString();
      }
    });

    String userUid = "";
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Users')
        .where('name', isEqualTo: '$nameSurname')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userUid = doc['userUid'].toString();
      }
    });

    await _firestore
        .collection('Users')
        .doc(userUid)
        .update({'admin': 'Admin'});
  }

  Future<void> setMemberStatus(String nameSurname) async {
    String vaultUid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vaultUid = doc['vault_uid'].toString();
      }
    });

    String userUid = "";
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Users')
        .where('name', isEqualTo: '$nameSurname')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userUid = doc['userUid'].toString();
      }
    });

    await _firestore
        .collection('Users')
        .doc(userUid)
        .update({'admin': 'Member'});
  }

  Future<void> setVaultPermissionStatusTrue(
      String nameSurname, int index) async {
    String vaultUid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vaultUid = doc['vault_uid'].toString();
      }
    });

    await _firestore
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc('Vaults')
        .update({'$index': true});
  }

  Future<void> setVaultPermissionStatusFalse(
      String nameSurname, int index) async {
    String vaultUid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vaultUid = doc['vault_uid'].toString();
      }
    });

    await _firestore
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc('Vaults')
        .update({'$index': false});
  }

  Future<String> getAdminStatusOfClickedPerson(String nameSurname) async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });

    String uidOfPerson = "";
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(uid)
        .collection('Users')
        .where('name', isEqualTo: '$nameSurname')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uidOfPerson = doc['userUid'];
      }
    });

    String adminStatus = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: uidOfPerson)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        adminStatus = doc['admin'];
      }
    });
    return adminStatus;
  }

  Future<List<bool>> getClickedPersonPermissionData(String nameSurname) async {
    String uid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        uid = doc['vault_uid'].toString();
      }
    });

    List<bool> data = [];
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(uid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        data.add(doc['0']);
        data.add(doc['1']);
        data.add(doc['2']);
        data.add(doc['3']);
        data.add(doc['4']);
        data.add(doc['5']);
        data.add(doc['6']);
        data.add(doc['7']);
      }
    });
    return data;
  }

  Future<List<bool>> getPermissionData() async {
    String vaultUid = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        vaultUid = doc['vault_uid'].toString();
      }
    });
    String userName = "";
    await _firestore
        .collection('Users')
        .where('userUid', isEqualTo: getCurrentUser()?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userName = doc['name'].toString();
      }
    });

    List<bool> data = [];
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(vaultUid)
        .collection('Users')
        .doc(userName)
        .collection('Permissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        data.add(doc['0']);
        data.add(doc['1']);
        data.add(doc['2']);
        data.add(doc['3']);
        data.add(doc['4']);
        data.add(doc['5']);
        data.add(doc['6']);
        data.add(doc['7']);
      }
    });
    return data;
  }

  //Kayıtlı olan kullanıcıyı alan fonksiyon
  User? getCurrentUser() {
    return _auth.currentUser!;
  }

  //çıkış yap fonksiyonu
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    runApp(new MaterialApp(
      home: new WelcomeScreen(),
    ));
  }
}
