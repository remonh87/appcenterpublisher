import 'dart:convert';

import 'package:appcenterpublisher/src/api_operation_data.dart';
import 'package:appcenterpublisher/src/event_logger.dart';
import 'package:appcenterpublisher/src/model/api_config.dart';
import 'package:appcenterpublisher/src/model/distribution_group.dart';
import 'package:appcenterpublisher/src/model/release_info.dart';
import 'package:appcenterpublisher/src/model/run_data.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UploadOrchestrator {
  const UploadOrchestrator({
    @required this.createUploadUrl,
    @required this.uploadBinary,
    @required this.commitUpload,
    @required this.distributeToGroup,
    @required this.eventLogger,
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

  final Future<UploadBinaryResult> Function(
    String uploadUrl,
    String filePath,
    void Function(String message) log,
  ) uploadBinary;

  final Future<DistributionResult> Function({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) post,
    @required DistributionGroup distributionGroup,
    @required ApiConfig config,
    @required String appName,
    @required String releaseId,
  }) distributeToGroup;

  final EventLogger eventLogger;

  Future<int> run(Iterable<RunData> rundata) async {
    var result = 0;
    for (final data in rundata) {
      eventLogger.log('=== Start distributing ${data.release.appName} ===');
      result += await _run(data);
    }
    return result;
  }

  Future<int> _run(RunData rundata) async {
    eventLogger.log('Creating upload url ...');
    final result = await createUploadUrl(callApi: http.post, config: rundata.config, appRelease: rundata.release);

    return await result.iswitch(success: (createReleaseResult) async {
      eventLogger..log('Creating upload url succeeded')..log('Uploading binary from ${rundata.artefactLocation}...');
      final uploadResult = await _uploadBinary(createReleaseResult.uploadUrl, rundata.artefactLocation);
      return uploadResult.iswitch(success: (_) async {
        eventLogger..log('Uploading binary succesfull')..log('Committing release ...');
        final commitResult =
            await _commitRelease(createReleaseResult.uploadId, rundata.config, rundata.release.appName);
        return commitResult.iswitch(success: (c) {
          eventLogger..log('Commiting release succesfull')..log('Distributing release ...');
          return _distributeToGroup(rundata.config, c.releaseId, rundata.release.appName, rundata.group.id);
        }, failure: (f) {
          eventLogger.log('Comitting release failed: $f');
          return 1;
        });
      }, failure: (f) {
        eventLogger.log('Uploading binary failed: $f');
        return 1;
      });
    }, failure: (f) {
      eventLogger.log('Creating upload url failed: $f');
      return 1;
    });
  }

  Future<UploadBinaryResult> _uploadBinary(String uploadUrl, String artefactLocation) async =>
      uploadBinary(uploadUrl, artefactLocation, eventLogger.logVerbose);

  Future<CommitReleaseResult> _commitRelease(String uploadId, ApiConfig config, String appName) async =>
      commitUpload(patch: http.patch, uploadId: uploadId, config: config, appName: appName);

  Future<int> _distributeToGroup(ApiConfig config, String releaseId, String appName, String distributionGroup) async {
    eventLogger.log('Start distributing release');
    final distributiongroup = DistributionGroup(id: distributionGroup);
    final result = await distributeToGroup(
      post: http.post,
      distributionGroup: distributiongroup,
      config: config,
      appName: appName,
      releaseId: releaseId,
    );

    return result.iswitch(success: (_) {
      eventLogger.log('Distributed release succesfull');
      return 0;
    }, failure: (f) {
      eventLogger.log('Failed to distribute release: $f');
      return 1;
    });
  }
}
