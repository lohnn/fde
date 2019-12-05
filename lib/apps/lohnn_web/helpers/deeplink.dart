export 'deeplink_none.dart'
    if (dart.library.io) 'deeplink_mobile.dart'
    if (dart.library.html) 'deeplink_web.dart';