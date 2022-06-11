import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrimaryColor = Color.fromRGBO(122, 115, 231, 1);
const kPrimaryLightColor = Color.fromRGBO(223, 224, 227, 1);
const kTextDarkColor = Color.fromRGBO(119, 119, 119, 1);

class Constants {
  late bool colorMode = false;

  void loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    colorMode = (prefs.getBool('dark') ?? false);
  }

  var kPrimaryColor = Color.fromRGBO(122, 115, 231, 1);
  var kPrimaryDarkColor = Color.fromRGBO(66, 66, 66, 1);
  var kPrimaryLightColor = Color.fromRGBO(223, 224, 227, 1);
  var kTextColor = Colors.white;
  var kTextDarkColor = Color.fromRGBO(119, 119, 119, 1);
  var kBottomBarColor = Color.fromRGBO(255, 255, 255, 1);
  var kBottomBarDarkColor = Color.fromRGBO(38, 38, 38, 1);

  Color get getPrimaryColor {
    loadCounter();
    if (colorMode == true) {
      return kPrimaryDarkColor;
    } else {
      return kPrimaryLightColor;
    }
  }

  Color get getKPrimaryColor {
    return kPrimaryDarkColor;
  }

  Color get getTextColor {
    loadCounter();
    if (colorMode == true) {
      return kTextDarkColor;
    } else {
      return kTextColor;
    }
  }

  Color get getBottomBarColor {
    loadCounter();
    if (colorMode == true) {
      return kBottomBarDarkColor;
    } else {
      return kBottomBarColor;
    }
  }
}
