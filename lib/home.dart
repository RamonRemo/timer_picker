import 'package:flutter/material.dart';
import 'package:time_pickerr/time_pickerr.dart';


class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Picker"),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            buildTextField(),
            buildButton(context),
            buildCustomTimer(context)
          ],
        ),
      ),
    );
  }

  Padding buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: TextField(
          controller: textFieldController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'DateTime',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  buildCustomTimer(BuildContext context) {
    return CustomHourPicker(
      elevation: 2,
      onPositivePressed: (context, time) {
        textFieldController.text = time.toString();
      },
      onNegativePressed: (context) {
      },
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: buildButtonName(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return buildCustomTimer(context);
            },
          );
        },
      ),
    );
  }

  SizedBox buildButtonName() {
    return const SizedBox(
      child: Center(child: Text("Show Time Picker")),
      height: 30,
      width: 130,
    );
  }
}
