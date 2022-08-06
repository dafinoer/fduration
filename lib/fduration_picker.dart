import 'package:fduration/fduration_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FDurationPickerWidget extends StatelessWidget {
  const FDurationPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: PageView.builder(
          itemCount: context
              .select<FDurationController, List<int>>(
                  (FDurationController value) => value.hours)
              .length,
          pageSnapping: false,
          itemBuilder: (BuildContext context, int index) =>
              Text('${context.read<FDurationController>().hours[index]}'),
          onPageChanged: (int value) =>
              context.read<FDurationController>().onSetHour(value),
        )),
        Expanded(
          child: PageView.builder(
            itemCount: context
                .select<FDurationController, List<int>>(
                    (FDurationController controller) => controller.minutes)
                .length,
            pageSnapping: false,
            itemBuilder: (BuildContext context, int index) =>
                Text('${context.read<FDurationController>().minutes[index]}'),
            onPageChanged: (int value) =>
                context.read<FDurationController>().onSetMinute(value),
          ),
        )
      ],
    );
  }
}
