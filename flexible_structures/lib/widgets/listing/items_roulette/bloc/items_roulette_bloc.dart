import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'items_roulette_event.dart';

abstract class ItemsMovementRouletteBloc extends Bloc<ItemsRouletteEvent, int> {
  int lastMovingDirection = 0;
  ItemsMovementRouletteBloc(super.initialState);
}

class SimpleItemsMovementRouletteBloc extends ItemsMovementRouletteBloc {

  bool isInfinite;
  SimpleItemsMovementRouletteBloc({this.isInfinite=false}) : super(0) {
    on<RouletteClickedLeftEvent>((event, emit) {

      lastMovingDirection = -1;
      if(isInfinite && state == 0) {
        emit(event.itemsLength - 1);
        return;
      }
      emit(max(state - 1, 0));
    });

    on<RouletteClickedRightEvent>((event, emit) {

      lastMovingDirection = 1;
      if(isInfinite) {

        if(state == event.itemsLength - 1) {
          emit(0);
          return;
        } else {
          emit(state + 1);
          return;
        }
      }
      int nextIndex = min(state + 1, event.itemsLength - (event.itemsAtATime  ));



      nextIndex = max(0, nextIndex);
      emit(nextIndex);
    });
  }


}

class TrackItemsMovementRouletteBloc extends ItemsMovementRouletteBloc {


  TrackItemsMovementRouletteBloc() : super(0) {

    on<RouletteClickedLeftEvent>((event, emit) {
      emit(trackMoveLeft(state, event.itemsAtATime));
    });

    on<RouletteClickedRightEvent>((event, emit) {
      emit(trackMoveRight(state, event.itemsAtATime, event));
    });

  }


  int trackMoveLeft(int trackIndex, int itemsAtATime) {

    for(int i = 0; i < itemsAtATime; i++) {
      if(trackIndex == 0) {
        break;
      }
      trackIndex--;
    }

    return trackIndex;
  }

  int trackMoveRight(int trackIndex, int itemsAtATime, RouletteClickedRightEvent event) {

    for(int i = 0; i < itemsAtATime; i++) {
      if(trackIndex >= event.itemsLength - itemsAtATime) {
        break;
      }
      trackIndex++;
    }

    return trackIndex;
  }


}
