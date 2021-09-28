import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

// insert a global map here, so that all application settings can be accessed from that map.

Map<String, dynamic> globalSettings = {
  'appbarColor': Colors.blue,
  'applicationFont': 5,
  'buttonColor': Colors.blue,
  'isBold': false,
  'backgroundColor': Colors.white,
  'textColor': Colors.black,
  'fontSize': 14.0,
  'backgroundImage': "",
};

// MaterialColor appbarColor = Colors.blue;
// int applicationFont = 5;
// MaterialColor buttonColor = Colors.blue;
// bool isBold = false;
// Color backgroundColor = Colors.white;
// Color textColor = Colors.black;
// double fontSize = 14;
// String backgroundImage = "";

class ApplicationSettings {
  /// This class saves data via shared preferences in local device.
  /// This class can also be used to get the initial settings from fontEnd. [[[[Important]]]]
  static Future<void> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globalSettings['appbarColor'] =
        appbarColors[prefs.getInt("appbarColor") ?? 0];
    globalSettings['applicationFont'] = prefs.getInt("applicationFont") ?? 5;
    globalSettings['buttonColor'] =
        appbarColors[prefs.getInt("buttonColor") ?? 0];
    globalSettings['isBold'] = prefs.getBool("isBold") ?? false;
    globalSettings['backgroundColor'] =
        colors[prefs.getInt("backgroundColor") ?? 1];
    globalSettings['textColor'] = colors[prefs.getInt("textColor") ?? 0];
    globalSettings['fontSize'] = prefs.getDouble("fontSize") ?? 14.0;
    globalSettings['backgroundImage'] =
        prefs.getString("backgroundImage") ?? "";
  }

  static void updateSettings(
      {required MaterialColor appbarColor_,
      required int applicationFont_,
      required MaterialColor buttonColor_,
      required bool isBold_,
      required Color backgroundColor_,
      required Color textColor_,
      required double fontSize_,
      required String backgroundImage_}) async {
    globalSettings['appbarColor'] = appbarColor_;
    globalSettings['applicationFont'] = applicationFont_;
    globalSettings['buttonColor'] = buttonColor_;
    globalSettings['isBold'] = isBold_;
    globalSettings['backgroundColor'] = backgroundColor_;
    globalSettings['textColor'] = textColor_;
    globalSettings['fontSize'] = fontSize_;
    globalSettings['backgroundImage'] = backgroundImage_;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("appbarColor", appbarColors.indexOf(appbarColor_));
    prefs.setInt("applicationFont", applicationFont_);
    prefs.setInt("buttonColor", appbarColors.indexOf(buttonColor_));
    prefs.setBool("isBold", isBold_);
    prefs.setInt("backgroundColor", colors.indexOf(backgroundColor_));
    prefs.setInt("textColor", colors.indexOf(textColor_));
    prefs.setDouble("fontSize", fontSize_);
    prefs.setString("backgroundImage", backgroundImage_);
  }
}

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
  // int font;

  // /// 1 irannastaliq, 2 titr, 3 b yekan, ...

  // double fontSize;
  // bool isBold;

  // /// false: not bold, true: bold.
  // //// Item colors can also be changed in the whole application.
  // Color textColor;
  // MaterialColor appBarColor;
  // MaterialColor buttonColor;
  // Color backgroundColor;
  // String imageName;
  Function? myAppSetState;
  bool canChangeFont;
  bool canChangeFontSize;
  bool canChangeIsBold;
  bool canChangeTextColor;
  bool canChangeAppBarColor;
  bool canChangeButtonColor;
  bool canChangeBackgroundColor;
  bool canChangeImageName;

  SettingsModule({
    required int id,
    required int index,
    // required this.font,
    // required this.fontSize,
    // required this.isBold,
    // required this.textColor,
    // required this.appBarColor,
    // required this.buttonColor,
    // required this.backgroundColor,
    // required this.imageName,
    this.myAppSetState,
    this.canChangeFont = true,
    this.canChangeFontSize = true,
    this.canChangeIsBold = true,
    this.canChangeTextColor = true,
    this.canChangeAppBarColor = true,
    this.canChangeButtonColor = true,
    this.canChangeBackgroundColor = true,
    this.canChangeImageName = true,
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
        title: Text('تنظیمات'),
      ),
      body: Center(
        child: Column(
          children: [
            (widget.canChangeFont)
                ? Text(
                    'فونت نوشته های اپلیکیشن: ',
                    style: TextStyle(fontFamily: 'Shabnam'),
                  )
                : Container(),
            (widget.canChangeFont)
                ? Container(
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
                              globalSettings['applicationFont'] = index;
                            },
                          );
                        }),
                  )
                : Container(),
            (widget.canChangeAppBarColor)
                ? Text('رنگ نوار بالای صفحه: ',
                    style: TextStyle(fontFamily: 'Shabnam'))
                : Container(),
            (widget.canChangeAppBarColor)
                ? Container(
                    width: 300,
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: appbarColors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            // widget.appBarColor = appbarColors[index];
                            globalSettings['appbarColor'] = appbarColors[index];
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                              primary: appbarColors[index]),
                        );
                      },
                    ),
                  )
                : Container(),
            (widget.canChangeButtonColor)
                ? Text('رنگ دکمه های صفحه: ',
                    style: TextStyle(fontFamily: 'Shabnam'))
                : Container(),
            (widget.canChangeButtonColor)
                ? Container(
                    width: 300,
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: appbarColors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            // widget.buttonColor = appbarColors[index];
                            globalSettings['buttonColor'] = appbarColors[index];
                          },
                          child: Text(''),
                          style: ElevatedButton.styleFrom(
                              primary: appbarColors[index]),
                        );
                      },
                    ),
                  )
                : Container(),
            (widget.canChangeBackgroundColor)
                ? Text('رنگ پس زمینه صفحه: ',
                    style: TextStyle(fontFamily: 'Shabnam'))
                : Container(),
            (widget.canChangeBackgroundColor)
                ? Container(
                    width: 300,
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            // widget.backgroundColor = colors[index];
                            globalSettings['backgroundColor'] = colors[index];
                          },
                          child: Text(''),
                          style:
                              ElevatedButton.styleFrom(primary: colors[index]),
                        );
                      },
                    ),
                  )
                : Container(),
            (widget.canChangeTextColor)
                ? Text('رنگ نوشته ها: ',
                    style: TextStyle(fontFamily: 'Shabnam'))
                : Container(),
            (widget.canChangeTextColor)
                ? Container(
                    width: 300,
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            // widget.textColor = colors[index];
                            globalSettings['textColor'] = colors[index];
                          },
                          child: Text(''),
                          style:
                              ElevatedButton.styleFrom(primary: colors[index]),
                        );
                      },
                    ),
                  )
                : Container(),
            (widget.canChangeImageName)
                ? Text(
                    'انتخاب والپیپر: ',
                    style: TextStyle(fontFamily: 'Shabnam'),
                  )
                : Container(),
            (widget.canChangeImageName)
                ? Container(
                    width: 300,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wallpapers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (index == 0) {
                                  // widget.imageName = '';
                                  globalSettings['backgroundImage'] = '';
                                } else {
                                  // widget.imageName = wallpapers[index];
                                  globalSettings['backgroundImage'] =
                                      wallpapers[index];
                                }
                              });
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black54, width: 4.0),
                                  image: DecorationImage(
                                      image: AssetImage(wallpapers[index]))),
                            ));
                      },
                    ),
                  )
                : Container(),
            (widget.canChangeFontSize)
                ? Text('سایز نوشته ها: ',
                    style: TextStyle(fontFamily: 'Shabnam'))
                : Container(),
            (widget.canChangeFontSize)
                ? Slider(
                    value: globalSettings['fontSize'],
                    min: 8,
                    max: 32,
                    divisions: 10,
                    onChanged: (double value) {
                      setState(() {
                        // widget.fontSize = value;
                        globalSettings['fontSize'] = value;
                      });
                    },
                  )
                : Container(),
            (widget.canChangeIsBold)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'بولد بودن یا نبودن نوشته ها',
                        style: TextStyle(fontFamily: 'Shabnam'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              globalSettings['isBold'] =
                                  !globalSettings['isBold'];
                            });
                          },
                          child: (globalSettings['isBold'])
                              ? Text('معمولی',
                                  style: TextStyle(fontFamily: 'Shabnam'))
                              : Text('بولد',
                                  style: TextStyle(fontFamily: 'Shabnam'))),
                    ],
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                widget.myAppSetState!();
                ApplicationSettings.updateSettings(
                    appbarColor_: globalSettings['appbarColor'],
                    applicationFont_: globalSettings['applicationFont'],
                    buttonColor_: globalSettings['buttonColor'],
                    isBold_: globalSettings['isBold'],
                    backgroundColor_: globalSettings['backgroundColor'],
                    textColor_: globalSettings['textColor'],
                    fontSize_: globalSettings['fontSize'],
                    backgroundImage_: globalSettings['backgroundImage']);
              },
              child: Text(
                'ذخیره سازی تغییرات',
                style: TextStyle(fontFamily: 'Shabnam'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
