import 'package:appcenterpublisher/src/publish_app_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  CommandRunner<dynamic>('distributor', 'Tooling to upload and distribute app binaries to Appcenter')
    ..addCommand(PublishAppCommand())
    ..run(args);
}
