import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';

class AdsServices {
  static bool _testMode = true;

  ///
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3733728720930348~8450921925";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (_testMode == true) {
      return AdmobBanner.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-3733728720930348/9260961787";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (_testMode == true) {
      return AdmobInterstitial.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-3733728720930348/7548903790";
    } else if (Platform.isIOS) {
      return "--------------------------------------";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (_testMode == true) {
      return "ca-app-pub-3733728720930348/8231430075";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-3733728720930348/8231430075";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}