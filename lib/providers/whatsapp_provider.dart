import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WhatsAppProvider with ChangeNotifier {
  final Dio _dio = Dio()
    ..options.baseUrl = 'https://netship20240323121328.azurewebsites.net/api'
    ..options.headers = {
      'Content-Type': 'application/json',
    };

  bool _isSending = false;

  bool get isSending => _isSending;

  Future<void> sendWhatsAppMessage(String message, String whatsapp) async {
    _isSending = true;
    notifyListeners();

    final data = {
      "message": message,
      "whatsapp": whatsapp,
    };

    try {
      final response =
          await _dio.post('/digital-menu/send-whatsapp-message', data: data);
      if (response.statusCode == 200) {
        GlobalConfigProvider.logMessage(
            'Mensaje enviado correctamente: ${response.data}');
      } else {
        GlobalConfigProvider.logMessage(
            'Error al enviar el mensaje: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        GlobalConfigProvider.logMessage(
            'DioError en el POST: ${e.response?.data}, Estado: ${e.response?.statusCode}');
      } else {
        GlobalConfigProvider.logMessage('Error en el POST: $e');
      }
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }
}
