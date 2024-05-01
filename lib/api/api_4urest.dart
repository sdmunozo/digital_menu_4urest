import 'dart:convert';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:dio/dio.dart';

class Api4uRest {
  static final Dio _dio = Dio()
    ..options.baseUrl = 'https://netship20240323121328.azurewebsites.net/api'
    ..options.headers = {
      'Content-Type': 'application/json',
    };

  static Future<dynamic> httpGet(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      if (response.statusCode == 200) {
        return _parseResponse(response.data);
      } else {
        GlobalConfigProvider.logError(
            'Respuesta no exitosa: ${response.statusCode}, ${response.data}');
      }
    } on DioException catch (dioError) {
      GlobalConfigProvider.logError('DioError en el GET: ${dioError.message}');
    } catch (e) {
      GlobalConfigProvider.logError('Error en el GET: $e');
    }
  }

  static dynamic _parseResponse(dynamic data) {
    try {
      return data is String ? jsonDecode(data) : data;
    } catch (e) {
      GlobalConfigProvider.logError('Error al parsear los datos: $e');
    }
  }
}
