///Keeping all constants centralized for better access
///and human error mitigating
class Constants {
  static const loginRouteName = '/LOGIN';

  static const double kButtonHeight = 40;
  static const double kFixedBottonHeight = 40;

  static const double kCartItemsHeight = 40;
}

class AvailableLanguages {
  static AvailableLanguages ptBR = AvailableLanguages('pt');
  static AvailableLanguages enUS = AvailableLanguages('en');

  AvailableLanguages(this.value);

  final String value;
}
