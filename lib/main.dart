import 'package:appbesaz/modules/ContactUsModule/contactMap.dart';
import 'package:appbesaz/modules/ContactUsModule/contactUs.dart';
import 'package:appbesaz/modules/rssReaderModule.dart';
import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:appbesaz/modules/UserAccountModule/registerPage.dart';
import 'package:appbesaz/modules/UserAccountModule/userAccountModule.dart';
import 'package:appbesaz/modules/contentModule.dart';
import 'package:appbesaz/modules/emailModule.dart';
import 'package:appbesaz/modules/musicModule/musicPlayer.dart';
import 'package:appbesaz/modules/zarinpalModule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appbesaz/modules/ListModule/listModule.dart';
import 'package:appbesaz/modules/ListModule/listTileModule.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:appbesaz/modules/siteModule.dart';
import 'package:just_audio/just_audio.dart';
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
          /// should use [initialRoute] here.

          debugShowCheckedModeBanner: false,
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
            appBarTheme: AppBarTheme(
                color: globalSettings['appbarColor'],
                shape: appBarShapeList[globalSettings['appBarShape']],
                centerTitle: globalSettings['appBarCenterTitle']),
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
  SiteModule s = new SiteModule(
    id: 0,
    index: 0,
    siteAddress: 'https://www.google.com',
    imageName: wallpapers[3],
    title: 'برو به گوگل دات کام!',
  );

  CallModule c = new CallModule(
    id: 1,
    index: 1,
    phoneNumber: '112',
    graphics: 2,
  );
  ContactUsModule tmp = ContactUsModule(
    id: 2,
    index: 2,
    imageNameList: [
      wallpapers[5],
      wallpapers[7],
      wallpapers[2],
    ],
    attributes: {
      'آدرس': 'بیرجند',
      'شماره تماس': '۱۱۰',
      'درباره': 'ما یه شرکت چند ملیتی هستیم که ...',
      '۰۹۱۵۲۵۸۲۰۲۵۸': 'شماره رئیس شرکت',
      'علی': 'علی علی'
    },
    maps: {
      'شعبه بیرجند': LatLng(32.872, 59.221),
      'شعبه یه جایی': LatLng(32.872, 60.2),
      'شعبه فلان جا': LatLng(31.872, 59.221),
    },
    imageName: wallpapers[2],
    title: 'تماس بگیر با ما',
  );
  UserAccountModule uam = new UserAccountModule(id: 3, index: 3);
  EmailModule em = new EmailModule(
      id: moduleList.length,
      index: moduleList.length,
      imageName: '',
      title: 'ایمیل بزن',
      emailAddress: 'dayan.acorn@gmail.com',
      emailSubject: 'emailSubject');

  @override
  Widget build(BuildContext context) {
    ContentModule cmm = new ContentModule(
      id: moduleList.length,
      index: moduleList.length,
      contentModuleList: [uam, em, c],
      mainSetState: () {
        setState(() {});
      },
    );

    // SettingsModule sm = new SettingsModule(
    //   id: moduleList.length,
    //   index: moduleList.length,
    //   myAppSetState: widget.myAppSetState,
    //   graphics: 0,
    // );
    for (int a = 0; a < moduleList.length; a++)
      if (findModuleByIndex(a) != null) print('yse');

    for (int a = 0; a < moduleList.length; a++) {
      if (moduleList[a].visibility == true) print('IT IS');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(moduleList.length.toString()),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          List<Module> ls = [];
          for (Module m in moduleList) {
            if (m.visibility == true) ls.add(m);
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 4,
                childAspectRatio: 1.25),
            itemCount: ls.length,
            itemBuilder: (BuildContext context, int index) {
              ScrollController _controller;
              String string = '';

              string = (ls[index].type == 1)
                  ? 'CallModule'
                  : (ls[index].type == 2)
                      ? 'SiteModule'
                      : (ls[index].type == 3)
                          ? 'ListModule'
                          : 'SettingsModule';
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ls[index]));
                },
                child: Container(
                  child: Column(
                    children: [
                      (ls[index].imageName != '')
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(ls[index].imageName))),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                            ),
                      (ls[index].title == '')
                          ? Text(string)
                          : Text(ls[index].title),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27)))),
              );

              // Container(
              //     height: 100,
              //     width: 100,
              //     child: ElevatedButton(
              //       child: Text(index.toString() + s),
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => findModuleByIndex(index)!));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //  cmm.addModule(s);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedReaderModule(
                          id: moduleList.length,
                          index: moduleList.length,
                          imageName: '',
                          siteLink: 'farsnews.ir',
                        )));

                        
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MusicPlayer(
            //             song: AudioPlayer()
            //               ..setAsset(
            //                 'assets/songs/a.mp3',
            //               ),
            //               songName: 'Mah o Mahi',
            //               imageName: wallpapers[3],
            //                filePath: 'assets/songs/a.mp3',)));

            // print(premiumPlanMonthly.description);
            // print(premiumPlanYearly.description);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ZarinPalTest(planId: 1)));

            // findModuleById(1)!.setVisibility(!findModuleById(1)!.visibility);
          });
        },
        tooltip: 'add contact us module',
        child: Icon(Icons.add),
      ),
    );
  }
}
