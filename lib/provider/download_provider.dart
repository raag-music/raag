import 'package:flutter/material.dart';

class DownloadProvider extends ChangeNotifier {
  String _alertBody = '';
  set alertBody(String body) {
    _alertBody = body;
    notifyListeners();
  }

  String _alertTitle = '';
  set alertTitle(String title) {
    _alertTitle = title;
    notifyListeners();
  }

  double _downloadProgress = 0;
  set downloadProgress(double progress) {
    _downloadProgress = progress;
    notifyListeners();
  }

  String _downloadedFilePath = '';
  set downloadedFilePath(String path) {
    _downloadedFilePath = path;
    notifyListeners();
  }

  String _downloadedFileTitle = '';
  set downloadedFileTitle(String title) {
    _downloadedFileTitle = title;
    notifyListeners();
  }

  String _thumbnailURL =
      "";
  set thumbnailURL(String url) {
    _thumbnailURL = url;
    notifyListeners();
  }

  String get alertTitle => _alertTitle;
  double get downloadProgress => _downloadProgress;
  String get alertBody => _alertBody;
  String get downloadedFileTitle => _downloadedFileTitle;
  String get downloadedFilePath => _downloadedFilePath;
  String get thumbnailURL => _thumbnailURL;
}
