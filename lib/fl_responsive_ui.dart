library fl_responsive_ui;

import 'package:flutter/material.dart';

class FlResponsiveUI {
  factory FlResponsiveUI() {
    return _singleton;
  }

  static final FlResponsiveUI _singleton = FlResponsiveUI._internal();

  FlResponsiveUI._internal() {
    print("Instance created FlResponsiveUI");
  }

  //current Screen Size and Proportional according to device
  double? _currentScreenHeight;
  double? _currentScreenWidth;

  double? get screenHeight => _currentScreenHeight;
  double? get screenWidth => _currentScreenWidth;

  final double _referenceScreenHeight = 740;
  final double _referenceScreenWidth = 360;

  void updateScreenDimension({double? width, double? height}) {
    _currentScreenWidth = (width != null) ? width : _currentScreenWidth;
    _currentScreenHeight = (height != null) ? height : _currentScreenHeight;
  }

  double? getProportionalHeight({double? height}) {
    if (_currentScreenHeight == null) return height;
    return _currentScreenHeight! * height! / _referenceScreenHeight;
  }

  double? getProportionalWidth({double? width}) {
    if (_currentScreenWidth == null) return width;
    var w = _currentScreenWidth! * width! / _referenceScreenWidth;
    return w.ceilToDouble();
  }

  //device orientation
  Orientation getDeviceOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  //regular TextStyle
  TextStyle getTextStyleRegular(
      {String fontName = 'Roboto-Regular',
        int fontSize = 12,
        Color? color,
        bool isChangeAccordingToDeviceSize = true,
        double? characterSpacing,
        double? lineSpacing}) {
    double finalFontSize = fontSize.toDouble();
    if (isChangeAccordingToDeviceSize && this._currentScreenWidth != null) {
      finalFontSize =
          (finalFontSize * _currentScreenWidth!) / _referenceScreenWidth;
    }
    if (characterSpacing != null) {
      return TextStyle(
          fontSize: finalFontSize,
          fontFamily: fontName,
          color: color,
          letterSpacing: characterSpacing);
    } else if (lineSpacing != null) {
      return TextStyle(
          fontSize: finalFontSize,
          fontFamily: fontName,
          color: color,
          height: lineSpacing);
    }
    return TextStyle(
        fontSize: finalFontSize, fontFamily: fontName, color: color);
  }
}

