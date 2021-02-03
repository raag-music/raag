import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
import 'package:raag/view/splash_screen.dart';
import 'package:raag/provider/theme.dart';
import 'package:raag/widgets/intro_widget.dart';

import 'home_scaffold.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPageValue = 0;
  int previousPageValue = 0;
  PageController controller;
  double _moveBar = 0;
  int page = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPageValue);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> onBoardingWidgets = [
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/images/onBoarding1.png',
          type: appName,
          startGradientColor: Theme.of(context).accentColor,
          endGradientColor: Colors.deepPurple,
          subText: 'The Millennial\'s music app'),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/images/onBoarding2.png',
          type: 'Listen',
          startGradientColor: hex('407BFF'),
          endGradientColor: hex('004DFF'),
          subText: 'Listen to all your songs in one place'),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/images/onBoarding3.png',
          type: 'Download',
          startGradientColor: hex('FF725E'),
          endGradientColor: hex('FF1A00'),
          subText: 'YouTube to your device'),
    ];

    Widget movingBar() {
      return GestureDetector(
        onTap: () async {
          if(page<2)
            controller.animateToPage(page+1, duration: Duration(milliseconds: 400), curve: Curves.ease);
          else
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScaffold()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: screenHeight * 0.1,
          width: screenWidth * 0.1,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: onBoardingWidgets.length,
                onPageChanged: (int page) {
                  setState(() {
                    this.page = page;
                  });
                  getChangedPageAndMoveBar(page);
                },
                controller: controller,
                itemBuilder: (context, index) {
                  return onBoardingWidgets[index];
                },
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.fastOutSlowIn,
                      margin: EdgeInsets.only(
                          bottom: 35,
                          left: screenWidth * _moveBar
                      ),
                      child: movingBar()),
                ],
              ),
              Visibility(
                visible: currentPageValue == onBoardingWidgets.length - 1
                    ? true
                    : false,
                child: FloatingActionButton(
                  onPressed: () {},
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(26))),
                  child: Icon(Icons.arrow_forward),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    print('page is $page');

    if (previousPageValue == 0) {
      previousPageValue = page;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < page) {
        previousPageValue = page;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = page;
        _moveBar = _moveBar - 0.14;
      }
    }
    setState(() {});
  }
}
