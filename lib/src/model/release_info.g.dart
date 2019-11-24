// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_info.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AppRelease {
  String get appName;
  ReleaseInfo get releaseInfo;
  const $AppRelease();
  AppRelease copyWith({String appName, ReleaseInfo releaseInfo}) => AppRelease(
      appName: appName ?? this.appName,
      releaseInfo: releaseInfo ?? this.releaseInfo);
  String toString() =>
      "AppRelease(appName: $appName, releaseInfo: $releaseInfo)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      appName == other.appName &&
      releaseInfo == other.releaseInfo;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + appName.hashCode;
    result = 37 * result + releaseInfo.hashCode;
    return result;
  }
}

class AppRelease$ {
  static final appName = Lens<AppRelease, String>(
      (s_) => s_.appName, (s_, appName) => s_.copyWith(appName: appName));
  static final releaseInfo = Lens<AppRelease, ReleaseInfo>(
      (s_) => s_.releaseInfo,
      (s_, releaseInfo) => s_.copyWith(releaseInfo: releaseInfo));
}

abstract class $ReleaseInfo {
  String get buildVersion;
  String get buildNumber;
  int get releaseId;
  const $ReleaseInfo();
  ReleaseInfo copyWith(
          {String buildVersion, String buildNumber, int releaseId}) =>
      ReleaseInfo(
          buildVersion: buildVersion ?? this.buildVersion,
          buildNumber: buildNumber ?? this.buildNumber,
          releaseId: releaseId ?? this.releaseId);
  String toString() =>
      "ReleaseInfo(buildVersion: $buildVersion, buildNumber: $buildNumber, releaseId: $releaseId)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      buildVersion == other.buildVersion &&
      buildNumber == other.buildNumber &&
      releaseId == other.releaseId;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + buildVersion.hashCode;
    result = 37 * result + buildNumber.hashCode;
    result = 37 * result + releaseId.hashCode;
    return result;
  }
}

class ReleaseInfo$ {
  static final buildVersion = Lens<ReleaseInfo, String>((s_) => s_.buildVersion,
      (s_, buildVersion) => s_.copyWith(buildVersion: buildVersion));
  static final buildNumber = Lens<ReleaseInfo, String>((s_) => s_.buildNumber,
      (s_, buildNumber) => s_.copyWith(buildNumber: buildNumber));
  static final releaseId = Lens<ReleaseInfo, int>((s_) => s_.releaseId,
      (s_, releaseId) => s_.copyWith(releaseId: releaseId));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseInfo _$ReleaseInfoFromJson(Map<String, dynamic> json) {
  return ReleaseInfo(
    buildVersion: json['build_version'] as String,
    buildNumber: json['build_number'] as String,
    releaseId: json['release_id'] as int,
  );
}

Map<String, dynamic> _$ReleaseInfoToJson(ReleaseInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('build_version', instance.buildVersion);
  writeNotNull('build_number', instance.buildNumber);
  writeNotNull('release_id', instance.releaseId);
  return val;
}
