import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/store/blocs/store_events.dart';
import 'package:framework/store/blocs/store_item_map_state.dart';

class StoreItemMapBloc extends Bloc<StoreEvents, StoreItemMapState> {
  StoreItemMapBloc() : super(const StoreItemMapState()) {
    on<ListInitialized>(_onInitialized);
    on<ItemCounterIncrement>(_onItemCounterIncrement);
    on<ItemCounterDecrement>(_onItemCounterDecrement);
    on<ItemCounterReset>(_onItemCounterReset);
    on<ResetAllCounters>(_onResetAllCounters);
  }

  void _onInitialized(ListInitialized event, Emitter<StoreItemMapState> emit) {
    emit(state.copyWith(map: event.map));
  }

  void _onItemCounterIncrement(
      ItemCounterIncrement event, Emitter<StoreItemMapState> emit) {
    final Map<String, int> _map = state.map!;
    final int _currentCounterValue = _map[event.itemName]!;
    _map[event.itemName] = _currentCounterValue + 1;
    emit(state.copyWith(map: _map));
  }

  void _onItemCounterDecrement(
      ItemCounterDecrement event, Emitter<StoreItemMapState> emit) {
    final Map<String, int> _map = state.map!;
    final int _currentCounterValue = _map[event.itemName]!;
    //Preventing negative items
    if (_currentCounterValue > 0) {
      _map[event.itemName] = _currentCounterValue - 1;
      emit(state.copyWith(map: _map));
    }
  }

  void _onItemCounterReset(
      ItemCounterReset event, Emitter<StoreItemMapState> emit) {
    final Map<String, int> _map = state.map!;
    _map[event.itemName] = 0;
    emit(state.copyWith(map: _map));
  }

  void _onResetAllCounters(
      ResetAllCounters event, Emitter<StoreItemMapState> emit) {
    final Map<String, int> _map = state.map!;
    for (var key in _map.keys) {
      _map[key] = 0;
    }
    emit(state.copyWith(map: _map));
  }
}
