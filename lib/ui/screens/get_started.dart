import 'package:azkar/services/shared_prefs.dart';
import 'package:azkar/services/utilites.dart';
import 'package:azkar/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  static String routeName = '/get_started';
  GetStartedScreen({Key? key}) : super(key: key);
  //late UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            children: [
              SizedBox(height: 32.0),
              Text(
                'أذكاري',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              Text(
                'تطبيق ينظم اذكارك اليومية وبيان فضلها و عدد مرات تكرارها',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Image.network(
                            'https://1.bp.blogspot.com/-TSwBut6XdRg/V44Y-XsrXhI/AAAAAAAAAHc/YUVRXTk856oU-7gFu9hSbxAsoBAHY9GagCK4B/w1200-h630-p-k-no-nu/For-Valid-Acts-of-Worship.jpg',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          MySharedPreference.mySharedPreference
                              .toggleFromFirstTime();
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        },
                        child: Text(
                          'ابدأ بذكر الله',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
