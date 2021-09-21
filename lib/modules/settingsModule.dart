import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

// insert a global map here, so that all application settings can be accessed from that map.

MaterialColor appbarColor = Colors.blue;
int applicationFont = 0;
MaterialColor buttonColor = Colors.blue;

List<SettingsModule> settingsModuleList = [];
SettingsModule? findSettingsModuleById(int id) {
  for (SettingsModule a in settingsModuleList) {
    if (a.id == id) {
      return a;
    }
  }
}

/// Settings module must be created only once. So...
class SettingsModule extends Module {
  int font;

  /// 1 irannastaliq, 2 titr, 3 b yekan, ...

  double fontSize;
  bool isBold;

  /// false: not bold, true: bold.
  //// Item colors can also be changed in the whole application.
  Color textColor;
  MaterialColor appBarColor;
  MaterialColor buttonColor;
  Color backgroundColor;
  String imageName;
  Function? myAppSetState;
  SettingsModule({
    required int id,
    required int index,
    required this.font,
    required this.fontSize,
    required this.isBold,
    required this.textColor,
    required this.appBarColor,
    required this.buttonColor,
    required this.backgroundColor,
    required this.imageName,
    this.myAppSetState,
  }) : super(id: id, index: index, type: 4) {
    settingsModuleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsModuleState();
  }
}

class SettingsModuleState extends State<SettingsModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'فونت نوشته های اپلیکیشن: ',
              style: TextStyle(fontFamily: 'Shabnam'),
            ),
            Container(
              height: 50,
              width: 300,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: fonts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ElevatedButton(
                      child: Text(
                        fonts[index],
                        style: TextStyle(fontFamily: fonts[index]),
                      ),
                      onPressed: () {
                        // font must be selected for whole application.
                        applicationFont = index;
                      },
                    );
                  }),
            ),
            Text('رنگ نوار بالای صفحه: ',
                style: TextStyle(fontFamily: 'Shabnam')),
            Container(
              width: 300,
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appbarColors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      widget.appBarColor = appbarColors[index];
                      appbarColor = appbarColors[index];
                    },
                    child: Text(''),
                    style:
                        ElevatedButton.styleFrom(primary: appbarColors[index]),
                  );
                },
              ),
            ),
            Text('رنگ دکمه های صفحه: ',
                style: TextStyle(fontFamily: 'Shabnam')),
            Container(
              width: 300,
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appbarColors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      widget.buttonColor = appbarColors[index];
                      buttonColor = appbarColors[index];
                    },
                    child: Text(''),
                    style:
                        ElevatedButton.styleFrom(primary: appbarColors[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.myAppSetState!();
                },
                child: Text('submit'))
          ],
        ),
      ),
    );
  }
}
