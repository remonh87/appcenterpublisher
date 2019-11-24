import 'dart:io';

import 'package:yaml/yaml.dart' as yaml;

Map<String, String> parseYamlConfig(
    void Function(Object object) log, File yamlFile) {
  final fileContents = yamlFile.readAsStringSync();
  log('Parsing yamlfile: ${yamlFile.path}');

  try {
    final config = yaml.loadYaml(fileContents) as yaml.YamlMap;

    final convertedMap =
        config.map((k, v) => MapEntry(k.toString(), v.toString()));
    return convertedMap;
  } on Error catch (e) {
    log('Error parsing yaml failed message: $e');
    throw ParseConfigException(e.toString());
  }
}

class ParseConfigException {
  const ParseConfigException(this.message);

  final String message;
}
