import 'package:appbesaz/modules/ListModule/listTileModule.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:flutter/material.dart';

List<ListModule> listModuleList = [];
ListModule? findListModuleById(int id) {
  for (ListModule a in listModuleList) {
    if (a.id == id) return a;
  }
}

class ListModule extends Module {
  
  // each list module has an id and it's list tiles share that id.
  ListModule({required int id, required int index,  String title = '', String imageName = ''})
      : super(id: id, index: index, type: 3, title: title) {
    listModuleList.add(this);
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListModuleState();
  }
}

class ListModuleState extends State<ListModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
          itemCount: findListTileModuleByListId(widget.id).length,
          itemBuilder: (context, int index) {
            return findListTileModuleByListId(widget.id)[index];
          }),
    );
  }
}
