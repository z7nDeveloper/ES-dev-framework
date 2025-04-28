import 'package:bloc/bloc.dart';
import 'package:project_presentation/views/presentation/choose_application/models/application_option.dart';
import 'package:meta/meta.dart';

part 'choose_application_event.dart';
part 'choose_application_state.dart';

class ChooseApplicationBloc extends Bloc<ChooseApplicationEvent, ChooseApplicationState> {

  ApplicationOption? focusedOption;
  ChooseApplicationBloc() : super(ChooseApplicationInitial()) {
    on<ChooseApplicationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FocusOnOptionEvent>((event, emit) {
      focusedOption = event.focusedOption;
      emit(OptionFocusedChangedState());
    });
  }
}
