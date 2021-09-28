import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:url_launcher/url_launcher.dart';

List<SiteModule> siteModuleList = [];
SiteModule? findSiteModuleById(int id) {
  for (SiteModule a in siteModuleList) {
    if (a.id == id) return a;
  }
}

class SiteModule extends Module {
  String siteAddress;
  int graphics; // each module will have several graphics types. default is 0.
  SiteModule(
      {required int id,
      required int index,
      required this.siteAddress,
      this.graphics = 0})
      : super(id: id, index: index, type: 2) {
    siteModuleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    return SiteModuleState();
  }
}

class SiteModuleState extends State<SiteModule> {
  @override
  Widget build(BuildContext context) {
    /// graphics = 0: with appbar
    /// graphics = 1: 
    
    return Scaffold(
        appBar: AppBar(
          title: Text('آدرس سایت'),
        ),
        body: Center(
          child: Row(
            children: [
              Text('آدرس سایت' + widget.siteAddress),
              ElevatedButton(
                  onPressed: () {
                    launch(widget.siteAddress);
                  },
                  child: Icon(Icons.web))
            ],
          ),
        ));
  }
}
