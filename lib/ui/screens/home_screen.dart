// import 'package:azkar/models/Zker_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '/ui/wedgits/custom_zeker_widget.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);

//   final CollectionReference _azkar =
//       FirebaseFirestore.instance.collection('azkar');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('أذكاري'),
//       ),
//       drawer: Drawer(),
//       backgroundColor: Colors.grey[300],
//       body: StreamBuilder(
//           stream: _azkar.snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text("Loading");
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 // crossAxisAlignment: CrossAxisAlignment.end,
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data()! as Map<String, dynamic>;
//                   Zker zeker = Zker.fromJson(data,document.id);
//                //   print(c);
//                   return CustomZekerWidget(zeker: zeker,);
//                 }).toList(),
//               ),
//             );
//           }),
//     );
//   }
// }

import 'package:azkar/models/Zker_model.dart';
import 'package:azkar/services/utilites.dart';
import 'package:azkar/ui/wedgits/custom_drawer.dart';
import 'package:provider/provider.dart';

import '/ui/wedgits/custom_zeker_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    List<Zker> azkarList = Provider.of<List<Zker>>(context);
    print(azkarList);
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('اضغط مرة اخرى للخروج')));
          print('cccccccccccccccccccc');
          return Future.value(false);
        }
        print('vvvvvvvvvvvvvvvvvvv');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('أذكاري'),
        ),
        drawer: CustomDrawer(),
        backgroundColor: Colors.grey[300],
        body: azkarList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : azkarList.every((element) => element.isDone)
                ? Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32.0, horizontal: 32.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ]),
                        child: Text(
                          'لقد أنهيت أذكارك اليومية\n نتمنى لك يوماً جميلاً',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        )),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: azkarList
                          .where((element) => !element.isDone)
                          .map((zeker) => CustomZekerWidget(zeker))
                          .toList(),
                    ),
                  ),
      ),
    );
  }
}
