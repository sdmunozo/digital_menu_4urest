import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';

class ViewTimeMetric extends GeneralEventMetric {
  String? pageName;
  int? viewTimeSeconds;

  ViewTimeMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.pageName,
    this.viewTimeSeconds,
  }) {
    eventType ??= "ViewTimeMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ViewTimeMetric.fromJson(Map<String, dynamic> json) {
    return ViewTimeMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      pageName: json['pageName'],
      viewTimeSeconds: json['viewTimeSeconds'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'pageName': pageName,
      'viewTimeSeconds': viewTimeSeconds,
    });
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (super != other) return false;

    return other is ViewTimeMetric &&
        other.pageName == pageName &&
        other.viewTimeSeconds == viewTimeSeconds;
  }

  @override
  int get hashCode {
    return super.hashCode ^ pageName.hashCode ^ viewTimeSeconds.hashCode;
  }
}


/*import 'general_event_metric.dart';

class ViewTimeMetric extends GeneralEventMetric {
  String? pageName;
  int? viewTimeSeconds;

  ViewTimeMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.pageName,
    this.viewTimeSeconds,
  }) {
    eventType ??= "ViewTimeMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory ViewTimeMetric.fromJson(Map<String, dynamic> json) {
    return ViewTimeMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      pageName: json['pageName'],
      viewTimeSeconds: json['viewTimeSeconds'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'pageName': pageName,
      'viewTimeSeconds': viewTimeSeconds,
    });
    return data;
  }
}

*/