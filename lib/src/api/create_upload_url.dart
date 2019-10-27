import 'dart:convert';

import 'package:app_center_uploader/src/api/constants.dart';
import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

Future<ReleaseUploadResult> createUploadUrl({
  @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) callApi,
  @required ApiConfig config,
  @required AppRelease appRelease,
}) {
  assert(callApi != null);

  const decoder = JsonDecoder();
  const encoder = JsonEncoder();

  return callApi(
    '$appcenterBaseUrl/${config.owner}/${appRelease.appName}/release_uploads',
    headers: {'Content-Type': 'application/json', 'X-API-Token': '${config.apiToken}'},
    body: encoder.convert(appRelease.releaseInfo.toJson()),
  ).then((response) {
    if (response.statusCode == 200) {
      final bodyconverted = decoder.convert(response.body) as Map<String, dynamic>;
      return ReleaseUploadResult.success(
          ReleaseUploadOperationSuccess(bodyconverted['upload_id'].toString(), bodyconverted['upload_url'].toString()));
    } else {
      final bodyconverted = decoder.convert(response.body) as Map<String, dynamic>;
      return ReleaseUploadResult.failure(ApiOperationFailure(message: bodyconverted['message']?.toString() ?? ""));
    }
  });
}
