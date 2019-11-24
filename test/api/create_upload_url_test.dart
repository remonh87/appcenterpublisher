import 'package:appcenterpublisher/src/api_operation_data.dart';
import 'package:appcenterpublisher/src/model/api_config.dart';
import 'package:appcenterpublisher/src/api/create_upload_url.dart';
import 'package:appcenterpublisher/src/model/release_info.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// ignore: one_member_abstracts
abstract class _HttpClient {
  Future<Response> sendRequest(
    dynamic url, {
    Map<String, String> headers,
    dynamic body,
  });
}

class _MockHttpClient extends Mock implements _HttpClient {}

void main() {
  group('Create upload url', () {
    _MockHttpClient client;
    const config = ApiConfig(owner: 'owner', apiToken: '1223');

    const releaseInfo =
        ReleaseInfo(buildNumber: '1234', releaseId: 178, buildVersion: '1.0.1');
    const appRelease = AppRelease(appName: 'myApp', releaseInfo: releaseInfo);

    group('GIVEN api call is succesfull', () {
      const responseBody =
          '{"upload_id": "123", "upload_url": "htpp://123.foo", "asset_id": "a","asset_domain": "b","asset_token": "c"}';
      setUp(() {
        client = _MockHttpClient();
        when(client.sendRequest(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) => Future.value(Response(responseBody, 201)));
      });

      test('It sends out empty body in case no release config specified ', () {
        const releaseInfo = ReleaseInfo();
        const appRelease =
            AppRelease(appName: 'myApp', releaseInfo: releaseInfo);
        createUploadUrl(
            callApi: client.sendRequest,
            config: config,
            appRelease: appRelease);

        verify(client.sendRequest(
                'https://api.appcenter.ms/v0.1/apps/owner/myApp/release_uploads',
                headers: const {
                  'Content-Type': 'application/json',
                  'X-API-Token': '1223'
                },
                body: '{}'))
            .called(1);
      });

      test('It sends out correct request', () {
        createUploadUrl(
            callApi: client.sendRequest,
            config: config,
            appRelease: appRelease);

        verify(client.sendRequest(
          'https://api.appcenter.ms/v0.1/apps/owner/myApp/release_uploads',
          headers: const {
            'Content-Type': 'application/json',
            'X-API-Token': '1223'
          },
          body:
              '{"build_version":"1.0.1","build_number":"1234","release_id":178}',
        )).called(1);
      });
      // {"buildVersion":"1.0.1","buildNumber":"1234","releaseId":178}
      // {"build_version":"1.0.1","build_number":"1234","release_id":178}
      test('It returns correct uploadid', () async {
        final response = await createUploadUrl(
            callApi: client.sendRequest,
            config: config,
            appRelease: appRelease);
        final result = response.iswitch<ReleaseUploadOperationSuccess>(
            success: (s) => s,
            failure: (_) => throw AssertionError("Should not fail"));
        expect(result.uploadId, '123');
      });

      test('It returns correct uploadUrl', () async {
        final response = await createUploadUrl(
            callApi: client.sendRequest,
            config: config,
            appRelease: appRelease);
        final result = response.iswitch<ReleaseUploadOperationSuccess>(
            success: (s) => s,
            failure: (_) => throw AssertionError("Should not fail"));
        expect(result.uploadUrl, 'htpp://123.foo');
      });
    });

    group('Given api fails', () {
      const responseBody = '{"message": "whoops"}';

      setUp(() {
        client = _MockHttpClient();
        when(client.sendRequest(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) => Future.value(Response(responseBody, 500)));
      });

      test('It retuns $ApiOperationFailure', () async {
        final response = await createUploadUrl(
            callApi: client.sendRequest,
            config: config,
            appRelease: appRelease);
        final result = response.iswitch<ApiOperationFailure>(
            success: (_) => throw AssertionError('Expect call to fail'),
            failure: (f) => f);

        expect(result.message, 'whoops');
      });
    });
  });
}
