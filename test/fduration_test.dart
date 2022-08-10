import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  group('Time duration test', () {
    late FDurationControllerMock fDurationControllerMock;
    late FDurationControllerStub fDurationControllerStub;
    final DateTime currentDate = DateTime.now();

    setUp(() {
      fDurationControllerMock = FDurationControllerMock();
      when(() => fDurationControllerMock.dateNow).thenReturn(
          DateTime(currentDate.year, currentDate.month, currentDate.day, 22));
      when(() => fDurationControllerMock.durationController)
          .thenReturn(3600000);
      when(() => fDurationControllerMock.todayDateTime).thenReturn(
          DateTime(currentDate.year, currentDate.month, currentDate.day));
      when(() => fDurationControllerMock.tomorrowDateTime).thenReturn(DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day + 1,
      ));
      fDurationControllerStub =
          FDurationControllerStub.create(fDurationControllerMock.dateNow);
      fDurationControllerStub.onSetTodayDateTime();
    });

    test('Test hour time', () {
      final int hour =
          (fDurationControllerMock.tomorrowDateTime.millisecondsSinceEpoch -
                  fDurationControllerMock.dateNow.millisecondsSinceEpoch) ~/
              fDurationControllerMock.durationController;
      expect(hour, 2);
    });

    test('Test ongoing time', () {
      final int onGoingTime = (fDurationControllerMock
                  .dateNow.millisecondsSinceEpoch -
              fDurationControllerMock.todayDateTime.millisecondsSinceEpoch) ~/
          fDurationControllerMock.durationController;
      expect(onGoingTime, 22);
    });

    test('Test total hours', () {
      fDurationControllerStub.setRemainTime();
      expect(fDurationControllerStub.hours.length, 2);
    });

    test('Test total minutes', () {
      fDurationControllerStub.setMinutes();
      expect(fDurationControllerStub.minutes.length, 4);
    });

    test('Test set hour time', () {
      fDurationControllerStub.setRemainTime();
      fDurationControllerStub.setMinutes();
      fDurationControllerStub.onSetHour(0);
      expect(fDurationControllerStub.value.hour, 22);
    });

    test('Test set minute time', () {
      fDurationControllerStub.setRemainTime();
      fDurationControllerStub.setMinutes();
      fDurationControllerStub.onSetMinute(1);
      expect(fDurationControllerStub.value.minute, 15);
    });

    test('Test value', () {
      fDurationControllerStub.setRemainTime();
      fDurationControllerStub.setMinutes();
      fDurationControllerStub.onSetHour(0);
      fDurationControllerStub.onSetMinute(1);

      final DateTime result = fDurationControllerStub.value;
      expect(result.hour, 22);
      expect(result.minute, 15);
    });

    test('Test on set Today date', () {
      when(() => fDurationControllerMock.todayDateTime).thenReturn(DateTime(
          fDurationControllerMock.dateNow.year,
          fDurationControllerMock.dateNow.month,
          fDurationControllerMock.dateNow.day));
      fDurationControllerMock.onSetTodayDateTime();
      verify(fDurationControllerMock.onSetTodayDateTime).called(1);

      expect(fDurationControllerMock.todayDateTime.hour, 0);
    });

    tearDownAll(() {
      resetMocktailState();
    });
  });
}
