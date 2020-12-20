import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:raag/DarkThemeProvider.dart';
import 'package:raag/view/My_Music_List.dart';
import 'package:raag/widgets/ThemeButton.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              DrawerHeader(
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/musical.png',
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Raag: Music App",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                  )),
              ListTile(
                title: Text(
                  "Setting",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                title: Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.share,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                title: Text(
                  "Favourite Song",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                title: Text(
                  "Recents Song",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.recent_actors,
                  color: Theme.of(context).accentColor,
                ),
              ),
              ListTile(
                title: Text(
                  "Rate Us",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                leading: Icon(
                  Icons.star_rate,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                onPressed: () {}),
            ThemeButton(),
          ],
          title: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/musical.png',
                  width: 40,
                  height: 40,
                ),
              ))),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [MyMusicList()],
            ),
          ),
        ],
      ),
    );
  }
}