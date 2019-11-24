import 'dart:convert';

import 'package:appcenterpublisher/src/api/constants.dart';
import 'package:appcenterpublisher/src/api_operation_data.dart';
import 'package:appcenterpublisher/src/model/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

Future<CommitReleaseResult> commitUpload({
  @required
      Future<http.Response> Function(dynamic url,
              {Map<String, String> headers, dynamic body, Encoding encoding})
          patch,
  @required String uploadId,
  @required ApiConfig config,
  @required String appName,
}) async {
  const decoder = JsonDecoder();

  final result = await patch(
    '$appcenterBaseUrl/${config.owner}/$appName/release_uploads/$uploadId',
    headers: {
      'Content-Type': 'application/json',
      'X-API-Token': '${config.apiToken}'
    },
    body: '{ "status": "committed"  }',
  );

  if (result.statusCode == 200) {
    return CommitReleaseResult.success(CommitReleaseSuccess.fromJson(
        decoder.convert(result.body) as Map<String, dynamic>));
  } else {
    return CommitReleaseResult.failure(
      ApiOperationFailure(
          message: "Api returned ${result.statusCode} message: ${result.body}"),
    );
  }
}
