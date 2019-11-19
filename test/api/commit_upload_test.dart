import 'dart:convert';

import 'package:app_center_uploader/src/api/commit_upload.dart';
import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

abstract class _HttpClient {
  Future<http.Response> patch(dynamic url, {Map<String, String> headers, dynamic body, Encoding encoding});
}

class _MockHttpClient extends Mock implements _HttpClient {}

void main() {
  group('$commitUpload', () {
    _MockHttpClient client;

    setUp(() {
      client = _MockHttpClient();
      when(client.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) => Future.value(http.Response('{}', 200)));
    });
    group('Create request', () {
      final payload = '{ "status": "committed"  }';
      const config = ApiConfig(owner: 'test', apiToken: '12345');

      test('It creates correct request', () {
        commitUpload(patch: client.patch, uploadId: '10', config: config, appName: 'testApp');
        verify(client.patch(
          'https://api.appcenter.ms/v0.1/apps/test/testApp/release_uploads/10',
          headers: {'Content-Type': 'application/json', 'X-API-Token': '12345'},
          body: payload,
        )).called(1);
      });

      group('GIVEN api returns success', () {
        setUp(() {
          when(client.patch(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer(
              (_) => Future.value(http.Response('{"release_id": "1234", "release_url": "http://foo1234"}', 200)));
        });

        test('It returns release id', () async {
          final response = await commitUpload(patch: client.patch, uploadId: '10', config: config, appName: 'test app');
          final result = response.iswitch(success: (s) => s, failure: (_) => throw AssertionError());
          expect(result.releaseId, '1234');
        });

        test('It returns release url', () async {
          final response = await commitUpload(patch: client.patch, uploadId: '10', config: config, appName: 'test app');
          final result = response.iswitch(success: (s) => s, failure: (_) => throw AssertionError());
          expect(result.releaseUrl, "http://foo1234");
        });
      });

      group('GIVEN api returns error', () {
        setUp(() {
          when(client.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
              .thenAnswer((_) => Future.value(http.Response('something went wrong', 401)));
        });

        test('It returns $ApiOperationFailure', () async {
          final response = await commitUpload(patch: client.patch, uploadId: '10', config: config, appName: 'test app');
          final result = response.iswitch(success: (_) => throw AssertionError(), failure: (f) => f);
          expect(result, const ApiOperationFailure(message: 'Api returned 401 message: something went wrong'));
        });
      });
    });
  });
}
