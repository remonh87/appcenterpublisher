import 'dart:convert';

import 'package:app_center_uploader/src/api_responses.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

Future<ReleaseUploadResponse> createUploadUrl({
  @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) callApi,
  @required ApiConfig config,
  @required ReleaseInfo releaseInfo,
}) {
  assert(callApi != null);

  const decoder = JsonDecoder();
  return callApi(
    'https://api.appcenter.ms/v0.1/apps/${config.owner}/${releaseInfo.appName}/release_uploads',
    headers: {'Content-Type': 'application/json', 'X-API-Token': '${config.apiToken}'},
    body: _createJsonBody(releaseInfo),
  ).then((response) {
    final bodyconverted = decoder.convert(response.body) as Map<String, dynamic>;
    return ReleaseUploadResponse(bodyconverted['upload_id'].toString(), bodyconverted['upload_url'].toString());
  });
}

String _createJsonBody(ReleaseInfo info) {
  final body = <String, dynamic>{};

  final entries = [
    _createEntryIfNotNull('release_id', info.releaseId),
    _createEntryIfNotNull('build_version', info.buildVersion),
    _createEntryIfNotNull('build_number', info.buildNumber),
  ];

  for (final e in entries.where((entry) => entry != null)) {
    body[e?.key] = e?.value;
  }

  const encoder = JsonEncoder();
  return encoder.convert(body);
}

MapEntry<String, dynamic> _createEntryIfNotNull(String key, dynamic value) =>
    value != null ? MapEntry<String, dynamic>(key, value) : null;
