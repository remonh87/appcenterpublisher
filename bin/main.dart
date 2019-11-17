import 'package:app_center_uploader/src/upload_app_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  CommandRunner<dynamic>('uploader', 'Tooling to upload and distribute app binaries to Appcenter')
    ..addCommand(UploadAppCommand())
    ..run(args);
}
