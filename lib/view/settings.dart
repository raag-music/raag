import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raag/widgets/download_location_button_settings.dart';
import 'package:raag/widgets/refresh_button.dart';
import 'package:raag/widgets/theme_button.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.3,
            toolbarHeight: screenHeight * 0.08,
            collapsedHeight: screenHeight * 0.1,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Text('Settings',
                    style: Theme.of(context).textTheme.headline1),
                background: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24)),
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            stops: [0.1, 0.8],
                            colors: [Colors.black45, Colors.black12])))),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: screenHeight * 0.05),
              ThemeButton(),
              RefreshButton(),
              DownloadLocationButton(),
            ]),
          )
        ],
      )),
    );
  }
}
