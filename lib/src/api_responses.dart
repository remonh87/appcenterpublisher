import 'package:sum_types/sum_types.dart';
import 'package:meta/meta.dart';

part 'api_responses.g.dart';

@SumType([
  Case<ReleaseUploadResponseSuccess>(name: "success"),
  Case<ApiReponseFailure>(name: "failure"),
])
mixin _ReleaseUploadResponse implements _ReleaseUploadResponseBase {}

class ReleaseUploadResponseSuccess {
  const ReleaseUploadResponseSuccess(this.uploadId, this.uploadUrl);
  final String uploadId;
  final String uploadUrl;
}

class ApiReponseFailure {
  const ApiReponseFailure({@required this.message});
  final String message;
}
