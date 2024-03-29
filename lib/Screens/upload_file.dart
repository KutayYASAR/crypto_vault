// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_vault/Screens/vault_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/api/firebase_api.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:crypto_vault/src/keyGenerator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uploadFile extends StatefulWidget {
  final String vaultName;
  uploadFile({Key? key, required this.vaultName}) : super(key: key);

  @override
  State<uploadFile> createState() => _uploadFileState();
}

class _uploadFileState extends State<uploadFile> {
  @override
  AuthService _authService = AuthService();
  String vaultNameUpload = '';
  @override
  void initState() {
    super.initState();
    var vaultName = widget.vaultName;

    if (vaultName == "ID's and Personal Info") {
      vaultNameUpload = "ID";
    } else if (vaultName == "Passwords") {
      vaultNameUpload = "Passwords";
    } else if (vaultName == "Property & Household") {
      vaultNameUpload = "Property";
    } else if (vaultName == "Estate") {
      vaultNameUpload = "Estate";
    } else if (vaultName == "Family") {
      vaultNameUpload = "Family";
    } else if (vaultName == "Health") {
      vaultNameUpload = "Health";
    } else if (vaultName == "Personal Business") {
      vaultNameUpload = "Personal";
    } else if (vaultName == "Archive") {
      vaultNameUpload = "Archive";
    }
  }

  String file = "";
  UploadTask? task;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path.toString();
    setState(() => file = path);
  }

  Widget build(BuildContext context) {
    var vaultNameOfStorage = vaultNameUpload;
    var vaultName = widget.vaultName;
    final fileName = file != null ? basename(file) : 'No File Selected';
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
        elevation: 0.0,
        backgroundColor: kPrimaryLightColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () async {
            var uid = await _authService.getVaultUid();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VaultInnerScreen(
                          uid: uid,
                          vaultName: vaultName,
                        )));
          },
        ),
        title: Text(
          'Upload File',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 35),
          child: SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: selectFile,
              child: Text('SELECT FILE',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: kPrimaryColor, width: 2))),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
            ),
          ),
        ),
        Text(
          'Selected File: ' + fileName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 35, 50, 150),
          child: SizedBox(
            width: double.infinity,
            height: 70,
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var phrase = prefs.getString('phrase');
                var seed = KeyGenerator.phraseToSeed(phrase!);
                final snackBar = SnackBar(
                    content: Text(
                        'Encryption has started. App may freeze dont worry!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Future.delayed(Duration(milliseconds: 300), () async {
                  String savefilepth = EncryptData.encrypt_file(file, seed);
                  var name = basename(savefilepth);
                  var uid = await _authService.getVaultUid();
                  uploadFile(
                      '$uid/Files/$vaultNameOfStorage/$name', savefilepth);
                  String pathOfStorage = '$uid/Files/$vaultNameOfStorage/$name';
                  String vaultUid = await _authService.getVaultUid();
                  if (name.length > 0) {
                    await FirebaseFirestore.instance
                        .collection('Vaults')
                        .doc(vaultUid)
                        .collection('Files')
                        .doc(name + vaultNameOfStorage)
                        .set({'path': pathOfStorage, 'time': DateTime.now()});
                  }
                });
              },
              child: Text('UPLOAD FILE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
            ),
          ),
        ),
        task != null ? buildUploadStatus(task!) : Container(),
      ]),
    );
  }

  Future uploadFile(String dest, String filePath) async {
    if (file == null) return;
    task = FirebaseApi.uploadFile(dest, File(filePath));
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            if (percentage == '100.00') {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Upload Completed. You can go back or upload a new file!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Text(
                'Uploading: $percentage%',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              );
            }
          } else {
            return Container();
          }
        },
      );
}
