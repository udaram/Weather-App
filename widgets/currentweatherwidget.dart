import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherData data;
  final address;
  CurrentWeatherWidget({@required this.data,@required this.address});
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Image.asset('assets/icons/${data.icon}.png'),
          Text(data.description.toUpperCase(),style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),),
          SizedBox(height: 10,),
          Text('${data.temperature.toString()} °C',style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),),
          Text('City: ${data.city}'),
          SizedBox(height: 5,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on,color: Colors.blue,),
                Text(address,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),),
              ],
            ),
          ),

          Divider(
            color: Colors.blue,
            height: 20,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.invert_colors),
                  Text("Humidity ${data.humidity.toString()} %",
                    style: TextStyle(
                      fontSize: 10,
                    ),),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.visibility),
                  Text("Visibility ${data.visibility.toString()} KM",style: TextStyle(
                    fontSize: 10,
                  ),),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.wrap_text),
                  Text("Wind ${data.windSpeed.toString()} m/s",style: TextStyle(
                    fontSize: 10,
                  ),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
