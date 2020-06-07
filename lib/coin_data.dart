import 'package:bitcoin_ticker/Network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static Map<String, dynamic> _BTCRate = {};
  static Map<String, dynamic> _ETCRate = {};
  static Map<String, dynamic> _LTCRate = {};
  NetworkHelper networkHelper = NetworkHelper();
  Future<void> getDate(Map<String, dynamic> map, String crypto) async {
    dynamic jsonResponce = await networkHelper.getdata(crypto);
    List<dynamic> rates = jsonResponce["rates"];
    for (dynamic var1 in rates) {
      String currency = var1["asset_id_quote"];
      dynamic currentRate = var1["rate"];
      if (currenciesList.contains(currency)) {
        map.putIfAbsent(currency, () => currentRate);
      }
    }
  }

  Future<void> getCurrenciesRate() async {
    await getDate(_BTCRate, cryptoList[0]);
    await getDate(_LTCRate, cryptoList[2]);
    await getDate(_ETCRate, cryptoList[1]);
  }

  String getBTCRate(String currency) {
    if (_BTCRate[currency] != null)
      return _BTCRate[currency].toStringAsFixed(0);
    else {
      return "--";
    }
  }

  String getETCRate(String currency) {
    if (_ETCRate[currency] != null)
      return _ETCRate[currency].toStringAsFixed(0);
    else {
      return "--";
    }
  }

  String getLTCRate(String currency) {
    if (_LTCRate[currency] != null)
      return _LTCRate[currency].toStringAsFixed(0);
    else {
      return "--";
    }
  }
}
//
//for (int j = 0; j < cryptoList.length; j++) {
//dynamic jsonResponce = await networkHelper.getdata(cryptoList[j]);
//for (int i = 0; i < jsonResponce["rates"]; i++) {
//String currency = jsonResponce["rates"][i]["asset_id_quote"];
//dynamic currentRate = jsonResponce["rates"][i]["rate"];
//if (j == 0) {
//_BTCRate.putIfAbsent(currency, () => currentRate);
//}
//if (j == 1) {
//_ETCRate.putIfAbsent(currency, () => currentRate);
//}
//if (j == 2) {
//_LTCRate.putIfAbsent(currency, () => currentRate);
//}
//}
////    for (String currency in currenciesList) {
////      dynamic jsonResponce = await networkHelper.getdata(currency);
////      double tempRate = jsonResponce["rate"];
////      String currentRate = (tempRate.toInt()).toString();
////      _currenciesRate.putIfAbsent(currency, () => currentRate);
////   }
//print(_BTCRate.toString());
//}
////return;
