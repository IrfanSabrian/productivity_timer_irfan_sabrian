// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:productivity_timer_irfan_sabrian/settings.dart';
import 'package:productivity_timer_irfan_sabrian/timer.dart';
import 'package:productivity_timer_irfan_sabrian/timermodel.dart';
import 'package:productivity_timer_irfan_sabrian/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'PRODUCTIVE THEME',
        theme: theme,
        darkTheme: darkTheme,
        home: const TimerHomepage(),
      ),
    );
  }
}

class TimerHomepage extends StatefulWidget {
  const TimerHomepage({
    super.key,
  });

  @override
  State<TimerHomepage> createState() => _TimerHomepageState();
}

class _TimerHomepageState extends State<TimerHomepage> {
  final double defaultPadding = 5.0;

  final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];

  final String SETTINGS = 'Settings';

  String buttonText = 'Start';

  CountDownTimer countDownTimer = CountDownTimer();

  @override
  void initState() {
    super.initState();

    menuItems.add(
      PopupMenuItem(
        value: SETTINGS,
        child: const Text('Settings'),
      ),
    );
    menuItems.add(
      const PopupMenuItem(
        value: 'Switch Theme',
        child: Text('Switch Theme'),
      ),
    );
    menuItems.add(
      const PopupMenuItem(
        value: 'About',
        child: Text('About'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TimerModel timerModel = TimerModel(
      time: '00:00',
      percent: 1.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productivity Timer'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                ...menuItems,
              ];
            },
            onSelected: (s) {
              if (s == SETTINGS) {
                goToSettings(context);
              } else if (s == 'Switch Theme') {
                _switchTheme(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Colors.indigo.shade900,
                      text: 'Work',
                      onPressed: () {
                        countDownTimer.startWork();
                        setState(() {
                          buttonText = 'Pause';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Colors.indigo.shade600,
                      text: 'Short Break',
                      onPressed: () {
                        countDownTimer.startBreak(true);
                        setState(() {
                          buttonText = 'Pause';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Colors.indigo.shade300,
                      text: 'Long Break',
                      onPressed: () {
                        countDownTimer.startBreak(false);
                        setState(() {
                          buttonText = 'Pause';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
              StreamBuilder(
                initialData: '00:00',
                stream: countDownTimer.stream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  timerModel =
                      snapshot.data == '00:00' ? timerModel : snapshot.data;

                  return Expanded(
                    child: CircularPercentIndicator(
                      radius: availableWidth / 2.5,
                      lineWidth: 20,
                      percent: timerModel.percent,
                      progressColor: Colors.indigo.shade500,
                      circularStrokeCap: CircularStrokeCap.round,
                      reverse: true,
                      center: Text(
                        timerModel.time,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Colors.blue.shade800,
                      text: buttonText,
                      onPressed: () {
                        if (countDownTimer.isActive) {
                          countDownTimer.stopTimer();
                          setState(() {
                            buttonText = 'Resume';
                          });
                        } else {
                          countDownTimer.startTimer();
                          setState(() {
                            buttonText = 'Pause';
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Colors.blue.shade900,
                      text: 'Reset',
                      onPressed: () {
                        countDownTimer.reset();
                        setState(() {
                          buttonText = 'Start';
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _switchTheme(BuildContext context) {
    final adaptiveThemeMode = AdaptiveTheme.of(context).mode;
    final newThemeMode = adaptiveThemeMode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;
    AdaptiveTheme.of(context).setThemeMode(newThemeMode);
  }
}
