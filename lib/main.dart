import 'package:appbesaz/modules/ContactUsModule/contactMap.dart';
import 'package:appbesaz/modules/ContactUsModule/contactUs.dart';
import 'package:flutter/material.dart';
import 'package:appbesaz/modules/ListModule/listModule.dart';
import 'package:appbesaz/modules/ListModule/listTileModule.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:appbesaz/modules/siteModule.dart';
import 'package:latlng/latlng.dart';
import 'modules/callModule.dart';
import 'package:appbesaz/modules/settingsModule.dart';

import 'modules/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationSettings.getSettings();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: (globalSettings['backgroundImage'] == "")
            ? new BoxDecoration()
            : new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(globalSettings['backgroundImage']),
                    fit: BoxFit.fill)),
        // decoration: new BoxDecoration(
        //     image:
        //         DecorationImage(image: AssetImage('assets/wallpapers/1.jpg'))),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            //scaffoldBackgroundColor: backgroundColor,
            // if background image is set, then background color must be transparent.
            scaffoldBackgroundColor: (globalSettings['backgroundImage'] == "")
                ? globalSettings['backgroundColor']
                : Colors.transparent,
            textTheme: TextTheme(
              button: TextStyle(
                fontWeight: (globalSettings['isBold'] == false)
                    ? FontWeight.normal
                    : FontWeight.bold,
                fontSize: globalSettings['fontSize'],
              ),
              bodyText2: TextStyle(
                  fontWeight: (globalSettings['isBold'] == false)
                      ? FontWeight.normal
                      : FontWeight.bold,
                  color: globalSettings['textColor'],
                  fontSize: globalSettings['fontSize']),
            ),
            primarySwatch: globalSettings['buttonColor'],
            appBarTheme: AppBarTheme(color: globalSettings['appbarColor']),
            fontFamily: fonts[globalSettings['applicationFont']],
          ),
          home: MyHomePage(
            title: 'Flutter Demo Home Page',
            myAppSetState: () {
              this.setState(() {});
            },
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    this.myAppSetState,
  }) : super(key: key);

  final String title;
  Function? myAppSetState;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SiteModule s =
      new SiteModule(id: 0, index: 0, siteAddress: 'https://www.google.com');
  CallModule c = new CallModule(id: 1, index: 1, phoneNumber: '112');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moduleList.length.toString()),
      ),
      body: ListView.builder(
          itemCount: moduleList.length,
          itemBuilder: (BuildContext context, int index) {
            ScrollController _controller;
            String s = (findModuleByIndex(index)!.type == 1)
                ? 'CallModule'
                : (findModuleByIndex(index)!.type == 2)
                    ? 'SiteModule'
                    : (findModuleByIndex(index)!.type == 3)
                        ? 'ListModule'
                        : 'SettingsModule';
            return Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  child: Text(index.toString() + s),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => findModuleByIndex(index)!));
                  },
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContactUsModule(id: 2, index: 2, imageName: [
                        wallpapers[5],
                        wallpapers[7],
                        wallpapers[2],
                      ], attributes: {
                        'آدرس': 'بیرجند',
                        'شماره تماس': '۱۱۰',
                        'درباره': 'ما یه شرکت چند ملیتی هستیم که ...',
                        '۰۹۱۵۲۵۸۲۰۲۵۸': 'شماره رئیس شرکت',
                        'علی': 'علی علی'
                      }, maps: {
                        'شعبه بیرجند': LatLng(32.872, 59.221),
                        'شعبه یه جایی': LatLng(32.872, 60.2),
                        'شعبه فلان جا': LatLng(31.872, 59.221),
                      })));
        },
        tooltip: 'add contact us module',
        child: Icon(Icons.add),
      ),
    );
  }
}
