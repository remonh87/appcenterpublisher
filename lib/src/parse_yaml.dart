import 'dart:io';

import 'package:yaml/yaml.dart' as yaml;

Iterable<Map<String, String>> parseYamlConfig(void Function(Object object) log, File yamlFile) {
  final fileContents = yamlFile.readAsStringSync();
  log('Parsing yamlfile: ${yamlFile.path}');

  final config = yaml.loadYaml(fileContents) as yaml.YamlList;

  final convertedMap = config.map((dynamic entry) =>
      (entry as yaml.YamlMap).map((dynamic key, dynamic value) => MapEntry(key.toString(), value.toString())));

  return convertedMap;
}
