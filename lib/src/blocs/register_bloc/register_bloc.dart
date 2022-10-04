import 'package:aerolinea/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/register_bloc/bloc.dart';
import 'dart:async';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.empty()) {
    on<Submitted>((event, emit) => {_emailChanged(event, emit, event.email)});
  }
}

EventTransformer<RegisterBloc> debounce<RegisterBloc>() {
  return (events, mapper) {
    final nonDebounce = events.where((event) {
      return (event is! FieldChanged && event is! FieldChanged);
    }).debounceTime(const Duration(milliseconds: 300));

    final debounce = events.where((event) {
      return (events is FieldChanged || events is FieldChanged);
    }).debounceTime(const Duration(milliseconds: 300));

    return nonDebounce.mergeWith([debounce]);
  };
}

Future<void> _emailChanged(
    registerState, Emitter<RegisterState> emit, String email) async {
  emit(state.update(isEmailValid: Validators.isValidEmail(email)));
}
