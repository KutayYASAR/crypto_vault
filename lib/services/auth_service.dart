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
        .set({'userUid': user.user!.uid, 'email': email, 'name': nameSurname});

    await _firestore
        .collection("Vaults")
        .doc(user.user!.uid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc("Vaults")
        .set({
      'VaultID': ["0", "1", "1", "1", "1", "1", "1", "0"],
    });

    await _firestore.collection("Users").doc(user.user!.uid).set({
      'name': nameSurname,
      'vault_uid': user.user!.uid,
      'email': email,
      'userUid': user.user!.uid
    });
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

    final oldUserId = getCurrentUser();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Vaults').doc(oldUserId?.uid);

    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: phrase);

    await _firestore
        .collection("Vaults")
        .doc(oldUserId?.uid)
        .collection('Users')
        .doc(nameSurname)
        .set({'userUid': user.user!.uid, 'email': email, 'name': nameSurname});

    await _firestore
        .collection("Vaults")
        .doc(oldUserId?.uid)
        .collection('Users')
        .doc(nameSurname)
        .collection('Permissions')
        .doc("Vaults")
        .set({
      'VaultID': ["0", "1", "1", "1", "1", "1", "1", "0"],
    });

    await _firestore.collection("Users").doc(user.user!.uid).set({
      'name': nameSurname,
      'vault_uid': oldUserId?.uid,
      'email': email,
      'userUid': user.user!.uid
    });
  }

  Future<User?> createInviteLink(String email, String nameSurname,
      String vaultName, String password) async {
    await _firestore
        .collection('Vaults')
        .doc(getCurrentUser()?.uid)
        .collection(vaultName)
        .doc(nameSurname)
        .set({
      'email': email,
    });
  }

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

  Future<void> updateVaultName(String vaultName) async {
    final User user = FirebaseAuth.instance.currentUser!;
    await _firestore
        .collection("Vaults")
        .doc(user.uid)
        .update({'Vault Name': vaultName});
  }

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

  Future<String> getFileUid() async {
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

    final user = getCurrentUser()?.uid;
    List<String> name123 = [];
    await FirebaseFirestore.instance
        .collection('Vaults')
        .doc(uid)
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        name123.add(doc['name']);
      }
    });
    name123.remove(userName);
    return name123;
  }

  //Kayıtlı olan kullanıcıyı alan fonksiyon
  User? getCurrentUser() {
    return _auth.currentUser!;
  }

  //çıkış yap fonksiyonu
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    runApp(new MaterialApp(
      home: new WelcomeScreen(),
    ));
  }
}
