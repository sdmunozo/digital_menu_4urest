enum Screen {
  welcome,
  home,
  searchResult,
}

extension ScreenExtension on Screen {
  String get name {
    switch (this) {
      case Screen.welcome:
        return 'WelcomeScreen';
      case Screen.home:
        return 'HomeScreen';
      case Screen.searchResult:
        return 'SearchResultScreen';
      default:
        return '';
    }
  }
}
