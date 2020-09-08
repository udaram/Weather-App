import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:weather_app/models/coordinates.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/widgets/dailylistwidget.dart';
import 'package:weather_app/widgets/hourlylistwidget.dart';
import 'package:weather_app/widgets/currentweatherwidget.dart';

class HomeWidget extends StatefulWidget {
  final LocationCoordinates coordinate;
  final selectedIndex;
  HomeWidget({@required this.coordinate,@required this.selectedIndex});
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var selectedIndex;
  WeatherData data;
  String address;
  bool loading=false;
  List<HourlyData> hourlyData = [];
  List<DailyData> dailyData = [];
  @override
  void initState(){
    // TODO: implement initState
    //print('in home widget ${widget.selectedIndex}');
    setState(() {
      selectedIndex = widget.selectedIndex;
    });

    super.initState();
    getData(widget.coordinate);
  }

  getData( LocationCoordinates coordinate)async{
    loading =true;
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(coordinate.lat,coordinate.lon));
    var first = addresses.first;
    address = "${first.addressLine}";
    GetCurrentWeather current=GetCurrentWeather();
    await current.getWeather(coordinate);
    data=current.data;
    if(selectedIndex==1){
      GetHourlyWeather hdata = GetHourlyWeather();
      await hdata.getWeather(coordinate);
      hourlyData = hdata.data;
    }
    else if(selectedIndex==2){
      GetDailyWeather ddata = GetDailyWeather();
      await ddata.getWeather(coordinate);
      dailyData = ddata.data;
    }
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading?Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ):
    SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: <Widget>[
            CurrentWeatherWidget(
              data: data,
              address:address,
            ),
            SizedBox(height: 10,),
            if(selectedIndex>0)
              Column(
                children: <Widget>[
                  selectedIndex==1 ?Text("Next ${hourlyData.length} Hours",style: TextStyle(color: Colors.green[400],fontWeight: FontWeight.w900),):Text("Next ${dailyData.length} Days",style: TextStyle(color: Colors.green[400],fontWeight: FontWeight.w900),),
                  Divider(
                    color: Colors.blue,
                    height: 20,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  selectedIndex!=0 && selectedIndex<2?
                  HourlyListView(
                    hourlyData: hourlyData,
                  )
                      :
                  DailyListView(
                    dailyData: dailyData,
                  ),
                  SizedBox(height: 10,),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
