import 'package:flutter/material.dart';
import 'package:weatherly/screens/CityList.dart';
import 'package:weatherly/constants.dart';
import 'package:weatherly/screens/AddCity.dart';
import 'package:weatherly/screens/Settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPageIndex = 0;
  PageController _pageContoller;
  
    @override
    void initState() {
      _pageContoller = new PageController(initialPage: _selectedPageIndex);
      super.initState();
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
              backgroundColor: Color(0xFFEFEFF4),
              appBar: AppBar(
                title: Text(appName),
              ),
              body: Padding(
                padding: EdgeInsets.all(8),
                child: PageView(
                  controller: _pageContoller,
                  onPageChanged: (newPage) {
                    setState(() {
                      _selectedPageIndex = newPage;
                    });
                  },
                  children: <Widget>[
                    CityList(pageController: _pageContoller),
                    AddCity(pageController: _pageContoller),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedPageIndex,
                elevation: 15,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), title: Text("City List")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), title: Text("Add City")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), title: Text("Settings")),
                ],
                onTap: (index) {
                  if (index < 2) {
                  this._pageContoller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                  }
                },
              ),
      );
    }
  }
  
  class Provider {
}
