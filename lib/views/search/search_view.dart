import 'package:flutter/material.dart';
import 'package:fresh_food/responsive/orientation_layout.dart';
import 'package:fresh_food/responsive/screen_type_layout.dart';
import 'package:fresh_food/views/search/search_view_mobile.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  static const TAG = "/search";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: SearchMobilePortrait(),
      ),
    );
  }
}
