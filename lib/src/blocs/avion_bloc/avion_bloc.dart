import 'package:aerolinea/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/avion_bloc/bloc.dart';
import 'dart:async';
import 'package:aerolinea/src/repository/avion_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/avion.dart';

class AvionBloc extends Bloc<AvionEvent, AvionState> {
  final AvionRepository _repository;

  AvionBloc({required AvionRepository repository})
      : _repository = repository,
        super(AvionState.empty()) {
    on<AddRegister>((event, emit) => {_createAvion(event, emit, event.avion)});
    on<EmailChanged>((event, emit) => {});
  }

  Future<void> _createAvion(
      create, Emitter<AvionState> emit, Avion avion) async {
    emit(AvionState.loading());
    try {
      _repository.addAvion(avion: avion);
      emit(AvionState.success());
    } catch (_) {
      emit(AvionState.failure());
    }
  }

  Future<void> _updateAvion(
      update, Emitter<AvionState> emit, Avion avion) async {
    emit(AvionState.loading());
    try {
      _repository.updAvion(avion: avion);
      emit(AvionState.success());
    } catch (_) {
      emit(AvionState.failure());
    }
  }

  Future<void> _emailChanged(
      emailChanged, Emitter<AvionState> emit, String email) async {
    emit(state.update(isValidEmail: Validators.isValidEmail(email)));
  }
}
