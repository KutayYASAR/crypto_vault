// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
        .set({'Vault Name': vaultName});

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
    print(phrase);

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
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: const Text('Attention')),
            content: const Text('Your Password Has Been Changed.'),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      }).catchError((error) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: const Text('Attention')),
            content: Text('Password must be atleast 6 characters.'),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      });
    }).catchError((err) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: const Text('Attention')),
          content: Text('Wrong Password.'),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      );
    });
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

  Future<String> getVaultChat() async {
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

    String groupchatName = "";
    await _firestore
        .collection('Group Chats')
        .doc(uid)
        .collection('Chats')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        groupchatName = doc['name'];
      }
    });
    return groupchatName;
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
        .set({'chatPersonUid': '$uid', 'name': '$currentUserName'});
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
        .where('userUid', isEqualTo: '$uidOfPerson')
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

  Future<void> updateVaultName(String vaultName) async {
    final User user = FirebaseAuth.instance.currentUser!;
    await _firestore
        .collection("Vaults")
        .doc(user.uid)
        .update({'Vault Name': vaultName});
  }

  /*
  Future<void> getData() async {
    List<String> name = [];
    await _firestore
        .collection('Vaults')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        name = doc['Vault Name'];
        print(name.toString());
      }
    });
  }
  */

  /*
  Future<String> getSpecie() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Vaults')
        .doc(getCurrentUser()?.uid);
    String specie = '';
    await documentReference.get().then((snapshot) {
      specie = snapshot['Vault Name'].toString();
      print(specie);
    });
    return specie;
  }
  */

  /*
  Future<List<String>> getVaultName() async {
    final user = getCurrentUser()?.uid;
    List<String> name = [];
    await FirebaseFirestore.instance
        .collection('Vaults')
        .where('uid', isEqualTo: '$user')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        name.add(doc['Vault Name']);
        print(name);
      }
    });
    return name;
  }
  */

}
