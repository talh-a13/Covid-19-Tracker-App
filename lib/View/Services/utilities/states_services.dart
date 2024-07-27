import 'dart:convert';

import 'package:covid_19/View/Model/world_ModelStats.dart';
import 'package:covid_19/View/Services/utilities/url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStats> fecthworldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldstateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStats.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> CountriesRecordApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
