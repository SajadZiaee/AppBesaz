import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:flutter/material.dart';

class registerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerPageState();
  }
}

class registerPageState extends State<registerPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<TextEditingController> textEditingList = [];
    List<TextField> textFieldList = [];
    TextEditingController nameCnt = new TextEditingController();
    TextEditingController emailCnt = new TextEditingController();
    TextEditingController usernameCnt = new TextEditingController();
    TextEditingController passwordCnt = new TextEditingController();
    TextField name = TextField(
      controller: nameCnt,
      decoration: InputDecoration(hintText: 'نام *'),
    );
    TextField email = TextField(
      controller: emailCnt,
      decoration: InputDecoration(hintText: 'ایمیل *'),
    );
    TextField username = TextField(
      controller: usernameCnt,
      decoration: InputDecoration(hintText: 'نام کاربری *'),
    );
    TextField password = TextField(
      controller: passwordCnt,
      decoration: InputDecoration(hintText: 'پسورد *'),
    );

    textFieldList.add(name);
    textFieldList.add(email);
    textFieldList.add(username);
    textFieldList.add(password);
    for (int i = 0; i < fieldList.length; i++) {
      TextEditingController tec = new TextEditingController();
      textEditingList.add(tec);
      TextField tf = new TextField(
        controller: tec,
        decoration: InputDecoration(hintText: fieldList[i].fieldName),
      );
      textFieldList.add(tf);
    }

    ElevatedButton submit = ElevatedButton(
        onPressed: () {
          // A query to this software's database must be replaced here.
        },
        child: Text('ثبت نام'));
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام'),
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: textFieldList.length,
              itemBuilder: (BuildContext context, int index) {
                return textFieldList[index];
              }),
          submit,
        ],
      ),
    );
  }
}
