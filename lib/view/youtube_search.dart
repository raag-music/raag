import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeSearch extends StatefulWidget {
  @override
  _YoutubeSearchState createState() => _YoutubeSearchState();
}

class _YoutubeSearchState extends State<YoutubeSearch> {
  @override
  Widget build(BuildContext context) {
    return WebView(

      initialUrl: 'https://m.youtube.com',
    );
  }
}
