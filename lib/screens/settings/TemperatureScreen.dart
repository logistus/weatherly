import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/state/SettingState.dart';

class TemperatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SettingState>(context).temperature_unit,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text('Select temperature unit',
                    style: TextStyle(fontSize: 20.0)),
                ListTile(
                  title: Text('Celcius'),
                  leading: Radio(
                    value: 'm',
                    groupValue: snapshot.data.toString(),
                    onChanged: (String value) {
                      Provider.of<SettingState>(context, listen: false).changeTemperatureUnit(value);
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: Text('Fahrenheit'),
                  leading: Radio(
                    value: 'f',
                    groupValue: snapshot.data.toString(),
                    onChanged: (String value) {
                      Provider.of<SettingState>(context, listen: false).changeTemperatureUnit(value);
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('Preferences could not load.');
        }
      },
    );
  }
}
