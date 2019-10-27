import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UploadOrchestrator {
  const UploadOrchestrator({@required this.createUploadUrl, @required this.uploadBinary});

  final Future<ReleaseUploadResult> Function({
    @required Future<http.Response> Function(dynamic url, {Map<String, String> headers, dynamic body}) callApi,
    @required ApiConfig config,
    @required AppRelease appRelease,
  }) createUploadUrl;

  final Future<UploadBinaryResult> Function(String uploadUrl, String filePath) uploadBinary;

  Future<int> run(ApiConfig config, AppRelease appRelease) async {
    final result = await createUploadUrl(callApi: http.post, config: config, appRelease: appRelease);

    //TODO parse file and remove stub
    return await result.iswitch(success: (s) => _uploadBinary(s.uploadUrl), failure: (_) => 1);
  }

  Future<int> _uploadBinary(String uploadUrl) async {
    final result = await uploadBinary(uploadUrl, 'stub');
    return result.iswitch(success: (_) => 0, failure: (_) => 1);
  }
}
