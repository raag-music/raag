import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/settings_provider.dart';
import 'package:raag/widgets/download_location_button.dart';
import 'package:raag/widgets/theme_button.dart';
import 'package:raag/model/strings.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<SettingsProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.3,
            toolbarHeight: screenHeight * 0.08,
            collapsedHeight: screenHeight * 0.15,
            systemOverlayStyle: themeProvider.darkTheme
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              title:
                  Text(settings, style: Theme.of(context).textTheme.headline1),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context)),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: screenHeight * 0.05),
              ThemeButton(),
              Platform.isAndroid ? DownloadLocationButton() : SizedBox(),
            ]),
          )
        ],
      )),
    );
  }
}
