import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:url_launcher/url_launcher.dart';

List<SiteModule> siteModuleList = [];
SiteModule? findSiteModuleById(int id) {
  for (SiteModule a in siteModuleList) {
    if (a.id == id) return a;
  }
}

/// every module's texts will be put in a map named [texts], and texts will change using [changeTexts] method.
/// [graphics] shows the way widgets are placed on the screen.
/// [widgetShapes] shows the different shapes of the widgets.
class SiteModule extends Module {
  String siteAddress;
  late int
      graphics; // each module will have several graphics types. default is 0.
  late Map<String, String> texts;
  late Map<String, int> widgetShapes;
  SiteModule({
    required int id,
    required int index,
    required this.siteAddress,
    String title = '',
    String imageName = '',
  }) : super(
          id: id,
          index: index,
          type: 2,
          imageName: imageName,
          title: title,
        ) {
    siteModuleList.add(this);
    graphics = 0;
    texts = {"متن ۱": "آدرس سایت", "متن دکمه": "برو"};
    widgetShapes = {
      "AppBar": 0,
    };
  }
  void changeTexts({required String txt1, required String btnTxt}) {
    texts["متن ۱"] = txt1;
    texts["متن دکمه"] = btnTxt;
  }

  void changeShapes({
    required int appBar,
  }) {
    widgetShapes['AppBar'] = appBar;
  }

  void changeGraphics({required int graphics}) {
    this.graphics = graphics;
  }

  @override
  State<StatefulWidget> createState() {
    return SiteModuleState();
  }
}

class SiteModuleState extends State<SiteModule> {
  @override
  Widget build(BuildContext context) {
    

    widget.changeTexts(btnTxt: "علی علی", txt1: "علی یارت");
    widget.changeShapes(appBar: 2);
    widget.changeGraphics(graphics: 2);
    switch (widget.graphics) {
      case 0:
        return Scaffold(
            appBar: AppBar(title: Text(widget.title),),
            body: Center(
              child: Row(
                children: [
                  Text(widget.texts["متن ۱"]! + widget.siteAddress),
                  ElevatedButton(
                      onPressed: () {
                        launch(widget.siteAddress);
                      },
                      child: Text(widget.texts["متن دکمه"]!))
                ],
              ),
            ));
      case 1:
        return Scaffold(
            appBar: AppBar(title: Text(widget.title),),
            body: Center(
              child: Column(
                children: [
                  Text(widget.texts["متن ۱"]! + widget.siteAddress),
                  ElevatedButton(
                      onPressed: () {
                        launch(widget.siteAddress);
                      },
                      child: Text(widget.texts["متن دکمه"]!))
                ],
              ),
            ));
      default:
        return Scaffold(
            appBar: AppBar(title: Text(widget.title),),
            body: Center(
              child: Column(
                children: [
                  Text(widget.texts["متن ۱"]! + widget.siteAddress),
                  ElevatedButton(
                      onPressed: () {
                        launch(widget.siteAddress);
                      },
                      child: Text(widget.texts["متن دکمه"]!))
                ],
              ),
            ));
    }
  }
}
