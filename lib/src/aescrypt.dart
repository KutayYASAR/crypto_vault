part of aes_crypt;


enum AesCryptOwMode {

  warn,

  rename,

  on,
}

enum AesMode {
  /// ECB (Electronic Code Book)
  ecb,

  /// CBC (Cipher Block Chaining)
  cbc,

  /// CFB (Cipher Feedback)
  cfb,

  /// OFB (Output Feedback)
  ofb,
}

/// Wraps encryption and decryption methods and algorithms.
class AesCrypt {
  final _aes = _Aes();

  String? _password;
  Uint8List? _passBytes;
  AesCryptOwMode? _owMode;
  Map<String, List<int>>? _userdata;

 
  AesCrypt([String password = '']) {
    _password = password;
    _passBytes = password.toUtf16Bytes(Endian.little);
    _owMode = AesCryptOwMode.warn;
    setUserData();
  }

  /// Sets encryption/decryption password.
  void setPassword(String password) {
    AesCryptArgumentError.checkNullOrEmpty(password, 'Empty password.');
    _password = password;
    _passBytes = password.toUtf16Bytes(Endian.little);
  }


  void setOverwriteMode(AesCryptOwMode mode) => _owMode = mode;

  void setUserData(
      {String createdBy = 'Dart aes_crypt library',
      String createdOn = '',
      String createdAt = ''}) {
    String key;
    _userdata = {};
    if (createdBy.isNotEmpty) {
      key = 'CREATED_BY';
      _userdata![key] = createdBy.toUtf8Bytes();
      if (key.length + _userdata![key]!.length + 1 > 255) {
        throw AesCryptArgumentError(
            'User data \'$key\' is too long. Total length should not exceed 255 bytes.');
      }
    }
    if (createdOn.isNotEmpty) {
      key = 'CREATED_DATE';
      _userdata![key] = createdOn.toUtf8Bytes();
      if (key.length + _userdata![key]!.length + 1 > 255) {
        throw AesCryptArgumentError(
            'User data \'$key\' is too long. Total length should not exceed 255 bytes.');
      }
    }
    if (createdAt.isNotEmpty) {
      key = 'CREATED_TIME';
      _userdata![key] = createdAt.toUtf8Bytes();
      if (key.length + _userdata![key]!.length + 1 > 255) {
        throw AesCryptArgumentError(
            'User data \'$key\' is too long. Total length should not exceed 255 bytes.');
      }
    }
  }

