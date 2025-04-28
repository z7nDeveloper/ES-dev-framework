part of 'items_roulette_bloc.dart';

@immutable
abstract class ItemsRouletteEvent {}

class RouletteClickedLeftEvent extends ItemsRouletteEvent {

  final int itemsAtATime;
  final int itemsLength;
  RouletteClickedLeftEvent({
    required this.itemsAtATime,
    required this.itemsLength,
});
}

class RouletteClickedRightEvent extends ItemsRouletteEvent {
  final int itemsLength;

  final int itemsAtATime;
  RouletteClickedRightEvent({
    required this.itemsLength,
    required this.itemsAtATime,
  });
}
