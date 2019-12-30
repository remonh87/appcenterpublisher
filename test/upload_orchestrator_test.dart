import 'dart:convert';

import 'package:appcenterpublisher/src/api_operation_data.dart';
import 'package:appcenterpublisher/src/event_logger.dart';
import 'package:appcenterpublisher/src/model/api_config.dart';
import 'package:appcenterpublisher/src/model/distribution_group.dart';
import 'package:appcenterpublisher/src/model/release_info.dart';
import 'package:appcenterpublisher/src/model/run_data.dart';
import 'package:appcenterpublisher/src/upload_orchestrator.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class _UploadStub {
  Future<ReleaseUploadResult> createUploadUrl({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) callApi,
    @required ApiConfig config,
    @required AppRelease appRelease,
  });

  Future<UploadBinaryResult> uploadBinary(String uploadUrl, String filePath, void Function(String message) log);

  Future<CommitReleaseResult> commitUpload(
      {Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding})
          patch,
      String uploadId,
      ApiConfig config,
      String appName});

  Future<DistributionResult> distributeToGroup({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) post,
    @required DistributionGroup distributionGroup,
    @required ApiConfig config,
    @required String appName,
    @required String releaseId,
  });
}

class _UploaderMock extends Mock implements _UploadStub {}

class _EventLoggerMock extends Mock implements EventLogger {}

