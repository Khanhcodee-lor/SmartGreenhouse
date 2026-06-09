import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/greenhouse_entity.dart';
import '../../domain/usecases/watch_greenhouse.dart';
import '../../domain/usecases/update_control.dart';

class GreenhouseProvider extends ChangeNotifier {
  final WatchGreenhouse _watchGreenhouse;
  final UpdateControl _updateControl;

  GreenhouseEntity? _greenhouse;
  bool _isLoading = true;
  String? _error;
  StreamSubscription<GreenhouseEntity>? _subscription;

  GreenhouseProvider({
    required WatchGreenhouse watchGreenhouse,
    required UpdateControl updateControl,
  }) : _watchGreenhouse = watchGreenhouse,
       _updateControl = updateControl;

  // --------------- Getters ---------------

  GreenhouseEntity? get greenhouse => _greenhouse;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasData => _greenhouse != null;

  // --------------- Realtime Subscription ---------------

  void startWatching() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _subscription?.cancel();
    _subscription = _watchGreenhouse().listen(
      (entity) {
        _greenhouse = entity;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // --------------- Control Actions ---------------

  Future<void> toggleManualMode(bool value) async {
    try {
      await _updateControl({'manualMode': value});
    } catch (e) {
      _error = 'Failed to update manual mode: $e';
      notifyListeners();
    }
  }

  Future<void> togglePump(bool value) async {
    try {
      await _updateControl({'pump': value});
    } catch (e) {
      _error = 'Failed to update pump: $e';
      notifyListeners();
    }
  }

  Future<void> toggleFan(bool value) async {
    try {
      await _updateControl({'fan': value});
    } catch (e) {
      _error = 'Failed to update fan: $e';
      notifyListeners();
    }
  }

  Future<void> toggleLight(bool value) async {
    try {
      await _updateControl({'light': value});
    } catch (e) {
      _error = 'Failed to update light: $e';
      notifyListeners();
    }
  }

  Future<void> resetWater() async {
    try {
      await _updateControl({'resetWater': true});
    } catch (e) {
      _error = 'Failed to reset water counter: $e';
      notifyListeners();
    }
  }

  Future<void> updateThresholds({
    required int soilThreshold,
    required int tempThreshold,
    required int humidityThreshold,
  }) async {
    try {
      await _updateControl({
        'soilThreshold': soilThreshold,
        'tempThreshold': tempThreshold,
        'humidityThreshold': humidityThreshold,
      });
    } catch (e) {
      _error = 'Failed to update thresholds: $e';
      notifyListeners();
      rethrow;
    }
  }

  // --------------- Lifecycle ---------------

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
