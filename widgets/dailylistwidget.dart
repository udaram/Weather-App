import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class DailyListView extends StatelessWidget {
  final List<DailyData> dailyData;
  DailyListView({@required this.dailyData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: 200,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount:dailyData.length,
            itemBuilder:(context,index){
              return DailyListTile(
                date:dailyData[index].date,
                clouds:dailyData[index].clouds,
                temp:dailyData[index].temp,
                description:dailyData[index].description,
                icon:dailyData[index].icon,
              );
            }
        ),
      ),
    );
  }
}

class DailyListTile extends StatelessWidget {
  final date,clouds,icon,description,temp;
  DailyListTile({@required this.date,@required this.clouds,@required this.icon,@required this.description,@required this.temp});
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
              Icon(Icons.cloud_queue),
              Text(' $clouds %'),
              SizedBox(width: 5,),
            ],
          ),
          SizedBox(height: 10,),
          Text('$date'),
        ],
      ),
    );
  }
}

