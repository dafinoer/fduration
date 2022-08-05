import 'dart:math';

import 'package:fduration/fduration_controller.dart';
import 'package:mocktail/mocktail.dart';

class FDurationControllerMock extends Mock implements FDurationController {
  List<int> listOfMinute(int minuteUnit) {
    const int minute = 60;
    final minValueMinute = max(0, minuteUnit);
    final minutes = <int>[];
    int totalCurrent = 0;
    while (totalCurrent < minute) {
      minutes.add(totalCurrent);
      final multipleOfMinutes = minValueMinute % 60 != 0 ? minuteUnit : 60;
      totalCurrent += multipleOfMinutes;
    }
    return minutes;
  }

  @override
  List<int> onSetRemainTime() {
    final totalRemain = totalHourRemain;
    final int hour = currentHour;
    final hours = <int>[];
    if (totalRemain > 1) {
      hours.addAll(List.generate(totalRemain, (index) => hour + index)
          .toList(growable: false));
    } else if (totalRemain > 0) {
      hours.addAll([hour, hour + 1]);
    } else {
      hours.add(hour);
    }
    return hours;
  }
}
