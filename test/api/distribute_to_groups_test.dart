import 'package:app_center_uploader/src/api/distribute_to_group.dart';
import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/distribution_group.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

abstract class _HttpClient {
  Future<http.Response> post(dynamic url, {Map<String, String> headers, dynamic body});
}

class _MockHttpClient extends Mock implements _HttpClient {}

void main() {
  group('$distributeToGroup', () {
    _MockHttpClient client;

    final distributionGroup = DistributionGroup(id: '123-456-789', mandatoryUpdate: true, notifyTesters: true);
    final config = ApiConfig(owner: 'test', apiToken: '1243432');

    group('Create correct request', () {
      setUp(() {
        client = _MockHttpClient();
        when(client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) => Future.value(http.Response('', 201)));
      });

      test('It call the correct endpoins and supplies correct arguments', () {
        distributeToGroup(
          post: client.post,
          distributionGroup: distributionGroup,
          config: config,
          releaseId: '1',
          appName: 'testApp',
        );

        final expectedUrl = 'https://api.appcenter.ms/v0.1/apps/test/testApp/releases/1/groups';
        final expectedHeaders = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-API-Token': '1243432'
        };

        verify(
          client.post(
            expectedUrl,
            headers: expectedHeaders,
            body: '{"id":"123-456-789","mandatory_update":true,"notify_testers":true}',
          ),
        ).called(1);
      });
    });

    group('Given distribution is successfull', () {
      setUp(() {
        when(client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) => Future.value(http.Response('{}}', 201)));
      });

      test('It returns $DistributionSuccess', () async {
        final response = await distributeToGroup(
          post: client.post,
          distributionGroup: distributionGroup,
          config: config,
          releaseId: '1',
          appName: 'test',
        );

        final result = response.iswitch(success: (s) => s, failure: (_) => throw AssertionError());

        expect(result, TypeMatcher<DistributionSuccess>());
      });
    });

    group('Given distributiongroup cannot be found', () {
      setUp(() {
        when(client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) => Future.value(http.Response('{}}', 404)));
      });

      test('It returns $ApiOperationFailure', () async {
        final response = await distributeToGroup(
          post: client.post,
          distributionGroup: distributionGroup,
          config: config,
          releaseId: '1',
          appName: 'test',
        );

        final result = response.iswitch(success: (_) => throw AssertionError(), failure: (f) => f);

        expect(result, ApiOperationFailure(message: 'Distributiongroup: 123-456-789 cannot be found'));
      });
    });

    group('Given api call fails', () {
      setUp(() {
        when(client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) => Future.value(http.Response('{whoops}', 400)));
      });

      test('It returns $ApiOperationFailure', () async {
        final response = await distributeToGroup(
          post: client.post,
          distributionGroup: distributionGroup,
          config: config,
          releaseId: '1',
          appName: 'test',
        );

        final result = response.iswitch(success: (_) => throw AssertionError(), failure: (f) => f);

        expect(result, ApiOperationFailure(message: 'Distributing failed error: {whoops}'));
      });
    });
  });
}