  String encryptDataToFileSync(Uint8List srcData, String destFilePath) {
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        destFilePath, 'Empty encrypted file path.');
    return _Cryptor.init(_passBytes, _owMode, _userdata)
        .encryptDataToFileSync(srcData, destFilePath);
  }

  String encryptTextToFileSync(String srcString, String destFilePath,
      {bool utf16 = false, Endian endian = Endian.big, bool bom = false}) {
    Uint8List bytes = utf16
        ? srcString.toUtf16Bytes(endian, bom)
        : srcString.toUtf8Bytes(bom) as Uint8List;
    return encryptDataToFileSync(bytes, destFilePath);
  }

  Future<String> encryptDataToFile(
      Uint8List srcData, String destFilePath) async {
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        destFilePath, 'Empty encrypted file path.');
    return await _Cryptor.init(_passBytes, _owMode, _userdata)
        .encryptDataToFile(srcData, destFilePath);
  }

  Future<String> encryptTextToFile(String srcString, String destFilePath,
      {bool utf16 = false,
      Endian endian = Endian.big,
      bool bom = false}) async {
    Uint8List bytes = utf16
        ? srcString.toUtf16Bytes(endian, bom)
        : srcString.toUtf8Bytes(bom) as Uint8List;
    return await encryptDataToFile(bytes, destFilePath);
  }


  String encryptFileSync(String srcFilePath, [String destFilePath = '']) {
    srcFilePath = srcFilePath.trim();
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    if (srcFilePath == destFilePath)
      throw AesCryptArgumentError(
          'Source file path and encrypted file path are the same.');
    return _Cryptor.init(_passBytes, _owMode, _userdata)
        .encryptFileSync(srcFilePath, destFilePath);
  }

  Future<String> encryptFile(String srcFilePath,
      [String destFilePath = '']) async {
    srcFilePath = srcFilePath.trim();
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    if (srcFilePath == destFilePath)
      throw AesCryptArgumentError(
          'Source file path and encrypted file path are the same.');
    return await _Cryptor.init(_passBytes, _owMode, _userdata)
        .encryptFile(srcFilePath, destFilePath);
  }

  Uint8List decryptDataFromFileSync(String srcFilePath) {
    srcFilePath = srcFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    return _Cryptor.init(_passBytes, _owMode, _userdata)
        .decryptDataFromFileSync(srcFilePath);
  }


  String decryptTextFromFileSync(String srcFilePath,
      {bool utf16 = false, Endian endian = Endian.big}) {
    Uint8List decData = decryptDataFromFileSync(srcFilePath);
    String srcString;
    if ((decData[0] == 0xFE && decData[1] == 0xFF) ||
        (decData[0] == 0xFF && decData[1] == 0xFE)) {
      srcString = decData.toUtf16String();
    } else if (decData[0] == 0xEF && decData[1] == 0xBB && decData[2] == 0xBF) {
      srcString = decData.toUtf8String();
    } else {
      srcString =
          utf16 ? decData.toUtf16String(endian) : decData.toUtf8String();
    }
    return srcString;
  }

  Future<Uint8List> decryptDataFromFile(String srcFilePath) async {
    srcFilePath = srcFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    return await _Cryptor.init(_passBytes, _owMode, _userdata)
        .decryptDataFromFile(srcFilePath);
  }


  Future<String> decryptTextFromFile(String srcFilePath,
      {bool utf16 = false, Endian endian = Endian.big}) async {
    Uint8List decData = await decryptDataFromFileSync(srcFilePath);
    String srcString;
    if ((decData[0] == 0xFE && decData[1] == 0xFF) ||
        (decData[0] == 0xFF && decData[1] == 0xFE)) {
      srcString = decData.toUtf16String();
    } else if (decData[0] == 0xEF && decData[1] == 0xBB && decData[2] == 0xBF) {
      srcString = decData.toUtf8String();
    } else {
      srcString =
          utf16 ? decData.toUtf16String(endian) : decData.toUtf8String();
    }
    return srcString;
  }


  String decryptFileSync(String srcFilePath, [String destFilePath = '']) {
    srcFilePath = srcFilePath.trim();
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    if (srcFilePath == destFilePath)
      throw AesCryptArgumentError(
          'Source file path and decrypted file path are the same.');
    return _Cryptor.init(_passBytes, _owMode, _userdata)
        .decryptFileSync(srcFilePath, destFilePath);
  }

 
  Future<String> decryptFile(String srcFilePath,
      [String destFilePath = '']) async {
    srcFilePath = srcFilePath.trim();
    destFilePath = destFilePath.trim();
    AesCryptArgumentError.checkNullOrEmpty(_password, 'Empty password.');
    AesCryptArgumentError.checkNullOrEmpty(
        srcFilePath, 'Empty source file path.');
    if (srcFilePath == destFilePath)
      throw AesCryptArgumentError(
          'Source file path and decrypted file path are the same.');
    return await _Cryptor.init(_passBytes, _owMode, _userdata)
        .decryptFile(srcFilePath, destFilePath);
  }


  Uint8List createKey([int length = 32]) => _Cryptor().createKey(length);

  Uint8List createIV() => _Cryptor().createKey(16);


  Uint8List sha256(Uint8List data) => _Cryptor().sha256(data);


  Uint8List hmacSha256(Uint8List key, Uint8List data) =>
      _Cryptor().hmacSha256(key, data);

  void aesSetKeys(Uint8List key, [Uint8List? iv]) => _aes.aesSetKeys(key, iv);


  void aesSetMode(AesMode mode) => _aes.aesSetMode(mode);

  void aesSetParams(Uint8List key, Uint8List iv, AesMode mode) {
    aesSetKeys(key, iv);
    aesSetMode(mode);
  }

  Uint8List aesEncrypt(Uint8List data) => _aes.aesEncrypt(data);

  Uint8List aesDecrypt(Uint8List data) => _aes.aesDecrypt(data);
}
