import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderEndpointService {
  static getStaticBaseEndpoint() {
    return {'Content-Type': 'application/json'};
  }

  static getStaticAccessTokenBaseEndpoint(SharedPreferences prefs) {
    return {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString(ShareKey.ACCESS_TOKEN)}"
    };
  }

  static getStaticRefreshTokenBaseEndpoint(SharedPreferences prefs) {
    return {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${prefs.getString(ShareKey.REFRESH_TOKEN)}"
    };
  }
}
