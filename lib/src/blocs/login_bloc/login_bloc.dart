import 'package:aerolinea/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/login_bloc/bloc.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.empty()) {
    on<EmailChanged>(
        (event, emit) => {_emailChanged(event, emit, event.email)});
    on<PasswordChanged>(
        (event, emit) => {_passwordChanged(event, emit, event.password)});
    on<LoginWithCredentialsPressed>((event, emit) async =>
        {await _login(event, emit, event.email, event.password)});
  }

  EventTransformer<LoginBloc> debounce<LoginBloc>() {
    return (events, mapper) {
      final nonDebounce = events.where((event) {
        return (events is! EmailChanged && events is! PasswordChanged);
      }).debounceTime(const Duration(milliseconds: 300));

      final debounce = events.where((event) {
        return (events is EmailChanged || events is PasswordChanged);
      }).debounceTime(const Duration(milliseconds: 300));

      return nonDebounce.mergeWith([debounce]);
    };
  }

  Future<void> _emailChanged(
      loginState, Emitter<LoginState> emit, String email) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(email)));
  }

  Future<void> _passwordChanged(
      loginState, Emitter<LoginState> emit, String password) async {
    emit(state.update(isPasswordValid: Validators.isValidPass(password)));
  }

  Future<void> _login(loginState, Emitter<LoginState> emit, String email,
      String password) async {
    emit(LoginState.loading());
    try {
      _userRepository.signWithCredentials(email, password);
      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
