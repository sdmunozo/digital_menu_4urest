import 'package:digital_menu_4urest/api/api_4uRest.dart';
import 'package:digital_menu_4urest/models/metrics/click_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/product_interaction_metric.dart';
import 'package:digital_menu_4urest/models/metrics/search_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/view_time_metric.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class EventMetricProvider with ChangeNotifier {
  final List<GeneralEventMetric> _metrics = [];
  bool _isSending = false;

  List<GeneralEventMetric> get metrics => _metrics;

  void addMetric(GeneralEventMetric metric) {
    try {
      if (!_metrics.contains(metric) && metric.status == MetricStatus.pending) {
        _metrics.add(metric);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
        _trySendMetrics();
      } else {
        GlobalConfigProvider.logMessage(
            ' - - - - - - Métrica duplicada o ya enviada, no se añadió - - - - - -');
      }
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error en addMetric - - - - - - : $e');
    }
  }

  void _trySendMetrics() {
    if (!_isSending) {
      _sendMetrics();
    }
  }

  Future<void> _sendMetrics() async {
    _isSending = true;
    try {
      // Trabajar sobre una copia de la lista para evitar modificación concurrente
      final pendingMetrics = List<GeneralEventMetric>.from(
          _metrics.where((m) => m.status == MetricStatus.pending));

      for (GeneralEventMetric metric in pendingMetrics) {
        metric.status = MetricStatus.sending;
        String endpoint = _getEndpointForMetric(metric);
        if (endpoint.isNotEmpty) {
          await Api4uRest.httpPost(endpoint, metric.toJson());
          metric.status = MetricStatus.sent;
        } else {
          metric.status = MetricStatus.pending;
        }
      }
      // Eliminar las métricas enviadas de la lista original
      _metrics.removeWhere((metric) => metric.status == MetricStatus.sent);
      notifyListeners();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error al enviar métricas - - - - - - : $e');
    } finally {
      _isSending = false;
      if (_metrics.any((m) => m.status == MetricStatus.pending)) {
        _trySendMetrics();
      }
    }
  }

  String _getEndpointForMetric(GeneralEventMetric metric) {
    if (metric is ClickEventMetric) {
      return '/metrics/createClickEvent';
    } else if (metric is ProductInteractionMetric) {
      return '/metrics/createProductInteraction';
    } else if (metric is SearchEventMetric) {
      return '/metrics/createSearchEvent';
    } else if (metric is ViewTimeMetric) {
      return '/metrics/createViewTime';
    }
    return '';
  }
}


/*

class EventMetricProvider with ChangeNotifier {
  final List<GeneralEventMetric> _metrics = [];

  List<GeneralEventMetric> get metrics => _metrics;

  void addMetric(GeneralEventMetric metric) {
    try {
      // Verificar si la métrica ya está en la lista
      if (!_metrics.contains(metric)) {
        _metrics.add(metric);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
        sendMetrics();
      } else {
        GlobalConfigProvider.logMessage(
            ' - - - - - - Métrica duplicada, no se añadió - - - - - -');
      }
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error en addMetric - - - - - - : $e');
    }
  }

  Future<void> sendMetrics() async {
    try {
      for (GeneralEventMetric metric in _metrics) {
        String endpoint = _getEndpointForMetric(metric);
        if (endpoint.isNotEmpty) {
          await Api4uRest.httpPost(endpoint, metric.toJson());
        }
      }
      _metrics.clear();
      notifyListeners();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error al enviar métricas - - - - - - : $e');
    }
  }

  String _getEndpointForMetric(GeneralEventMetric metric) {
    if (metric is ClickEventMetric) {
      return '/metrics/createClickEvent';
    } else if (metric is ProductInteractionMetric) {
      return '/metrics/createProductInteraction';
    } else if (metric is SearchEventMetric) {
      return '/metrics/createSearchEvent';
    } else if (metric is ViewTimeMetric) {
      return '/metrics/createViewTime';
    }
    return '';
  }
}

*/

/*import 'package:digital_menu_4urest/api/api_4uRest.dart';
import 'package:digital_menu_4urest/models/metrics/click_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/general_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/product_interaction_metric.dart';
import 'package:digital_menu_4urest/models/metrics/search_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/view_time_metric.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class EventMetricProvider with ChangeNotifier {
  final List<GeneralEventMetric> _metrics = [];

  List<GeneralEventMetric> get metrics => _metrics;

  void addMetric(GeneralEventMetric metric) {
    try {
      _metrics.add(metric);
      notifyListeners();
      sendMetrics();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error en addMetric - - - - - - : $e');
    }
  }

  Future<void> sendMetrics() async {
    try {
      for (GeneralEventMetric metric in _metrics) {
        String endpoint = _getEndpointForMetric(metric);
        if (endpoint.isNotEmpty) {
          await Api4uRest.httpPost(endpoint, metric.toJson());
        }
      }
      _metrics.clear();
      notifyListeners();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          ' - - - - - - Error al enviar métricas - - - - - - : $e');
    }
  }

  String _getEndpointForMetric(GeneralEventMetric metric) {
    if (metric is ClickEventMetric) {
      return '/metrics/createClickEvent';
    } else if (metric is ProductInteractionMetric) {
      return '/metrics/createProductInteraction';
    } else if (metric is SearchEventMetric) {
      return '/metrics/createSearchEvent';
    } else if (metric is ViewTimeMetric) {
      return '/metrics/createViewTime';
    }
    return '';
  }
}
*/