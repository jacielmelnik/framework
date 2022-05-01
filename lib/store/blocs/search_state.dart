class SearchState {
  const SearchState({
    this.searchText = "",
  });

  final String searchText;

  SearchState copyWith({String searchText = ""}) {
    SearchState _state = SearchState(searchText: searchText);
    return _state;
  }
}
