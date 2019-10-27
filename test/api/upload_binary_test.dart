import 'dart:io';
import 'dart:typed_data';

import 'package:app_center_uploader/src/api/upload_binary.dart';
import 'package:app_center_uploader/src/api_operation_data.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class _MockMultiPartRequest extends Mock implements MultipartRequest {}

class _MockFile extends Mock implements File {}

void main() {
  group('$uploadBinary', () {
    _MockMultiPartRequest request;
    _MockFile file;

    final byteStream = Stream.fromIterable([
      [1, 2, 3],
      [3, 2, 1]
    ]);
    final apiResponse = StreamedResponse(byteStream, 200);

    setUp(() {
      final files = <MultipartFile>[];
      request = _MockMultiPartRequest();
      file = _MockFile();
      when(file.readAsBytesSync()).thenReturn(Uint8List.fromList([1, 2, 3, 4]));
      when(request.files).thenReturn(files);
    });

    group('Create correct request', () {
      setUp(() {
        when(request.send()).thenAnswer((_) => Future.value(apiResponse));
      });
      test('It adds file to request ', () {
        uploadBinary(request: request, file: file);

        expect(request.files.length, 1);
      });

      group('GIVEN file does not exist', () {
        setUp(() {
          when(file.readAsBytesSync()).thenThrow(const FileSystemException("File does not exist", "", null));
        });

        test('It returns $ApiOperationFailure', () async {
          final response = await uploadBinary(request: request, file: file);
          final result = response.iswitch<ApiOperationFailure>(
              success: (_) => throw AssertionError("Operation should not succeed"), failure: (f) => f);

          expect(result, const ApiOperationFailure(message: "FileSystemException: File does not exist, path = ''"));
        });
      });
    });

    group('GIVEN upload request succeeds', () {
      setUp(() {
        when(request.send()).thenAnswer((_) => Future.value(apiResponse));
      });

      test('It returns success', () async {
        final response = await uploadBinary(request: request, file: file);
        final result = response.iswitch<UploadBinaryOperationSuccess>(
          success: (s) => s,
          failure: (_) => throw AssertionError('this is not expected to fail'),
        );

        expect(result, const TypeMatcher<UploadBinaryOperationSuccess>());
      });
    });

    group('GIVEN upload request fails', () {
      setUp(() {
        final apiResponse = StreamedResponse(Stream.fromIterable(<List<int>>[]), 500);
        when(request.send()).thenAnswer((_) => Future.value(apiResponse));
      });

      test('It returns $ApiOperationFailure', () async {
        final response = await uploadBinary(request: request, file: file);
        final result = response.iswitch<ApiOperationFailure>(
          success: (s) => throw AssertionError('this is not expected to fail'),
          failure: (f) => f,
        );

        expect(result, const ApiOperationFailure(message: 'Upload failed: statuscode=500'));
      });
    });
  });
}
