import 'package:json_annotation/json_annotation.dart';
import 'package:sum_types/sum_types.dart';
import 'package:meta/meta.dart';

part 'api_responses.g.dart';

@SumType([
  Case<ReleaseUploadResponseSuccess>(name: "success"),
  Case<ApiReponseFailure>(name: "failure"),
])
mixin _ReleaseUploadResponse implements _ReleaseUploadResponseBase {}

@JsonSerializable()
class ReleaseUploadResponseSuccess {
  const ReleaseUploadResponseSuccess(this.uploadId, this.uploadUrl);

  factory ReleaseUploadResponseSuccess.fromJson(Map<String, dynamic> json) =>
      _$ReleaseUploadResponseSuccessFromJson(json);

  final String uploadId;
  final String uploadUrl;
}

@JsonSerializable()
class ApiReponseFailure {
  const ApiReponseFailure({@required this.message});

  factory ApiReponseFailure.fromJson(Map<String, dynamic> json) => _$ApiReponseFailureFromJson(json);

  final String message;
}
