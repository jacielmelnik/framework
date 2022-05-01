class Constants {
  static const loginRouteName = '/LOGIN';

  static const double kButtonHeight = 40;
  static const double kFixedBottonHeight = 40;

  static const double kCartItemsHeight = 40;

  static String kFirebaseTokenKey = 'firebase_token_key';
}

class AvailableLanguages {
  static AvailableLanguages ptBR = AvailableLanguages('pt');
  static AvailableLanguages enUS = AvailableLanguages('en');

  AvailableLanguages(this.value);

  final String value;
}
