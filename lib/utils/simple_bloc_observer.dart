import 'package:classic_games/utils/logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d('Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d(
        'Change: ${change.currentState.runtimeType.toString()} -> ${change.nextState.runtimeType.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d(
        'Transition: ${transition.currentState.runtimeType.toString()} -> ${transition.nextState.runtimeType.toString()}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.d('Error: $error, StackTrace: $stackTrace');
  }
}
