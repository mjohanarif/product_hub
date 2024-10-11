import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)', name: 'BLOC');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      'onError(${bloc.runtimeType}, $error, $stackTrace)',
      name: 'BLOC',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log(
      'onEvent(${bloc.runtimeType}, Event: ${event.runtimeType})',
      name: 'BLOC',
    );
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log(
      'onEventTransition(${bloc.runtimeType}, Transition: { Event: ${transition.event},\nCurrentState: ${transition.currentState},\nNextState: ${transition.nextState} })',
      name: 'BLOC',
    );
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log(
      'onClose(${bloc.runtimeType})',
      name: 'BLOC',
    );
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log(
      'onCreate(${bloc.runtimeType})',
      name: 'BLOC',
    );
    super.onCreate(bloc);
  }
}
