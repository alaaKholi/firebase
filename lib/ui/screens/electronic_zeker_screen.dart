import 'package:azkar/backend/firestore_backend.dart';
import 'package:azkar/services/utilites.dart';
import 'package:azkar/ui/screens/home_screen.dart';
import 'package:azkar/ui/wedgits/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ElectronicZeker extends StatelessWidget {
  ElectronicZeker({Key? key}) : super(key: key);
  static String routeName = '/electronic_zeker';
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> counterAndTitleMap =
        Provider.of<Map<String, dynamic>>(context);
    int counter = counterAndTitleMap['counter'];
    String title = counterAndTitleMap['title'];
    TextEditingController textController = TextEditingController(text: title);

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        print('vvvvvvvvvvvvvvvvvvv');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('المسبحة الالكترونية'),
        ),
        resizeToAvoidBottomInset: false,
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                shape: Border.all(
                    color: mainColor, style: BorderStyle.solid, width: 1.5),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    // Provider.of<ZekerCounterProvider>(context,
                                    //         listen: false)
                                    firestore
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({'title': textController.text});

                                    //     .changeZekerTitle(textController.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('تغيير'))
                            ],
                            content: TextFormField(
                              controller: textController,
                            ),
                          );
                        });
                  },
                ),
                title: Text(title),
              ),
              //SizedBox(height: 64.0),
              Expanded(
                flex: 5,
                child: CircularPercentIndicator(
                  radius: 180,
                  lineWidth: 8.0,
                  center: FittedBox(
                    child: Text(
                      counter.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 64.0),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      // Provider.of<ZekerCounterProvider>(context, listen: false)
                      //     .increaseCounter();
                      counter++;
                      firestore
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'counter': counter});
                    },
                    child: Text(
                      "اذكر الله",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(height: 16.0),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {
                      // Provider.of<ZekerCounterProvider>(context, listen: false)
                      //     .reset();
                      counter = 0;
                      firestore
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'counter': counter});
                    },
                    child: Text(
                      "إعادة البدء",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
