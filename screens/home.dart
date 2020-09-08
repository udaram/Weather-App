import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/HomeWideget.dart';

class Home extends StatefulWidget {
  final LocationCoordinates coordinate;
  final state;
  Home({this.coordinate,this.state=0});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex=widget.state;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: HomeWidget(
        coordinate: widget.coordinate,
        selectedIndex: _selectedIndex,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.album),
            title: Text('Current'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer),
            title: Text('Hourly'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Daily'),
          ),
        ],
        //currentIndex: _selectedIndex,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap:(index){
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder:(context)=>Home(
                coordinate: widget.coordinate,
                state: index,
              ),
            ));
          });
        },
      ),
    );
  }
}