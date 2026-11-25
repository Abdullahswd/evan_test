import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_model.dart';

class OrderFetchResult {
  final List<OrderModel> orders;
  final bool isFromCache;
  final String? cachedAt;

  OrderFetchResult({
    required this.orders,
    required this.isFromCache,
    this.cachedAt,
  });
}

class OrderService {
  static const String _cacheKey = 'cached_wasl_orders';
  static const String _cacheTimeKey = 'cached_wasl_time';

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(milliseconds: 1500));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<OrderFetchResult> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnline = await hasInternetConnection();

    if (isOnline) {
      // simulate network request latency
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString = await rootBundle.loadString('assets/wasl-orders.json');
      
      // Cache the latest successful data
      await prefs.setString(_cacheKey, jsonString);
      final nowFormatted = DateTime.now().toIso8601String();
      await prefs.setString(_cacheTimeKey, nowFormatted);

      final List<OrderModel> orders = _parseOrders(jsonString);
      return OrderFetchResult(
        orders: orders,
        isFromCache: false,
      );
    } else {
      // Offline fallback: Read from local cache
      final cachedJson = prefs.getString(_cacheKey);
      final cachedTime = prefs.getString(_cacheTimeKey);

      if (cachedJson != null && cachedJson.isNotEmpty) {
        final List<OrderModel> orders = _parseOrders(cachedJson);
        return OrderFetchResult(
          orders: orders,
          isFromCache: true,
          cachedAt: cachedTime,
        );
      } else {
        // If first launch ever happened without internet, load asset as cached fallback
        final fallbackJson = await rootBundle.loadString('assets/wasl-orders.json');
        await prefs.setString(_cacheKey, fallbackJson);
        final List<OrderModel> orders = _parseOrders(fallbackJson);
        return OrderFetchResult(
          orders: orders,
          isFromCache: true,
          cachedAt: DateTime.now().toIso8601String(),
        );
      }
    }
  }

  List<OrderModel> _parseOrders(String jsonString) {
    final data = json.decode(jsonString) as Map<String, dynamic>;
    final list = data['orders'] as List<dynamic>? ?? [];
    return list.map((item) => OrderModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}
