import 'dart:convert';

import 'package:app_center_uploader/src/api/constants.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/distribution_group.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../api_operation_data.dart';

Future<DistributionResult> distributeToGroup({
  @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) post,
  @required DistributionGroup distributionGroup,
  @required ApiConfig config,
  @required String appName,
  @required String releaseId,
}) async {
  const encoder = JsonEncoder();
  final headers = {'Content-Type': 'application/json', 'Accept': 'application/json', 'X-API-Token': config.apiToken};

  final response = await post('$appcenterBaseUrl/${config.owner}/$appName/releases/$releaseId/groups',
      headers: headers, body: encoder.convert(distributionGroup.toJson()));

  if (response.statusCode == 201) {
    return DistributionResult.success(DistributionSuccess());
  } else if (response.statusCode == 404) {
    return DistributionResult.failure(ApiOperationFailure(
      message: 'Distributiongroup: ${distributionGroup.id} cannot be found',
    ));
  } else {
    return DistributionResult.failure(ApiOperationFailure(message: 'Distributing failed error: ${response.body}'));
  }
}
