// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:crypto_vault/Screens/vault_inner_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/api/firebase_api.dart';
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class uploadFile extends StatefulWidget {
  uploadFile({Key? key}) : super(key: key);

  @override
  State<uploadFile> createState() => _uploadFileState();
}

class _uploadFileState extends State<uploadFile> {
  @override
  String file ="";
  UploadTask? task;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result == null) return;
    final path = result.files.single.path.toString();
    setState(() => file = path);
  }
  
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file) : 'No File Selected';
    return Scaffold
    (
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
        elevation: 0.0,
        backgroundColor: kPrimaryLightColor,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded),onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VaultInnerScreen()));},),
        title: Text(
          'Upload File',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  shape: MaterialStateProperty.all<
                      RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                          color: kPrimaryColor, width: 2))),
                          backgroundColor:MaterialStateProperty.all(Colors.white)),
            ),
          ),
        ),
        Text(
          'Selected File: '+fileName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(50,35,50,150),
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(onPressed: () async {
                final snackBar = SnackBar(content: Text('Encryption has started. App may freeze dont worry!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                Future.delayed(Duration(milliseconds: 300), () {
                  String savefilepth = EncryptData.encrypt_file(file,'626cf59e45b1e57279df12c65f41a56e697c710185a90f51aed814c0d3464c92c4cb9d4e950e9269fce19971bd7a03d02a77a34708fffc5d45f492e5e9f07bf3fffb5958487a6ae8ef26524ce7173d0178e86c04fab339aba108f4b180876f493ded50dc7b4304ffa95b3bef4b46dee17910ed2ef348f0a259a714d737981c7e');
                  var name =basename(savefilepth);
                  uploadFile('Files/$name', savefilepth);
                });  
                }, child: Text('UPLOAD FILE',style:TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                backgroundColor: MaterialStateProperty.all(kPrimaryColor)
              ),
              ),
            ),
          ),
          task != null ? buildUploadStatus(task!) : Container(),
      ]),
    );
  }
    Future uploadFile(String dest,String filePath) async {
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
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Text(
                'Upload Completed. You can go back or upload a new file!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
            ),
              );
            }
            else
            {
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