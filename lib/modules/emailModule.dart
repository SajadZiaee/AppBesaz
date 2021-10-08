import 'package:url_launcher/url_launcher.dart';

import 'module.dart';
import 'package:flutter/material.dart';

List<EmailModule> emailModuleList = [];

class EmailModule extends Module {
  String emailAddress;
  String emailSubject;
  EmailModule({
    required int id,
    required int index,
    String imageName = '',
    String title = '',
    required this.emailAddress,
    required this.emailSubject,
  }) : super(
            id: id, type: 6, index: index, imageName: imageName, title: title) {
    emailModuleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmailModuleState();
  }
}

class EmailModuleState extends State<EmailModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            
          },
          child: Text('به ما ایمیل بزن'),
        ),
      ),
    );
  }
}
