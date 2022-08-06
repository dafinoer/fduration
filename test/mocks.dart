import 'dart:math';

import 'package:fduration/fduration_controller.dart';
import 'package:mocktail/mocktail.dart';

class FDurationControllerMock extends Mock implements FDurationController {
  int hour = 0;
  int minute = 0;

  List<int> listOfMinute(int minuteUnit) {
    const int minute = 60;
    final int minValueMinute = max(0, minuteUnit);
    final List<int> minutes = <int>[];
    int totalCurrent = 0;
    while (totalCurrent < minute) {
      minutes.add(totalCurrent);
      final int multipleOfMinutes = minValueMinute % 60 != 0 ? minuteUnit : 60;
      totalCurrent += multipleOfMinutes;
    }
    return minutes;
  }

  @override
  void onSetHour(int index) {
    hour = hours[index];
  }

  @override
  void onSetMinute(int index) {
    minute = minutes[index];
  }

  @override
  DateTime get value =>
      DateTime(dateNow.year, dateNow.month, dateNow.day, hour, minute);

  @override
  List<int> onSetRemainTime() {
    final int totalRemain = totalHourRemain;
    final int hour = currentHour;
    final List<int> hours = <int>[];
    if (totalRemain > 1) {
      hours.addAll(List<int>.generate(totalRemain, (int index) => hour + index)
          .toList(growable: false));
    } else if (totalRemain > 0) {
      hours.addAll(<int>[hour, hour + 1]);
    } else {
      hours.add(hour);
    }
    return hours;
  }
}
