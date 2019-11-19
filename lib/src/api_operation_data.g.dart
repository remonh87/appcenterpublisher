// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_operation_data.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $ApiOperationFailure {
  String get message;
  const $ApiOperationFailure();
  ApiOperationFailure copyWith({String message}) => ApiOperationFailure(message: message ?? this.message);
  String toString() => "ApiOperationFailure(message: $message)";
  bool operator ==(dynamic other) => other.runtimeType == runtimeType && message == other.message;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + message.hashCode;
    return result;
  }
}

class ApiOperationFailure$ {
  static final message =
      Lens<ApiOperationFailure, String>((s_) => s_.message, (s_, message) => s_.copyWith(message: message));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitReleaseSuccess _$CommitReleaseSuccessFromJson(Map<String, dynamic> json) {
  return CommitReleaseSuccess(
    json['release_id'] as String,
    json['release_url'] as String,
  );
}

Map<String, dynamic> _$CommitReleaseSuccessToJson(CommitReleaseSuccess instance) => <String, dynamic>{
      'release_id': instance.releaseId,
      'release_url': instance.releaseUrl,
    };

ReleaseUploadOperationSuccess _$ReleaseUploadOperationSuccessFromJson(Map<String, dynamic> json) {
  return ReleaseUploadOperationSuccess(
    json['upload_id'] as String,
    json['upload_url'] as String,
  );
}

Map<String, dynamic> _$ReleaseUploadOperationSuccessToJson(ReleaseUploadOperationSuccess instance) => <String, dynamic>{
      'upload_id': instance.uploadId,
      'upload_url': instance.uploadUrl,
    };

ApiOperationFailure _$ApiOperationFailureFromJson(Map<String, dynamic> json) {
  return ApiOperationFailure(
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ApiOperationFailureToJson(ApiOperationFailure instance) => <String, dynamic>{
      'message': instance.message,
    };

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

abstract class _$DistributionResult {
  const _$DistributionResult({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null || success == null && failure != null);
  static DistributionResult load<$T extends DistributionResultRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.success != null && rec.failure == null) {
      return DistributionResult.success(rec.success);
    } else if (rec.success == null && rec.failure != null) {
      return DistributionResult.failure(rec.failure);
    } else {
      throw Exception("Cannot select a $DistributionResult case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
      DistributionSuccess success,
      ApiOperationFailure failure,
    })
        make,
  ) {
    return iswitch(
      success: (success) => make(success: success),
      failure: (failure) => make(failure: failure),
    );
  }

  $T iswitch<$T>({
    @required $T Function(DistributionSuccess) success,
    @required $T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError("an instance of $DistributionResult has no case selected");
    }
  }

  $T iswitcho<$T>({
    $T Function(DistributionSuccess) success,
    $T Function(ApiOperationFailure) failure,
    @required $T Function() otherwise,
  }) {
    $T _otherwise(Object _) => otherwise();
    return iswitch(
      success: success ?? _otherwise,
      failure: failure ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType && other.success == success && other.failure == failure;
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
  final DistributionSuccess success;
  @protected
  final ApiOperationFailure failure;
}

abstract class DistributionResultRecordBase<Self> {
  DistributionSuccess get success;
  ApiOperationFailure get failure;
}

abstract class _$ReleaseUploadResult {
  const _$ReleaseUploadResult({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null || success == null && failure != null);
  static ReleaseUploadResult load<$T extends ReleaseUploadResultRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.success != null && rec.failure == null) {
      return ReleaseUploadResult.success(rec.success);
    } else if (rec.success == null && rec.failure != null) {
      return ReleaseUploadResult.failure(rec.failure);
    } else {
      throw Exception("Cannot select a $ReleaseUploadResult case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
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

  $T iswitch<$T>({
    @required $T Function(ReleaseUploadOperationSuccess) success,
    @required $T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError("an instance of $ReleaseUploadResult has no case selected");
    }
  }

  $T iswitcho<$T>({
    $T Function(ReleaseUploadOperationSuccess) success,
    $T Function(ApiOperationFailure) failure,
    @required $T Function() otherwise,
  }) {
    $T _otherwise(Object _) => otherwise();
    return iswitch(
      success: success ?? _otherwise,
      failure: failure ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType && other.success == success && other.failure == failure;
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

abstract class _$UploadBinaryResult {
  const _$UploadBinaryResult({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null || success == null && failure != null);
  static UploadBinaryResult load<$T extends UploadBinaryResultRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.success != null && rec.failure == null) {
      return UploadBinaryResult.success(rec.success);
    } else if (rec.success == null && rec.failure != null) {
      return UploadBinaryResult.failure(rec.failure);
    } else {
      throw Exception("Cannot select a $UploadBinaryResult case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
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

  $T iswitch<$T>({
    @required $T Function(UploadBinaryOperationSuccess) success,
    @required $T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError("an instance of $UploadBinaryResult has no case selected");
    }
  }

  $T iswitcho<$T>({
    $T Function(UploadBinaryOperationSuccess) success,
    $T Function(ApiOperationFailure) failure,
    @required $T Function() otherwise,
  }) {
    $T _otherwise(Object _) => otherwise();
    return iswitch(
      success: success ?? _otherwise,
      failure: failure ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType && other.success == success && other.failure == failure;
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

abstract class _$CommitReleaseResult {
  const _$CommitReleaseResult({
    this.success,
    this.failure,
  }) : assert(success != null && failure == null || success == null && failure != null);
  static CommitReleaseResult load<$T extends CommitReleaseResultRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.success != null && rec.failure == null) {
      return CommitReleaseResult.success(rec.success);
    } else if (rec.success == null && rec.failure != null) {
      return CommitReleaseResult.failure(rec.failure);
    } else {
      throw Exception("Cannot select a $CommitReleaseResult case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
      CommitReleaseSuccess success,
      ApiOperationFailure failure,
    })
        make,
  ) {
    return iswitch(
      success: (success) => make(success: success),
      failure: (failure) => make(failure: failure),
    );
  }

  $T iswitch<$T>({
    @required $T Function(CommitReleaseSuccess) success,
    @required $T Function(ApiOperationFailure) failure,
  }) {
    if (this.success != null) {
      return success(this.success);
    } else if (this.failure != null) {
      return failure(this.failure);
    } else {
      throw StateError("an instance of $CommitReleaseResult has no case selected");
    }
  }

  $T iswitcho<$T>({
    $T Function(CommitReleaseSuccess) success,
    $T Function(ApiOperationFailure) failure,
    @required $T Function() otherwise,
  }) {
    $T _otherwise(Object _) => otherwise();
    return iswitch(
      success: success ?? _otherwise,
      failure: failure ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType && other.success == success && other.failure == failure;
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
  final CommitReleaseSuccess success;
  @protected
  final ApiOperationFailure failure;
}

abstract class CommitReleaseResultRecordBase<Self> {
  CommitReleaseSuccess get success;
  ApiOperationFailure get failure;
}
