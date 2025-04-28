import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



class VisibilityHoverCubit extends Cubit<bool> {
  VisibilityHoverCubit({required bool initialVisibility}) : super(initialVisibility);


  changeVisibility(bool visibility) {
    emit(visibility);
  }
}
