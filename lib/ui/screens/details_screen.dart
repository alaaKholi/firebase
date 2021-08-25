import 'package:azkar/backend/firestore_backend.dart';
import 'package:azkar/models/Zker_model.dart';
import 'package:azkar/services/utilites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static String routeName = '/details_screen';

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Zker zeker = argument['zeker'];
    print(zeker);
    return Scaffold(
      appBar: AppBar(
        title: Text('أذكاري'),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 10)
                  ]),
              child: Text(
                zeker.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فضل الدعاء',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Text(
                    zeker.description,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 10)
                  ]),
              child: Text(
                'العدد المطلوب : ${zeker.targetCount}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            SizedBox(height: 16.0),
            CustomCircularPercentanceIndicator(zeker: zeker),
          ],
        ),
      ),
    );
  }
}

class CustomCircularPercentanceIndicator extends StatefulWidget {
  const CustomCircularPercentanceIndicator({
    Key? key,
    required this.zeker,
  }) : super(key: key);

  final Zker zeker;

  @override
  _CustomCircularPercentanceIndicatorState createState() =>
      _CustomCircularPercentanceIndicatorState();
}

class _CustomCircularPercentanceIndicatorState
    extends State<CustomCircularPercentanceIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 150.0,
          lineWidth: 15.0,
          animation: true,
          animateFromLastPercent: true,
          percent: widget.zeker.counter / widget.zeker.targetCount,
          center: Text(widget.zeker.counter.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: mainColor,
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
            onPressed: () {
              if (widget.zeker.counter < widget.zeker.targetCount) {
                widget.zeker.counter++;
                firestore
                    .collection(
                        'users/${FirebaseAuth.instance.currentUser!.uid}/azkar/')
                    // .doc(FirebaseAuth.instance.currentUser!.uid)
                    // .collection('azkar')
                    .doc(widget.zeker.id)
                    .update({'counter': widget.zeker.counter});
                setState(() {});
                if (widget.zeker.counter == widget.zeker.targetCount) {
                  widget.zeker.isDone = true;
                  firestore
                      .collection(
                          'users/${FirebaseAuth.instance.currentUser!.uid}/azkar/')
                      .doc(widget.zeker.id)
                      .update({'isDone': widget.zeker.isDone});
                  showCustomDialog(context, [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('الرجوع لقائمة الأذكار')),
                      ],
                    ),
                  ]);
                }
              } else if (widget.zeker.counter == widget.zeker.targetCount) {
                showCustomDialog(context, [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text('الرجوع لقائمة الأذكار')),
                    ],
                  ),
                ]);
              }
            },
            child: Text(
              'اذكر الله',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ))
      ],
    );
  }
}
