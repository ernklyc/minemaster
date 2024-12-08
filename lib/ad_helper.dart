import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1554217925055679/1156228678';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1554217925055679/1156228678';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}


//appid : ca-app-pub-1554217925055679~2359196376
//unitid : ca-app-pub-1554217925055679/1156228678