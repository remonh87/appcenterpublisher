import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:app_center_uploader/src/upload_orchestrator.dart';
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

  Future<UploadBinaryResult> uploadBinary(String uploadUrl, String filePath);
}

class _MockUploader extends Mock implements _UploadStub {}

void main() {
  _MockUploader uploader;
  UploadOrchestrator sut;
  const releaseInfo = ReleaseInfo(buildVersion: '1', buildNumber: '2', releaseId: 0);
  const release = AppRelease(appName: 'test', releaseInfo: releaseInfo);
  const config = ApiConfig(owner: 'me', apiToken: '1234');

  setUp(() {
    uploader = _MockUploader();
    sut = UploadOrchestrator(createUploadUrl: uploader.createUploadUrl, uploadBinary: uploader.uploadBinary);
  });

  group('Start upload', () {
    setUp(() async {
      when(uploader.createUploadUrl(
              callApi: anyNamed('callApi'), config: anyNamed('config'), appRelease: anyNamed('appRelease')))
          .thenAnswer((_) => Future.value(const ReleaseUploadResult.failure(ApiOperationFailure(message: ''))));

      await sut.run(config, release);
    });

    test('It executes createuploadurl function with correct arguments', () async {
      verify(uploader.createUploadUrl(callApi: http.post, config: config, appRelease: release)).called(1);
    });

    group('GIVEN create uploadurl succeeds', () {
      setUp(() async {
        when(uploader.createUploadUrl(
                callApi: anyNamed('callApi'), config: anyNamed('config'), appRelease: anyNamed('appRelease')))
            .thenAnswer((_) => Future.value(
                const ReleaseUploadResult.success(ReleaseUploadOperationSuccess('1', 'http://upload.test'))));
      });

      group('AND uploadBinary succeeds', () {
        setUp(() async {
          when(uploader.uploadBinary(any, any))
              .thenAnswer((_) => Future.value(UploadBinaryResult.success(UploadBinaryOperationSuccess())));

          await sut.run(config, release);
        });

        test('It executes uploading binary with correct arguments', () async {
          verify(uploader.uploadBinary('http://upload.test', 'stub')).called(1);
        });

        test('It returns exit code 0', () async {
          final result = await sut.run(config, release);

          expect(result, 0);
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
        final result = await sut.run(config, release);
        expect(result, 1);
      });
    });
  });
}