void main() {
  _UploaderMock uploader;
  UploadOrchestrator sut;
  const releaseInfo = ReleaseInfo(buildVersion: '1', buildNumber: '2', releaseId: 0);
  const release = AppRelease(appName: 'test', releaseInfo: releaseInfo);
  const config = ApiConfig(owner: 'me', apiToken: '1234');
  const distributionGroup = DistributionGroup(id: '123');
  const artefactLocation = '/test/arctefact.apk';
  final eventLogger = _EventLoggerMock();
  const rundata = [
    RunData(config: config, release: release, group: distributionGroup, artefactLocation: artefactLocation)
  ];

  setUp(() {
    uploader = _UploaderMock();
    sut = UploadOrchestrator(
        createUploadUrl: uploader.createUploadUrl,
        uploadBinary: uploader.uploadBinary,
        commitUpload: uploader.commitUpload,
        distributeToGroup: uploader.distributeToGroup,
        eventLogger: eventLogger);
  });

  group('Start upload', () {
    setUp(() async {
      when(uploader.createUploadUrl(
        callApi: anyNamed('callApi'),
        config: anyNamed('config'),
        appRelease: anyNamed('appRelease'),
      )).thenAnswer((_) => Future.value(const ReleaseUploadResult.failure(ApiOperationFailure(message: ''))));

      when(uploader.uploadBinary(any, any, any))
          .thenAnswer((_) => Future.value(const UploadBinaryResult.failure(ApiOperationFailure(message: ''))));

      when(uploader.commitUpload(
        patch: anyNamed('patch'),
        uploadId: anyNamed('uploadId'),
        appName: anyNamed('appName'),
        config: anyNamed('config'),
      )).thenAnswer((_) => Future.value(const CommitReleaseResult.failure(ApiOperationFailure(message: ''))));

      when(
        uploader.distributeToGroup(
          post: anyNamed('post'),
          distributionGroup: anyNamed('distributionGroup'),
          config: config,
          appName: anyNamed('appName'),
          releaseId: anyNamed('releaseId'),
        ),
      ).thenAnswer((_) => Future.value(DistributionResult.success(DistributionSuccess())));

      await sut.run(rundata);
    });

    test('It executes createuploadurl function with correct arguments', () async {
      verify(uploader.createUploadUrl(callApi: http.post, config: config, appRelease: release)).called(1);
    });

    group('GIVEN create uploadurl succeeds', () {
      const uploadId = 206;
      setUp(() async {
        when(uploader.createUploadUrl(
                callApi: anyNamed('callApi'), config: anyNamed('config'), appRelease: anyNamed('appRelease')))
            .thenAnswer((_) => Future.value(
                ReleaseUploadResult.success(ReleaseUploadOperationSuccess(uploadId.toString(), 'http://upload.test'))));
      });

      test('It executes uploading binary with correct arguments', () async {
        await sut.run(rundata);
        verify(uploader.uploadBinary('http://upload.test', artefactLocation, any)).called(1);
      });

      group('AND uploadBinary succeeds', () {
        setUp(() async {
          when(uploader.uploadBinary(any, any, any))
              .thenAnswer((_) => Future.value(UploadBinaryResult.success(UploadBinaryOperationSuccess())));

          await sut.run(rundata);
        });

        test('It executes commit upload with correct arguments', () async {
          verify(uploader.commitUpload(
                  patch: http.patch, uploadId: uploadId.toString(), config: config, appName: 'test'))
              .called(1);
        });

        group('AND commit release succeeds', () {
          const commitReleaseSuccess = CommitReleaseSuccess('12345678', 'http:/./qu/release12foo');
          setUp(() {
            when(
              uploader.commitUpload(
                  patch: anyNamed('patch'),
                  uploadId: anyNamed('uploadId'),
                  config: anyNamed('config'),
                  appName: anyNamed('appName')),
            ).thenAnswer((_) => Future.value(const CommitReleaseResult.success(commitReleaseSuccess)));
          });

          test('It calls distribute to group', () async {
            await sut.run(rundata);
            final group = DistributionGroup(id: distributionGroup.id, mandatoryUpdate: true, notifyTesters: true);
            verify(
              uploader.distributeToGroup(
                  post: http.post,
                  distributionGroup: group,
                  config: config,
                  appName: release.appName,
                  releaseId: commitReleaseSuccess.releaseId),
            ).called(1);
          });

          group('AND distribute to group succeeds', () {
            setUp(() {
              when(
                uploader.distributeToGroup(
                  post: anyNamed('post'),
                  distributionGroup: anyNamed('distributionGroup'),
                  config: config,
                  appName: anyNamed('appName'),
                  releaseId: anyNamed('releaseId'),
                ),
              ).thenAnswer((_) => Future.value(DistributionResult.success(DistributionSuccess())));
            });

            test('It returns exit code 0', () async {
              final result = await sut.run(rundata);
              expect(result, 0);
            });
          });

          group('AND distribute to group fails', () {
            setUp(() {
              when(
                uploader.distributeToGroup(
                  post: anyNamed('post'),
                  distributionGroup: anyNamed('distributionGroup'),
                  config: config,
                  appName: anyNamed('appName'),
                  releaseId: anyNamed('releaseId'),
                ),
              ).thenAnswer(
                  (_) => Future.value(const DistributionResult.failure(ApiOperationFailure(message: 'whoops'))));
            });

            test('It returns exit code 1', () async {
              final result = await sut.run(rundata);
              expect(result, 1);
            });
          });
        });

        group('AND commit release fails', () {
          setUp(() {
            when(
              uploader.commitUpload(
                  patch: anyNamed('patch'),
                  uploadId: anyNamed('uploadId'),
                  config: anyNamed('config'),
                  appName: anyNamed('appName')),
            ).thenAnswer(
                (_) => Future.value(const CommitReleaseResult.failure(ApiOperationFailure(message: 'commit failed'))));
          });

          test('It returns exit code 1®', () async {
            final result = await sut.run(rundata);
            expect(result, 1);
          });
        });
      });

      group('AND uploadBinary fails', () {
        var result = -100;

        setUp(() async {
          when(uploader.uploadBinary(any, any, any)).thenAnswer(
              (_) => Future.value(const UploadBinaryResult.failure(ApiOperationFailure(message: 'failed'))));
          result = await sut.run(rundata);
        });

        test('It returns exitcode 1', () async {
          expect(result, 1);
        });

        test('It does not call commit release', () {
          verifyNever(uploader.commitUpload(
            patch: anyNamed('patch'),
            appName: anyNamed('appName'),
            uploadId: anyNamed('uploadId'),
            config: anyNamed('config'),
          ));
        });
      });
    });

    group('Given create uploadurl fails', () {
      setUp(() async {
        when(uploader.createUploadUrl(
                callApi: anyNamed('callApi'), config: anyNamed('config'), appRelease: anyNamed('appRelease')))
            .thenAnswer((_) => Future.value(const ReleaseUploadResult.failure(ApiOperationFailure(message: ''))));
      });

      test('It returns exitcode 1', () async {
        final result = await sut.run(rundata);
        expect(result, 1);
      });
    });
  });
}
