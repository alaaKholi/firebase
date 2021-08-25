import 'package:azkar/models/Zker_model.dart';
import 'package:azkar/ui/screens/add_zeker_screen.dart';
import 'package:azkar/ui/screens/details_screen.dart';
import 'package:azkar/ui/screens/electronic_zeker_screen.dart';
import 'package:azkar/ui/screens/get_started.dart';
import 'package:azkar/ui/screens/home_screen.dart';
import 'package:azkar/ui/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backend/data.dart';
import 'backend/firestore_backend.dart';
import 'services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreference.mySharedPreference.initMySharedPreference();
    await Firebase.initializeApp();
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print(userCredential);
    print('object');
    print(userCredential.user!.uid);
    DateTime now = DateTime.now();
  
      if (MySharedPreference.mySharedPreference.isDataNotUploaded()) {
        print('data not uploaded yet for first time');
        WriteBatch batch = firestore.batch();

        CollectionReference path = firestore
            .collection('users/${FirebaseAuth.instance.currentUser!.uid}/azkar');
            // .doc(FirebaseAuth.instance.currentUser!.uid)
            // .collection('azkar');

        sharedAzkar.forEach((element) {
          batch.set(path.doc(), element.toJson());
        });
        batch.set(
            firestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid),
            {
              'counter': 0,
              'title': 'سبحان الله سبحان الله',
              'date':
                  DateTime(now.year, now.month, now.day).millisecondsSinceEpoch
            });

        batch.commit();
        print('ddddone');

        MySharedPreference.mySharedPreference.dataUploadingDone();
      }

      int nowInt = now.millisecondsSinceEpoch;
      DocumentSnapshot<Map<String, dynamic>> document = await firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      int c = document.data()!['date'];

      if (DateTime.fromMillisecondsSinceEpoch(nowInt)
          .subtract(Duration(days: 1))
          .isAfter(DateTime.fromMillisecondsSinceEpoch(c))) {
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
        //batch2.commit();
        print('reset ddddone');
      }
    
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: StreamProvider<Map<String, dynamic>>.value(
                value: counterAndTitle,
                initialData: {'counter': 0, 'title': 'سبحان الله العظيم'},
                child: StreamProvider<List<Zker>>.value(
                  value: zekerAll,
                  initialData: [],
                  child: child,
                ),
              ),
            ),
            data: data.copyWith(
              textScaleFactor: data.textScaleFactor.clamp(0.8, 1.2),
            ),
          );
        },
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          GetStartedScreen.routeName: (context) => GetStartedScreen(),
          AddZekerScreen.routeName: (context) => AddZekerScreen(),
          DetailsScreen.routeName: (context) => DetailsScreen(),
          ElectronicZeker.routeName: (context) => ElectronicZeker(),
        });
  }
}
