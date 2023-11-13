import 'package:cn1_d_wallet/app_flavor.dart';

class AppEndpoint {
  static String mainEndpoint = AppFlavor.staging.baseUrl;
  static String userEndpoint = "$mainEndpoint" + "users/";
  static String authEndpoint = "$mainEndpoint" + "auth/";
  static String balanceEndpoint = "$mainEndpoint" + "balance";
  static String transactionEndpoint = "$mainEndpoint" + "transactions/";
  static String userProfileEndpoint = "$mainEndpoint" + "profile";
  static String filesEndpoint = "$mainEndpoint" + "files";
  static String cardsDefaultEndpoint = "$mainEndpoint" + "cards";
  static String cardsEndpoint = "$mainEndpoint" + "cards/";
  static String localBankDefaultEndpoint = "$mainEndpoint" + "local-banks";
  static String localBankEndpoint = "$mainEndpoint" + "local-banks/";
  static String notificationsEndpoint = "$mainEndpoint" + "notifications";
}
