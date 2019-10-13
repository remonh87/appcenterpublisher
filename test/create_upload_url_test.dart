import 'dart:convert';

import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/create_upload_url.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
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

    group('Create correct request', () {
      setUp(() {
        client = _MockHttpClient();
      });

      test('It sends out empty body in case no release config specified ', () {
        const releaseInfo = ReleaseInfo(appName: 'myApp');
        createUploadUrl(callApi: client.sendRequest, config: config, releaseInfo: releaseInfo);

        verify(client.sendRequest('https://api.appcenter.ms/v0.1/apps/owner/myApp/release_uploads',
                headers: const {'Content-Type': 'application/json', 'X-API-Token': '1223'}, body: '{}'))
            .called(1);
      });

      test('It sends out ', () {
        const releaseInfo = ReleaseInfo(appName: 'myApp', buildNumber: '1234', releaseId: 178, buildVersion: '1.0.1');
        createUploadUrl(callApi: client.sendRequest, config: config, releaseInfo: releaseInfo);

        verify(client.sendRequest(
          'https://api.appcenter.ms/v0.1/apps/owner/myApp/release_uploads',
          headers: const {'Content-Type': 'application/json', 'X-API-Token': '1223'},
          body: '{"release_id":178,"build_version":"1.0.1","build_number":"1234"}',
        )).called(1);
      });
    });
  });
}
