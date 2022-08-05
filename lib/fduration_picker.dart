import 'package:fduration/fduration_controller.dart';
import 'package:flutter/widgets.dart';

class FDurationPicker extends StatefulWidget {
  const FDurationPicker({
    Key? key,
    required this.durationMinute,
    this.inFormat12Hour = false,
  }) : super(key: key);

  final int durationMinute;
  final bool inFormat12Hour;

  @override
  State<FDurationPicker> createState() => _FDurationPickerState();
}

class _FDurationPickerState extends State<FDurationPicker> {
  late final FDurationController _fDurationController;

  @override
  void initState() {
    super.initState();
    _fDurationController = FDurationController(durationController: 120);
  }

  @override
  void dispose() {
    _fDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
