import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  MySharedPreference._();
  static MySharedPreference mySharedPreference = MySharedPreference._();
  late SharedPreferences prefsInstance;
  initMySharedPreference() async {
    prefsInstance = await SharedPreferences.getInstance();
  }

  bool isFirstTime() {
    return prefsInstance.getBool('isFirst') ?? true;
  }

  void toggleFromFirstTime() {
    prefsInstance.setBool('isFirst', false);
  }

  
  bool isDataNotUploaded() {
    return prefsInstance.getBool('isNotUploaded') ?? true;
  }

  void dataUploadingDone() {
    prefsInstance.setBool('isNotUploaded', false);
  }
}
