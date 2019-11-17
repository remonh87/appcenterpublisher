import 'dart:convert';

import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/distribution_group.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:app_center_uploader/src/model/run_data.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UploadOrchestrator {
  const UploadOrchestrator({
    @required this.createUploadUrl,
    @required this.uploadBinary,
    @required this.commitUpload,
    @required this.distributeToGroup,
  });

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

  final Future<DistributionResult> Function({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) post,
    @required DistributionGroup distributionGroup,
    @required ApiConfig config,
    @required String appName,
    @required int releaseId,
  }) distributeToGroup;

  Future<int> run(RunData rundata) async {
    final result = await createUploadUrl(callApi: http.post, config: rundata.config, appRelease: rundata.release);

    return await result.iswitch(
        success: (createReleaseResult) async {
          final uploadResult = await _uploadBinary(createReleaseResult.uploadUrl, rundata.artefactLocation);
          return uploadResult.iswitch(
              success: (_) async {
                final commitResult =
                    await _commitRelease(createReleaseResult.uploadId, rundata.config, rundata.release.appName);
                return commitResult.iswitch(
                    success: (c) =>
                        _distributeToGroup(rundata.config, c.releaseId, rundata.release.appName, rundata.group.id),
                    failure: (_) => 1);
              },
              failure: (_) => 1);
        },
        failure: (_) => 1);
  }

  Future<UploadBinaryResult> _uploadBinary(String uploadUrl, String artefactLocation) async =>
      await uploadBinary(uploadUrl, artefactLocation);

  Future<CommitReleaseResult> _commitRelease(String uploadId, ApiConfig config, String appName) async =>
      await commitUpload(patch: http.patch, uploadId: uploadId, config: config, appName: appName);

  Future<int> _distributeToGroup(ApiConfig config, int releaseId, String appName, String distributionGroup) async {
    final distributiongroup = DistributionGroup(id: distributionGroup);
    final result = await distributeToGroup(
      post: http.post,
      distributionGroup: distributiongroup,
      config: config,
      appName: appName,
      releaseId: releaseId,
    );

    return result.iswitch(success: (_) => 0, failure: (_) => 1);
  }
}
