// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:crypto_vault/Screens/settings_screen.dart';
import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/models/firebase_file.dart';
import 'package:crypto_vault/services/auth_service.dart';
import 'package:crypto_vault/src/AES_encryption.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

var CardsCreate = [
  ['File Example1'],
  ['File Example2'],
  ['File Example3']
];

List<Map<String, dynamic>> progressItemsBackground = [
  {'color': Color.fromRGBO(196, 196, 196, 1), 'progress': 1}
];

List<Map<String, dynamic>> progressItems = [
  {
    'color': Color(0xff3a49f6),
    'progress': .1,
  },
  {
    'color': Color(0xfff7bc48),
    'progress': .3,
  },
  {
    'color': Color(0xffef5b54),
    'progress': .1,
  },
  {
    'color': Color(0xff5dcb86),
    'progress': .4,
  },
  {'color': Color.fromRGBO(196, 196, 196, 1), 'progress': .1}
];

List<Map<String, dynamic>> storageList = [
  {
    'name': 'ID\'s and Personal Info',
    'color': Color(0xff3d4bf7),
  },
  {
    'name': 'Passwords',
    'color': Color(0xfff7b63a),
  },
  {
    'name': 'Property & Household',
    'color': Color(0xffef5b54),
  },
  {
    'name': 'Estate',
    'color': Color(0xff5dcb86),
  },
  {
    'name': 'Family',
    'color': Color(0xffa257df),
  },
  {
    'name': 'Available Space',
    'color': Color.fromRGBO(196, 196, 196, 1),
  },
];

AppBar AppBarHome(BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: kPrimaryLightColor,
    title: Text(
      'Home',
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
                icon: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                )),
          ],
        ),
      )
    ],
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FirebaseFile>> futureFiles;
  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    futureFiles = _authService.listAllRecent();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthService _authService = AuthService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryLightColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 25, bottom: 20),
                child: Text(
                  'Available Vault Space',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 3),
                                      blurRadius: 3.5,
                                      spreadRadius: -1)
                                ],
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: LayoutBuilder(
                                builder: (ctx, constraints) {
                                  return Stack(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          progressItemsBackground.length,
                                          (f) {
                                            BorderRadius border;
                                            border = BorderRadius.only(
                                              bottomLeft: Radius.circular(30.0),
                                              topLeft: Radius.circular(30.0),
                                              bottomRight:
                                                  Radius.circular(30.0),
                                              topRight: Radius.circular(30.0),
                                            );
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: border,
                                                color:
                                                    progressItemsBackground[f]
                                                        ['color'],
                                              ),
                                              width: constraints.maxWidth *
                                                  progressItemsBackground[f]
                                                      ['progress'],
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                          progressItems.length,
                                          (f) {
                                            BorderRadius border;
                                            if (f == 0)
                                              border = BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(30.0),
                                                topLeft: Radius.circular(30.0),
                                              );
                                            else if (f ==
                                                progressItems.length - 1)
                                              border = BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30.0),
                                                topRight: Radius.circular(30.0),
                                              );
                                            else if (f ==
                                                progressItems.length - 2)
                                              border = BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(30.0),
                                                topRight: Radius.circular(30.0),
                                              );
                                            else
                                              border = BorderRadius.zero;
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: border,
                                                color: progressItems[f]
                                                    ['color'],
                                              ),
                                              width: constraints.maxWidth *
                                                  progressItems[f]['progress'],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            LayoutBuilder(
                              builder: (ctx, constraints) {
                                return Wrap(
                                  runSpacing: 9,
                                  children: List.generate(
                                    6,
                                    (f) {
                                      return Container(
                                        width: constraints.maxWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: storageList[f]
                                                        ['color'],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45.0),
                                                  ),
                                                ),
                                                SizedBox(width: 5.0),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        "${storageList[f]['name']}"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text((() {
                                              if (f == 0) {
                                                return 'Total Space: 64 GB';
                                              }
                                              ;
                                              if (f == 1) {
                                                return 'Remaining : 18.75 GB';
                                              }
                                              return '';
                                            })()),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Recent Files',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder<List<FirebaseFile>>(
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
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              return buildFile(context, file, size);
                            },
                          );
                        }
                    }
                  }),
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: SizedBox(
                height: size.height * 0.05,
                width: size.width * 0.50,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: Text('EXPAND YOUR VAULT',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side:
                                  BorderSide(color: kPrimaryColor, width: 1))),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile filex, Size size) =>
      InkWell(
        child: createRecentFileCard(size, context, filex),
        onTap: () async {
          final isref = filex.ref;
          final dir = await getApplicationDocumentsDirectory();
          final file = File('${dir.path}/${isref.name}');
          var snackBar = SnackBar(
            content: Text('Download has started.'),
            duration: const Duration(milliseconds: 200),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await isref.writeToFile(file);
          print(file.path);
          Future.delayed(Duration(milliseconds: 200), () {
            snackBar = SnackBar(
                content:
                    Text('Download has finished.Dencryption has started.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
          Future.delayed(Duration(milliseconds: 500), () async {
            var f2Path = EncryptData.decrypt_file(file.path,
                '626cf59e45b1e57279df12c65f41a56e697c710185a90f51aed814c0d3464c92c4cb9d4e950e9269fce19971bd7a03d02a77a34708fffc5d45f492e5e9f07bf3fffb5958487a6ae8ef26524ce7173d0178e86c04fab339aba108f4b180876f493ded50dc7b4304ffa95b3bef4b46dee17910ed2ef348f0a259a714d737981c7e');
            final file2 = File(f2Path);
            var data = file2.readAsBytesSync();
            String path = await FileSaver.instance.saveAs(
                basename(f2Path).split('.').first,
                data,
                basename(f2Path).split('.').last,
                MimeType.OTHER);
            print(path);
            file.delete();
            file2.delete();
          });
        },
      );
}

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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                              filex.name
                                  .substring(0, filex.name.lastIndexOf('.')),
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
