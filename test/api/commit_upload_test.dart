import 'dart:convert';

import 'package:app_center_uploader/src/api/commit_upload.dart';
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
    group('Create request', () {
      _MockHttpClient client;

      final payload = <String, dynamic>{'status': 'comitted'};
      const config = ApiConfig(owner: 'test', apiToken: '12345');

      setUp(() {
        client = _MockHttpClient();
      });

      test('It creates correct request', () {
        commitUpload(client.patch, '10', config, 'testApp');
        verify(client.patch(
          'https://api.appcenter.ms/v0.1/apps/test/testApp/release_uploads/10',
          headers: {'Content-Type': 'application/json', 'X-API-Token': '12345'},
          body: payload,
        )).called(1);
      });
    });
  });
}
