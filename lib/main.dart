import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/screens/Home.dart';
import 'package:weatherly/state/CityState.dart';
import 'package:weatherly/state/SettingState.dart';
import 'constants.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => CityState()),
        ChangeNotifierProvider(create: (BuildContext context) => SettingState()),
      ],
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: appName,
            home: Home(),
          ),
        ),
    );
  }
}
