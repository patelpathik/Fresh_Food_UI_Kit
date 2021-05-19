import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
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
  bool isSearching = false;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (mounted)
        setState(() {
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
    Widget searchingWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
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
    );
    Widget defaultView = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          height: SizeConfig.screenWidth * 0.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: COLORS.GREEN,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(SizeConfig.screenWidth * 0.4),
            ),
            child: Material(
              color: COLORS.GREEN,
              child: InkWell(
                splashColor: COLORS.MEDIUM_DARK_GREY,
                onTap: () {
                  if (mounted) setState(() => isSearching = true);
                },
                child: Container(
                  height: SizeConfig.screenWidth * 0.4,
                  width: SizeConfig.screenWidth * 0.4,
                  padding: EdgeInsets.all(SizeConfig.screenWidth * 0.1),
                  child: SvgPicture.asset(ThemeIcon.VOICE),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Voice Search",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline5.fontSize,
            color: COLORS.GREEN,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Tap and say something",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
            color: COLORS.MEDIUM_GREY,
          ),
        ),
      ],
    );
    Widget closeButton = Align(
      alignment: Alignment.topRight,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        height: AppBar().preferredSize.height,
        width: AppBar().preferredSize.height,
        margin: EdgeInsets.only(
          top: AppBar().preferredSize.height * 0.25,
          right: AppBar().preferredSize.height * 0.25,
        ),
        // color: Colors.black12,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBar().preferredSize.height),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                padding: EdgeInsets.all(AppBar().preferredSize.height * 0.3),
                child: SvgPicture.asset(ThemeIcon.CLOSE),
              ),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          isSearching ? searchingWidget : defaultView,
          isSearching ? Container() : closeButton,
        ],
      ),
    );
  }
}
