import 'package:appbesaz/modules/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicPlayer extends StatefulWidget {
  String imageName;
  AudioPlayer song;
  String songName;
  Function nextSong;
  Function previousSong;
  MusicPlayer({
    required this.song,
    required this.songName,
    required this.nextSong,
    required this.previousSong,
    this.imageName = '',
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MusicPlayerState();
  }
}

class MusicPlayerState extends State<MusicPlayer> {
  @override
  void initState() {
    // TODO: implement initState
    widget.song.play();
    super.initState();
  }

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
    double getDuration() {
      if (widget.song.duration == null)
        return 0;
      else
        return widget.song.duration!.inSeconds.toDouble();
    }

    widget.song.playerStateStream.listen((event) async{
      if (event.processingState == ProcessingState.completed) {
        // song has ended playing.
        if (getDuration() == widget.song.position.inSeconds.toDouble()) {
          await widget.song.seek(Duration.zero);
          widget.nextSong();
          
        }
      }
    });
    StreamBuilder<Duration?> currentTime = new StreamBuilder(
        stream: widget.song.positionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data!.inSeconds.toDouble() != 0 &&
            //     snapshot.data!.inSeconds.toDouble() == getDuration()) {
            //   widget.song.stop();
            //   widget.nextSong();
            //   setState(() {
            //     print('nextSong');
            //   });
            //   widget.song.play();
            // }
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

    StreamBuilder<double> volumeSlider = StreamBuilder(
        stream: widget.song.volumeStream,
        builder: (context, snapshot) {
          return Row(
            children: [
              Icon(Icons.volume_down),
              Expanded(
                child: Slider(
                  value: widget.song.volume,
                  min: 0,
                  max: 10,
                  onChanged: (newValue) {
                    widget.song.setVolume(newValue);
                  },
                ),
              ),
              Icon(Icons.volume_up)
            ],
          );
        });
    Widget songArtwork = ScreenTypeLayout.builder(
      mobile: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            print('mobile portrait');
            print(MediaQuery.of(context).size.height /
                MediaQuery.of(context).size.width);
            return Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: (widget.imageName != "")
                            ? AssetImage(widget.imageName)
                            : AssetImage(wallpapers[0]))));
          },
          landscape: (context) {
            print('mobile landscape');
            return Container(
                width: MediaQuery.of(context).size.height * 0.40,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: (widget.imageName != "")
                            ? AssetImage(widget.imageName)
                            : AssetImage(wallpapers[0]))));
          },
        );
      },
      tablet: (context) {
        return OrientationLayoutBuilder(portrait: (context) {
          print('tablet portrait');
          return Container(
              width: MediaQuery.of(context).size.height / 2,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (widget.imageName != "")
                          ? AssetImage(widget.imageName)
                          : AssetImage(wallpapers[0]))));
        }, landscape: (context) {
          print('tablet landscape');
          return Container(
              width: MediaQuery.of(context).size.height / 2,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (widget.imageName != "")
                          ? AssetImage(widget.imageName)
                          : AssetImage(wallpapers[0]))));
        });
      },
    );

    Widget controlButtons = ScreenTypeLayout.builder(
      mobile: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // mobile portrait
            return Container(
              child: SafeArea(
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
                              widget.previousSong();
                            },
                            child: Icon(Icons.skip_previous_rounded)),
                        ElevatedButton(
                            onPressed: () async {
                              widget.nextSong();
                            },
                            child: Icon(Icons.skip_next_rounded)),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.song.setSpeed(2.0);
                            });
                          },
                          child: Text('2x'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.song.setSpeed(0.5);
                            });
                          },
                          child: Text('0.5x'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.song.setSpeed(1);
                              });
                            },
                            child: Text('1x')),
                      ]))),
            );
          },
          landscape: (context) {
            //mobile landscape
            return Container(
              child: SafeArea(
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
                              widget.previousSong();
                            },
                            child: Icon(Icons.skip_previous_rounded)),
                        ElevatedButton(
                            onPressed: () async {
                              widget.nextSong();
                            },
                            child: Icon(Icons.skip_next_rounded)),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.song.setSpeed(2.0);
                            });
                          },
                          child: Text('2x'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.song.setSpeed(0.5);
                            });
                          },
                          child: Text('0.5x'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.song.setSpeed(1);
                              });
                            },
                            child: Text('1x')),
                      ]))),
            );
          },
        );
      },
      tablet: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // tablet portrait
            return Container(
              child: SafeArea(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                  widget.previousSong();
                                },
                                child: Icon(Icons.skip_previous_rounded)),
                            ElevatedButton(
                                onPressed: () async {
                                  widget.nextSong();
                                },
                                child: Icon(Icons.skip_next_rounded)),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(2.0);
                                });
                              },
                              child: Text('2x'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(0.5);
                                });
                              },
                              child: Text('0.5x'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.song.setSpeed(1);
                                  });
                                },
                                child: Text('1x')),
                          ]))),
            );
          },
          landscape: (context) {
            return Container(
              child: SafeArea(
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                  widget.previousSong();
                                },
                                child: Icon(Icons.skip_previous_rounded)),
                            ElevatedButton(
                                onPressed: () async {
                                  widget.nextSong();
                                },
                                child: Icon(Icons.skip_next_rounded)),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(2.0);
                                });
                              },
                              child: Text('2x'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.song.setSpeed(0.5);
                                });
                              },
                              child: Text('0.5x'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.song.setSpeed(1);
                                  });
                                },
                                child: Text('1x')),
                          ]))),
            );
          },
        );
      },
    );

    Widget timeSlider = ScreenTypeLayout.builder(
      mobile: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // mobile portrait

            return Column(children: [
              StreamBuilder<Duration?>(
                  stream: widget.song.positionStream,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.data!.inSeconds.toDouble(),
                      onChanged: (double newValue) {
                        if (newValue <= getDuration())
                          setState(() {
                            widget.song
                                .seek(Duration(seconds: newValue.toInt()));
                          });
                      },
                      min: 0,
                      max: getDuration(),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [currentTime, endTime],
              ),
            ]);
          },
          landscape: (context) {
            // mobile landscape
            return Column(children: [
              StreamBuilder<Duration?>(
                  stream: widget.song.positionStream,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.data!.inSeconds.toDouble(),
                      onChanged: (double newValue) {
                        if (newValue <= getDuration())
                          setState(() {
                            widget.song
                                .seek(Duration(seconds: newValue.toInt()));
                          });
                      },
                      min: 0,
                      max: getDuration(),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentTime,
                  endTime,
                ],
              )
            ]);
          },
        );
      },
      tablet: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // tablet portrait
            return Column(children: [
              StreamBuilder<Duration?>(
                  stream: widget.song.positionStream,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.data!.inSeconds.toDouble(),
                      onChanged: (double newValue) {
                        if (newValue <= getDuration())
                          setState(() {
                            widget.song
                                .seek(Duration(seconds: newValue.toInt()));
                          });
                      },
                      min: 0,
                      max: getDuration(),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: currentTime,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: endTime,
                  ),
                ],
              )
            ]);
          },
          landscape: (context) {
            // tablet landscape
            return Center(
                child: Row(children: [
              currentTime,
              Expanded(
                child: StreamBuilder<Duration?>(
                    stream: widget.song.positionStream,
                    builder: (context, snapshot) {
                      return Slider(
                        value: snapshot.data!.inSeconds.toDouble(),
                        onChanged: (double newValue) {
                          if (newValue <= getDuration())
                            setState(() {
                              widget.song
                                  .seek(Duration(seconds: newValue.toInt()));
                            });
                        },
                        min: 0,
                        max: getDuration(),
                      );
                    }),
              ),
              endTime,
            ]));
          },
        );
      },
    );

    Widget speedSlider = StreamBuilder<double>(
      stream: widget.song.speedStream,
      builder: (context, snapshot) {
        return Row(children: [
          Icon(Icons.slow_motion_video),
          Expanded(
            child: Slider(
                value: snapshot.data!,
                min: 0.1,
                max: 5,
                onChanged: (newValue) {
                  widget.song.setSpeed(newValue);
                }),
          ),
          Icon(Icons.speed),
        ]);
      },
    );

    Widget mainLayout = ScreenTypeLayout.builder(
      mobile: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // mobile portrait: Column
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    songArtwork,
                    Text(widget.songName),
                  ]),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      controlButtons,
                      Expanded(
                        child: timeSlider,
                      ),
                    ],
                  ),
                ]);
          },
          landscape: (context) {
            // mobile landscape: Row
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [songArtwork, Text(widget.songName)]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [controlButtons, timeSlider],
                )
              ],
            );
          },
        );
      },
      tablet: (context) {
        return OrientationLayoutBuilder(
          portrait: (context) {
            // tablet portrait
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      child: songArtwork),
                  Text(widget.songName),
                  Center(
                    child: timeSlider,
                  ),
                  controlButtons,
                  speedSlider,
                  volumeSlider,
                ],
              ),
            );
          },
          landscape: (context) {
            // tablet landscape
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: songArtwork),
                  Text(widget.songName),
                  Center(
                    child: timeSlider,
                  ),
                  controlButtons,
                  speedSlider,
                  volumeSlider,
                ],
              ),
            );
          },
        );
      },
    );

    return Scaffold(
      body: mainLayout,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => MusicPlayer(
      //                   song: AudioPlayer()
      //                     ..setAsset(
      //                       'assets/songs/a.mp3',
      //                     ),
      //                   songName: 'Sheydaei',

      //                   imageName: wallpapers[2],
      //                 )));
      //   },
      // ),
    );
  }
}
