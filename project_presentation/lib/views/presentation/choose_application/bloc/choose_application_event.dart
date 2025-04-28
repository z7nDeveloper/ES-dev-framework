part of 'choose_application_bloc.dart';


class ChooseApplicationEvent {}


class FocusOnOptionEvent extends ChooseApplicationEvent {
  final ApplicationOption focusedOption;

  FocusOnOptionEvent({required this.focusedOption});
}