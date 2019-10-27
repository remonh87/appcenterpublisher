import 'dart:io';
import 'dart:typed_data';

import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';

Future<UploadBinaryResult> uploadBinaryToAppcenter(String uploadUrl, String filePath) {
  final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

  return uploadBinary(request: request, file: File(filePath));
}

@visibleForTesting
Future<UploadBinaryResult> uploadBinary({@required http.MultipartRequest request, @required File file}) async {
  final contenType = MediaType('multipart', 'form-data');
  Uint8List bytes;
  try {
    bytes = file.readAsBytesSync();
  } on FileSystemException catch (e) {
    return UploadBinaryResult.failure(ApiOperationFailure(message: e.toString()));
  }
  final multiPartfile = http.MultipartFile.fromBytes('ipa', bytes, contentType: contenType);

  request.files.add(multiPartfile);

  return request.send().then((response) {
    if (response.statusCode == 200) {
      return UploadBinaryResult.success(UploadBinaryOperationSuccess());
    } else {
      return UploadBinaryResult.failure(
          ApiOperationFailure(message: 'Upload failed: statuscode=${response.statusCode}'));
    }
  });
}
