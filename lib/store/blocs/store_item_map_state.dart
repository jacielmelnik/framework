class StoreItemMapState {
  const StoreItemMapState({
    this.map,
  });

  final Map<String, int>? map;

  StoreItemMapState copyWith({Map<String, int>? map}) {
    StoreItemMapState _state = StoreItemMapState(map: map ?? this.map);
    return _state;
  }
}
