import 'package:appbesaz/main.dart';
import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:appbesaz/modules/UserAccountModule/userListTest.dart';
import 'package:flutter/material.dart';

/// if login was successful, it username should be stored in shared preferences.
/// if a user's role was changed, the change must be saved in shared preferences.
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextEditingController emailOrUsernameCnt = new TextEditingController();
    TextEditingController passwordCnt = new TextEditingController();
    TextField emailOrUsername = TextField(
      controller: emailOrUsernameCnt,
      decoration: InputDecoration(hintText: 'ایمیل یا نام کاربری'),
    );
    TextField password = TextField(
      controller: passwordCnt,
      decoration: InputDecoration(hintText: 'رمز عبور'),
    );

    ElevatedButton submit = ElevatedButton(
        onPressed: () {
          // A query to this software's database must be replaced here.
          if (checkValidity(emailOrUsernameCnt.text, passwordCnt.text)) {
            Navigator.pop(context);
          }
        },
        child: Text('ورود'));
    TextButton forgot = TextButton(
        onPressed: () {},
        child: Text(
          'فراموشی رمز عبور',
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          emailOrUsername,
          password,
          submit,
          forgot,
        ],
      ),
    );
  }
}
