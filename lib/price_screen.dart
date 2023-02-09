import 'dart:convert';

import 'package:bitcoin_ticker/bitcoin_data.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String lastPrice, lastPrice1, lastPrice2, rate1;
  String one = cryptoList[0];
  String two = cryptoList[1];
  String three = cryptoList[2];

  @override
  void initState() {
    super.initState();
    getData1();
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
          Block(ratex: lastPrice, selectedCurrency: selectedCurrency, num: 0,),
          Block(ratex: lastPrice1, selectedCurrency: selectedCurrency, num: 1,),
          Block(ratex: lastPrice2, selectedCurrency: selectedCurrency, num: 2,),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: DropdownButton<String>(
                value: selectedCurrency,
                items: currenciesList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                    getData1();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getData1() async {
    BitcoinData bitcoinData = BitcoinData();
    var rate = await bitcoinData.getData(selectedCurrency, currency);
    var rate1 = await bitcoinData.getData(selectedCurrency, currency1);
    var rate2 = await bitcoinData.getData(selectedCurrency, currency2);
    setState(() {
      lastPrice = rate;
      lastPrice1 = rate1;
      lastPrice2 = rate2;
    });
  }
}

class Block extends StatelessWidget {
  const Block({
    Key key,
    @required this.ratex,
    @required this.selectedCurrency,
    @required this.num,
  }) : super(key: key);

  final String ratex;
  final String selectedCurrency;
  final int num;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[num]} = ${ratex} $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
