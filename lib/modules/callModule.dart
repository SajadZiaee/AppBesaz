import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:url_launcher/url_launcher.dart';

List<CallModule> callModuleList = [];
CallModule? findCallModuleById(int id) {
  for (CallModule a in callModuleList) {
    if (a.id == id) return a;
  }
}

class CallModule extends Module {
  final String phoneNumber;
  late int graphics;
  CallModule({
    required int id,
    required int index,
    required this.phoneNumber,
    this.graphics = 0,
    String title = '',
    String imageName = '',
  }) : super(
            id: id, index: index, type: 1, imageName: imageName, title: title) {
    // graphics = 0;
    callModuleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    return CallModuleState();
  }
}

class CallModuleState extends State<CallModule> {
  @override
  Widget build(BuildContext context) {
    Widget txt = Text(
      'شماره تماس: ' + widget.phoneNumber,
      textDirection: TextDirection.rtl,
    );
    Widget btn = ElevatedButton(
        onPressed: () {
          launch("tel://" + widget.phoneNumber);
        },
        child: Icon(Icons.call));
    Widget btn2 = ElevatedButton(
        onPressed: () {
          launch("tel://" + widget.phoneNumber);
        },
        child: Text('تماس'));
    Widget btn3 = ElevatedButton(
      onPressed: () {
        launch("tel://" + widget.phoneNumber);
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 13,
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          children: [
            Icon(Icons.call),
            Text('تماس'),
          ],
        ),
      ),
    );
    switch (widget.graphics) {
      case 0:
        return Scaffold(
            appBar: AppBar(
              title: Text('تماس'),
            ),
            body: Center(
              child: Row(
                children: [
                  txt,
                  btn,
                ],
              ),
            ));
      case 1:
        return Scaffold(
            appBar: AppBar(
              title: Text('تماس'),
            ),
            body: Center(
              child: Column(
                children: [
                  txt,
                  btn,
                ],
              ),
            ));
      case 2:
        return Scaffold(
            appBar: AppBar(
              title: Text('تماس'),
            ),
            body: Center(
              child: btn3,
            ));
      default:
        return Container();
    }
  }
}
