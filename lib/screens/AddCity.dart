import 'package:flutter/material.dart';
import 'package:weatherly/models/City.dart';
import 'package:weatherly/services/WeatherService.dart';
import 'package:weatherly/state/CityState.dart';
import 'package:provider/provider.dart';

class AddCity extends StatefulWidget {
  final PageController pageController;
  AddCity({Key key, this.pageController}) : super(key: key);

  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final _formKey = GlobalKey<FormState>();
  final _cityNameController = TextEditingController();
  String _cityName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              validator: (val) {
                if (val.isEmpty || val.trim() == '') {
                  return 'Please enter a city name';
                }
                return null;
              },
              onSaved: (val) {
                setState(() {
                  _cityName = val;
                });
              },
              controller: _cityNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'City Name',
                icon: Icon(Icons.location_city),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200], width: 2.0)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400], width: 2.0)),
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Add City',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  WeatherService().checkCity(this._cityName).then((result) {
                    if (result) {
                      Provider.of<CityState>(context, listen: false)
                          .add(City(null, _cityName));
                      FocusScope.of(context).unfocus();
                      widget.pageController.animateTo(0, // city list page
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Not Found'),
                            content: Text('City ' + this._cityName + ' not found'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                      );
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
