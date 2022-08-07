import 'package:fduration/fduration_controller.dart';
import 'package:mocktail/mocktail.dart';

class FDurationControllerMock extends Mock implements FDurationController {}

class FDurationControllerStub extends FDurationController {
  FDurationControllerStub(
      {required super.durationController,
      required super.dateNow,
      super.multiplesOfMinutes});

  factory FDurationControllerStub.create(DateTime dateTime) {
    const int hour = 3600000;
    return FDurationControllerStub(
      durationController: hour,
      dateNow: dateTime,
      multiplesOfMinutes: 15,
    )..onSetTodayDateTime();
  }
}
