import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:flutter/material.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:just_audio/just_audio.dart';
import 'musicPlayer.dart';

class Song {
  String songPath;
  String songName;
  String imageName;

  Song({required this.songPath, required this.songName, this.imageName = ''});
}

class MusicModule extends Module {
  List<Song> songList;
  MusicModule({
    required int id,
    required int index,
    String imageName = '',
    String title = 'پخش موسیقی',
    required this.songList,
  }) : super(
          id: id,
          index: index,
          type: 20,
          imageName: imageName,
          title: title,
        );
  AudioPlayer player = AudioPlayer();
  int currentSong = 0;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    player.setAsset(songList[0].songPath);
    currentSong = 0;
    return MusicModuleState();
  }
}

class MusicModuleState extends State<MusicModule> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void nextSong() {
    if (widget.currentSong + 1 < widget.songList.length)
      ++widget.currentSong;
    else
      widget.currentSong = 0;

    setState(() {
      widget.player.setAsset(widget.songList[widget.currentSong].songPath);
    });
  }

  void previousSong() {
    if (widget.currentSong > 0)
      --widget.currentSong;
    else
      widget.currentSong = widget.songList.length - 1;


    setState(() {
      widget.player.setAsset(widget.songList[widget.currentSong].songPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MusicPlayer(
          nextSong: () {
            this.nextSong();
          },
          previousSong: () {
            this.previousSong();
          },
          song: widget.player,
          songName: widget.songList[widget.currentSong].songName,
          imageName: widget.songList[widget.currentSong].imageName,
        ));
  }
}
