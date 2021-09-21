import 'package:appbesaz/modules/settingsModule.dart';
import 'package:flutter/material.dart';
import 'package:appbesaz/modules/ListModule/listModule.dart';
import 'package:appbesaz/modules/callModule.dart';
import 'package:appbesaz/modules/siteModule.dart';

List<Module> moduleList = [];
Module? findModuleByIndex(int index) {
  for (Module a in moduleList) {
    if (a.index == index) return a;
  }
}

void goUp(int index) {
  // This function swaps the indexes of the two modules.
  if (index < moduleList.length) {
    Module m = findModuleByIndex(index)!;
    Module n = findModuleByIndex(index - 1)!;
    m.index = index - 1;
    n.index = index;
  }
}

class Module extends StatefulWidget {
  int id;
  int index;
  int type; // 1 for call module, 2 for site module, 3 for list module, 4 for settings module ..... to be continued.
  Module({required this.id, required this.index, required this.type}) {
    moduleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ModuleState();
  }
}

class ModuleState extends State<Module> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (widget.type) {
      case 1:
        {
          CallModule cm = CallModule(
              id: widget.id,
              index: widget.index,
              phoneNumber: findCallModuleById(widget.id)!.phoneNumber);
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => cm));
              },
              child: Icon(Icons.call));
        }
      case 2:
        {
          SiteModule sm = SiteModule(
              id: widget.id,
              index: widget.index,
              siteAddress: findSiteModuleById(widget.id)!.siteAddress);
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => sm));
              },
              child: Icon(Icons.web));
        }
      case 3:
        {
          ListModule ls = ListModule(
              id: widget.id,
              title: findListModuleById(widget.id)!.title,
              index: widget.index);
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ls));
              },
              child: Icon(Icons.list));
        }
      case 4:
        {
          SettingsModule sm = SettingsModule(
            id: widget.id,
            index: widget.index,
            // font: findSettingsModuleById(widget.id)!.font,
            // fontSize: findSettingsModuleById(widget.id)!.fontSize,
            // isBold: findSettingsModuleById(widget.id)!.isBold,
            // textColor: findSettingsModuleById(widget.id)!.textColor,
            // appBarColor: findSettingsModuleById(widget.id)!.appBarColor,
            // buttonColor: findSettingsModuleById(widget.id)!.buttonColor,
            // backgroundColor:
            //     findSettingsModuleById(widget.id)!.backgroundColor,
            // imageName: findSettingsModuleById(widget.id)!.imageName);
          );
          return ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => sm));
              },
              child: Icon(Icons.list));
        }
      default:
        return Container();
    }
  }
}
