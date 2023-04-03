import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  var temp;
  var humidity;
  var wind;
  var desciprtion;

  Future getWeather() async {

    http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/'
    '2.5/weather?lat=7.291418&lon=80.636696&units=imperial&appid=6d2e4ca05da888016f2d814c34fd4ce1'));

     var Result = jsonDecode(response.body);

     setState(() {
       this.temp = Result['main'] ['temp'];
       this.humidity = Result ['main'] ['humidity'];
       this.wind = Result ['wind'];
       this.desciprtion = Result ['weather'][0]['description'];

     });

  }
  @override

  void initState() {
    // TODO: implement initState
    super.initState();

    getWeather();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Currently in Kandy',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Text(
                temp != null?  temp.toString() + "\u00B0": 'Loading',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  desciprtion != null? desciprtion.toString() : 'Loading',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text( 'Temparuture'),
                leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                trailing: Text(temp != null?  temp.toString() + "\u00B0" + 'F': 'Loading'),
              ),
              ListTile(
                title: Text('Clouds' ),
                leading: FaIcon(FontAwesomeIcons.cloud),
                trailing: Text(desciprtion != null? desciprtion.toString() : 'Loading'),
              ),
              ListTile(
                title: Text('Humidity'),
                leading: FaIcon(FontAwesomeIcons.sun),
                trailing: Text(humidity != null? humidity.toString() : 'Loading'),
              ),
              ListTile(
                title: Text('Wind'),
                leading: FaIcon(FontAwesomeIcons.wind),
                trailing: Text(wind  != null? wind.toString() : 'Loading'),
              ),

            ],
          ),
        )
      ]),
    );
  }
}
