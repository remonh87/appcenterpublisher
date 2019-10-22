// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseUploadResponseSuccess _$ReleaseUploadResponseSuccessFromJson(
    Map<String, dynamic> json) {
  return ReleaseUploadResponseSuccess(
    json['uploadId'] as String,
    json['uploadUrl'] as String,
  );
}

Map<String, dynamic> _$ReleaseUploadResponseSuccessToJson(
        ReleaseUploadResponseSuccess instance) =>
    <String, dynamic>{
      'uploadId': instance.uploadId,
      'uploadUrl': instance.uploadUrl,
    };

ApiReponseFailure _$ApiReponseFailureFromJson(Map<String, dynamic> json) {
  return ApiReponseFailure(
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ApiReponseFailureToJson(ApiReponseFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

abstract class _ReleaseUploadResponseBase {
  __T iswitch<__T>({
    @required __T Function(ReleaseUploadResponseSuccess) success,
    @required __T Function(ApiReponseFailure) failure,
  });
  __T iswitcho<__T>({
    __T Function(ReleaseUploadResponseSuccess) success,
    __T Function(ApiReponseFailure) failure,
    @required __T Function() otherwise,
  });
}

class ReleaseUploadResponse
    with _ReleaseUploadResponse
    implements _ReleaseUploadResponseBase {
  const ReleaseUploadResponse.success(
    ReleaseUploadResponseSuccess success,
  ) : this._unsafe(success: success);
  const ReleaseUploadResponse.failure(
    ApiReponseFailure failure,
  ) : this._unsafe(failure: failure);
  const ReleaseUploadResponse._unsafe({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null ||
            success == null && failure != null);
  static ReleaseUploadResponse
      load<__T extends ReleaseUploadResponseRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.success != null && rec.failure == null ||
        rec.success == null && rec.failure != null)) {
      throw Exception("Cannot select a $ReleaseUploadResponse case given $rec");
    }
    return ReleaseUploadResponse._unsafe(
      success: rec.success,
      failure: rec.failure,
    );
  }

  __T dump<__T>(
    __T Function({
      ReleaseUploadResponseSuccess success,
      ApiReponseFailure failure,
    })
        make,
  ) {
    return iswitch(
      success: (success) => make(success: success),
      failure: (failure) => make(failure: failure),
    );
  }

  @override
  __T iswitch<__T>({
    @required __T Function(ReleaseUploadResponseSuccess) success,
    @required __T Function(ApiReponseFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError(
          "an instance of $ReleaseUploadResponse has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(ReleaseUploadResponseSuccess) success,
    __T Function(ApiReponseFailure) failure,
    @required __T Function() otherwise,
  }) {
    __T _otherwise(Object _) => otherwise();
    return iswitch(
      success: success ?? _otherwise,
      failure: failure ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType &&
        other.success == success &&
        other.failure == failure;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + success.hashCode;
    result = 37 * result + failure.hashCode;
    return result;
  }

  @override
  String toString() {
    final ctor = iswitch(
      success: (value) => "success($value)",
      failure: (value) => "failure($value)",
    );
    return "$runtimeType.$ctor";
  }

  @protected
  final ReleaseUploadResponseSuccess success;
  @protected
  final ApiReponseFailure failure;
}

abstract class ReleaseUploadResponseRecordBase<Self> {
  ReleaseUploadResponseSuccess get success;
  ApiReponseFailure get failure;
}
