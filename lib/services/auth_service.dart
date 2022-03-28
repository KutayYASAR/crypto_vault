import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        .collection(vaultName)
        .doc(nameSurname)
        .set({
      'email': email,
    });
    return user.user;
  }

  //Giriş yapılı olan kullanıcıyı alan fonksiyon
  User? getCurrentUser() {
    return _auth.currentUser!;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }
}
