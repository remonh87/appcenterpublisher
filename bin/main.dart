import 'package:appcenterpublisher/src/publish_app_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  CommandRunner<dynamic>(
      'publisher', 'Tooling to upload and distribute apps to Appcenter')
    ..addCommand(PublishAppCommand())
    ..run(args);
}
