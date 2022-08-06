import 'package:fduration/fduration_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  group('Time duration test', () {
    late FDurationControllerMock fDurationControllerMock;
    late FDurationController fDurationControllerObject;

    setUp(() {
      fDurationControllerMock = FDurationControllerMock();
      fDurationControllerObject =
          FDurationController.create(durationController: 60);
      final DateTime currentDate = DateTime.now();
      when(() => fDurationControllerMock.dateNow).thenReturn(
          DateTime(currentDate.year, currentDate.month, currentDate.day, 1));
      when(() => fDurationControllerMock.durationController)
          .thenReturn(3600000);
    });

    test('min today datetime test', () {
      when(() => fDurationControllerMock.todayDateTime).thenReturn(DateTime(
          fDurationControllerMock.dateNow.year,
          fDurationControllerMock.dateNow.month,
          22));

      expect(fDurationControllerMock.todayDateTime.day, 22);
    });

    test('max day datetime test', () {
      when(() => fDurationControllerMock.tomorrowDateTime).thenReturn(DateTime(
        fDurationControllerMock.dateNow.year,
        fDurationControllerMock.dateNow.month,
        5 + 1,
      ));
      expect(fDurationControllerMock.tomorrowDateTime.day, 6);
    });

    test('total remain test', () {
      when(() => fDurationControllerMock.dateNow).thenReturn(DateTime(
        fDurationControllerMock.dateNow.year,
        fDurationControllerMock.dateNow.month,
        fDurationControllerMock.dateNow.day,
        22,
      ));
      when(() => fDurationControllerMock.tomorrowDateTime).thenReturn(DateTime(
        fDurationControllerMock.dateNow.year,
        fDurationControllerMock.dateNow.month,
        fDurationControllerMock.dateNow.day + 1,
      ));
      final int result =
          (fDurationControllerMock.tomorrowDateTime.millisecondsSinceEpoch -
                  fDurationControllerMock.dateNow.millisecondsSinceEpoch) ~/
              fDurationControllerMock.durationController;

      expect(result, 2);
    });

    test('set real remind time test', () {
      final List<int> result = fDurationControllerObject.onSetRemainTime();
      expect(result.length, 2);
      expect(result, <int>[22, 23]);
    });

    test('Test remind time test with mock', () {
      when(() => fDurationControllerMock.totalHourRemain).thenReturn(0);
      when(() => fDurationControllerMock.currentHour).thenReturn(23);
      expect(fDurationControllerMock.onSetRemainTime().length, 1);

      when(() => fDurationControllerMock.totalHourRemain).thenReturn(0);
      expect(fDurationControllerMock.onSetRemainTime().length, 1);
      expect(fDurationControllerMock.onSetRemainTime(), <int>[23]);
      verify(fDurationControllerMock.onSetRemainTime).called(3);
    });

    test('Test multiples of minute', () {
      final List<int> resultMax = fDurationControllerMock.listOfMinute(60);
      final List<int> resultMin = fDurationControllerMock.listOfMinute(0);
      final List<int> result15minutes = fDurationControllerMock.listOfMinute(15);
      final List<int> resultMinus = fDurationControllerMock.listOfMinute(-20);
      expect(resultMax.length, 1);
      expect(resultMin.length, 1);
      expect(result15minutes.length, 4);
      expect(resultMinus.length, 1);
    });

    tearDownAll(() {
      resetMocktailState();
    });
  });
}
