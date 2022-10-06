import 'package:aerolinea/src/models/usuario.dart';
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
    on<Validate>((event, emit) => {
          _validate(event, emit, event.email, event.password, event.number,
              event.code, event.number2, event.code2, event.pasaport)
        });
    on<Register>((event, emit) => {
          (event, emit) async => {
                await _register(
                    event, emit, event.email, event.password, event.usuario)
              }
        });
  }

  EventTransformer<RegisterBloc> debounce<RegisterBloc>() {
    return (events, mapper) {
      final nonDebounce = events.where((event) {
        return (event is! EmailChanged && event is! PasswordChanged);
      }).debounceTime(const Duration(milliseconds: 300));

      final debounce = events.where((event) {
        return (events is EmailChanged || events is PasswordChanged);
      }).debounceTime(const Duration(milliseconds: 300));

      return nonDebounce.mergeWith([debounce]);
    };
  }

  Future<void> _validate(
      registerState,
      Emitter<RegisterState> emit,
      String email,
      String pass,
      String number,
      String code,
      String number2,
      String code2,
      String pasaport) async {
    emit(state.update(
        isCodeValid: Validators.isValidCodeCountry(code),
        isCode2Valid: Validators.isValidCodeCountry(code2),
        isEmailValid: Validators.isValidEmail(email),
        isNumber2Valid: Validators.isValidPhone(number2),
        isNumberValid: Validators.isValidPhone(number),
        isPasswordValid: Validators.isValidPass(pass),
        isPasaportValid: Validators.isValidPasaport(pasaport)));
  }

  Future<void> _register(registerState, Emitter<RegisterState> emit,
      String email, String password, Usuario usuario) async {
    emit(RegisterState.loading());
    try {
      await _userRepository.register(email, password);
      emit(RegisterState.success());
      if (state.isSuccess) {
        await _userRepository.addUsuario(
            usuario, "Autocreación", DateTime.now().toString(), "", "", "1");
      }
    } catch (_) {
      emit(RegisterState.failure());
    }
  }
}
