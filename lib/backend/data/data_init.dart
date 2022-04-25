import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/shared_prefs.dart';
import '../connectivity/connection.dart';
import 'data.dart';
import '../firebase/fireauth_backend.dart';
import '../firebase/firestore_backend.dart';

setData() async {
  DateTime now = DateTime.now();

  bool connected = await checkConnection();
  if (connected) {
    if (MySharedPreference.mySharedPreference.isDataNotUploaded()) {
      uploadDataForFirstTime(now);
    }

    int nowInt = now.millisecondsSinceEpoch;
    DocumentSnapshot<Map<String, dynamic>> document = await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    int c = (document.data()?["date"]);

    if (DateTime.fromMillisecondsSinceEpoch(nowInt)
        .subtract(Duration(days: 1))
        .isAfter(DateTime.fromMillisecondsSinceEpoch(c))) {
      resetData(now);
    }
  }
}

uploadDataForFirstTime(DateTime now) {
  print('data not uploaded yet for first time');
  WriteBatch batch = firestore.batch();

  CollectionReference path = firestore
      .collection('users/${currentUser!.uid}/azkar');

  sharedAzkar.forEach((element) {
    batch.set(path.doc(), element.toJson());
  });
  batch.set(
      firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid),
      {
        'counter': 0,
        'title': 'سبحان الله سبحان الله',
        'date': DateTime(now.year, now.month, now.day).millisecondsSinceEpoch
      });

  batch.commit();
  print('ddddone');

  MySharedPreference.mySharedPreference.dataUploadingDone();
}

resetData(DateTime now) {
  //reset Data

  print('reset');
  // WriteBatch batch2 = firestore.batch();
  firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'counter': 0,
    'title': 'سبحان الله سبحان الله',
    'date': DateTime(now.year, now.month, now.day).millisecondsSinceEpoch
  });
  firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('azkar')
      .get()
      .then((snapshot) async {
    for (DocumentSnapshot ds in snapshot.docs) {
      await ds.reference.update({'isDone': false, 'counter': 0});
    }
  });
  print('reset ddddone');
}
