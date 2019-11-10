import 'dart:convert';

import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UploadOrchestrator {
  const UploadOrchestrator({@required this.createUploadUrl, @required this.uploadBinary, @required this.commitUpload});

  final Future<ReleaseUploadResult> Function({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) callApi,
    @required ApiConfig config,
    @required AppRelease appRelease,
  }) createUploadUrl;

  final Future<CommitReleaseResult> Function(
      {@required
          Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding})
              patch,
      @required
          String uploadId,
      @required
          ApiConfig config,
      @required
          String appName}) commitUpload;

  final Future<UploadBinaryResult> Function(String uploadUrl, String filePath) uploadBinary;

  Future<int> run(ApiConfig config, AppRelease appRelease) async {
    final result = await createUploadUrl(callApi: http.post, config: config, appRelease: appRelease);

    return await result.iswitch(
        success: (createReleaseResult) async {
          final uploadResult = await _uploadBinary(createReleaseResult.uploadUrl);
          return uploadResult.iswitch(
              success: (_) => _commitRelease(createReleaseResult.uploadId, config, appRelease.appName),
              failure: (_) => 1);
        },
        failure: (_) => 1);
  }

  Future<UploadBinaryResult> _uploadBinary(String uploadUrl) async {
    return await uploadBinary(uploadUrl, 'stub');
  }

  Future<int> _commitRelease(String uploadId, ApiConfig config, String appName) async {
    final result = await commitUpload(patch: http.patch, uploadId: uploadId, config: config, appName: appName);

    return result.iswitch(success: (_) => 0, failure: (_) => 1);
  }
}
