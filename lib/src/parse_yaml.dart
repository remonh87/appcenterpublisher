import 'dart:io';

import 'package:yaml/yaml.dart' as yaml;

Map<String, String> parseYamlConfig(void Function(Object object) log, File yamlFile) {
  final fileContents = yamlFile.readAsStringSync();
  log('Parsing yamlfile: ${yamlFile.path}');

  final config = yaml.loadYaml(fileContents) as yaml.YamlMap;

  final convertedMap = config.map((dynamic key, dynamic value) => MapEntry(key.toString(), value.toString()));
  return convertedMap;
}
