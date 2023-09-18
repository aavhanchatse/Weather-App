import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

import '../app_constants/api_path.dart';
import 'custom_exceptions.dart';

class API<T> {
  Future<http.Response> postMethod(String endpoint, Map payLoad,
      [Map<String, String>? headers]) async {
    debugPrint(
        'POST ${ApiPath.baseURL + endpoint}  + payload = ${jsonEncode(payLoad)}');

    debugPrint('headers: $headers');

    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    } else {
      headers = {'Content-Type': 'application/json'};
    }

    var response = await http.post(
      Uri.parse(ApiPath.baseURL + endpoint),
      body: json.encode(payLoad),
      headers: headers,
    );

    return _handledResponse(response, endpoint);
  }

  Future<http.Response> deleteMethod(String endpoint,
      [Map<String, String>? headers = const {}]) async {
    debugPrint(ApiPath.baseURL + endpoint);

    final response = await http.delete(Uri.parse(ApiPath.baseURL + endpoint));
    return _handledResponse(response, endpoint);
  }

  Future<http.Response> getMethod(
    String endpoint, [
    Map<String, String>? headers = const {},
    String parameterString = "",
  ]) async {
    debugPrint(
        'GET ${ApiPath.baseURL + endpoint}${parameterString.isNotEmpty ? "?" : ""}$parameterString');
    final response = await retry(
      () async => await http.get(
          Uri.parse(
              "${ApiPath.baseURL}$endpoint${parameterString.isNotEmpty ? "?" : ""}$parameterString"),
          headers: headers),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    return _handledResponse(response, endpoint);
  }

  Future<http.Response> getMethodCustom(
    String endpoint, [
    Map<String, String>? headers = const {},
    String parameterString = "",
  ]) async {
    debugPrint(
        '$endpoint${parameterString.isNotEmpty ? "?" : ""}$parameterString');
    final response = await retry(
      () async => await http
          .get(
              Uri.parse(
                  "${ApiPath.baseURL}$endpoint${parameterString.isNotEmpty ? "?" : ""}$parameterString"),
              headers: headers)
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    return _handledResponse(response, endpoint);
  }

  Future<http.Response> _handledResponse(
      http.Response response, String endpoint) async {
    debugPrint('status code: ${response.statusCode}');
    debugPrint('response[$endpoint]: ${response.body}');

    // if (response.body!['auth'] == false) {
    //   LogoutDialog().logout();
    //   return null;
    // }

    if (response.statusCode >= 200 && response.statusCode < 400) {
      return response;
    } else if (response.statusCode == 400) {
      throw BadRequestException(response.toString());
    } else if (response.statusCode == 403) {
      throw UnauthorizedException(response.toString());
    } else {
      throw FetchDataException(
          "Error occurred while communicating with server with StatusCode : ${response.statusCode}");
    }
  }
}
