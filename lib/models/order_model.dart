class OrderModel {
  final String id;
  final String customer;
  final String phone;
  final num total;
  final String currency;
  final num deliveryFee;
  final DateTime createdAt;
  final String status;
  final String statusAr;
  final String address;
  final List<OrderItem> items;
  final List<TimelineStep> timeline;

  OrderModel({
    required this.id,
    required this.customer,
    required this.phone,
    required this.total,
    required this.currency,
    required this.deliveryFee,
    required this.createdAt,
    required this.status,
    required this.statusAr,
    required this.address,
    required this.items,
    required this.timeline,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      customer: json['customer'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      total: json['total'] as num? ?? 0,
      currency: json['currency'] as String? ?? 'YER',
      deliveryFee: json['delivery_fee'] as num? ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      status: json['status'] as String? ?? 'new',
      statusAr: json['status_ar'] as String? ?? 'جديد',
      address: json['address'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((t) => TimelineStep.fromJson(t as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'phone': phone,
      'total': total,
      'currency': currency,
      'delivery_fee': deliveryFee,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'status_ar': statusAr,
      'address': address,
      'items': items.map((i) => i.toJson()).toList(),
      'timeline': timeline.map((t) => t.toJson()).toList(),
    };
  }
}

class OrderItem {
  final String name;
  final int qty;
  final num price;

  OrderItem({
    required this.name,
    required this.qty,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] as String? ?? '',
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      price: json['price'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty,
      'price': price,
    };
  }
}

class TimelineStep {
  final String step;
  final DateTime at;

  TimelineStep({
    required this.step,
    required this.at,
  });

  factory TimelineStep.fromJson(Map<String, dynamic> json) {
    return TimelineStep(
      step: json['step'] as String? ?? '',
      at: DateTime.tryParse(json['at'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step': step,
      'at': at.toIso8601String(),
    };
  }
}
