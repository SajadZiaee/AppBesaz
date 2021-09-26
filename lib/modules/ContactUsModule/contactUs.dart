import 'package:appbesaz/modules/ContactUsModule/contactMap.dart';
import 'package:appbesaz/modules/constants.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:appbesaz/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

List<ContactUsModule> contactUsModuleList = [];
ContactUsModule? findContactUsModuleById(int id) {
  for (ContactUsModule a in contactUsModuleList) {
    if (a.id == id) return a;
  }
}

class ContactUsModule extends Module {
  List<String> imageName;
  Map<String, dynamic> attributes = {};
  Map<String, LatLng> maps = {};
  ContactUsModule({
    required int id,
    required int index,
    this.imageName = const [],
    required this.attributes,
    required this.maps,
  }) : super(id: id, index: index, type: 11);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactUsModuleState();
  }
}

class ContactUsModuleState extends State<ContactUsModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('تماس با ما'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            (widget.imageName.length != 0)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height / 5),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage(widget.imageName),
                    //         fit: BoxFit.fitWidth)),
                    child: SlideShow(
                      imageNames: widget.imageName,
                      duration: 3,
                    ),
                  )
                : Container(),
            SizedBox(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.attributes.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(widget.attributes['آدرس']);
                    return Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.attributes.keys.elementAt(index)),
                        Text('    '),
                        Text(widget.attributes[
                            widget.attributes.keys.elementAt(index)]),
                      ],
                    );
                  }),
            ),
            SizedBox(
              // height: 600,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.maps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(textDirection: TextDirection.rtl, children: [
                      Text(widget.maps.keys.elementAt(index)),
                      Container(
                        width: 300,
                        height: 300,
                        child: ContactMap(
                          title: widget.maps.keys.elementAt(index),
                          a: widget.maps[widget.maps.keys.elementAt(index)]!
                              .latitude,
                          b: widget.maps[widget.maps.keys.elementAt(index)]!
                              .longitude,
                        ),
                      ),
                    ]);
                  }),
            ),
            // Container(
            //   width: 300,
            //   height: 300,
            //   child: ContactMap(
            //     title: 'شعبه بیرجند',
            //     a: 32.87,
            //     b: 59.22,
            //   ),
            // ),
          ],
        )));
  }
}
