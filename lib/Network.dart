import 'dart:convert';

import 'package:http/http.dart' as http;

const String BASE_URL = "http://rest.coinapi.io/v1/exchangerate";
const String apiKey = "346C85DC-ED32-475A-B97F-184CEA812C2F";

class NetworkHelper {
  NetworkHelper();

  Future<dynamic> getdata(String cypto) async {
    http.Response response =
        await http.get("$BASE_URL/$cypto?invert=false&apikey=$apiKey");
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
