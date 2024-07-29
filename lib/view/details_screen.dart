

import 'package:covid_flutter_application/view/world_stat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatefulWidget {

String name;
String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailsScreen({
     required this.name,
     required this.image,
   required this.totalCases,
   required this.totalDeaths,
   required this.totalRecovered,
   required this.active,
   required this.critical,
   required this.todayRecovered,
   required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.name),
      centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      Reuseable(title: 'Cases', value: widget.totalCases.toString()),
                      Reuseable(title: 'Recovered', value: widget.totalRecovered.toString()),
                      Reuseable(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                      Reuseable(title: 'Deaths', value: widget.totalDeaths.toString()),
                      Reuseable(title: 'Critical', value: widget.critical.toString()),


                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),

              ),

            ],
          ),

        ],
      ),
    );
  }
}
