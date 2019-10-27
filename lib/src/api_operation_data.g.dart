// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_operation_data.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $ApiOperationFailure {
  String get message;
  const $ApiOperationFailure();
  ApiOperationFailure copyWith({String message}) =>
      ApiOperationFailure(message: message ?? this.message);
  String toString() => "ApiOperationFailure(message: $message)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && message == other.message;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + message.hashCode;
    return result;
  }
}

class ApiOperationFailure$ {
  static final message = Lens<ApiOperationFailure, String>(
      (s_) => s_.message, (s_, message) => s_.copyWith(message: message));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseUploadOperationSuccess _$ReleaseUploadOperationSuccessFromJson(
    Map<String, dynamic> json) {
  return ReleaseUploadOperationSuccess(
    json['uploadId'] as String,
    json['uploadUrl'] as String,
  );
}

Map<String, dynamic> _$ReleaseUploadOperationSuccessToJson(
        ReleaseUploadOperationSuccess instance) =>
    <String, dynamic>{
      'uploadId': instance.uploadId,
      'uploadUrl': instance.uploadUrl,
    };

ApiOperationFailure _$ApiOperationFailureFromJson(Map<String, dynamic> json) {
  return ApiOperationFailure(
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ApiOperationFailureToJson(
        ApiOperationFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

abstract class _ReleaseUploadResultBase {
  __T iswitch<__T>({
    @required __T Function(ReleaseUploadOperationSuccess) success,
    @required __T Function(ApiOperationFailure) failure,
  });
  __T iswitcho<__T>({
    __T Function(ReleaseUploadOperationSuccess) success,
    __T Function(ApiOperationFailure) failure,
    @required __T Function() otherwise,
  });
}

class ReleaseUploadResult
    with _ReleaseUploadResult
    implements _ReleaseUploadResultBase {
  const ReleaseUploadResult.success(
    ReleaseUploadOperationSuccess success,
  ) : this._unsafe(success: success);
  const ReleaseUploadResult.failure(
    ApiOperationFailure failure,
  ) : this._unsafe(failure: failure);
  const ReleaseUploadResult._unsafe({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null ||
            success == null && failure != null);
  static ReleaseUploadResult
      load<__T extends ReleaseUploadResultRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.success != null && rec.failure == null ||
        rec.success == null && rec.failure != null)) {
      throw Exception("Cannot select a $ReleaseUploadResult case given $rec");
    }
    return ReleaseUploadResult._unsafe(
      success: rec.success,
      failure: rec.failure,
    );
  }

  __T dump<__T>(
    __T Function({
      ReleaseUploadOperationSuccess success,
      ApiOperationFailure failure,
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
    @required __T Function(ReleaseUploadOperationSuccess) success,
    @required __T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError(
          "an instance of $ReleaseUploadResult has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(ReleaseUploadOperationSuccess) success,
    __T Function(ApiOperationFailure) failure,
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
  final ReleaseUploadOperationSuccess success;
  @protected
  final ApiOperationFailure failure;
}

abstract class ReleaseUploadResultRecordBase<Self> {
  ReleaseUploadOperationSuccess get success;
  ApiOperationFailure get failure;
}

abstract class _UploadBinaryResultBase {
  __T iswitch<__T>({
    @required __T Function(UploadBinaryOperationSuccess) success,
    @required __T Function(ApiOperationFailure) failure,
  });
  __T iswitcho<__T>({
    __T Function(UploadBinaryOperationSuccess) success,
    __T Function(ApiOperationFailure) failure,
    @required __T Function() otherwise,
  });
}

class UploadBinaryResult
    with _UploadBinaryResult
    implements _UploadBinaryResultBase {
  const UploadBinaryResult.success(
    UploadBinaryOperationSuccess success,
  ) : this._unsafe(success: success);
  const UploadBinaryResult.failure(
    ApiOperationFailure failure,
  ) : this._unsafe(failure: failure);
  const UploadBinaryResult._unsafe({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null ||
            success == null && failure != null);
  static UploadBinaryResult load<__T extends UploadBinaryResultRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.success != null && rec.failure == null ||
        rec.success == null && rec.failure != null)) {
      throw Exception("Cannot select a $UploadBinaryResult case given $rec");
    }
    return UploadBinaryResult._unsafe(
      success: rec.success,
      failure: rec.failure,
    );
  }

  __T dump<__T>(
    __T Function({
      UploadBinaryOperationSuccess success,
      ApiOperationFailure failure,
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
    @required __T Function(UploadBinaryOperationSuccess) success,
    @required __T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError(
          "an instance of $UploadBinaryResult has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(UploadBinaryOperationSuccess) success,
    __T Function(ApiOperationFailure) failure,
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
  final UploadBinaryOperationSuccess success;
  @protected
  final ApiOperationFailure failure;
}

abstract class UploadBinaryResultRecordBase<Self> {
  UploadBinaryOperationSuccess get success;
  ApiOperationFailure get failure;
}
