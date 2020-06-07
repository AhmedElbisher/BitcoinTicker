import 'dart:convert';

import 'package:http/http.dart' as http;

const String BASE_URL = "http://rest.coinapi.io/v1/exchangerate";
const String apiKey = "8D890E33-8A7B-4DA7-9120-88FF53FA8DFE";

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
