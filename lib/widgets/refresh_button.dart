import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:raag/model/SharedPreferences.dart';
import 'package:raag/model/music_model.dart';
import 'package:raag/provider/db_provider.dart';

class RefreshButton extends StatefulWidget {
  @override
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Preferences _preferencesProvider = new Preferences();

    showAlert(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text('Refreshing DB', style: Theme.of(context).textTheme.headline3,),
            content: Text('Looking for new songs')
          );
        },
      );
    }

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () async {
          showAlert();
          var _oldCount = await DBProvider.db.getCount();
          await DBProvider.db.deleteAll();
          List<SongInfo> songs = await FlutterAudioQuery().getSongs();
          for (var it = 0; it < songs.length; it++) {
            DBProvider.db.insertSong(new Song(
                id: songs[it].id,
                title: songs[it].title,
                displayName: songs[it].displayName,
                filePath: songs[it].filePath,
                albumArtwork: songs[it].albumArtwork,
                artist: songs[it].artist,
                album: songs[it].album,
                duration: songs[it].duration,
                composer: songs[it].composer));
          }
          _preferencesProvider.setBool(Preferences.DB_POPULATED,true);
          var _diff = await DBProvider.db.getCount()-_oldCount;
          var toastText = (_diff < 0) ? ' songs removed' : ' new songs added' ;
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: (_diff).toString()+toastText);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.refresh_rounded,
                  size: screenWidth * 0.08,
                  color: Theme.of(context).accentColor,
                )),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Text(
              'Refresh Songs',
              style: Theme.of(context).textTheme.headline3,
            )
          ]),
        ),
      ),
    );
  }
}
