import 'dart:async';

import 'package:flutter/material.dart';

/// This class is used to create a slideshow of images :)
/// inception from Appeto.ir :)
/// duration is the time (in seconds) between each two slides.

class SlideShow extends StatefulWidget {
  List<String> imageNames;
  int duration;
  SlideShow({required this.imageNames, this.duration = 5});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SlideShowState();
  }
}

class SlideShowState extends State<SlideShow> {
  @override
  Widget build(BuildContext context) {
    Stream<int> insertZero(Stream<int> s) async* {
      yield 0;
      yield* s;
    }

    Stream<int> stream = (Stream<int>.periodic(
        Duration(seconds: widget.duration),
        (data) => ((data + 1) % widget.imageNames.length)));
    // timer();
    Stream<int> s = insertZero(stream);
    return StreamBuilder<int>(
        stream: s,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else
            return Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.imageNames[(snapshot.data!)]),
                  fit: BoxFit.fitWidth),
            ));
        });
  }
}
