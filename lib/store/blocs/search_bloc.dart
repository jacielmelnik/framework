import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/store/blocs/search_events.dart';
import 'package:framework/store/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvents, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<OnChanged>(_onChanged);
  }

  void _onChanged(OnChanged event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchText: event.searchText));
  }
}
