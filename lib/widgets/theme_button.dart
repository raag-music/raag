import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raag/provider/settings_provider.dart';
import 'package:raag/provider/theme.dart';
import 'package:raag/model/strings.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    Widget nightIcon = Icon(
      Icons.nightlight_round,
      color: hex('809DF5'),
    );
    Widget dayIcon = Icon(
      Icons.wb_sunny_outlined,
      color: hex('415EB4'),
    );

    changeTheme() {
      provider.changeTheme();
      provider.darkTheme ? controller.forward() : controller.reverse();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Card(
        elevation: 3,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => changeTheme(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                AnimatedIconButton(
                  size: screenWidth * 0.08,
                  animationController: controller,
                  startIcon: (provider.darkTheme) ? dayIcon : nightIcon,
                  endIcon: (provider.darkTheme) ? nightIcon : dayIcon,
                  onPressed: () {},
                ),
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Text(
                  darktheme,
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Switch(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: !provider.darkTheme,
                  onChanged: (bool value) => changeTheme(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
