// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double workTime = 25.0;
  double shortBreak = 5.0;
  double longBreak = 20.0;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  final double minValue = 1;
  final double maxValue = 180;

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    readSettings();
  }

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      workTime = (prefs.getInt(WORKTIME) ?? 25).toDouble();
      shortBreak = (prefs.getInt(SHORTBREAK) ?? 5).toDouble();
      longBreak = (prefs.getInt(LONGBREAK) ?? 20).toDouble();
    });
  }

  void updateSettings(String key, double value) {
    setState(() {
      switch (key) {
        case WORKTIME:
          workTime = value;
          prefs.setInt(WORKTIME, workTime.toInt());
          break;
        case SHORTBREAK:
          shortBreak = value;
          prefs.setInt(SHORTBREAK, shortBreak.toInt());
          break;
        case LONGBREAK:
          longBreak = value;
          prefs.setInt(LONGBREAK, longBreak.toInt());
          break;
      }
    });
  }

  void resetSettings() {
    prefs.setInt(WORKTIME, 25);
    prefs.setInt(SHORTBREAK, 5);
    prefs.setInt(LONGBREAK, 20);
    setState(() {
      workTime = 25.0;
      shortBreak = 5.0;
      longBreak = 20.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 24,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSettingRow(
              'Work',
              workTime,
              WORKTIME,
              textStyle,
            ),
            const SizedBox(height: 40),
            buildSettingRow(
              'Short',
              shortBreak,
              SHORTBREAK,
              textStyle,
            ),
            const SizedBox(height: 40),
            buildSettingRow(
              'Long',
              longBreak,
              LONGBREAK,
              textStyle,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => resetSettings(),
              child: Text(
                'Reset',
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingRow(
    String label,
    double value,
    String settingKey,
    TextStyle textStyle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: textStyle),
            Text('${value.toInt()} min', style: textStyle),
          ],
        ),
        CupertinoSlider(
          value: value,
          min: minValue,
          max: maxValue,
          onChanged: (newValue) {
            updateSettings(settingKey, newValue);
          },
        ),
      ],
    );
  }
}
