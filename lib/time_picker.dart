import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomHourPicker extends StatefulWidget {
  final DateTime? date;
  final DateTime? initDate;
  final String? title;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final double? elevation;
  final TextStyle? positiveButtonStyle;
  final TextStyle? negativeButtonStyle;
  final TextStyle? titleStyle;
  final Function(BuildContext context, TimeOfDay time)? onPositivePressed;
  final Function(BuildContext context)? onNegativePressed;

  const CustomHourPicker({
    Key? key,
    this.onPositivePressed,
    this.onNegativePressed,
    this.date,
    this.initDate,
    this.title,
    this.positiveButtonText,
    this.negativeButtonText,
    this.elevation,
    this.positiveButtonStyle,
    this.negativeButtonStyle,
    this.titleStyle,
  }) : super(key: key);

  @override
  _CustomHourPickerState createState() => _CustomHourPickerState();
}

class _CustomHourPickerState extends State<CustomHourPicker> {
  var hourValue = 12;
  var minValue = 30;
  TimeOfDay time = const TimeOfDay(hour: 0, minute: 0);
  DateTime? date;
  DateTime? initDate;

  @override
  void initState() {
    super.initState();
    date = widget.date ?? DateTime.now();
    initDate = widget.date ?? DateTime.now();

    hourValue = date?.hour ?? hourValue;
    minValue = date?.minute ?? minValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: widget.elevation ?? Theme.of(context).cardTheme.elevation,
      contentPadding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(),
          const SizedBox(height: 15),
          lineViewWidget(),
          const SizedBox(height: 10),
          buildClockNumbers(),
          const SizedBox(height: 10),
          lineViewWidget(),
          // SizedBox(height: 15),
          buildButtons()
        ],
      ),
    );
  }

  Row buildClockNumbers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          minValue: 00,
          maxValue: 23,
          zeroPad: true,
          value: hourValue,
          infiniteLoop: true,
          onChanged: (value) {
            setState(() {
              hourValue = value;
            });
          },
        ),
        const Text(
          ":",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        NumberPicker(
          minValue: 00,
          maxValue: 59,
          zeroPad: true,
          value: minValue,
          infiniteLoop: true,
          onChanged: (value) {
            setState(() {
              minValue = value;
            });
          },
        ),
      ],
    );
  }

  Text buildTitle() {
    return Text(
      widget.title ?? "Choose a time",
      textAlign: TextAlign.left,
      style: widget.titleStyle,
    );
  }

  Widget buildButtons() {
    time = TimeOfDay(hour: hourValue, minute: minValue);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.onNegativePressed != null) buildNegativeButton(),
        if (widget.onPositivePressed != null) buildPositiveButton(),
      ],
    );
  }

  GestureDetector buildPositiveButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        widget.onPositivePressed!(context, time);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 8,
          right: 5,
          bottom: 20,
        ),
        child: Text(
          widget.negativeButtonText ?? "Ok",
          style:
              widget.negativeButtonStyle ?? const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  GestureDetector buildNegativeButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onNegativePressed!(context);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 8,
          right: 5,
          bottom: 20,
        ),
        child: Text(
          widget.positiveButtonText ?? "Cancel",
          style:
              widget.negativeButtonStyle ?? const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

Widget lineViewWidget(
    {Color? color,
    double width = 2000,
    double boarder = 0,
    double height = 1,
    double bottom = 0,
    double top = 0,
    bool horizontal = true}) {
  return Container(
    margin: EdgeInsets.only(
        right: boarder, left: boarder, bottom: bottom, top: top),
    color: color ?? Colors.grey[300],
    width: horizontal ? width : 1,
    height: horizontal ? height : height,
  );
}
