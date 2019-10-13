// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_info.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $ReleaseInfo {
  String get appName;
  String get buildVersion;
  String get buildNumber;
  int get releaseId;
  const $ReleaseInfo();
  ReleaseInfo copyWith(
          {String appName,
          String buildVersion,
          String buildNumber,
          int releaseId}) =>
      ReleaseInfo(
          appName: appName ?? this.appName,
          buildVersion: buildVersion ?? this.buildVersion,
          buildNumber: buildNumber ?? this.buildNumber,
          releaseId: releaseId ?? this.releaseId);
  String toString() =>
      "ReleaseInfo(appName: $appName, buildVersion: $buildVersion, buildNumber: $buildNumber, releaseId: $releaseId)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      appName == other.appName &&
      buildVersion == other.buildVersion &&
      buildNumber == other.buildNumber &&
      releaseId == other.releaseId;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + appName.hashCode;
    result = 37 * result + buildVersion.hashCode;
    result = 37 * result + buildNumber.hashCode;
    result = 37 * result + releaseId.hashCode;
    return result;
  }
}

class ReleaseInfo$ {
  static final appName = Lens<ReleaseInfo, String>(
      (s_) => s_.appName, (s_, appName) => s_.copyWith(appName: appName));
  static final buildVersion = Lens<ReleaseInfo, String>((s_) => s_.buildVersion,
      (s_, buildVersion) => s_.copyWith(buildVersion: buildVersion));
  static final buildNumber = Lens<ReleaseInfo, String>((s_) => s_.buildNumber,
      (s_, buildNumber) => s_.copyWith(buildNumber: buildNumber));
  static final releaseId = Lens<ReleaseInfo, int>((s_) => s_.releaseId,
      (s_, releaseId) => s_.copyWith(releaseId: releaseId));
}
