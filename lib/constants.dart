class Constants {
  static const loginRouteName = '/LOGIN';
}

class AvailableLanguages {
  static AvailableLanguages ptBR = AvailableLanguages('pt');
  static AvailableLanguages enUS = AvailableLanguages('en');

  AvailableLanguages(this.value);

  final String value;
}
