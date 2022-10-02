//import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/authentication bloc/bloc.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(Uninitialized()) {
    on<AppStarted>(_appStartedTostate);
    on<LoggedIn>(_loggedInToState);
    on<LoggedOut>(_loggedOutToState);
  }

  Future<void> _appStartedTostate(
      appStarted, Emitter<AuthenticationState> emit) async {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getUser();
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _loggedInToState(
      loggedIn, Emitter<AuthenticationState> emit) async {
    emit(Authenticated(await _userRepository.getUser()));
  }

  Future<void> _loggedOutToState(
      loggedOut, Emitter<AuthenticationState> emit) async {
    emit(Unauthenticated());
    _userRepository.signOut();
  }
}
