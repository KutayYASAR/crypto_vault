// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:crypto_vault/Screens/upload_file.dart';
import 'package:crypto_vault/models/api/firebase_api.dart';
import 'package:crypto_vault/models/firebase_file.dart';
import 'package:crypto_vault/src/keyGenerator.dart';
import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:bip39/bip39.dart' as bip39;

import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


AppBar AppBarVaultsInnerScreen() {
  return AppBar(
    foregroundColor: kPrimaryColor,
    elevation: 0.0,
    backgroundColor: kPrimaryLightColor,
    centerTitle: true,
    title: Text(
      'Vault Name',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
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
  );
}

class VaultInnerScreen extends StatefulWidget {
  const VaultInnerScreen({Key? key}) : super(key: key);
  @override
  State<VaultInnerScreen> createState() => _VaultInnerState();
}

class _VaultInnerState extends State<VaultInnerScreen> {
   late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('Files/');
  }
  @override

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarVaultsInnerScreen(),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;
                    return SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];
                                print(file.name);
                                return buildFile(context, file,size);
                              },
                            ),
                          ),
                      Center(
                        child: Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.03, bottom: size.height * 0.03),
                        child: SizedBox(
                          height: size.height * 0.05,
                          width: size.width * 0.50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> uploadFile()));
                             },
                            child: Text('ADD FILE',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: kPrimaryColor, width: 1))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                          ),
                        )),
                      ),
                        ],

                      ),
                    );
                }
            }
          },
        ),
        );
        
  }
  Widget buildFile(BuildContext context, FirebaseFile filex,Size size) => 
  InkWell(
      child: createRecentFileCard(size, context, filex),
      onTap: () async {
        
        final isref = filex.ref;
        final dir =await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/${isref.name}');
        var snackBar = SnackBar(content: Text('Download has started.'),duration: const Duration(milliseconds: 200),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar); 
        await isref.writeToFile(file);
        print(file.path);
        Future.delayed(Duration(milliseconds: 200), () {
          snackBar = SnackBar(content: Text('Download has finished.Dencryption has started.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
        Future.delayed(Duration(milliseconds: 500), () async {
          var f2Path= EncryptData.decrypt_file(file.path,'626cf59e45b1e57279df12c65f41a56e697c710185a90f51aed814c0d3464c92c4cb9d4e950e9269fce19971bd7a03d02a77a34708fffc5d45f492e5e9f07bf3fffb5958487a6ae8ef26524ce7173d0178e86c04fab339aba108f4b180876f493ded50dc7b4304ffa95b3bef4b46dee17910ed2ef348f0a259a714d737981c7e');
          final file2 = File(f2Path);
          var data = file2.readAsBytesSync();
          String path = await FileSaver.instance.saveAs(basename(f2Path).split('.').first, data, basename(f2Path).split('.').last,MimeType.OTHER);
          print(path);
          file.delete();
          file2.delete();
        }); 

      },
      onLongPress: () async {
        await filex.ref.delete();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VaultInnerScreen()));
        },
    );
  Padding createRecentFileCard(
      Size size, BuildContext context, FirebaseFile filex) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.width * 0.85,
            child: Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Center(
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 9, bottom: 9),
                            child: Icon(
                              Icons.file_copy,
                              color: kTextDarkColor,
                              size: 44.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 1,
                              color: kPrimaryLightColor,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                filex.name.substring(0,filex.name.lastIndexOf('.')),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: kTextDarkColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
