import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile {
  final Reference ref;
  final String name;

  const FirebaseFile({
    required this.ref,
    required this.name,
  });
}