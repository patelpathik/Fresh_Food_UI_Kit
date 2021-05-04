import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/sizeconfig.dart';

class VoiceSearchMobilePortrait extends StatefulWidget {
  const VoiceSearchMobilePortrait({Key key}) : super(key: key);

  @override
  _VoiceSearchMobilePortraitState createState() =>
      _VoiceSearchMobilePortraitState();
}

class _VoiceSearchMobilePortraitState extends State<VoiceSearchMobilePortrait> {
  double oddHW = 10;
  double evenHW = 20;

  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        /*
        * a = 10
        * b = 20
        *
        * a = a+b = 30
        * b = a-b = 10
        * a = a-b = 20
        *  */
        oddHW = oddHW + evenHW;
        evenHW = oddHW - evenHW;
        oddHW = oddHW - evenHW;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.screenWidth * 0.7,
            margin: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.15,
              right: SizeConfig.screenWidth * 0.15,
            ),
            alignment: Alignment.center,
            child: Scatter(
              delegate: EllipseScatterDelegate(
                a: SizeConfig.screenWidth * 0.25,
                b: SizeConfig.screenWidth * 0.25,
                step: 1.0 / 8,
              ),
              children: List.generate(
                8,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: index.isEven ? evenHW : oddHW,
                  width: index.isEven ? evenHW : oddHW,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: COLORS.GREEN,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Searching for",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              color: COLORS.MEDIUM_GREY,
            ),
          ),
          SizedBox(height: 10),
          AnimatedTextKit(
            repeatForever: false,
            onFinished: () => Navigator.of(context).pop(true),
            isRepeatingAnimation: false,
            totalRepeatCount: 0,
            animatedTexts: [
              TypewriterAnimatedText(
                // "Green",
                "Broccoli",
                textStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                  color: COLORS.GREEN,
                ),
                curve: Curves.fastOutSlowIn,
                speed: Duration(milliseconds: 500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
