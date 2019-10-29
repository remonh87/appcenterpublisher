import 'dart:convert';

import 'package:app_center_uploader/src/api/constants.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:http/http.dart' as http;

void commitUpload(
    Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding}) patch,
    String uploadId,
    ApiConfig config,
    String appName) {
  patch(
    '$appcenterBaseUrl/${config.owner}/$appName/release_uploads/$uploadId',
    headers: {'Content-Type': 'application/json', 'X-API-Token': '${config.apiToken}'},
    body: <String, dynamic>{'status': 'comitted'},
  );
}
