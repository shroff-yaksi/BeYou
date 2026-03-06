import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ReloadImageEvent>(_onReloadImage);
  }

  void _onReloadImage(ReloadImageEvent event, Emitter<HomeState> emit) {
    emit(ReloadImageState());
  }
}
