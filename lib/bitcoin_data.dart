import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'price_screen.dart';
import 'package:http/http.dart' as http;

final String apikey = 'A12EFCD0-D280-41DC-99CC-B42AE0516B92';
String currency = cryptoList[0];
String currency1 = cryptoList[1];
String currency2 = cryptoList[2];

double lastPrice;

class BitcoinData {
  double rate;
  String crypto;
  BitcoinData({@required this.rate});

  Future getData(String selectedCurrency, String crypto1) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto1/$selectedCurrency?apikey=$apikey';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['rate'];
      return lastPrice.toStringAsFixed(0);
    } else {
      print('Error');
    }
  }

  factory BitcoinData.fromJson(Map<String, dynamic> json) {
    return BitcoinData(
      rate: lastPrice,
    );
  }
}
