import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'coin_data.dart';
import 'price_screen.dart';

class LoadingScrean extends StatefulWidget {
  @override
  _LoadingScreanState createState() => _LoadingScreanState();
}

class _LoadingScreanState extends State<LoadingScrean> {
  void loadData() async {
    await CoinData().getCurrenciesRate();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PriceScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Center(
          child: SpinKitThreeBounce(
        color: Colors.lightBlue,
        size: 50.0,
      )),
    );
  }
}
