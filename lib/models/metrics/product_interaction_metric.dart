import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';

class ProductInteractionMetric extends GeneralEventMetric {
  String? productId;
  String? action; // "viewed", "added_to_cart", etc.

  ProductInteractionMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.productId,
    this.action,
  }) {
    eventType ??= "ProductInteractionMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ProductInteractionMetric.fromJson(Map<String, dynamic> json) {
    return ProductInteractionMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      productId: json['productId'],
      action: json['action'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'productId': productId,
      'action': action,
    });
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (super != other) return false;

    return other is ProductInteractionMetric &&
        other.productId == productId &&
        other.action == action;
  }

  @override
  int get hashCode {
    return super.hashCode ^ productId.hashCode ^ action.hashCode;
  }
}


/*import 'general_event_metric.dart';

class ProductInteractionMetric extends GeneralEventMetric {
  String? productId;
  String? action; // "viewed", "added_to_cart", etc.

  ProductInteractionMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.productId,
    this.action,
  }) {
    eventType ??= "ProductInteractionMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ProductInteractionMetric.fromJson(Map<String, dynamic> json) {
    return ProductInteractionMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      productId: json['productId'],
      action: json['action'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'productId': productId,
      'action': action,
    });
    return data;
  }
}

*/