import 'dart:io';

import 'package:appcenterpublisher/src/api/commit_upload.dart';
import 'package:appcenterpublisher/src/api/create_upload_url.dart';
import 'package:appcenterpublisher/src/api/distribute_to_group.dart';
import 'package:appcenterpublisher/src/event_logger.dart';
import 'package:appcenterpublisher/src/model/run_data.dart';
import 'package:appcenterpublisher/src/parse_yaml.dart';
import 'package:appcenterpublisher/src/upload_orchestrator.dart';
import 'package:args/command_runner.dart';

import 'api/upload_binary.dart';

class PublishAppCommand extends Command<dynamic> {
  PublishAppCommand() {
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
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
      );
  }

  @override
  String get description => 'Upload and and distribute your ipa or apk file to Microsoft Appcenter';

  @override
  String get name => 'publish';

  @override
  Future<void> run() async {
    final eventLogger = EventLogger(verboseLoggingEnabled: argResults['verbose'] as bool);
    final yaml = File(argResults['config'] as String);

    eventLogger.log('Start uploading app');
    final parsedYaml = parseYamlConfig(print, yaml);
    final runData = RunData.fromConfig(
      apiToken: argResults['apiToken'].toString(),
      buildVersion: '0.1',
      artefactlocation: argResults['binary'].toString(),
      yaml: parsedYaml,
    );

    final orchestrator = UploadOrchestrator(
      createUploadUrl: createUploadUrl,
      uploadBinary: uploadBinaryToAppcenter,
      commitUpload: commitUpload,
      distributeToGroup: distributeToGroup,
      eventLogger: eventLogger,
    );

    final result = await orchestrator.run(runData);

    eventLogger.log('Uploading app exited with statuscode $result');
    exit(result);
  }
}
