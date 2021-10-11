import 'package:appbesaz/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  String imageName;
  AudioPlayer song;
  String filePath;
  String songName;
  MusicPlayer(
      {required this.song,
      required this.songName,
      required this.filePath,
      this.imageName = ''});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MusicPlayerState();
  }
}

class MusicPlayerState extends State<MusicPlayer> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.song.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    String audioLength = '0';
    StreamBuilder<Duration?> currentTime = new StreamBuilder(
        stream: widget.song.positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int min = (snapshot.data!.inSeconds.toDouble().toInt() ~/ 60);
            int sec = (snapshot.data!.inSeconds.toDouble().toInt() % 60);

            return Text(min.toString() + ":" + sec.toString());
          } else
            return Container();
        });
    StreamBuilder<Duration?> endTime = new StreamBuilder(
        stream: widget.song.durationStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int min = (snapshot.data!.inSeconds.toDouble().toInt() ~/ 60);
            int sec = (snapshot.data!.inSeconds.toDouble().toInt() % 60);

            return Text(min.toString() + ":" + sec.toString());
          } else
            return Text('0');
        });

    double getDuration() {
      if (widget.song.duration == null)
        return 0;
      else
        return widget.song.duration!.inSeconds.toDouble();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.songName),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          return Column(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: (widget.imageName != "")
                            ? AssetImage(widget.imageName)
                            : AssetImage(wallpapers[0])))),
            ListView(
              shrinkWrap: true,
              children: [
                SafeArea(
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(children: [
                          ElevatedButton(
                              onPressed: () async {
                                widget.song.play();
                                setState(() {
                                  audioLength = widget.song.duration!.inSeconds
                                      .toDouble()
                                      .toString();
                                });
                                print(audioLength);
                              },
                              child: Icon(Icons.play_arrow)),
                          ElevatedButton(
                              onPressed: () async {
                                await widget.song.pause();
                              },
                              child: Icon(Icons.pause)),
                          ElevatedButton(
                              onPressed: () async {
                                if (widget.song.position.inSeconds > 10)
                                  await widget.song.seek(widget.song.position -
                                      Duration(seconds: 10));
                                else
                                  widget.song.seek(Duration(seconds: 0));
                                setState(() {});
                              },
                              child: Icon(Icons.fast_rewind)),
                          ElevatedButton(
                              onPressed: () async {
                                if (widget.song.duration != null) if (widget
                                            .song.position.inSeconds +
                                        10 <
                                    widget.song.duration!.inSeconds)
                                  await widget.song.seek(widget.song.position +
                                      Duration(seconds: 10));
                                else {
                                  widget.song.seek(widget.song.duration);
                                }

                                setState(() {});
                              },
                              onLongPress: () async {
                                if (widget.song.duration != null) if (widget
                                            .song.position.inSeconds +
                                        30 <
                                    widget.song.duration!.inSeconds)
                                  await widget.song.seek(widget.song.position +
                                      Duration(seconds: 30));
                                else {
                                  widget.song.seek(widget.song.duration);
                                }

                                setState(() {});
                              },
                              child: Icon(Icons.fast_forward)),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.song.setSpeed(2.0);
                              });
                            },
                            child: Icon(Icons.speed),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(0.5);
                                });
                              },
                              child: Icon(Icons.slow_motion_video)),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(1);
                                });
                              },
                              child: Text('1x')),
                        ]))),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    currentTime,
                    StreamBuilder<Duration?>(
                        stream: widget.song.positionStream,
                        builder: (context, snapshot) {
                          return Slider(
                            value: snapshot.data!.inSeconds.toDouble(),
                            onChanged: (double newValue) {
                              setState(() {
                                widget.song
                                    .seek(Duration(seconds: newValue.toInt()));
                              });
                            },
                            min: 0,
                            max: getDuration(),
                          );
                        }),
                    endTime,
                  ]),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<double>(
                    stream: widget.song.speedStream,
                    builder: (context, snapshot) {
                      return Slider(
                          value: snapshot.data!,
                          min: 0.1,
                          max: 5,
                          onChanged: (newValue) {
                            widget.song.setSpeed(newValue);
                          });
                    },
                  ),
                )
              ],
            ),
          ]);
        else if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return Row(children: [
            Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: (widget.imageName != "")
                            ? AssetImage(widget.imageName)
                            : AssetImage(wallpapers[0])))),
            Container(
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SafeArea(
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(children: [
                            ElevatedButton(
                                onPressed: () async {
                                  widget.song.play();
                                  setState(() {
                                    audioLength = widget
                                        .song.duration!.inSeconds
                                        .toDouble()
                                        .toString();
                                  });
                                  print(audioLength);
                                },
                                child: Icon(Icons.play_arrow)),
                            ElevatedButton(
                                onPressed: () async {
                                  await widget.song.pause();
                                },
                                child: Icon(Icons.pause)),
                            ElevatedButton(
                                onPressed: () async {
                                  if (widget.song.position.inSeconds > 10)
                                    await widget.song.seek(
                                        widget.song.position -
                                            Duration(seconds: 10));
                                  else
                                    widget.song.seek(Duration(seconds: 0));
                                  setState(() {});
                                },
                                child: Icon(Icons.fast_rewind)),
                            ElevatedButton(
                                onPressed: () async {
                                  if (widget.song.duration != null) if (widget
                                              .song.position.inSeconds +
                                          10 <
                                      widget.song.duration!.inSeconds)
                                    await widget.song.seek(
                                        widget.song.position +
                                            Duration(seconds: 10));
                                  else {
                                    widget.song.seek(widget.song.duration);
                                  }

                                  setState(() {});
                                },
                                onLongPress: () async {
                                  if (widget.song.duration != null) if (widget
                                              .song.position.inSeconds +
                                          30 <
                                      widget.song.duration!.inSeconds)
                                    await widget.song.seek(
                                        widget.song.position +
                                            Duration(seconds: 30));
                                  else {
                                    widget.song.seek(widget.song.duration);
                                  }

                                  setState(() {});
                                },
                                child: Icon(Icons.fast_forward)),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(2.0);
                                });
                              },
                              child: Icon(Icons.speed),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.song.setSpeed(0.5);
                                  });
                                },
                                child: Icon(Icons.slow_motion_video)),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.song.setSpeed(1);
                                  });
                                },
                                child: Text('1x')),
                          ]))),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      currentTime,
                      StreamBuilder<Duration?>(
                          stream: widget.song.positionStream,
                          builder: (context, snapshot) {
                            return Slider(
                              value: snapshot.data!.inSeconds.toDouble(),
                              onChanged: (double newValue) {
                                setState(() {
                                  widget.song.seek(
                                      Duration(seconds: newValue.toInt()));
                                });
                              },
                              min: 0,
                              max: getDuration(),
                            );
                          }),
                      endTime,
                    ]),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<double>(
                      stream: widget.song.speedStream,
                      builder: (context, snapshot) {
                        return Slider(
                            value: snapshot.data!,
                            min: 0.1,
                            max: 5,
                            onChanged: (newValue) {
                              widget.song.setSpeed(newValue);
                            });
                      },
                    ),
                  )
                ],
              ),
            )
          ]);
        } else
          return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MusicPlayer(
                        song: AudioPlayer()
                          ..setAsset(
                            'assets/songs/a.mp3',
                          ),
                        songName: 'Sheydaei',
                        filePath: 'assets/songs/a.mp3',
                        imageName: wallpapers[2],
                      )));
        },
      ),
    );
  }
}
