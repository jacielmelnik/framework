class Constants {
  static const loginRouteName = '/LOGIN';

  static const int kButtonHeight = 40;
  static const int kFixedBottonHeight = 40;

  static const int kCartItemsHeight = 60;
}

class AvailableLanguages {
  static AvailableLanguages ptBR = AvailableLanguages('pt');
  static AvailableLanguages enUS = AvailableLanguages('en');

  AvailableLanguages(this.value);

  final String value;
}
