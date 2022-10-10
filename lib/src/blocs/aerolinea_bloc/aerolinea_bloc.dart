import 'package:aerolinea/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/aerolinea_bloc/bloc.dart';
import 'dart:async';
import 'package:aerolinea/src/repository/aeroline_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/aerolinea.dart';

class AerolineaBloc extends Bloc<AerolineaEvent, AerolineaState> {
  final AerolineaRepository _repository;

  AerolineaBloc({required AerolineaRepository repository})
      : _repository = repository,
        super(AerolineaState.empty()) {
    on<AddRegister>(
        (event, emit) => {_createAerolinea(event, emit, event.aerolinea)});
    on<EmailChanged>((event, emit) => {});
  }

  Future<void> _createAerolinea(
      create, Emitter<AerolineaState> emit, Aerolinea aerolinea) async {
    emit(AerolineaState.loading());
    try {
      _repository.addAerolinea(aerolinea: aerolinea);
      emit(AerolineaState.success());
    } catch (_) {
      emit(AerolineaState.failure());
    }
  }

  Future<void> _updateAerolinea(
      update, Emitter<AerolineaState> emit, Aerolinea aerolinea) async {
    emit(AerolineaState.loading());
    try {
      _repository.updAerolinea(aerolinea: aerolinea);
      emit(AerolineaState.success());
    } catch (_) {
      emit(AerolineaState.failure());
    }
  }

  Future<void> _emailChanged(
      emailChanged, Emitter<AerolineaState> emit, String email) async {
    emit(state.update(isValidEmail: Validators.isValidEmail(email)));
  }
}
