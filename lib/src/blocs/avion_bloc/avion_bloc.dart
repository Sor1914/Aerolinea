import 'package:aerolinea/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:aerolinea/src/blocs/avion_bloc/bloc.dart';
import 'dart:async';
import 'package:aerolinea/src/repository/avion_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/avion.dart';
import '../../models/seat.dart';

class AvionBloc extends Bloc<AvionEvent, AvionState> {
  final AvionRepository _repository;

  AvionBloc({required AvionRepository repository})
      : _repository = repository,
        super(AvionState.empty()) {
    on<AddRegister>((event, emit) => {_createAvion(event, emit, event.avion)});
    on<EmailChanged>((event, emit) => {});
    on<UpdRegister>((event, emit) =>
        {_updateAvion(event, emit, event.avion, event.idDocumento)});
    on<AvionChange>((event, emit) async {
      await _updSeat(event, emit, event.idDocumento, event.seat)
          .whenComplete(() => emit(AvionState.change()));
      //emit(AvionState.change());
    });
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
      update, Emitter<AvionState> emit, Avion avion, String idDocumento) async {
    try {
      _repository
          .updSeatTemporal(avion: avion, idDocumento: idDocumento)
          .whenComplete(() => emit(AvionState.success()));
    } catch (_) {
      emit(AvionState.failure());
    }
  }

  Future<void> _updSeat(AvionEvent updates, Emitter<AvionState> emit,
      String idDocumento, Seato seat) async {
    try {
      await _repository.getSeat(seat: seat);
    } catch (_) {
      emit(AvionState.empty());
    }
  }
}
