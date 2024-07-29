import 'dart:async';

import 'package:covid_flutter_application/view/world_stat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
void dispose(){
  super.dispose();
  _controller.dispose();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> WorldStat()))
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child:const Center(
                  child: Image(image: AssetImage("images/virus.png"),),
                ),
              ),
              builder: (BuildContext context, Widget? child){
          return  Transform.rotate(angle: _controller.value*2.0*math.pi,
            child: child,);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,),
          const Align(
            alignment: Alignment.center,
              child: Text("Covid-19\n Tracker App",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)),


      ],),
    );
  }
}


