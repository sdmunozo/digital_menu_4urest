import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';

class SearchEventMetric extends GeneralEventMetric {
  String? searchTerm;

  SearchEventMetric({
    super.branchId,
    super.userId,
    super.sessionId,
    String? eventType,
    super.eventTimestamp,
    this.searchTerm,
  }) : super(
          eventType: "SearchEventMetric",
        ) {
    _validateParameters();
  }

  factory SearchEventMetric.fromJson(Map<String, dynamic> json) {
    final metric = SearchEventMetric(
      branchId: json['branchId'],
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      searchTerm: json['searchTerm'],
    );
    metric._validateParameters();
    return metric;
  }

  void _validateParameters() {
    assert(searchTerm != null, 'searchTerm is null');
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'searchTerm': searchTerm,
    });
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (super != other) return false;

    return other is SearchEventMetric && other.searchTerm == searchTerm;
  }

  @override
  int get hashCode {
    return super.hashCode ^ searchTerm.hashCode;
  }
}


/*import 'general_event_metric.dart';

class SearchEventMetric extends GeneralEventMetric {
  String? searchTerm;

  SearchEventMetric({
    super.branchId,
    super.userId,
    super.sessionId,
    String? eventType,
    super.eventTimestamp,
    this.searchTerm,
  }) : super(
          eventType: "SearchEventMetric",
        ) {
    _validateParameters();
  }

  factory SearchEventMetric.fromJson(Map<String, dynamic> json) {
    final metric = SearchEventMetric(
      branchId: json['branchId'],
      userId: json['userId'],
      sessionId: json['sessionId'],
      eventType: json['eventType'],
      eventTimestamp: DateTime.parse(json['eventTimestamp']),
      searchTerm: json['searchTerm'],
    );
    metric._validateParameters();
    return metric;
  }

  void _validateParameters() {
    assert(searchTerm != null, 'searchTerm is null');
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'searchTerm': searchTerm,
    });
    return data;
  }
}

*/