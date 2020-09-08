import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class HourlyListView extends StatelessWidget {
  final List<HourlyData> hourlyData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: 200,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: hourlyData.length,
            itemBuilder:(context,index){
              return HourlyListTile(
                date: hourlyData[index].date,
                clouds: hourlyData[index].clouds,
                temp: hourlyData[index].temp,
                description: hourlyData[index].description,
                icon: hourlyData[index].icon,
                time: hourlyData[index].time,
              );
            }
        ),
      ),
    );
  }
  HourlyListView({@required this.hourlyData});
}


class HourlyListTile extends StatelessWidget {
  final time,date,clouds,icon,description,temp;
  HourlyListTile({@required this.time,@required this.date,@required this.clouds,@required this.icon,@required this.description,@required this.temp});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 150,
      height: 200,
      color: Colors.lightBlue[50],
      child: Column(
        children: <Widget>[
          Image.asset('assets/icons/${icon}.png',height: 80,width: 80,),
          Text('${temp.toString()}°C',style: TextStyle(fontWeight: FontWeight.w900),),
          Text('$description'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.access_time),
              SizedBox(width: 5,),
              Text('$time'),
            ],
          ),
          SizedBox(height: 10,),
          Text('$date'),
        ],
      ),
    );
  }
}
