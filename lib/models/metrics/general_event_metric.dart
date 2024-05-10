import 'package:digital_menu_4urest/providers/global_config_provider.dart';

class GeneralEventMetric {
  String? branchId;
  String? userId;
  String? sessionId;
  String? eventType;
  DateTime? eventTimestamp;

  GeneralEventMetric({
    this.branchId,
    this.userId,
    this.sessionId,
    this.eventType,
    this.eventTimestamp,
  }) {
    branchId ??= GlobalConfigProvider.lastUrlSegment;
    userId ??= GlobalConfigProvider.sessionId;
    sessionId ??= GlobalConfigProvider.sessionId;
    eventTimestamp ??= DateTime.now();
  }

  // Factory constructor para crear un objeto desde un JSON
  factory GeneralEventMetric.fromJson(Map<String, dynamic> json) {
    return GeneralEventMetric(
      branchId: json['branchId'],
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
    );
  }

  // Método para convertir el objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'userId': userId,
      'sessionId': sessionId,
      'eventType': eventType,
      'eventTimestamp': eventTimestamp?.toIso8601String(),
    };
  }
}
