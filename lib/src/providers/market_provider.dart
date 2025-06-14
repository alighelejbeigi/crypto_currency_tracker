import 'dart:async';

import 'package:crypto_currency_tracker/src/models/api.dart';
import 'package:crypto_currency_tracker/src/models/crypto_currency.dart';
import 'package:flutter/foundation.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrencyViewModel> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List<dynamic> markets2 = await API.getMarkets();
    List<CryptoCurrencyViewModel> temp = [];
    for (var market in markets2) {
      CryptoCurrencyViewModel newCrypto =
          CryptoCurrencyViewModel.fromJson(market);
      temp.add(newCrypto);
    }
    markets = temp;

    isLoading = false;
    notifyListeners();

    Timer(
      const Duration(seconds: 10),
      () {
        fetchData();
        if (kDebugMode) {
          print('Fetching data');
        }
      },
    );
  }

  CryptoCurrencyViewModel fetchDataById(final String id) {
    CryptoCurrencyViewModel crypto =
        markets.where((e) => e.id == id).toList()[0];
    return crypto;
  }
}
