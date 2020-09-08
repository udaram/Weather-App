import 'package:flutter/material.dart';
import 'package:weather_app/screens/home.dart';
import 'package:weather_app/services/getlocation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  //final position = {};
  void _getPosition() async{
    Location l = Location();
    var position = await l.getLocation();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context)=>Home(
        coordinate: position,
      )
    ));
  }
  DateTime current;
  Future<bool> popped(){
    DateTime now = DateTime.now();
    if(current==null||now.difference(current)>Duration(seconds: 2)){
      current=now;
      Fluttertoast.showToast(
        msg: 'Press back again to exit',
        toastLength: Toast.LENGTH_SHORT,
      );
      return Future.value(false);
    }else{
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>popped(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.location_on,size: 50,color: Colors.blue[400],),
              SizedBox(height: 10,),
              RaisedButton(
                onPressed:(){
                  _getPosition();
                } ,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  child: const Text('Locate Yourself', style: TextStyle(fontSize: 15)),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
