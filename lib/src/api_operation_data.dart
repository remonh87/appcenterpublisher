import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sum_types/sum_types.dart';
import 'package:meta/meta.dart';

part 'api_operation_data.g.dart';
// ignore_for_file: annotate_overrides

@SumType()
class ReleaseUploadResult extends _$ReleaseUploadResult {
  const ReleaseUploadResult.success(ReleaseUploadOperationSuccess success) : super(success: success);

  const ReleaseUploadResult.failure(ApiOperationFailure failure) : super(failure: failure);
}

@SumType()
class UploadBinaryResult extends _$UploadBinaryResult {
  const UploadBinaryResult.success(UploadBinaryOperationSuccess success) : super(success: success);

  const UploadBinaryResult.failure(ApiOperationFailure failure) : super(failure: failure);
}

class UploadBinaryOperationSuccess {}

@JsonSerializable()
class ReleaseUploadOperationSuccess {
  const ReleaseUploadOperationSuccess(this.uploadId, this.uploadUrl);

  factory ReleaseUploadOperationSuccess.fromJson(Map<String, dynamic> json) =>
      _$ReleaseUploadOperationSuccessFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseUploadOperationSuccessToJson(this);

  final String uploadId;
  final String uploadUrl;
}

@JsonSerializable()
@FunctionalData()
class ApiOperationFailure extends $ApiOperationFailure {
  const ApiOperationFailure({@required this.message});

  factory ApiOperationFailure.fromJson(Map<String, dynamic> json) => _$ApiOperationFailureFromJson(json);

  Map<String, dynamic> toJson() => _$ApiOperationFailureToJson(this);

  final String message;
}
