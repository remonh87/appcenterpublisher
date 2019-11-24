import 'dart:io';

import 'package:appcenterpublisher/src/parse_yaml.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// ignore: one_member_abstracts
abstract class _Logger {
  void print(Object object);
}

class _MockLogger extends Mock implements _Logger {}

class _Mockfile extends Mock implements File {}

void main() {
  _Mockfile yamlFile;
  _MockLogger logger;

  group('$parseYamlConfig', () {
    setUp(() {
      yamlFile = _Mockfile();
      logger = _MockLogger();
    });

    group('GIVEN yaml is valid', () {
      setUp(() {
        when(yamlFile.readAsStringSync()).thenReturn(
            'appName: testApp\ndistributionGroup: aaa\nowner: test');
      });

      test('It returns the mapp with 3 items', () {
        expect(parseYamlConfig(logger.print, yamlFile), {
          'appName': 'testApp',
          'distributionGroup': 'aaa',
          'owner': 'test',
        });
      });
    });
  });
}
