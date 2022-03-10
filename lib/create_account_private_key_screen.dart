import 'package:crypto_vault/constants.dart';
import 'package:flutter/material.dart';

var privateKeyData = [
  ['pkt1', 'pkt2'],
  ['pkt3', 'pkt4'],
  ['pkt5', 'pkt6'],
  ['pkt7', 'pkt8'],
  ['pkt9', 'pkt10'],
  ['pkt11', 'pkt12'],
  ['pkt13', 'pkt14'],
  ['pkt15', 'pkt16'],
  ['pkt17', 'pkt18'],
  ['pkt19', 'pkt20'],
  ['pkt21', 'pkt22'],
  ['pkt23', 'pkt24'],
];

class CreateAccountPrivateKeyScreen extends StatelessWidget {
  const CreateAccountPrivateKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Center(
          child: Text(
            'Your Private Key',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                height: size.height / 2),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SAVE THIS KEY! Your Data is Encrypted using this key. You will need it to access your encrypted data in the case that you lose your password ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 47),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.83,
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return createAccountPrivateKeyCard(
                                  context,
                                  privateKeyData[index][0],
                                  privateKeyData[index][1]);
                            },
                            itemCount: privateKeyData.length,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountPrivateKeyScreen()));
                              },
                              child: Text('I SAVED İT',
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
                                      MaterialStateProperty.all(kPrimaryColor)),
                            ),
                          ),
                        )
                      ],
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

  Padding createAccountPrivateKeyCard(
      BuildContext context, String privateKeyText1, privateKeyText2) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Center(
                    child: Text(
                      privateKeyText1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
              elevation: 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Center(
                    child: Text(
                      privateKeyText2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
