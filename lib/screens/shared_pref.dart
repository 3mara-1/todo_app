import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  setUserName(namecontroller) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('username', namecontroller);
  }

  // getUsername() async {
  //   final pref = await SharedPreferences.getInstance();
  //  return pref.getString('username');
  // }
}
