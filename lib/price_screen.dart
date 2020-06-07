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
  String rate1, rate2, rate3;

  void clearRates() {
    rate1 = "?";
    rate2 = "?";
    rate3 = "?";
  }

  Future<void> updateRates() async {
    await coinData.getRates(currentCurrancy);
    setState(() {
      rate1 = coinData.getRate(cryptoList[0]);
      rate2 = coinData.getRate(cryptoList[1]);
      rate3 = coinData.getRate(cryptoList[2]);
    });
  }

  Widget AndroidDropdownButtom() {
    List<DropdownMenuItem<String>> dropdownmenuitemsList = [];
    for (String item in currenciesList) {
      dropdownmenuitemsList.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    }
    return DropdownButton(
      onChanged: (value) async {
        setState(() {
          currentCurrancy = value;
          clearRates();
        });
        await updateRates();
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
      onSelectedItemChanged: (itemSelected) async {
        setState(() {
          currentCurrancy = currenciesList[itemSelected];
          clearRates();
        });
        await updateRates();
      },
      children: items,
    );
  }

  @override
  void initState() {
    super.initState();
    clearRates();
    updateRates();
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
            rate: rate1,
            currency: currentCurrancy,
          ),
          ReusableCard(
            bitCoin: cryptoList[1],
            rate: rate2,
            currency: currentCurrancy,
          ),
          ReusableCard(
            bitCoin: cryptoList[2],
            rate: rate3,
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
