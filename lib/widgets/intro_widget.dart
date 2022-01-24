import 'package:flutter/material.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget(
      {Key? key,
      required this.screenWidth,
      required this.screenHeight,
      this.image,
      this.type,
      this.startGradientColor,
      this.endGradientColor,
      this.subText})
      : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final image;
  final type;
  final Color? startGradientColor;
  final Color? endGradientColor;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[startGradientColor!, endGradientColor!],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            image,
            width: screenWidth * 0.8,
            height: screenHeight * 0.6,
            fit: BoxFit.contain,
          ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Opacity(
                  opacity: 0.10,
                  child: Container(
                    height: screenHeight * 0.12,
                    child: Text(
                      type.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 65.0,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w900,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -3,
                  left: 10,
                  child: Text(
                    type.toString().toUpperCase(),
                    style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'Alata',
                        fontWeight: FontWeight.w900,
                        foreground: Paint()..shader = linearGradient),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              subText!,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                  letterSpacing: 2.0),
            ),
          )
        ],
      ),
    );
  }

  TextStyle buildTextStyle(double size) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 0.5,
    );
  }
}
