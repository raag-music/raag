import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/connectivity.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/settings_provider.dart';
import 'package:raag/provider/theme.dart';
import 'package:raag/provider/youtube_icon.dart';
import 'package:raag/view/settings.dart';
import 'package:raag/view/youtube_search.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadMusic extends StatefulWidget {
  final String url;

  DownloadMusic({@required this.url});
  @override
  _DownloadMusicState createState() => _DownloadMusicState();
}

class _DownloadMusicState extends State<DownloadMusic> {
  String alertBody = '';
  String alertTitle = '';
  double downloadProgress = 0;
  String downloadedFilePath = '';
  String downloadedFileTitle = '';
  var thumbnailURL =
      "https://user-images.githubusercontent.com/20596763/104451609-cceeff80-55c7-11eb-92f9-828dc8940daf.png";
  final urlFieldController = TextEditingController();
  YoutubeExplode yt;
  IOSink fileSink;

  void _flushDownloader() {
    fileSink.flush();
    fileSink.close();
    yt.close();
    setProgress(0);
    print('Downloader flushed');
  }

  @override
  void initState() {
    super.initState();
    urlFieldController.clear();
    urlFieldController.text = widget.url;
    if (isValidYouTubeURL(widget.url)) downloadMusic(widget.url, context);
  }

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

  void setProgress(double value) {
    setState(() {
      downloadProgress = value;
    });
  }

  void setThumbnail(String url) {
    setState(() {
      thumbnailURL = url;
    });
  }

  @override
  void dispose() {
    urlFieldController.dispose();
    super.dispose();
  }

  Future<int> downloadMusic(String url, BuildContext context) async {
    Preferences sharedPreference = Preferences();
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
    try {
      yt = YoutubeExplode();

      setBody(downloading);
      setTitle(resolvingURL);

      var video = await yt.videos.get(url);
      var title = video.title;
      setBody("$downloading $title");
      setTitle(fetchingStream);

      setThumbnail(video.thumbnails.mediumResUrl);
      StreamManifest streamManifest =
      await yt.videos.streamsClient.getManifest(video.id);
      StreamInfo streamInfo = streamManifest.audioOnly.withHighestBitrate();

      setTitle(downloadDir);
      Directory _raagDownloadsDirectory;
      if (await sharedPreference.getBool(Preferences.DOWNLOAD_DIRECTORY) ==
          true) {
        Directory downloadsDirectory = await DownloadsPathProvider
            .downloadsDirectory;
        _raagDownloadsDirectory =
            Directory('${downloadsDirectory.path}/$appName');
      }
      else
        _raagDownloadsDirectory = await getExternalStorageDirectory();

      if (!await _raagDownloadsDirectory.exists()) {
        _raagDownloadsDirectory.create(recursive: true);
        print('Created directory: ${_raagDownloadsDirectory.path}');
      }
      var tempTitle = title
          .replaceAll('|', '-')
          .replaceAll('\'', '')
          .replaceAll('\"', '')
          .replaceAll('.', ' ')
          .replaceAll('/', ' ')
          .replaceAll(':', ' ');
      //TODO Do something efficient to choose only alpha-numeric characters from $title
      var filePath = _raagDownloadsDirectory.path + '/' + tempTitle + '.webm';

      if (streamInfo != null) {
        var stream = yt.videos.streamsClient.get(streamInfo);
        var file = new File(filePath);
        if (!await file.exists()) file.create(recursive: true);
        fileSink = file.openWrite();
        var fileSizeInBytes = streamInfo.size.totalKiloBytes * 1024;
        var received = 0;
        setTitle('$downloading');

        await stream.map((s) {
          received += s.length;
          setProgress((received / fileSizeInBytes));
          setTitle(
              '$downloading ${(downloadProgress * 100).toStringAsFixed(2)} %');
          return s;
        }).pipe(fileSink);

        setTitle('Converting to MP3');
        filePath = await webmToMP3(filePath);

        // setTitle('Adding tags');
        // print(await tagArtWork(video.thumbnails.mediumResUrl, filePath));

        setTitle(downloadComplete);
        setBody(
            '$fileLocation: $filePath\n$fileSize: ${(streamInfo.size.totalMegaBytes.toString().substring(0, 4))} MB');
        OpenFile.open(filePath);
        downloadedFilePath = 'file://$filePath';
        downloadedFileTitle = tempTitle;
      }
      yt.close();
      setProgress(0);
    } on FileSystemException {
      Alert(
          context: context,
          title: 'File error',
          desc: 'Raag was unable to create a file. Try changing the download location from settings and try again',
          type: AlertType.error,
          style: Styles.alertStyle(context),
          buttons: [
            DialogButton(
              child: Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                _flushDownloader();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Settings(),
                ));
              },
            ),
            DialogButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context))
          ]).show();
      setTitle('');
      setBody('');
      setThumbnail(thumbnailURL);
      return 0;
    } catch (e, s) {
      print("Exception: $e\nStack Trace: $s");
      Alert(
          context: context,
          title: 'Unknown error',
          desc: '$e',
          type: AlertType.error,
          style: Styles.alertStyle(context))
          .show();
      setTitle('');
      setBody('');
      setThumbnail(thumbnailURL);
    } finally {
      _flushDownloader();
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        brightness:
        settingsProvider.darkTheme ? Brightness.light : Brightness.dark,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () => Navigator.pop(context)),
        title: Text("Download music",
            style: Theme
                .of(context)
                .textTheme
                .headline3),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              YouTubeIcon.youtube,
              color: Theme
                  .of(context)
                  .accentColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onPressed: () =>
                Navigator.push(
                    context,
                MaterialPageRoute(
                  builder: (context) => YoutubeSearch(),
                )),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.all(8),
                color: Theme.of(context).backgroundColor,
                child: TextField(
                  controller: urlFieldController,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                  autocorrect: false,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (url) {
                    downloadMusic(url, context);
                  },
                  decoration: InputDecoration(
                    // focusedBorder: UnderlineInputBorder(
                    //     borderSide:
                    //         BorderSide(color: Theme.of(context).accentColor)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme
                          .of(context)
                          .accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    hintText: pasteYoutube,
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,
                    fillColor: Theme
                        .of(context)
                        .accentColor,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                ),
                child: IconButton(
                  iconSize: 24,
                  onPressed: () =>
                      downloadMusic(urlFieldController.text, context),
                  icon: Icon(
                    Icons.download_rounded,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
              IconButton(
                iconSize: 18,
                onPressed: () {
                  urlFieldController.clear();
                  FlutterClipboard.paste().then((url) {
                    if (isValidYouTubeURL(url)) {
                      urlFieldController.text = url;
                      urlFieldController.selection = TextSelection.fromPosition(
                          TextPosition(offset: urlFieldController.text.length));
                    } else {
                      Fluttertoast.showToast(msg: clipBoardYT);
                    }
                  });
                },
                icon: Icon(
                  Icons.paste_rounded,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
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
                Stack(children: [
                  LinearProgressIndicator(
                    value: downloadProgress,
                  ),
                ]),
                SizedBox(height: 32),
                Text(
                  alertBody,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 32),
                Image.network(thumbnailURL)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
