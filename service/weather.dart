import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/coordinates.dart';
import 'dart:convert';

//for current data
class WeatherData{
  LocationCoordinates coordinate;
  var icon;
  var description;
  var precipitation;
  var rainChance;
  var windSpeed;
  var city;
  var temperature;
  var humidity;
  var visibility;
  WeatherData({@required this.icon,@required this.description,@required this.precipitation,@required this.rainChance, @required this.windSpeed,@required this.coordinate,@required this.city,@required this.temperature,@required this.humidity,@required this.visibility});
}

class GetCurrentWeather{
  LocationCoordinates coordinate;
  WeatherData data;
  getWeather(LocationCoordinates coordinate) async{
    String url = 'https://api.weatherbit.io/v2.0/current?key=e1d17bfcc6754d4b8c9de6b2a6cdbe9d&lat=${coordinate.lat}&lon=${coordinate.lon}';
    var response = await get(url);
    var jsonData = jsonDecode(response.body)["data"][0];
    //print(jsonData);
      data=WeatherData(icon: jsonData['weather']['icon'],
      description: jsonData['weather']['description'],
      precipitation: jsonData['precip'],
      rainChance: jsonData['clouds'],
      windSpeed: jsonData['wind_spd'],
      coordinate: coordinate,
      city: jsonData['city_name'],
      temperature: jsonData['temp'],
        humidity: jsonData['rh'],
        visibility: jsonData['vis'],
    );
  }
}


//for hourly data
class HourlyData{
  var time;
  var date;
  var clouds;
  var icon;
  var description;
  var temp;
  HourlyData({@required this.time,@required this.date,@required this.clouds,@required this.icon,@required this.description,@required this.temp});
}


class GetHourlyWeather{

  //GetHourlyWeather({@required this.coordinate});
  List<HourlyData> data = [];

  getWeather(LocationCoordinates coordinate)async {
    Map months = {
      "01":"Jan",
      "02":"Feb",
      "03":"Mar",
      "04":"Apr",
      "05":"May",
      "06":"Jun",
      "07":"Jul",
      "08":"Aug",
      "09":"Sep",
      "10":"Oct",
      "11":"Nov",
      "12":"Dec",
    };
    String url = 'https://api.weatherbit.io/v2.0/forecast/hourly?key=e1d17bfcc6754d4b8c9de6b2a6cdbe9d&lat=${coordinate.lat}&lon=${coordinate.lon}';
    var response = await get(url);
    var jsonData = jsonDecode(response.body)["data"];
    for(var jdata in jsonData){
      String date =jdata['timestamp_local'].toString().substring(8,10)+" "+months[jdata['timestamp_local'].toString().substring(5,7)];
      HourlyData hourlydata = HourlyData(
        time: DateFormat.jm().format(DateTime.parse(jdata['timestamp_local'])),
        date: date,
        clouds: jdata['clouds'],
        icon: jdata['weather']['icon'],
        description: jdata['weather']['description'],
        temp: jdata['temp'],
      );
      data.add(hourlydata);
    }
  }
}


//get daily data
class DailyData{
  var date;
  var clouds;
  var icon;
  var description;
  var temp;
  DailyData({@required this.date,@required this.clouds,@required this.icon,@required this.description,@required this.temp});
}


class GetDailyWeather{

  //GetHourlyWeather({@required this.coordinate});
  List<DailyData> data = [];

  getWeather(LocationCoordinates coordinate)async {
    Map months = {
      "01":"Jan",
      "02":"Feb",
      "03":"Mar",
      "04":"Apr",
      "05":"May",
      "06":"Jun",
      "07":"Jul",
      "08":"Aug",
      "09":"Sep",
      "10":"Oct",
      "11":"Nov",
      "12":"Dec",
    };
    String url = 'https://api.weatherbit.io/v2.0/forecast/daily?key=e1d17bfcc6754d4b8c9de6b2a6cdbe9d&lat=${coordinate.lat}&lon=${coordinate.lon}';
    var response = await get(url);
    var jsonData = jsonDecode(response.body)["data"];
    for(var jdata in jsonData){

      String date =jdata['valid_date'].toString().substring(8,10)+" "+months[jdata['valid_date'].toString().substring(5,7)];
      DailyData dailydata = DailyData(
        date: date,
        clouds: jdata['clouds'],
        icon: jdata['weather']['icon'],
        description: jdata['weather']['description'],
        temp: jdata['max_temp'],
      );
      data.add(dailydata);
    }
  }
}