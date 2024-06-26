import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class RegisterRepo {
  static Future<bool> login(String username, String password) async {
    String encryptpassword = sha256.convert(utf8.encode(password)).toString();

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'), 
        body: {
          'username': username,
          'password': encryptpassword,
        },
      );

      if (response.statusCode == 200) {
        
        Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success']) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
