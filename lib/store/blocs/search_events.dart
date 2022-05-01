class SearchEvents {
  const SearchEvents();
}

class OnChanged extends SearchEvents {
  const OnChanged({required this.searchText});

  final String searchText;
}
