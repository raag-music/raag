import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/provider/audio_helper.dart';
import 'package:raag/provider/settings_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'download_music.dart';

class YoutubeSearch extends StatefulWidget {
  @override
  _YoutubeSearchState createState() => _YoutubeSearchState();
}

class _YoutubeSearchState extends State<YoutubeSearch> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: themeProvider.darkTheme
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        title: Text('YouTube', style: Theme.of(context).textTheme.headline3),
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://www.youtube.com/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            if (isValidYouTubeURL(url)) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DownloadMusic(url: '')));
            }
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Fluttertoast.showToast(msg: message.message);
        });
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.download_rounded),
              onPressed: () async {
                String? currentURL;
                await _webViewControllerFuture.then(
                    (value) async => {currentURL = (await value.currentUrl())});
                print(currentURL);
                if (isValidYouTubeURL(currentURL!)) {
                  Navigator.pop(context); //To close the search page
                  Navigator.pop(
                      context); //To close the previous instance of Download page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadMusic(url: currentURL),
                      ));
                } else {
                  Fluttertoast.showToast(msg: openValidVideo);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        Fluttertoast.showToast(msg: noPageHistory);
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        Fluttertoast.showToast(msg: noForward);
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
