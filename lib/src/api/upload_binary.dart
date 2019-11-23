import 'package:appcenterpublisher/src/api_operation_data.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';

Future<UploadBinaryResult> uploadBinaryToAppcenter(
    String uploadUrl, String filePath, void Function(String message) log) {
  log('Upload url = $uploadUrl');
  final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
  log('Reading file from $filePath');

  return uploadBinary(request: request, path: filePath, log: log);
}

@visibleForTesting
Future<UploadBinaryResult> uploadBinary({
  @required http.MultipartRequest request,
  @required String path,
  void Function(String message) log,
}) async {
  final contenType = MediaType('multipart', 'form-data');

  final multiPartfile = await http.MultipartFile.fromPath('ipa', path, contentType: contenType);
  request.files.add(multiPartfile);

  return request.send().then((response) {
    if (response.statusCode == 204) {
      return UploadBinaryResult.success(UploadBinaryOperationSuccess());
    } else {
      return UploadBinaryResult.failure(
          ApiOperationFailure(message: 'Upload failed: statuscode=${response.statusCode}'));
    }
  });
}
