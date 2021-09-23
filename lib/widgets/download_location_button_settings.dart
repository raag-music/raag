import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/settings_provider.dart';

class DownloadLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () async {
          if (provider.appStorage != false) {
            provider.appStorage = false;
            Fluttertoast.showToast(
                msg:
                    'Downloaded files will be stored to \nAndroid/Data/in.amfoss.raag/files\nUse a File manager to move to your preferred location',
                toastLength: Toast.LENGTH_LONG);
          } else {
            Fluttertoast.showToast(
                msg: 'Downloaded files will be stored to \nDownload/Raag/',
                toastLength: Toast.LENGTH_LONG);
            provider.appStorage = true;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Download Location',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  provider.appStorage == true
                      ? 'Storage/Download/Raag'
                      : 'Android/Data/in.amfoss.raag/files/',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            // SizedBox(
            //   width: screenWidth * 0.3,
            // ),
          ]),
        ),
      ),
    );
  }
}
