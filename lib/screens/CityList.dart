import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/models/City.dart';
import 'package:weatherly/state/CityState.dart';
import 'CityTile.dart';

class CityList extends StatefulWidget {
  final PageController pageController;
  CityList({Key key, this.pageController}) : super(key: key);

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  bool reload = false;
  @override
  Widget build(BuildContext context) {
    Future<List<City>> cityData = Provider.of<CityState>(context).cities;
    return FutureBuilder(
      future: cityData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<City> cities = snapshot.data ?? [];
          return cities.length > 0
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                      RaisedButton(
                        child: Text(
                          "Delete All",
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete All'),
                                content: Text('Are you sure?'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      Provider.of<CityState>(context, listen: false).deleteAll();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            }
                          );
                        },
                      ),
                      RaisedButton(
                        child: Text(
                          "Refresh All",
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            reload = true;
                          });
                        },
                      ),
                    ]),
                    Expanded(
                        child: ListView.builder(
                            itemCount: cities.length,
                            itemBuilder: (context, index) {
                              return CityTile(
                                  key: UniqueKey(), city: cities[index]);
                            }))
                  ],
                )
              : Center(
                  child: Text("No city added."),
                );
        }
        return Center(
            child: Container(
                width: 50, height: 50, child: CircularProgressIndicator()));
      },
    );
  }
}
