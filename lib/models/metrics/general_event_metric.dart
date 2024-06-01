import 'package:digital_menu_4urest/providers/global_config_provider.dart';

enum MetricStatus { pending, sending, sent }

class GeneralEventMetric {
  String? branchId;
  String? userId;
  String? sessionId;
  String? eventType;
  DateTime? eventTimestamp;
  MetricStatus status;

  GeneralEventMetric({
    this.branchId,
    this.userId,
    this.sessionId,
    this.eventType,
    this.eventTimestamp,
    this.status = MetricStatus.pending,
  }) {
    branchId ??= GlobalConfigProvider.branchCatalog!.brand.branches[0].id;
    userId ??= GlobalConfigProvider.sessionId;
    sessionId ??= GlobalConfigProvider.sessionId;
    eventTimestamp ??= DateTime.now();
  }

  factory GeneralEventMetric.fromJson(Map<String, dynamic> json) {
    return GeneralEventMetric(
      branchId: json['branchId'],
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      status: MetricStatus
          .pending, // Asume que cualquier métrica creada desde JSON no ha sido enviada aún
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'userId': userId,
      'sessionId': sessionId,
      'eventType': eventType,
      'eventTimestamp': eventTimestamp?.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithStatus() {
    final data = toJson();
    data['status'] = status.index;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralEventMetric &&
        other.branchId == branchId &&
        other.userId == userId &&
        other.sessionId == sessionId &&
        other.eventType == eventType &&
        other.eventTimestamp == eventTimestamp;
  }

  @override
  int get hashCode {
    return branchId.hashCode ^
        userId.hashCode ^
        sessionId.hashCode ^
        eventType.hashCode ^
        eventTimestamp.hashCode;
  }
}



/* sin status

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
    branchId ??= GlobalConfigProvider.branchCatalog!.branchId;
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralEventMetric &&
        other.branchId == branchId &&
        other.userId == userId &&
        other.sessionId == sessionId &&
        other.eventType == eventType &&
        other.eventTimestamp == eventTimestamp;
  }

  @override
  int get hashCode {
    return branchId.hashCode ^
        userId.hashCode ^
        sessionId.hashCode ^
        eventType.hashCode ^
        eventTimestamp.hashCode;
  }
}
*/


/*

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
    branchId ??= GlobalConfigProvider.branchCatalog!.branchId;
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

*/