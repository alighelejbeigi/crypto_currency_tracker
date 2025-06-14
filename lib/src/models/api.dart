import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/markets"
        "?vs_currency=usd"
        "&order=market_cap_desc"
        "&per_page=100"
        "&page=1"
        "&sparkline=false"
        "&locale=en"
        "&x_cg_demo_api_key=CG-tMbp1sR4JnFCnrUjzF94oRDr" // اضافه کردن کلید دموی شما
        );

    try {
      final response =
          await http.get(requestPath).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedResult = jsonDecode(response.body);
        List<dynamic> markets = decodedResult as List<dynamic>;

        return markets;
      } else {
        if (kDebugMode) {
          print('Failed to load data: ${response.statusCode}');
        }
        return [];
      }
    } on SocketException catch (e) {
      if (kDebugMode) print('SocketException: $e');
      return [];
    } on http.ClientException catch (e) {
      if (kDebugMode) print('ClientException: $e');
      return [];
    } on TimeoutException catch (e) {
      if (kDebugMode) print('TimeoutException: $e');
      return [];
    } catch (e) {
      if (kDebugMode) print('Unexpected error: $e');
      return [];
    }
  }
}
