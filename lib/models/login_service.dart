import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';
import 'package:my_mart/models/user.dart';

class LoginService {
  //load xml
  Future<List<User>> loadUsers() async {
    final xmlString = await rootBundle.loadString(
      'assets/data/login_parser.xml',
    );
    final document = XmlDocument.parse(xmlString);

    return document.findAllElements('user').map((node) {
      return User(
        username: node.findAllElements('username').first.innerText,
        password: node.findAllElements('password').first.innerText,
        role: node.findAllElements('role').first.innerText,
      );
    }).toList();
  }

  // fungsi login
  Future<User?> login(String username, String password) async {
    final users = await loadUsers();

    for (var user in users) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
