import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial()) {
    on<TabBarItemTappedEvent>(_onItemTapped);
  }

  int currentIndex = 0;

  void _onItemTapped(TabBarItemTappedEvent event, Emitter<TabBarState> emit) {
    currentIndex = event.index;
    emit(TabBarItemSelectedState(index: currentIndex));
  }
}
