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

    tearDownAll(() {
      resetMocktailState();
    });
  });
}
