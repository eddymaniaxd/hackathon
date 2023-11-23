import 'package:flutter/material.dart';

class CheckboxAlerta extends StatefulWidget {
  const CheckboxAlerta({super.key});

  @override
  State<CheckboxAlerta> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxAlerta> {
  bool? isCheckedPolicia = false;
  bool? isCheckedBomberos = false;
  bool? isCheckedTrancas = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Checkbox(
              value: isCheckedPolicia,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedPolicia = value;
                });
              },
            ),
            const Text('Policia'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isCheckedBomberos,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedBomberos = value;
                });
              },
            ),
            const Text('Bomberos'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: isCheckedTrancas,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedTrancas = value;
                });
              },
            ),
            const Text('Trancas'),
          ],
        ),
      ],
    );
  }
}