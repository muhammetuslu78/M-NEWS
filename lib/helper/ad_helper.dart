import 'dart:io';

class AdHelper {
  static String bannerAdUnitId() {
    if (Platform.isAndroid) {
      print('android');
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      print('android degil');
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }

  static String interstitialAdUnitId() {
    if (Platform.isAndroid) {
      print('android');
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      print('android degil');
      return "ca-app-pub-3940256099942544/6300978111";
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }
}
