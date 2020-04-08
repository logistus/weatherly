import 'package:flutter/material.dart';
import 'package:weatherly/models/City.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/services/WeatherService.dart';
import 'package:weatherly/state/CityState.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weatherly/state/SettingState.dart';

class CityTile extends StatelessWidget {
  final City city;
  CityTile({Key key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String tu;
    Provider.of<SettingState>(context).temperature_unit.then((result) {
      tu = result;
    });

    return FutureBuilder(
      future: Provider.of<SettingState>(context).temperature_unit,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: WeatherService().fetchCity(city.name, snapshot.data),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                '${snapshot.data.name}, ${snapshot.data.country}',
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Column(
                                children: <Widget>[
                                  Text(
                                    "${snapshot.data.temperature}°${tu == 'm' ? 'C' : 'F'}",
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                  FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: snapshot.data.weatherIcon
                                  ),
                                  SizedBox(height: 5.0),
                                  Text("Feels like: ${snapshot.data.feelsLike}°${tu == 'm' ? 'C' : 'F'}"),
                                ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.description,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text("Humidity: ${snapshot.data.humidity}%"),
                                    SizedBox(height: 5.0),
                                    Text("Wind Speed: ${snapshot.data.windSpeed} ${tu == 'm' ? 'km' : 'mi'}/h"),
                                    SizedBox(height: 5.0),
                                    Text("Cloud Cover: ${snapshot.data.cloudCover}%"),
                                    SizedBox(height: 5.0),
                                    Text("Visibility: ${snapshot.data.visibility} ${tu == 'm' ? 'km' : 'mi'}"),
                                  ],
                                )
                            ],
                          ),
                        ),
                        ButtonBar(
                          buttonPadding: EdgeInsets.all(0),
                          children: <Widget>[
                            FlatButton.icon(
                              icon: Icon(Icons.delete),
                              textColor: Colors.grey,
                              onPressed: () {
                                Provider.of<CityState>(context, listen: false)
                                    .delete(city.id);
                              },
                              label: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ));
              } 
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(child: CircularProgressIndicator()),
                ),
              );
            });
        } else {
          return Container();
        }
      }
    );
  }
}