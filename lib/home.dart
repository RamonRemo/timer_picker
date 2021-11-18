import 'package:flutter/material.dart';
import 'package:time_picker/time_picker.dart';

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
    Function(TimeOfDay time) onAccept = (time) {
      textFieldController.text = time.toString();
      print(time);
    };

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
          decoration: InputDecoration(
            hintText: 'DateTime',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  buildCustomTimer(BuildContext context) {
    return CustomHourPicker(
      onPositivePressed: (context, time) {
        textFieldController.text = time.toString();
        print(time);
      },
      onNegativePressed: (context) {
        print('cancel');
      },
    );
  }

  Padding buildButton(BuildContext context) {
    Function(TimeOfDay time) onAccept = (time) {
      textFieldController.text = time.toString();
      print(time);
    };

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
