import 'package:shared_preferences/shared_preferences.dart';

Future<void> writeRole(userType) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('role', userType);
}