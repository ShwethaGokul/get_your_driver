import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int _groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _myRadioButton(
          title: "MANUAL",
          value: 0,
          onChanged: (newValue) => setState(() => _groupValue = newValue),
        ),
        _myRadioButton(
          title: "AUTOMATIC",
          value: 1,
          onChanged: (newValue) => setState(() => _groupValue = newValue),
        ),
      ],
    );
  }

  Widget _myRadioButton(
      {required String title,
      required int value,
      required ValueChanged onChanged}) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xffFF7373),
          value: value,
          groupValue: _groupValue,
          onChanged: onChanged,
        ),
        Text(title)
      ],
    );
  }
}
