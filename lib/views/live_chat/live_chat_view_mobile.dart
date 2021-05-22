import 'dart:async';
import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/theme/images.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/utils/sizeconfig.dart';
import 'package:fresh_food/widgets/appBar.dart';
import 'package:fresh_food/widgets/bottom_curved_shadow.dart';
import 'package:fresh_food/widgets/input_field.dart';

class LiveChatMobilePortrait extends StatefulWidget {
  const LiveChatMobilePortrait({Key key}) : super(key: key);

  @override
  _LiveChatMobilePortraitState createState() => _LiveChatMobilePortraitState();
}

class _LiveChatMobilePortraitState extends State<LiveChatMobilePortrait> {
  TextEditingController msgBoxController = new TextEditingController();
  FocusNode msgBoxFocusNode = new FocusNode();
  bool isDark = false;
  List<String> automatedReplies = [
    "Give me a moment, I'll be back soon",
    "Thanks for the note, I'll revert you ASAP",
    "Thanks for the message. I'll be back in a while.",
    "We're OOO, catch you later.",
  ];
  List<Message> chatLog = [
    Message(
      messageText: "Meow can I help you",
      messageType: MessageType.RECEIVED,
      time: "Oct 12, 14:00",
    ),
    Message(
      messageText: "Hello, I seem to be having some issues with "
          "changing my account",
      messageType: MessageType.SENT,
      time: "Oct 12, 14:30",
    ),
    Message(
      messageText: "Thanks for your patience, "
          "I've fixed your issue and everything is working",
      messageType: MessageType.RECEIVED,
      time: "Oct 12, 15:45",
    ),
    Message(
      messageText: "Puuurfect, Thanks so much!",
      messageType: MessageType.SENT,
      time: "Oct 13, 09:00",
    ),
    Message(
      messageText: "You're Welcome!",
      messageType: MessageType.RECEIVED,
      time: "Oct 13, 09:30",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }
    Widget appBar = Container(
      alignment: Alignment.center,
      decoration: CurvedShadowDecoration.getDecoration(isDark: isDark),
      child: ThemeAppBar.appBar(
        context,
        title: "Live Chat",
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(55)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: COLORS.GREEN,
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: 35,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ThemeIcon.ARROW,
                  color: COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ),
        ),
        trailing: ClipOval(
          child: Image.asset(Images.chat_cat),
        ),
      ),
    );

    Widget msgBox() {
      return Container(
        width: SizeConfig.screenWidth * 0.9,
        margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
        child: InputField(
          focusNode: this.msgBoxFocusNode,
          controller: this.msgBoxController,
          hintText: "Say something...",
          suffix: Container(
            height: 25,
            width: 25,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: COLORS.GREEN,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                Message newMsg = Message(
                  messageText: msgBoxController.text,
                  messageType: MessageType.SENT,
                  time: "now",
                );
                Message newMsgReceived = Message(
                  messageText: automatedReplies[Random().nextInt(
                    automatedReplies.length,
                  )],
                  messageType: MessageType.RECEIVED,
                  time: "now",
                );
                if (msgBoxController.text.trim().isNotEmpty) {
                  setState(() {
                    chatLog.add(newMsg);
                    msgBoxController.clear();
                  });
                  new Timer(
                    Duration(milliseconds: 1000),
                    () => setState(() => chatLog.add(newMsgReceived)),
                  );
                }
                msgBoxFocusNode.unfocus();
              },
              child: SvgPicture.asset(ThemeIcon.SELECT, color: COLORS.WHITE),
            ),
          ),
        ),
      );
    }

    List<Widget> getMessages() {
      return chatLog.map((e) => Msg(msg: e, isDark: isDark)).toList();
    }

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Column(
          children: [
            appBar,
            SizedBox(height: SizeConfig.screenWidth * 0.05),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: getMessages(),
                ),
              ),
            ),
            msgBox(),
          ],
        ),
      ),
    );
  }
}

enum MessageType {
  SENT,
  RECEIVED,
}

class Message {
  final String messageText;
  final MessageType messageType;
  final String time;

  Message({
    @required this.messageText,
    @required this.messageType,
    @required this.time,
  });
}

class Msg extends StatefulWidget {
  final Message msg;
  final bool isDark;

  const Msg({
    Key key,
    @required this.msg,
    @required this.isDark,
  }) : super(key: key);

  @override
  _MsgState createState() => _MsgState();
}

class _MsgState extends State<Msg> {
  bool showTimeStamp = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color txtColor;
    if (widget.msg.messageType == MessageType.SENT) {
      bgColor = COLORS.GREEN;
      txtColor = COLORS.WHITE;
    } else {
      bgColor = widget.isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY;
      txtColor = COLORS.MEDIUM_DARK_GREY;
    }
    TextStyle txtStyle = Theme.of(context).textTheme.subtitle1.copyWith(
          color: txtColor,
          fontWeight: FontWeight.w400,
        );
    return GestureDetector(
      onTap: () {
        setState(() => showTimeStamp = !showTimeStamp);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          /*
          * To create a block of size, which is consumed by positioned
          * widget below block is required to acquire space
          * this is to keep exact space between multiple messages
          * this is not ideal way but WIP
          */
          AnimatedOpacity(
            opacity: 0,
            duration: Duration(milliseconds: 0),
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: SizeConfig.screenWidth * 0.9,
                margin: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
                padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: bgColor,
                ),
                child: Text(widget.msg.messageText, style: txtStyle),
              ),
            ),
          ),
          /* timestamp */
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacity(
              opacity: showTimeStamp ? 1 : 0,
              duration: Duration(milliseconds: 500),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                ),
                alignment: Alignment.center,
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height * 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(ThemeIcon.CLOCK,
                        color: COLORS.MEDIUM_GREY),
                    Text(
                      widget.msg.time,
                      style: TextStyle(color: COLORS.MEDIUM_GREY),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /* msg content */
          AnimatedPositioned(
            // curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 500),
            left: showTimeStamp
                ? -(AppBar().preferredSize.height * 1.5)
                : SizeConfig.screenWidth * 0.025,
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: SizeConfig.screenWidth * 0.9,
                margin: EdgeInsets.all(SizeConfig.screenWidth * 0.025),
                padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: bgColor,
                ),
                child: Text(widget.msg.messageText, style: txtStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
