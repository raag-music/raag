import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/DarkThemeProvider.dart';

class ThemeButton extends StatefulWidget {
  @override
  _ThemeButtonState createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final Color themeIconcolor = Theme.of(context).accentColor;
    //Color(0xFF809DF5);

    return AnimatedIconButton(
      animationController: controller,
      startIcon: Icon(
        Icons.nights_stay,
        color: themeIconcolor,
      ),
      endIcon: Icon(
        Icons.wb_sunny_outlined,
        color: themeIconcolor,
      ),
      onPressed: () {
        if (themeChange.darkTheme == true) {
          themeChange.darkTheme = false;
        } else {
          themeChange.darkTheme = true;
        }
        setState(() {
          themeChange.darkTheme ? controller.forward() : controller.reverse();
        });
      },
    );
  }
}
