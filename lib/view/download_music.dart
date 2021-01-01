import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:raag/model/connectivity.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/provider/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadMusic extends StatefulWidget {
  @override
  _DownloadMusicState createState() => _DownloadMusicState();
}

class _DownloadMusicState extends State<DownloadMusic> {
  String alertBody = "";
  String alertTitle = "";
  double progressOpacity = 0;

  void setTitle(String title) {
    setState(() {
      alertTitle = title;
    });
  }

  void setBody(String body) {
    setState(() {
      alertBody = body;
    });
  }

  void setProgressOpacity(double value) {
    setState(() {
      progressOpacity = value;
    });
  }

  Future<int> downloadMusic(String url, BuildContext context) async {
    if (await isConnected() == false) {
      Alert(
              context: context,
              title: '$notConnected',
              desc: '$checkConn',
              type: AlertType.error,
              style: Styles.alertStyle(context))
          .show();
      return 0;
    }

    var yt = YoutubeExplode();

    setProgressOpacity(1);
    setBody(downloading);
    setTitle(resolvingURL);

    var video = await yt.videos.get(url);
    var title = video.title;
    setBody("$downloading $title");
    setTitle(fetchingStream);

    var streamManifest = await yt.videos.streamsClient.getManifest(video.id);
    var streamInfo = streamManifest.audioOnly.withHighestBitrate();

    setTitle(downloadDir);
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    var filePath = downloadsDirectory.path +
        '/' +
        title.replaceAll('|', '-') +
        '.mp3'; //TODO Do something efficient to choose only alpha-numeric characters from $title

    print('FilePath: ' + filePath);

    if (streamInfo != null) {
      var stream = yt.videos.streamsClient.get(streamInfo);
      var file = new File(filePath);
      var fileStream = file.openWrite();

      setTitle(downloading);
      await stream.pipe(fileStream);

      setTitle(downloadComplete);
      setBody(filePath);

      await fileStream.flush();
      await fileStream.close();
    }
    yt.close();
    setProgressOpacity(0);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Download music",
              style: Theme.of(context).textTheme.headline3),
          centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).backgroundColor,
            child: TextField(
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
              autocorrect: false,
              textInputAction: TextInputAction.search,
              onSubmitted: (url) {
                downloadMusic(url, context);
              },
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor)),
                hintText: pasteYoutube,
                hintStyle: Theme.of(context).textTheme.subtitle1,
                fillColor: Theme.of(context).accentColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                Text(
                  alertTitle,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 32),
                Opacity(
                    opacity: progressOpacity, child: LinearProgressIndicator()),
                SizedBox(height: 32),
                Text(
                  alertBody,
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
