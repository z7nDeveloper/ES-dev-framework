import 'package:bloc/bloc.dart';

part 'navigation_rail_event.dart';
part 'navigation_rail_state.dart';

// unused
class NavigationRailBloc extends Bloc<NavigationRailEvent, NavigationRailState> {


  bool extended = false;

  NavigationRailBloc() : super(NavigationRailInitial()) {
    on<NavigationRailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NavigationRailExtended>((event, emit) {
      emit(NavigationRailExtendedState());
      extended = true;
    });

    on<NavigationRailCollapsed>((event, emit) {
      emit(NavigationRailCollapsedState());
      extended = false;
    });

    }

}
