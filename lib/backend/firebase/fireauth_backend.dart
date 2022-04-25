import 'package:firebase_auth/firebase_auth.dart';

signInUser() async {
  await FirebaseAuth.instance.signInAnonymously();
}

User? currentUser = FirebaseAuth.instance.currentUser;
