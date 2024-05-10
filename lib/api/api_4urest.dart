// ignore: file_names
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
        GlobalConfigProvider.logMessage(
            'Respuesta 200: ${response.statusCode}, ${response.data}');
        return _parseResponse(response.data);
      } else {
        var responseData = jsonDecode(response.data);
        GlobalConfigProvider.logMessage(
            'Respuesta no exitosa: ${response.statusCode}, ${responseData['title']}: ${responseData['detail']}');
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        var responseData = jsonDecode(dioError.response!.data);
        GlobalConfigProvider.logMessage(
            'DioError en el GET: ${dioError.message}, ${responseData['title']}: ${responseData['detail']}');
      } else {
        GlobalConfigProvider.logMessage(
            'DioError en el GET: ${dioError.message}');
      }
    } catch (e) {
      GlobalConfigProvider.logMessage('Error en el GET: $e');
    }
  }

  static dynamic _parseResponse(dynamic data) {
    try {
      return data is String ? jsonDecode(data) : data;
    } catch (e) {
      GlobalConfigProvider.logMessage('Error al parsear los datos: $e');
    }
  }
}
