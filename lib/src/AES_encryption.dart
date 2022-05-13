import 'dart:async';
import 'dart:io';
import 'package:crypto_vault/aes_crypt_null_safe.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/material.dart';

 class EncryptData {
   
  static String encrypt_file(String path,String key) {
    String encFilepath="";
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword(key);
    try {

      encFilepath = crypt.encryptFileSync(path);
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
    } catch (e) {
      print(e);
    }
    return encFilepath;
  }

  static String decrypt_file(String path,String key) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword(key);
    String decFilepath="";
    try {
      Stopwatch stopwatch = new Stopwatch()..start();
      print('The decryption started');
      decFilepath = crypt.decryptFileSync(path);
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('executed in ${stopwatch.elapsed.inSeconds}');
      print('File content: ' + File(decFilepath).path);
    } catch (e) {
      print(e);
    }
    return decFilepath;
  }
}