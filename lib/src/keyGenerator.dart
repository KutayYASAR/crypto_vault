import 'package:bip39/bip39.dart' as bip39;

class KeyGenerator
{
  static String randomPhraseGenerator()
  {
    String phrase = bip39.generateMnemonic(strength: 256);
    return phrase;
  }
  static String phraseToSeed(String phrase)
  {
    String key = bip39.mnemonicToSeedHex(phrase);
    return key;
  }
}