import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';
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
  PageController? controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPageValue);
  }

  Widget _indicator(bool isActive) {
    return AnimatedOpacity(
      opacity: (_page == 2) ? 0 : 1,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
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
          startGradientColor: Theme.of(context).colorScheme.secondary,
          endGradientColor: Colors.deepPurple,
          subText: splashTagString),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/images/onBoarding2.png',
          type: 'Listen',
          startGradientColor: hex('407BFF'),
          endGradientColor: hex('004DFF'),
          subText: splashCaption),
      IntroWidget(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          image: 'assets/images/onBoarding3.png',
          type: 'Download',
          startGradientColor: hex('FF725E'),
          endGradientColor: hex('FF1A00'),
          subText: splashYouTube),
    ];

    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < onBoardingWidgets.length; i++) {
        list.add(i == _page ? _indicator(true) : _indicator(false));
      }
      return list;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  stops: [0.1, 0.9],
                  colors: [Colors.black54, Colors.black26])),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: onBoardingWidgets.length,
                onPageChanged: (int page) {
                  setState(() {
                    this._page = page;
                  });
                },
                controller: controller,
                itemBuilder: (context, index) {
                  return onBoardingWidgets[index];
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: AnimatedOpacity(
                  opacity: (_page == 2) ? 0 : 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: TextButton(
                      onPressed: () {
                        _page = 2;
                        controller!.animateToPage(_page,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.ease);
                      },
                      child: Text(
                        skip,
                        style: Theme.of(context).textTheme.headline3,
                      )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: (_page == 2) ? 1 : 0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScaffold()));
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
