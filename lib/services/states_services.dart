import 'dart:convert';

import 'package:covid_flutter_application/services/utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/WorldStatesModel.dart';

class StatesServices{

  Future<WorldStatesModel> fetchWorkedStatesRecord()async{
    final respones=await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (respones.statusCode==200) {
      var  data= jsonDecode(respones.body);
      return WorldStatesModel.fromJson(data);
      
    } else{
      throw Exception("Eror");


    }

  }
  Future<List<dynamic>> countryListApi()async{
    var data;
    final respones=await http.get(Uri.parse(AppUrl.countriesList));

    if (respones.statusCode==200) {
      data= jsonDecode(respones.body);
      return data;

    } else{
      throw Exception("Eror");


    }

  }
}


