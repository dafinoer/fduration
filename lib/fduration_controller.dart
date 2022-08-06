import 'dart:math';
import 'package:flutter/foundation.dart';

class FDurationController extends ChangeNotifier {
  final DateTime dateNow = DateTime.now();
  late final DateTime todayDateTime;
  final int durationController;
  final int multiplesOfMinutes;
  final List<int> hours = <int>[];
  final List<int> minutes = <int>[];
  int _hour = 0;
  int _minute = 0;

  FDurationController({
    required this.durationController,
    this.multiplesOfMinutes = 60,
  });

  factory FDurationController.create({int durationController = 0}) {
    int hour = 3600000;
    if (durationController > 0 && durationController < 1440) {
      hour = 60000 * durationController;
    }
    return FDurationController(durationController: hour)
      ..onSetTodayDateTime()
      ..setRemainTime()
      ..setMinutes();
  }

  void onSetHour(int index) {
    _hour = hours[index];
    notifyListeners();
  }

  void onSetMinute(int index) {
    _minute = hours[index];
    notifyListeners();
  }

  DateTime get value => DateTime(
        dateNow.year,
        dateNow.month,
        dateNow.day,
        _hour,
        _minute,
      );

  void onSetTodayDateTime() =>
      todayDateTime = DateTime(dateNow.year, dateNow.month, dateNow.day);

  DateTime get tomorrowDateTime =>
      DateTime(dateNow.year, dateNow.month, dateNow.day, 23, 59);

  int get totalHourRemain =>
      (tomorrowDateTime.millisecondsSinceEpoch -
          dateNow.millisecondsSinceEpoch) ~/
      durationController;

  int get currentHour =>
      (dateNow.millisecondsSinceEpoch - todayDateTime.millisecondsSinceEpoch) ~/
      durationController;

  void setRemainTime() {
    final int totalRemain = totalHourRemain + 1;
    final int hour = currentHour;
    if (totalRemain > 0) {
      hours.addAll(List<int>.generate(totalRemain, (int index) => hour + index)
          .toList(growable: false));
    } else {
      hours.add(hour);
    }
  }

  void setMinutes() {
    const int minute = 60;
    final int minutesValue = max(0, multiplesOfMinutes);
    int totalCurrent = 0;
    while (totalCurrent < minute) {
      minutes.add(totalCurrent);
      totalCurrent += minutesValue % 60 != 0 ? minutesValue : 60;
    }
  }
}
