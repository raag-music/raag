import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/provider/settings_provider.dart';

class DownloadLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<SettingsProvider>(context);

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () async {
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();

          if (selectedDirectory != null) {
            provider.downloadPath = selectedDirectory;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.folder_open,
                  size: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                downloadedLocation,
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                provider.downloadPath,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
