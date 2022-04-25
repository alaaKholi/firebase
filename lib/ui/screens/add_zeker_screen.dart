import 'package:azkar/backend/firebase/firestore_backend.dart';
import 'package:azkar/models/Zker_model.dart';
import 'package:azkar/services/utilites.dart';
import 'package:azkar/ui/screens/home_screen.dart';
import 'package:azkar/ui/wedgits/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddZekerScreen extends StatelessWidget {
  AddZekerScreen({Key? key}) : super(key: key);
  static String routeName = '/add_zeker';

  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late int _targetCount;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _targetCountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        print('vvvvvvvvvvvvvvvvvvv');
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة ذِكْر'),
        ),
        backgroundColor: Colors.grey[300],
        drawer: CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    maxLines: null,
                    autofocus: true,
                    onSaved: (value) => _title = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'عنوان الذكر',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: null,
                    onSaved: (value) => _description = value!,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'فضل الذكر',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _targetCountController,
                    maxLines: null,
                    onSaved: (value) => _targetCount = int.parse(value!),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد مرات تكرار الذكر',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
          
                        firestore
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('azkar')
                            .doc()
                            .set(Zker(
                                    counter: 0,
                                    targetCount: _targetCount,
                                    title: _title,
                                    description: _description,
                                    isDone: false,
                                    id: 'null')
                                .toJson());
                        showCustomDialog(
                          context,
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacementNamed(
                                          HomeScreen.routeName);
                                    },
                                    child: Text('الرجوع لقائمة الأذكار')),
                                TextButton(
                                    onPressed: () {
                                      _titleController.text = '';
                                      _descriptionController.text = '';
                                      _targetCountController.text = '';
                                      Navigator.of(context).pop();
      
                                         },
                                    child: Text('إضافة ذِكْر أخر')),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                    child: Text('إضافة'),
                  )
                ],
              ),
            ),
          ),
        ),
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         margin:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         alignment: Alignment.centerRight,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Colors.grey[300],
        //             boxShadow: [
        //               BoxShadow(
        //                   color: Colors.black12, spreadRadius: 1, blurRadius: 10)
        //             ]),
        //         child: Text(
        //           'xx',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        //         ),
        //       ),
        //       SizedBox(height: 16.0),
        //       Container(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         margin:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         alignment: Alignment.centerRight,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Colors.grey[300],
        //             boxShadow: [
        //               BoxShadow(
        //                   color: Colors.black12, spreadRadius: 1, blurRadius: 10)
        //             ]),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'فضل الدعاء',
        //               style:
        //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        //             ),
        //             Text(
        //               'zeker.description',
        //               style:
        //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 16.0),
        //       Container(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         margin:
        //             const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        //         alignment: Alignment.centerRight,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: Colors.grey[300],
        //             boxShadow: [
        //               BoxShadow(
        //                   color: Colors.black12, spreadRadius: 1, blurRadius: 10)
        //             ]),
        //         child: Text(
        //           'العدد المطلوب : ${'zeker.targetCount'}',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        //         ),
        //       ),
        //       SizedBox(height: 16.0),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
