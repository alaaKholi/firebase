import 'package:azkar/models/Zker_model.dart';
import 'package:azkar/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/data/data_init.dart';
import 'backend/firebase/fireauth_backend.dart';
import 'backend/firebase/firestore_backend.dart';
import 'services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreference.mySharedPreference.initMySharedPreference();
  await Firebase.initializeApp();
  await signInUser();
  await setData();
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
        routes: routes);
  }
}
