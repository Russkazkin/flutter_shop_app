import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=' + env['FIREBASE_KEY']);
  }
}