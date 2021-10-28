import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raag/provider/db_provider.dart';
import 'package:raag/view/splash_screen.dart';
import 'package:raag/model/strings.dart';

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    showAlert() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                refreshingDB,
                style: Theme.of(context).textTheme.headline3,
              ),
              content: Text(newSongs));
        },
      );
    }

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () async {
          showAlert();
          var _oldCount = await DBProvider.db.getCount();
          // _preferencesProvider.setBool(Preferences.DB_POPULATED, false);
          await SplashScreen.populateSongsIntoDB();
          var _diff = await DBProvider.db.getCount() - _oldCount;
          var toastText = (_diff < 0) ? songsRemoved : newSongsAdded;
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: (_diff).toString() + toastText);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.refresh_rounded,
                  size: screenWidth * 0.08,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Text(
              refreshSongs,
              style: Theme.of(context).textTheme.headline3,
            )
          ]),
        ),
      ),
    );
  }
}
