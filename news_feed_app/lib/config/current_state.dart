import 'package:flutter/material.dart';

enum StateAs {
  error,
  loading,
  ok,
}

class CurrentState {
  StateAs _state;
  final void Function() _updater;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CurrentState(this._updater, {StateAs starting = StateAs.ok})
      : _state = starting;

  CurrentState.asLoading(this._updater) : _state = StateAs.loading;

  //**
  //
  //
  //**/
  void update() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updater();
    });
  }

  void asOk() {
    _errorMessage = null;
    _state = StateAs.ok;
    update();
  }

  void asError(String message) {
    _errorMessage = message;
    _state = StateAs.error;
    update();
  }

  void asLoading() {
    _errorMessage = null;
    _state = StateAs.loading;
    update();
  }

  void refresh(StateAs state) {
    _state = state;
    update();
  }

  bool get isError => _state == StateAs.error;
  bool get isLoading => _state == StateAs.loading;
  bool get isOk => _state == StateAs.ok;
}
