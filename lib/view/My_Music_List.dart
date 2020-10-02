import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 16,
        itemBuilder: (context, pos) {
          return Card(
            shadowColor: Colors.deepPurpleAccent,
            elevation: 3,
            child: ListTile(
              title: Text('Song $pos',
                style: Theme.of(context).textTheme.headline3,
              ),
              subtitle: Text(
                "Artist $pos",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              leading: IconTheme(
                data: Theme.of(context).iconTheme,
                child: Icon(
                  Icons.album,
                ),
              ),
              trailing: IconTheme(
                data: Theme.of(context).iconTheme,
                child: Icon(
                  Icons.play_arrow,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}