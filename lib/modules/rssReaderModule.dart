import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'module.dart';

class Feed_item extends StatelessWidget {
  int id;
  String title;
  String description;
  String link;
  String pubDate;
  late bool isDescriptionImage;
  Feed_item({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.pubDate,
  });

  @override
  Widget build(BuildContext context) {
    if (description.startsWith('<img')) {
      isDescriptionImage = true;
      int start = description.indexOf('"');
      description = description.substring(start + 1);
      int end = description.indexOf('"');
      description = description.substring(0, end);
      print(description);
    } else if (description.startsWith('http'))
      isDescriptionImage = true;
    else
      isDescriptionImage = false;
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        launch(link);
      },
      child: Container(
        child: Column(
          children: [
            Text('title: ' + title),
            (isDescriptionImage)
                ? Container(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(imageUrl: description))
                : Text('description: ' + description),
            Text('pubDate: ' + pubDate),
          ],
        ),
      ),
    );
  }
}

class FeedReaderModule extends Module {
  String siteLink;
  late String rssLink;
  FeedReaderModule({
    required int id,
    required int index,
    String imageName = '',
    String title = 'آخرین اخبار',
    required this.siteLink,
  }) : super(
            id: id,
            index: index,
            type: 18,
            imageName: imageName,
            title: title,
            visibility: true) {
    if (!siteLink.startsWith('https://') && !siteLink.startsWith('http://')) {
      if (!siteLink.startsWith('www.')) {
        siteLink = 'www.' + siteLink;
      }
      siteLink = 'https://' + siteLink;
    }
  }
  void edit(String newSiteLink) {
    this.siteLink = newSiteLink;
    if (!siteLink.startsWith('https://') && !siteLink.startsWith('http://')) {
      if (!siteLink.startsWith('www.')) {
        siteLink = 'www.' + siteLink;
      }
      siteLink = 'https://' + siteLink;
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeedReaderModuleState();
  }
}

class FeedReaderModuleState extends State<FeedReaderModule> {
  Future<String> makeRequest() async {
    if (widget.siteLink.contains('rss')) {
      widget.rssLink = widget.siteLink;
      return widget.rssLink;
    }
    var response = await http.get(Uri.parse(widget.siteLink));
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;

      int start = htmlToParse
          .indexOf('<link rel="alternate" type="application/rss+xml"');
      String cut = htmlToParse.substring(start);
      // print(cut);
      int end = cut.indexOf('>');

      if (end > 0) {
        // print(end);

        String link = cut.substring(0, end);

        print(link);
        // print(';fadssdaf');
        int start2 = link.indexOf('hre');

        String cut2 = link.substring(start2 + 6);
        int end2 = cut2.indexOf('"');
        String link2 = cut2.substring(0, end2);
        print(link2);
        widget.rssLink = link2;
        return link2;
      }

      return widget.rssLink;
    }

    return widget.rssLink;
  }

  Future<List<Feed_item>> loadFeed() async {
    List<Feed_item> list = [];
    var client = http.Client();

    var response = await client.get(
      Uri.parse(widget.rssLink),
    );
    RssFeed channel = RssFeed.parse(response.body);
    for (int i = 0; i < channel.items!.length; i++) {
      list.add(Feed_item(
          id: i,
          title: channel.items![i].title!,
          description: channel.items![i].description!,
          link: channel.items![i].link!,
          pubDate: channel.items![i].pubDate!.toString()));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: FutureBuilder<String>(
            future: makeRequest(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data) {
                  case '':
                    return Center(child: CircularProgressIndicator.adaptive());
                  default:
                    return FutureBuilder<List<Feed_item>>(
                        future: loadFeed(),
                        builder: (context2, snapshot2) {
                          if (snapshot2.hasData) {
                            switch (snapshot2.data) {
                              case []:
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              default:
                                return ListView.builder(
                                    itemCount: snapshot2.data!.length,
                                    itemBuilder: (context, index) {
                                      return snapshot2.data![index];
                                    });
                            }
                          } else
                            return Center(
                                child: CircularProgressIndicator.adaptive());
                        });
                }
              } else
                return Center(child: CircularProgressIndicator.adaptive());
            }));
  }
}
