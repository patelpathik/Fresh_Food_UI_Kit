import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class QuantitySelector {
  static Widget quantitySelector({@required bool isDark}) {
    int selectedQuantityInd = 1;
    int selectedTypeInd = 2;
    FixedExtentScrollController _quantityController;
    FixedExtentScrollController _typeController;
    _quantityController = new FixedExtentScrollController(
      initialItem: selectedQuantityInd,
    );
    _typeController = new FixedExtentScrollController(
      initialItem: selectedTypeInd,
    );
    List<String> type = ["grams", "lbs", "heads", "packs", "punnets"];
    return Container(
      height: AppBar().preferredSize.height * 2.5,
      alignment: Alignment.center,
      child: Row(
        children: [
          /* quantity/figure */
          Expanded(
            flex: 1,
            child: Container(
              child: ListWheelScrollView.useDelegate(
                controller: _quantityController,
                onSelectedItemChanged: (value) {
                  selectedQuantityInd = value;
                },
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemExtent: 30,
                diameterRatio: 1,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 10,
                  builder: (context, index) => Text(
                    "${index + 1}",
                    style: TextStyle(
                      // color: selectedQuantityInd == index
                      //     ? COLORS.MEDIUM_GREY
                      //     : COLORS.MEDIUM_DARK_GREY,
                      color: selectedQuantityInd == index
                          ? (isDark
                              ? COLORS.MEDIUM_GREY
                              : COLORS.MEDIUM_DARK_GREY)
                          : (isDark
                              ? COLORS.MEDIUM_GREY.withOpacity(0.5)
                              : COLORS.MEDIUM_DARK_GREY.withOpacity(0.5)),
                    ),
                  ),
                ),
                useMagnifier: true,
                magnification: 1.25,
              ),
            ),
          ),
          /* measurement */
          Expanded(
            flex: 1,
            child: Container(
              child: ListWheelScrollView.useDelegate(
                controller: _typeController,
                onSelectedItemChanged: (value) {
                  selectedTypeInd = value;
                },
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemExtent: 30,
                diameterRatio: 1,
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: type.length,
                  builder: (context, index) => Text(
                    type[index],
                    style: TextStyle(
                      // color: selectedTypeInd == index
                      //     ? COLORS.MEDIUM_GREY
                      //     : COLORS.MEDIUM_DARK_GREY,
                      color: selectedTypeInd == index
                          ? (isDark
                              ? COLORS.MEDIUM_GREY
                              : COLORS.MEDIUM_DARK_GREY)
                          : (isDark
                              ? COLORS.MEDIUM_GREY.withOpacity(0.5)
                              : COLORS.MEDIUM_DARK_GREY.withOpacity(0.5)),
                    ),
                  ),
                ),
                useMagnifier: true,
                magnification: 1.25,
              ),
            ),
          ),
          /* total amount */
          Expanded(
            flex: 1,
            child: Container(
              // padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Text(
                "£0.80",
                style: TextStyle(
                  color: isDark ? COLORS.MEDIUM_GREY : COLORS.MEDIUM_DARK_GREY,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
