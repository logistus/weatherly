import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:weatherly/state/SettingState.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEFEFF4),
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: FutureBuilder(
        future: Provider.of<SettingState>(context).temperature_unit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SettingsList(
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile(
                      title: "Temperature Unit",
                      subtitle: snapshot.data == 'm' ? 'Celcius' : 'Fahrenheit',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Temperature Unit"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text('Celcius'),
                                    value: 'm',
                                    groupValue: snapshot.data.toString(),
                                    onChanged: (String value) {
                                        Provider.of<SettingState>(context, listen: false).changeTemperatureUnit(value);
                                        Navigator.pop(context);
                                      },
                                  ),
                                  RadioListTile(
                                    title: Text('Fahrenheit'),
                                    value: 'f',
                                    groupValue: snapshot.data.toString(),
                                    onChanged: (String value) {
                                        Provider.of<SettingState>(context, listen: false).changeTemperatureUnit(value);
                                        Navigator.pop(context);
                                      },
                                  )
                                ],
                              ),
                            );
                          }
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          } else {
            return Text('Settings could not load.');
          }
        }
      ),
    );
  }
}