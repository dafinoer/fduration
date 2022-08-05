import 'dart:math';

import 'package:flutter/foundation.dart';

class FDurationController extends ChangeNotifier {
  final dateNow = DateTime.now();
  late final DateTime todayDateTime;
  final int durationController;
  final int multiplesOfMinutes;

  FDurationController({
    required this.durationController,
    this.multiplesOfMinutes = 60,
  });

  factory FDurationController.create({int durationController = 0}) {
    int hour = 3600000;
    if (durationController > 0 && durationController < 1440) {
      hour = 60000 * durationController;
    }
    return FDurationController(durationController: hour)..onSetTodayDateTime();
  }

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

  List<int> onSetRemainTime() {
    final totalRemain = totalHourRemain;
    final int hour = currentHour;
    final hours = <int>[];
    if (totalRemain > 1) {
      hours.addAll(List.generate(totalRemain, (index) => hour + index)
          .toList(growable: false));
    } else if (totalRemain > 0) {
      hours.addAll(List.generate(totalRemain + 1, (index) => hour + index));
    } else {
      hours.add(hour);
    }
    return hours;
  }

  List<int> minutes() {
    const int minute = 60;
    final minutesValue = max(0, multiplesOfMinutes);
    final minutes = <int>[];
    int totalCurrent = 0;
    while (totalCurrent < minute) {
      minutes.add(totalCurrent);
      totalCurrent += minutesValue % 60 != 0 ? minutesValue : 60;
    }
    return minutes;
  }
}
