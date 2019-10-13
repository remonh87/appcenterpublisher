import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'release_info.g.dart';
// ignore_for_file: annotate_overrides

@FunctionalData()
class ReleaseInfo extends $ReleaseInfo {
  const ReleaseInfo({
    @required this.appName,
    this.buildVersion,
    this.buildNumber,
    this.releaseId,
  }) : assert(appName != null);

  final String appName;
  final String buildVersion;
  final String buildNumber;
  final int releaseId;
}
