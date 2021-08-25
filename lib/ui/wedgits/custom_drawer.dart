import 'package:azkar/services/utilites.dart';
import 'package:azkar/ui/screens/add_zeker_screen.dart';
import 'package:azkar/ui/screens/electronic_zeker_screen.dart';
import 'package:azkar/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200.0, child: Container(color: mainColor)),
            ListTile(
              title: Text('أذكاري'),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, (route) => false);
              },
            ),
            ListTile(
              title: Text('أضف ذِكْر'),
              leading: Icon(Icons.add),
              onTap: () {
                 Navigator.of(context).pushNamedAndRemoveUntil(
                    AddZekerScreen.routeName, (route) => false);
             
              },
            ),
            ListTile(
              title: Text('المسبحة الالكترونية'),
              leading: Icon(Icons.add),
              onTap: () {
                 Navigator.of(context).pushNamedAndRemoveUntil(
                    ElectronicZeker.routeName, (route) => false);
             
              },
            ),
          ],
        ),
      ),
    );
  }
}
