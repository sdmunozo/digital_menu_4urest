import 'general_event_metric.dart';

class SearchEventMetric extends GeneralEventMetric {
  String? searchTerm;

  SearchEventMetric({
    super.userId,
    super.sessionId,
    super.eventType,
    super.eventTimestamp,
    this.searchTerm,
  }) {
    eventType ??= "SearchEventMetric";
  }

  // Factory constructor para crear un objeto desde un JSON
  factory SearchEventMetric.fromJson(Map<String, dynamic> json) {
    return SearchEventMetric(
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      searchTerm: json['searchTerm'],
    );
  }

  // Método para convertir el objeto a JSON
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'searchTerm': searchTerm,
    });
    return data;
  }
}
