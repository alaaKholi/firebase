import 'package:azkar/models/Zker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// getAllZeker() {
//   FirebaseFirestore.instance.collection('users').get().then((value) {
//     print(value);
//     return value;
//   }).catchError((onError) => print('erorrrrrrrrrrr'));
// }
Stream<List<Zker>> zekerAll = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('azkar')
    .snapshots()
    .map((QuerySnapshot querySnapshot) => querySnapshot.docs
        .map(
          (DocumentSnapshot e) =>
              Zker.fromJson(e.data() as Map<String, dynamic>, e.id),
        )
        .toList())
    .handleError((_) {
  print('error');
});

Stream<Map<String, dynamic>> counterAndTitle = firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .snapshots()
    .map((DocumentSnapshot e) {
  Map<String, dynamic> map = e.data() as Map<String, dynamic>;
  return map;
});
