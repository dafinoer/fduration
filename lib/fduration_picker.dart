import 'package:fduration/extensions/number_extension.dart';
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
        const Spacer(),
        Expanded(
            child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: context
              .select<FDurationController, List<int>>(
                  (FDurationController value) => value.hours)
              .length,
          itemBuilder: (BuildContext context, int index) => Center(
              child: Text(
            context.read<FDurationController>().hours[index].timeToString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          )),
          onPageChanged: (int value) =>
              context.read<FDurationController>().onSetHour(value),
        )),
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: context
                .select<FDurationController, List<int>>(
                    (FDurationController controller) => controller.minutes)
                .length,
            itemBuilder: (BuildContext context, int index) => Center(
                child: Text(
              context.read<FDurationController>().minutes[index].timeToString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            )),
            onPageChanged: (int value) =>
                context.read<FDurationController>().onSetMinute(value),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
