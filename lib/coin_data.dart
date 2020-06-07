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
  NetworkHelper networkHelper = NetworkHelper();
  Map<String, String> rates = {};

  Future<void> getRates(String currency) async {
    for (String crypto in cryptoList) {
      dynamic jsonResponce = await networkHelper.getdata(crypto, currency);
      double rate = jsonResponce["rate"];
      rates[crypto] = (rate.toInt()).toString();
    }
  }

  String getRate(String crypto) {
    if (rates[crypto] != null) {
      return rates[crypto];
    } else
      return "?";
  }
}
