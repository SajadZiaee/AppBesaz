import 'module.dart';
import 'package:flutter/material.dart';

class ContentModule extends Module {
  List<Module> contentModuleList;
  Function mainSetState;
  ContentModule({
    required int id,
    required int index,
    required this.contentModuleList,
    required this.mainSetState,
  }) : super(id: id, index: index, type: 17) {
    for (Module a in contentModuleList) {
      a.setVisibility(false);
    }
  }

  void addModule(Module m) {
    contentModuleList.add(m);
    m.setVisibility(false);
  }

  void deleteModule(Module d) {
    contentModuleList.remove(d);
    d.setVisibility(true);
    mainSetState();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentModuleState();
  }
}

class ContentModuleState extends State<ContentModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('this is content module');
    return Scaffold(
      appBar: AppBar(
        title: Text('ماژول فهرست'),
      ),
      body: ListView.builder(
          itemCount: widget.contentModuleList.length,
          itemBuilder: (BuildContext context, int index) {
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              widget.contentModuleList[index]));
                },
                child: Text('module $index'));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.deleteModule(
                widget.contentModuleList[widget.contentModuleList.length - 1]);
          });
        },
      ),
    );
  }
}
