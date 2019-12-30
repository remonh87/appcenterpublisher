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
            '- Test app1:\n  appName: testApp\n  distributionGroup: aaa\n  owner: test \n- Test app2:\n  appName: testApp2\n  distributionGroup: bb\n  owner: test2');
      });

      test('It returns the mapp with 3 items', () {
        expect(parseYamlConfig(logger.print, yamlFile), [
          {
            'Test app1': 'null',
            'appName': 'testApp',
            'distributionGroup': 'aaa',
            'owner': 'test',
          },
          {
            'Test app2': 'null',
            'appName': 'testApp2',
            'distributionGroup': 'bb',
            'owner': 'test2',
          },
        ]);
      });
    });
  });
}
