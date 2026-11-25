import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  bool _isOffline = false;
  String? _errorMessage;
  String? _lastUpdated;
  String _selectedFilter = 'all';

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;
  String? get errorMessage => _errorMessage;
  String? get lastUpdated => _lastUpdated;
  String get selectedFilter => _selectedFilter;

  List<OrderModel> get filteredOrders {
    if (_selectedFilter == 'all') {
      return _orders;
    }
    return _orders.where((order) => order.status == _selectedFilter).toList();
  }

  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      notifyListeners();
    }
  }

  int getCount(String status) {
    if (status == 'all') return _orders.length;
    return _orders.where((o) => o.status == status).length;
  }

  Future<void> fetchOrders({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
    }

    try {
      final result = await _service.fetchOrders();
      _orders = result.orders;
      _isOffline = result.isFromCache;
      _lastUpdated = result.cachedAt;
      _errorMessage = null;
    } catch (e) {
      if (_orders.isEmpty) {
        _errorMessage = 'تعذر جلب البيانات. يرجى التأكد من الاتصال بالإنترنت.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  OrderModel? getOrderById(String id) {
    try {
      return _orders.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
