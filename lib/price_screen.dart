import 'dart:io' show Platform;

import 'package:bitcoin_ticker/ReusableCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String currentCurrancy = currenciesList[0];
  //  NetworkHelper networkHelper = NetworkHelper();
//  void getTempValue() async {
//    dynamic jsonData = await networkHelper.getdata("USD");
//    double temp = jsonData["rate"];
//    setState(() {
//      tempvalue = temp.toStringAsFixed(1);
//    });
//  }

  Widget AndroidDropdownButtom() {
    List<DropdownMenuItem<String>> dropdownmenuitemsList = [];
    for (String item in currenciesList) {
      dropdownmenuitemsList.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return DropdownButton(
      onChanged: (value) {
        setState(() {
          currentCurrancy = value;
        });
      },
      value: currentCurrancy,
      items: dropdownmenuitemsList,
    );
  }

  Widget IOSPicker() {
    List<Text> items = [];
    for (String item in currenciesList) {
      items.add(Text(item));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (itemSelected) {
        setState(() {
          currentCurrancy = currenciesList[itemSelected];
        });
      },
      children: items,
    );
  }

  @override
  void initState() {
    super.initState();
    //CoinData().getCurrenciesRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ReusableCard(
            bitCoin: cryptoList[0],
            rate: coinData.getBTCRate(currentCurrancy),
            currency: currentCurrancy,
          ),
          ReusableCard(
            bitCoin: cryptoList[1],
            rate: coinData.getETCRate(currentCurrancy),
            currency: currentCurrancy,
          ),
          ReusableCard(
            bitCoin: cryptoList[2],
            rate: coinData.getLTCRate(currentCurrancy),
            currency: currentCurrancy,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : AndroidDropdownButtom(),
          ),
        ],
      ),
    );
  }
}
