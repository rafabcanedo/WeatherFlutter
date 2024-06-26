import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:weather/model/weatherModel.dart';
import 'package:weather/utils/staticFile.dart';

class Home extends StatefulWidget {
 List<WeatherModel> weatherModel = [];

 Home({required this.weatherModel});

 @override
 State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     await scrollToIndex();
    });
    find_myLocation_index();
    super.initState();
  }

 find_myLocation_index() {
  for (var i = 0; i < widget.weatherModel.length; i++) {
   if (widget.weatherModel[i].name == StaticFile.myLocation) {
    setState(() {
      StaticFile.myLocationIndex = i;
      complete1 = true;
    });
    break;
   }
  }
  find_hour_index();
 }

 DateTime time = DateTime.now();
 int hour_index = 0;
 bool complete1 = false;
 bool complete2 = false;

 find_hour_index(){
  String my_time;

  my_time = time.hour.toString();
    if (my_time.length == 1) {
      my_time = '0' + my_time;
  }
  for (var i = 0; i < widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!.allTime!.hour!.length; i++) {
   if (widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!
    .allTime!.hour![i]!
    .substring(0, 2)
    .toString() ==
    my_time) {
    setState(() {
    hour_index = i;
    complete2 = true;
   });
    break;
  }
  }
 }

 final ItemScrollController itemScrollController = ItemScrollController();
 final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

 scrollToIndex() async {
  itemScrollController.scrollTo(
   index: hour_index, duration: Duration(seconds: 1),
   curve: Curves.easeInOutCubic);
 }

 @override
 Widget build(BuildContext context) {
  double myHeight = MediaQuery.of(context).size.height;
  double myWidth = MediaQuery.of(context).size.width;

  return SafeArea(
    child: Scaffold(
      backgroundColor: Color.fromARGB(255, 113, 113, 192),
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Column(
          children: [
            SizedBox(
              height: myHeight * 0.03,
            ),
            Text(
              widget.weatherModel[StaticFile.myLocationIndex].name
              .toString(),
              style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Text(
              '26 May 2024'
              .toString(),
              style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
            ),
            SizedBox(
              height: myHeight * 0.05,
            ),
            Container(
              height: myHeight * 0.05,
              width: myWidth * 0.6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10)),
                child: Row(
                 children: [
                  Expanded(
                   flex: 2,
                   child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 157, 157, 201)),
                      child: Center(
                       child: Text(
                        'Previsao',
                        style: TextStyle(
                          color: Colors.white, fontSize: 18),
                       )),
                   )),
                  Expanded(
                   flex: 2,
                   child: Container(
                    child: Center(
                      child: Text(
                       'Ar',
                       style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18),
                      ),
                    ),
                   )),
                 ],
                 )
            ),
            SizedBox(
              height: myHeight * 0.05,
            ),
            Image.asset(widget.weatherModel[StaticFile.myLocationIndex]
             .weeklyWeather![0]!.mainImg
             .toString(),
             height: myHeight * 0.3,
             width: myWidth * 0.8, 
            ),
            SizedBox(
              height: myHeight * 0.05,
            ),
            Container(
              height: myHeight * 0.06,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          'Tempo',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16),
                        ),
                         Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                           .weeklyWeather![0]!.mainTemp
                           .toString(),
                          style: TextStyle(
                            color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )),
                    Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          'Vento',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16),
                        ),
                         Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                           .weeklyWeather![0]!.mainWind
                           .toString(),
                          style: TextStyle(
                            color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )),
                    Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          'Humidade',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16),
                        ),
                         Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                           .weeklyWeather![0]!.mainHumidity
                           .toString(),
                          style: TextStyle(
                            color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )),
                ],
              )
            ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Padding(
             padding: EdgeInsets.symmetric(
              horizontal: myWidth * 0.02,
              vertical: myHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hoje',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                 Text(
                  'Historico',
                  style: TextStyle(color: Color.fromARGB(255, 157, 157, 201), fontSize: 14),
                ),
              ],
            )
          ),
          SizedBox(
            height: myHeight * 0.02,
          ),
          Expanded(
           child: Padding(
           padding: EdgeInsets.only(left: myWidth * 0.1, bottom: myHeight * 0.01),
           child: ScrollablePositionedList.builder(
           itemScrollController: itemScrollController,
           itemPositionsListener: itemPositionsListener,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.weatherModel[StaticFile.myLocationIndex].weeklyWeather![0]!.allTime!.hour!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                width: myWidth * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: hour_index == index
                   ? null 
                   : Colors.white.withOpacity(0.05),
                   gradient: 
                   hour_index == index ?
                   LinearGradient(colors: [
                    Color.fromARGB(255, 164, 141, 226),
                    Color.fromARGB(255, 154, 120, 216),
                   ])
                   : null),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  Image.asset(
                    widget.weatherModel[StaticFile.myLocationIndex]
                     .weeklyWeather![0]!.allTime!.img![index]
                     .toString(),
                     height: myHeight * 0.04,
                  ),
                  SizedBox(
                    width: myWidth * 0.02,
                  ),
                  Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Text(
                     widget
                     .weatherModel[
                     StaticFile.myLocationIndex]
                     .weeklyWeather![0]!
                     .allTime!
                     .hour![index]
                     .toString(),
                     style: TextStyle(
                      fontSize: 10, color: Colors.white),
                     ),
                    Text(
                     widget
                     .weatherModel[
                     StaticFile.myLocationIndex]
                     .weeklyWeather![0]!
                     .allTime!
                     .temps![index]
                     .toString(),
                     style: TextStyle(
                     fontSize: 25, color: Colors.white),
                    ),
                   ]
                   )
                 ],
                ),
              ));
            },
          ))
        )],
          ),
          )),
    );
 }
}