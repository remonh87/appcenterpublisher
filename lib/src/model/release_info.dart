import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'release_info.g.dart';

// ignore_for_file: annotate_overrides
@immutable
@FunctionalData()
class AppRelease extends $AppRelease {
  const AppRelease({@required this.appName, @required this.releaseInfo})
      : assert(appName != null),
        assert(releaseInfo != null);

  final String appName;
  final ReleaseInfo releaseInfo;
}

@immutable
@FunctionalData()
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ReleaseInfo extends $ReleaseInfo {
  const ReleaseInfo({
    this.buildVersion,
    this.buildNumber,
    this.releaseId,
  });

  factory ReleaseInfo.fromJson(Map<String, dynamic> json) => _$ReleaseInfoFromJson(json);

  final String buildVersion;
  final String buildNumber;
  final int releaseId;

  Map<String, dynamic> toJson() => _$ReleaseInfoToJson(this);
}
