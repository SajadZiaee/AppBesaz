import 'package:appbesaz/modules/ContactUsModule/contactUs.dart';
import 'package:appbesaz/modules/settingsModule.dart';
import 'package:flutter/material.dart';
import 'package:appbesaz/modules/ListModule/listModule.dart';
import 'package:appbesaz/modules/callModule.dart';
import 'package:appbesaz/modules/siteModule.dart';

import 'UserAccountModule/ entities.dart';

List<Module> moduleList = [];
Module? findModuleByIndex(int index) {
  for (Module a in moduleList) {
    if (a.index == index && a.visibility == true) return a;
  }
  return null;
}

Module? findModuleById(int id) {
  for (Module a in moduleList) {
    if (a.id == id) return a;
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

/// [title] is the text shown on the [ElevatedButton] connected to this module.
/// [imageName] is the name of the image connected to this module (located in assets).
/// [imageName] will be shown on the [ElevatedButton] connected to this module.
/// [visibility] = false, indicates that this module is invisible and will not be shown in the app.
/// [findModuleByIndex] also checks if this module is visible and returns the module only if it's [visibility] = true.
class Module extends StatefulWidget {
  int id;
  int index;
  int type; // 1 for call module, 2 for site module, 3 for list module, 4 for settings module ..... to be continued.
  String title;
  String imageName;
  bool visibility;
  Module({
    required this.id,
    required this.index,
    required this.type,
    this.title = '',
    this.imageName = '',
    this.visibility = true,
  }) {
    moduleList.add(this);
    Role.giveAccessToAllRoles(); // gives this module's access to all Roles.
  }
  void setVisibility(bool newVisibility) {
    visibility = newVisibility;
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
      // case 1:
      //   {
      //     CallModule cm = CallModule(
      //         id: widget.id,
      //         index: widget.index,
      //         phoneNumber: findCallModuleById(widget.id)!.phoneNumber);
      //     return ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => cm));
      //         },
      //         child: Icon(Icons.call));
      //   }
      // case 2:
      //   {
      //     SiteModule sm = SiteModule(
      //         id: widget.id,
      //         index: widget.index,
      //         siteAddress: findSiteModuleById(widget.id)!.siteAddress);
      //     return ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => sm));
      //         },
      //         child: Icon(Icons.web));
      //   }
      // case 3:
      //   {
      //     ListModule ls = ListModule(
      //         id: widget.id,
      //         title: findListModuleById(widget.id)!.title,
      //         index: widget.index);
      //     return ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => ls));
      //         },
      //         child: Icon(Icons.list));
      //   }
      // case 4:
      //   {
      //     SettingsModule sm = SettingsModule(
      //       id: widget.id,
      //       index: widget.index,
      //       // font: findSettingsModuleById(widget.id)!.font,
      //       // fontSize: findSettingsModuleById(widget.id)!.fontSize,
      //       // isBold: findSettingsModuleById(widget.id)!.isBold,
      //       // textColor: findSettingsModuleById(widget.id)!.textColor,
      //       // appBarColor: findSettingsModuleById(widget.id)!.appBarColor,
      //       // buttonColor: findSettingsModuleById(widget.id)!.buttonColor,
      //       // backgroundColor:
      //       //     findSettingsModuleById(widget.id)!.backgroundColor,
      //       // imageName: findSettingsModuleById(widget.id)!.imageName);
      //     );

      //   return ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => sm));
      //       },
      //       child: Container(
      //         child: Column(
      //           children: [
      //             Container(
      //               height: 100,
      //               width: 100,
      //               decoration: (widget.imageName != '')
      //                   ? BoxDecoration(
      //                       image: DecorationImage(
      //                           image: AssetImage(widget.imageName)))
      //                   : null,
      //             ),
      //             (widget.title == '')
      //                 ? Text('Settings')
      //                 : Text(widget.title),
      //           ],
      //         ),
      //       ));
      // }
      // case 11:
      //   {
      //     ContactUsModule tmp = ContactUsModule(
      //         id: widget.id,
      //         index: widget.index,
      //         attributes: findContactUsModuleById(widget.id)!.attributes,
      //         maps: findContactUsModuleById(widget.id)!.maps);
      //     return ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => tmp));
      //         },
      //         child: Icon(Icons.list));
      //   }
      default:
        return Container();
    }
  }
}
