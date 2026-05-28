import 'package:firebase_database/firebase_database.dart';

class FirebaseModule {
  static FirebaseDatabase get database => FirebaseDatabase.instance;
}
