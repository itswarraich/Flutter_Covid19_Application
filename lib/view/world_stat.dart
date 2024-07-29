import 'package:covid_flutter_application/models/WorldStatesModel.dart';
import 'package:covid_flutter_application/services/states_services.dart';
import 'package:covid_flutter_application/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


class WorldStat extends StatefulWidget {
  const WorldStat({super.key});

  @override
  State<WorldStat> createState() => _WorldStatState();
}

class _WorldStatState extends State<WorldStat> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList=<Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height*.01,),
            FutureBuilder(future: statesServices.fetchWorkedStatesRecord(),

                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
              if (!snapshot.hasData) {

                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                    controller: _controller,
                  ),
                );

              }else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  PieChart(dataMap: {
                    "Total": double.parse(snapshot.data!.cases!.toString()),
                    "Recoverd":double.parse(snapshot.data!.recovered!.toString()),
                    "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                  },
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                    chartRadius: MediaQuery.of(context).size.width/3.2,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.left,
                    ),
                    animationDuration: Duration(milliseconds: 1200),
                    chartType: ChartType.ring,
                    colorList: colorList,
                  ),

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                    child: Card(
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Reuseable(title: "Total:", value: snapshot.data!.cases.toString()),
                          Reuseable(title: "Deaths:", value: snapshot.data!.deaths.toString()),
                          Reuseable(title: "Recovered:", value: snapshot.data!.recovered.toString()),
                          Reuseable(title: "Active:", value: snapshot.data!.active.toString()),





                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList()));
                      
                  },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff1aa260),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text("Track Countries")),
                    ),
                  ),

                ],);
              }

                }),





          ],),
        ),
      ),
    );
  }
}

class Reuseable extends StatelessWidget {
  String title, value;
  Reuseable({Key? key, required this.title, required this.value}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5,left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],

          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}

