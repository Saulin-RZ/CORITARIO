import 'package:coritario/Style/colors.dart';
import 'package:flutter/material.dart';

// Initial text styles
const TextStyle _baseTextStyle = TextStyle(
  fontFamily: 'MartianMonoNerdFontMono',
);

// Mutable font size variables
double _lyricsFontSize = 26;
double _topNumberFontSize = 30;
double _sideNumberFontSize = 14;
double _listTitlesFontSize = 25;

// Text styles using the mutable font size variables
final TextStyle lightThemeLyricsStyle = _baseTextStyle.copyWith(
  color: myPurple,
  fontSize: _lyricsFontSize,
);

final TextStyle lightThemeTopNumberStyle = _baseTextStyle.copyWith(
  color: myGray,
  fontSize: _topNumberFontSize,
);

final TextStyle lightThemeSideNumberStyle = _baseTextStyle.copyWith(
  color: myWhite,
  fontSize: _sideNumberFontSize,
);

final TextStyle lightThemeListTittlesStyle = _baseTextStyle.copyWith(
  color: myPurple,
  fontSize: _listTitlesFontSize,
  fontStyle: FontStyle.italic,
);

const TextStyle lightThemeTextFieldFilledStyle = TextStyle(
  color: myBlue,
  // fontSize: 30,
);

const TextStyle lightThemeTextFieldEmptyStyle = TextStyle(
  color: myGray,
  // fontSize: 30,
);

// Setter functions to update font sizes
void updateLyricsFontSize(double size) {
  _lyricsFontSize = size;
}

void updateTopNumberFontSize(double size) {
  _topNumberFontSize = size;
}

void updateSideNumberFontSize(double size) {
  _sideNumberFontSize = size;
}

void updateListTitlesFontSize(double size) {
  _listTitlesFontSize = size;
}
