import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';

class ClickEventMetric extends GeneralEventMetric {
  String? clickedElement;
  String? origin;
  String? destination;

  ClickEventMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.clickedElement,
    this.origin,
    this.destination,
  }) {
    eventType ??= "ClickEventMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ClickEventMetric.fromJson(Map<String, dynamic> json) {
    return ClickEventMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      clickedElement: json['clickedElement'],
      origin: json['origin'],
      destination: json['destination'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'clickedElement': clickedElement,
      'origin': origin,
      'destination': destination,
    });
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (super != other) return false;

    return other is ClickEventMetric &&
        other.clickedElement == clickedElement &&
        other.origin == origin &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return super.hashCode ^
        clickedElement.hashCode ^
        origin.hashCode ^
        destination.hashCode;
  }
}


/*import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';

class ClickEventMetric extends GeneralEventMetric {
  String? clickedElement;
  String? origin;
  String? destination;

  ClickEventMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.clickedElement,
    this.origin,
    this.destination,
  }) {
    eventType ??= "ClickEventMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ClickEventMetric.fromJson(Map<String, dynamic> json) {
    return ClickEventMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      clickedElement: json['clickedElement'],
      origin: json['origin'],
      destination: json['destination'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'clickedElement': clickedElement,
      'origin': origin,
      'destination': destination,
    });
    return data;
  }
}
*/