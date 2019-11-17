import 'dart:io';

import 'package:app_center_uploader/src/api/commit_upload.dart';
import 'package:app_center_uploader/src/api/create_upload_url.dart';
import 'package:app_center_uploader/src/api/distribute_to_group.dart';
import 'package:app_center_uploader/src/model/run_data.dart';
import 'package:app_center_uploader/src/parse_yaml.dart';
import 'package:app_center_uploader/src/upload_orchestrator.dart';
import 'package:args/command_runner.dart';

import 'api/upload_binary.dart';

class UploadAppCommand extends Command<dynamic> {
  UploadAppCommand() {
    argParser
      ..addOption(
        'apiToken',
        abbr: 'a',
        help: 'MS appcenter API token. This needs to be created in appcenter',
      )
      ..addOption(
        'binary',
        abbr: 'b',
        help: 'Path of the apk or ipa file',
        valueHelp: 'path',
      )
      ..addOption(
        'config',
        abbr: 'c',
        help: 'Path to the config yaml',
        valueHelp: 'path',
      );
  }

  @override
  String get description => 'Upload and and distribute your ipa or apk file to Microsoft Appcenter';

  @override
  String get name => 'upload';

  @override
  Future<void> run() async {
    final yaml = File(argResults['config'] as String);
    final parsedYaml = parseYamlConfig(print, yaml);
    final runData = RunData.fromConfig(
      apiToken: argResults['apiToken'],
      buildVersion: '0.1',
      artefactlocation: argResults['binary'],
      yaml: parsedYaml,
    );

    final orchestrator = UploadOrchestrator(
        createUploadUrl: createUploadUrl,
        uploadBinary: uploadBinaryToAppcenter,
        commitUpload: commitUpload,
        distributeToGroup: distributeToGroup);

    final result = await orchestrator.run(runData);
    exit(result);
  }
}
